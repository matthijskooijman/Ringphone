/**
 * Ringphone sketch for Arduino.
 *
 * This software is licensed under the MIT License.
 *
 * Copyright (c) 2019 Matthijs Kooijman <matthijs@stdin.nl>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <SD.h>
#include <SPI.h>
#include "AudioZero.h"

const uint8_t PIN_RING_A = 9;
const uint8_t PIN_RING_B = 6;
const uint8_t PIN_CURRENT = A1;
const uint8_t PIN_SOUND = A0;
const uint8_t PIN_RANDOM_SEED = A2;
const uint8_t PIN_TRIGGER = A3;
const uint8_t PIN_MOTION = 5;
const uint8_t PIN_SD_SS = 4;
const uint8_t PIN_LED_RED = LED_BUILTIN;
const uint8_t PIN_LED_GREEN = 8;

// Value for PIN_MOTION when active
const bool MOTION_ACTIVE = HIGH;

// Frequency of the ring signal, determines the ring sound
const uint8_t RING_FREQ = 25; // Hz

// Minimum ADC reading to be off-hook when idle (not ringing, line at
// half DC voltage with or without audio)
const uint16_t IDLE_HOOK_THRESHOLD = 75;
// Minimum ADC reading to be off-hook when ringing
const uint16_t RING_HOOK_THRESHOLD = 200;

// Ringing is RING, PAUSE, RING, IDLE, repeat
const uint16_t RING_TIME = 500;
const uint16_t RING_PAUSE_TIME = 200;
const uint16_t RING_IDLE_TIME = 1500;
// Time to pause between (answered or unanswered) rings
const uint32_t COOLDOWN_TIME = 1000 * 300;

enum class HookStatus : bool {
  ON_HOOK,
  OFF_HOOK,
};

// Aliases in global scope to prevent having to write HookStatus::
// everywhere
auto ON_HOOK = HookStatus::ON_HOOK;
auto OFF_HOOK = HookStatus::OFF_HOOK;

// Number of audio files on the sd card
size_t numberOfFiles;
// List of indices of recent files played
size_t recentFiles[5];
// How many indices are valid in recentFiles
size_t numberRecent = 0;

// Helper for scope debugging
void trigger() {
  digitalWrite(PIN_TRIGGER, !digitalRead(PIN_TRIGGER));
}

HookStatus check_off_hook(uint16_t threshold) {
  uint16_t current = analogRead(PIN_CURRENT);
  // Current above threshold means off-hook
  bool off_hook = (current > threshold);

  static uint16_t prev_current = 0;
  int32_t diff = abs((int32_t)current - (int32_t)prev_current);
  if (true && diff > current / 8 && diff > 5) {
    prev_current = current;
    Serial.print(current);
    Serial.print(" > ");
    Serial.print(threshold);
    Serial.print("? ");
    Serial.println(off_hook ? "yes, OFF_HOOK" : "no, ON_HOOK");
  }

  digitalWrite(PIN_LED_GREEN, off_hook);
  return off_hook ? OFF_HOOK : ON_HOOK;
}

bool is_sound_file(File entry) {
  String name = entry.name();
  return !entry.isDirectory() && (name.endsWith(".RAW") || name.endsWith(".SOU"));
}

size_t countFiles(const char *dirname) {
  File d = SD.open(dirname);
  if (!d.isDirectory())
    return 0;

  size_t count = 0;
  while (true) {
    File entry = d.openNextFile();
    if (!entry) // Done
      return count;

    if (is_sound_file(entry))
      ++count;
    entry.close();
  }
}

void setup() {
  Serial.begin(115200);
  //while (!Serial);
  pinMode(PIN_LED_RED, OUTPUT);
  pinMode(PIN_LED_GREEN, OUTPUT);
  pinMode(PIN_CURRENT, INPUT);
  pinMode(PIN_RANDOM_SEED, INPUT);
  pinMode(PIN_RING_A, OUTPUT);
  pinMode(PIN_RING_B, OUTPUT);
  pinMode(PIN_SOUND, OUTPUT);
  pinMode(PIN_MOTION, INPUT_PULLUP); // TODO: No pullup
  pinMode(PIN_TRIGGER, OUTPUT);

  randomSeed(analogRead(PIN_RANDOM_SEED));

  Serial.print("Initializing SD card...");
  if (!SD.begin(PIN_SD_SS)) {
    Serial.println(" failed!");
    while(true) {
      digitalWrite(PIN_LED_RED, !digitalRead(PIN_LED_RED));
      delay(250);
    }
  }
  numberOfFiles = countFiles("/");
  if (numberOfFiles == 0) {
    Serial.println(" failed!");
    Serial.println("No sound files found.");

    while(true) {
      digitalWrite(PIN_LED_RED, !digitalRead(PIN_LED_RED));
      delay(500);
    }
  }
  Serial.println(" done.");
  Serial.print(numberOfFiles);
  Serial.println(" audio files found.");

  // 44100kHz stereo => 88200 sample rate
  AudioZero.begin(44100);
  digitalWrite(PIN_RING_A, LOW);
  digitalWrite(PIN_RING_B, LOW);
  analogWrite(PIN_SOUND, 128);
  // Allow ring cap to charge. R=2x470Ω, C=33μF, so RC~33. Allow > 4xRC for a full charge.
  delay(200);
}

bool is_recent_file(size_t index_to_check) {
  for (size_t i = 0; i < numberRecent; i++) {
    if (index_to_check == recentFiles[i])
      return true;
  }
  return false;
}

#define lengthof(x) (sizeof(x)/sizeof(*x))
void add_recent_file(size_t index) {
  if (numberRecent < lengthof(recentFiles) && numberRecent < (numberOfFiles + 1) / 2) {
    // If there is room in the recentFiles array, just add the new
    // index. But never remember more than half of the total number of
    // files, since then things are not really random anymore
    recentFiles[numberRecent++] = index;
  } else if (numberRecent) {
    // If the array is full, move all existing indices backwards and
    // append the new one.
    for (size_t i = 0; i + 1 < numberRecent; i++)
      recentFiles[i] = recentFiles[i+1];
    recentFiles[numberRecent-1] = index;
  }
}

File select_sound_file(const char *dirname) {
  // Play the nth-file skipping recent files
  size_t rnd = random(numberOfFiles - numberRecent);
  // File to play, including recent files
  size_t to_play = -1;
  while(rnd != (size_t)-1) {
    to_play++;
    if (!is_recent_file(to_play))
      rnd--;
  }
  add_recent_file(to_play);

  File d = SD.open(dirname);
  if (!d.isDirectory())
    return File();

  File entry;
  size_t i = 0;
  while (i <= to_play) {
    entry.close();
    entry = d.openNextFile();
    if (!entry) {
      // Should never happen, but just in case
      Serial.println("File disappeared?");
      break;
    }

    if (!is_sound_file(entry))
      continue;

    ++i;
  }
  d.close();
  return entry;
}

void sound() {
  Serial.println("SOUND");

  File f = select_sound_file("/");
  if (play_file(f) == ON_HOOK)
    return;

  Serial.println("END");
  // Sound played to completion, play end sound
  if (play_file("special/end.raw") == ON_HOOK)
    return;

  Serial.println("WAIT_FOR_HOOK");
  // Still off-hook, wait for on-hook before starting cooldown
  while (check_off_hook(IDLE_HOOK_THRESHOLD) == OFF_HOOK) /* wait */;
}

HookStatus play_file(const char* filename) {
  File f = SD.open(filename);
  if (!f) {
    Serial.print("error opening file: ");
    Serial.println(filename);
    return OFF_HOOK;
  }
  return play_file(f);
}

HookStatus play_file(File f) {
  Serial.println("PLAY");
  Serial.println(f.name());

  AudioZero.play(f);

  while (AudioZero.isPlaying()) {
    AudioZero.update();

    if (check_off_hook(IDLE_HOOK_THRESHOLD) == ON_HOOK) {
      AudioZero.stop();
      return ON_HOOK;
    }
  }
  return OFF_HOOK;
}

HookStatus idle(uint16_t ms) {
  Serial.println("IDLE");
  digitalWrite(PIN_RING_A, LOW);
  digitalWrite(PIN_RING_B, LOW);
  unsigned long start = millis();
  while (millis() - start < ms) {
    if (check_off_hook(IDLE_HOOK_THRESHOLD) == OFF_HOOK)
      return OFF_HOOK;
  }
  return ON_HOOK;
}

HookStatus ring_once(uint16_t ms) {
  Serial.println("RING");
  const uint16_t PERIOD = 1000 / RING_FREQ;
  unsigned long start = millis();
  while (millis() - start < ms) {
    digitalWrite(PIN_RING_A, HIGH);
    digitalWrite(PIN_RING_B, LOW);
    delay(1);
    // Check for off_hook when B is (just) low, since then the off-hook
    // current is positive and highest.
    if (check_off_hook(RING_HOOK_THRESHOLD) == OFF_HOOK) {
      digitalWrite(PIN_RING_A, LOW);
      return OFF_HOOK;
    }

    delay(PERIOD / 2 - 1);
    digitalWrite(PIN_RING_A, LOW);
    digitalWrite(PIN_RING_B, HIGH);
    delay(PERIOD / 2);
  }
  digitalWrite(PIN_RING_B, LOW);
  // Allow current to stabilize
  delay(30);
  return ON_HOOK;
}

HookStatus ring(uint8_t times) {
  Serial.println("RINGING");

  for (uint8_t i = 0; i < times; ++i) {
    if (ring_once(RING_TIME) == OFF_HOOK)
      return OFF_HOOK;
    if (idle(RING_PAUSE_TIME) == OFF_HOOK)
      return OFF_HOOK;
    if (ring_once(RING_TIME) == OFF_HOOK)
      return OFF_HOOK;
    if (idle(RING_IDLE_TIME) == OFF_HOOK)
      return OFF_HOOK;
  }
  return ON_HOOK;
}

void loop() {
  Serial.println("WAIT_FOR_MOTION**********************************************************************");
  while (digitalRead(PIN_MOTION) != MOTION_ACTIVE && check_off_hook(IDLE_HOOK_THRESHOLD) == ON_HOOK) /* wait */;

  if (check_off_hook(IDLE_HOOK_THRESHOLD) == OFF_HOOK || ring(2) == OFF_HOOK)
    sound();

  // Allow current to stabilize
  delay(300);

  Serial.println("COOLDOWN");

  unsigned long start = millis();
  while (millis() - start < COOLDOWN_TIME && check_off_hook(IDLE_HOOK_THRESHOLD) == ON_HOOK) /* wait */;
}
