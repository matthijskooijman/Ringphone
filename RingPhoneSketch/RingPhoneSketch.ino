#include <SD.h>
#include <SPI.h>
#include "AudioZero.h"

const uint8_t PIN_RING_A = 2;
const uint8_t PIN_RING_B = 3;
const uint8_t PIN_CURRENT = A1;
const uint8_t PIN_SOUND = A0;
const uint8_t PIN_RANDOM_SEED = A2;
const uint8_t PIN_TRIGGER = 8;
const uint8_t PIN_MOTION = 9;

// Value for PIN_MOTION when active
const bool MOTION_ACTIVE = HIGH;

// Frequency of the ring signal, determines the ring sound
const uint8_t RING_FREQ = 50; // Hz

// Minimum ADC reading to be off-hook when idle (not ringing, line at
// half DC voltage with or without audio)
const uint16_t IDLE_HOOK_THRESHOLD = 75;
// Minimum ADC reading to be off-hook when ringing
const uint16_t RING_HOOK_THRESHOLD = 150;

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

size_t numberOfFiles;

// Helper for scope debugging
void trigger() {
  digitalWrite(PIN_TRIGGER, !digitalRead(PIN_TRIGGER));
}

HookStatus check_off_hook(uint16_t threshold) {
  uint16_t current = analogRead(PIN_CURRENT);
  // Current above threshold means off-hook
  bool off_hook = (current > threshold);

  digitalWrite(LED_BUILTIN, off_hook);
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
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(PIN_CURRENT, INPUT);
  pinMode(PIN_RANDOM_SEED, INPUT);
  pinMode(PIN_RING_A, OUTPUT);
  pinMode(PIN_RING_B, OUTPUT);
  pinMode(PIN_SOUND, OUTPUT);
  pinMode(PIN_MOTION, INPUT);
  pinMode(PIN_TRIGGER, OUTPUT);

  randomSeed(analogRead(PIN_RANDOM_SEED));

  Serial.print("Initializing SD card...");
  if (!SD.begin(SS1)) {
    Serial.println(" failed!");
    while(true);
  }
  numberOfFiles = countFiles("/");
  if (numberOfFiles == 0) {
    Serial.println(" failed!");
    Serial.println("No sound files found.");
    while(true);
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

File select_sound_file(const char *dirname) {
  size_t to_play = random(numberOfFiles);

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
  Serial.println("WAIT_FOR_MOTION");
  while (digitalRead(PIN_MOTION) != MOTION_ACTIVE) /* wait */;

  if (ring(2) == OFF_HOOK)
    sound();

  Serial.println("COOLDOWN");
  delay(COOLDOWN_TIME);
}
