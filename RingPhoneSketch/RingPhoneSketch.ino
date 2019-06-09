#include <SD.h>
#include <SPI.h>
#include "AudioZero.h"

const uint8_t PIN_RING_A = 2;
const uint8_t PIN_RING_B = 3;
const uint8_t PIN_CURRENT = A1;
const uint8_t PIN_SOUND = A0;
const uint8_t PIN_TRIGGER = 8;
const uint8_t RING_FREQ = 50; // Hz
const uint16_t RING_DELAY = 1000 / RING_FREQ; // ms

// Helper for scope debugging
void trigger() {
  pinMode(PIN_TRIGGER, OUTPUT);
  digitalWrite(PIN_TRIGGER, LOW);
  digitalWrite(PIN_TRIGGER, HIGH);
}

void setup() {
  Serial.begin(115200);
  //while (!Serial);
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(PIN_CURRENT, INPUT);
  pinMode(PIN_RING_A, OUTPUT);
  pinMode(PIN_RING_B, OUTPUT);
  pinMode(PIN_SOUND, OUTPUT);
 
  if (!SD.begin(SS1)) {
    Serial.println(" failed!");
    while(true);
  }
  Serial.println(" done.");

  // 44100kHz stereo => 88200 sample rate
  AudioZero.begin(44100);
  trigger();
  digitalWrite(PIN_RING_A, LOW);
  digitalWrite(PIN_RING_B, LOW);
  analogWrite(PIN_SOUND, 128);
  // Allow ring cap to charge. R=2x470Ω, C=33μF, so RC~33. Allow > 4xRC for a full charge.
  delay(200);
}

void sound(uint16_t ms) {
  Serial.println("SOUND");
  uint16_t current = analogRead(PIN_CURRENT);
  Serial.println(current);
  if (current > 50) {
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW);
    return;
  }

  File myFile = SD.open("test.raw");
  if (!myFile) {
    // if the file didn't open, print an error and stop
    Serial.println("error opening file");
    while (true);
  }

  Serial.println("Playing");

  AudioZero.play(myFile);
  while (AudioZero.isPlaying()) {
    AudioZero.update();

    uint16_t current = analogRead(PIN_CURRENT);
    Serial.println(current);
    if (current > 50) {
      digitalWrite(LED_BUILTIN, HIGH);
    } else {
      digitalWrite(LED_BUILTIN, LOW);
      AudioZero.stop();
    }
  }
}

void ring(uint16_t ms) {
  Serial.println("RING");
  uint16_t current = analogRead(PIN_CURRENT);
  Serial.println(current);
  if (current > 50) {
    digitalWrite(LED_BUILTIN, HIGH);
    return;
  } else {
    digitalWrite(LED_BUILTIN, LOW);
  }
  unsigned long start = millis();
  while (millis() - start < ms) {
    digitalWrite(PIN_RING_A, HIGH);
    digitalWrite(PIN_RING_B, LOW);
    uint16_t current = analogRead(PIN_CURRENT);
    Serial.println(current);
    if (current > 150) {
      digitalWrite(LED_BUILTIN, HIGH);
      break;
    } else {
      digitalWrite(LED_BUILTIN, LOW);
    }
    delay(RING_DELAY);
    digitalWrite(PIN_RING_A, LOW);
    digitalWrite(PIN_RING_B, HIGH);
    delay(RING_DELAY);
  }
  digitalWrite(PIN_RING_A, LOW);
  digitalWrite(PIN_RING_B, LOW);
}

void loop() {
  ring(2000);
  sound(2000);
}
