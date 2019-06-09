/*
 * Copyright (c) 2015 by 
 Arturo Guadalupi <a.guadalupi@arduino.cc>
 Angelo Scialabba <a.scialabba@arduino.cc>
 Claudio Indellicati <c.indellicati@arduino.cc> <bitron.it@gmail.com>
 
 * Audio library for Arduino Zero.
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of either the GNU General Public License version 2
 * or the GNU Lesser General Public License version 2.1, both as
 * published by the Free Software Foundation.
 */

#include "AudioZero.h"
#include <SD.h>
#include <SPI.h>


/*Global variables*/
bool __StartFlag;
volatile uint32_t __SampleIndex;
uint32_t __HeadIndex;
uint32_t __StopAtIndex;
File __CurrentFile;
uint32_t __NumberOfSamples; // Number of samples to read in block
uint8_t *__WavSamples;

int __Volume;

void AudioZeroClass::begin(uint32_t sampleRate) {
	
	__StartFlag = false;
	__NumberOfSamples = 1024; //samples to read to have a buffer
	__SampleIndex = __StopAtIndex =__NumberOfSamples - 1;
        __HeadIndex = 0;
	
	/*Allocate the buffer where the samples are stored*/
	__WavSamples = (uint8_t *) malloc(__NumberOfSamples * sizeof(uint8_t));
	
	/*Modules configuration */
  	dacConfigure();
	tcConfigure(sampleRate);
        tcStartCounter();
}

void AudioZeroClass::end() {
	tcDisable();
	tcReset();
        free(__WavSamples);
	analogWrite(A0, 128);
}

/*void AudioZeroClass::prepare(int volume){
//Not Implemented yet
}*/

void AudioZeroClass::play(File myFile) {
  __CurrentFile = myFile;
  update();
   // Update again, in case there was only little room at the end of the
   // buffer, so the second update wraps around.
  update();
  __StopAtIndex = -1;
}

void AudioZeroClass::stop() {
  noInterrupts();
  __StopAtIndex = __SampleIndex;
  interrupts();
  __CurrentFile.close();
}

bool AudioZeroClass::isPlaying() {
  // File is set and still open
  return (bool)__CurrentFile;
}


void AudioZeroClass::update() {
  if (!isPlaying())
    return;

  // Last sample read by the ISR
  uint32_t current__SampleIndex = __SampleIndex;

  // If the ISR has wrapped around the end of the buffer, read until the
  // end. Otherwise, read up to the ISR pointer
  size_t to_read;
  if (current__SampleIndex <= __HeadIndex)
    to_read = __NumberOfSamples - __HeadIndex;
  else
    to_read = current__SampleIndex - __HeadIndex;

  // Note that this always leaves one sample "empty" between head and
  // sample index, to prevent ambiguity whether equal indices mean an
  // empty or full buffer

  // Do the actual read
  __HeadIndex += __CurrentFile.read(&__WavSamples[__HeadIndex], to_read);

  if (__HeadIndex == __NumberOfSamples)
    __HeadIndex = 0;

  if (__CurrentFile.available() == 0) {
    if (__HeadIndex == 0)
      __StopAtIndex = __NumberOfSamples;
    else
      __StopAtIndex = __HeadIndex - 1;
    __CurrentFile.close();
  }
}


/**
 * Configures the DAC in event triggered mode.
 *
 * Configures the DAC to use the module's default configuration, with output
 * channel mode configured for event triggered conversions.
 */
void AudioZeroClass::dacConfigure(void){
	analogWriteResolution(10);
	analogWrite(A0, 0);
}

/**
 * Configures the TC to generate output events at the sample frequency.
 *
 * Configures the TC in Frequency Generation mode, with an event output once
 * each time the audio sample frequency period expires.
 */
 void AudioZeroClass::tcConfigure(uint32_t sampleRate)
{
	// Enable GCLK for TCC2 and TC5 (timer counter input clock)
	GCLK->CLKCTRL.reg = (uint16_t) (GCLK_CLKCTRL_CLKEN | GCLK_CLKCTRL_GEN_GCLK0 | GCLK_CLKCTRL_ID(GCM_TC4_TC5)) ;
	while (GCLK->STATUS.bit.SYNCBUSY);

	tcReset();

	// Set Timer counter Mode to 16 bits
	TC5->COUNT16.CTRLA.reg |= TC_CTRLA_MODE_COUNT16;

	// Set TC5 mode as match frequency
	TC5->COUNT16.CTRLA.reg |= TC_CTRLA_WAVEGEN_MFRQ;

	TC5->COUNT16.CTRLA.reg |= TC_CTRLA_PRESCALER_DIV1 | TC_CTRLA_ENABLE;

	TC5->COUNT16.CC[0].reg = (uint16_t) (SystemCoreClock / sampleRate - 1);
	while (tcIsSyncing());
	
	// Configure interrupt request
	NVIC_DisableIRQ(TC5_IRQn);
	NVIC_ClearPendingIRQ(TC5_IRQn);
	NVIC_SetPriority(TC5_IRQn, 0);
	NVIC_EnableIRQ(TC5_IRQn);

	// Enable the TC5 interrupt request
	TC5->COUNT16.INTENSET.bit.MC0 = 1;
	while (tcIsSyncing());
}	


bool AudioZeroClass::tcIsSyncing()
{
  return TC5->COUNT16.STATUS.reg & TC_STATUS_SYNCBUSY;
}

void AudioZeroClass::tcStartCounter()
{
  // Enable TC

  TC5->COUNT16.CTRLA.reg |= TC_CTRLA_ENABLE;
  while (tcIsSyncing());
}

void AudioZeroClass::tcReset()
{
  // Reset TCx
  TC5->COUNT16.CTRLA.reg = TC_CTRLA_SWRST;
  while (tcIsSyncing());
  while (TC5->COUNT16.CTRLA.bit.SWRST);
}

void AudioZeroClass::tcDisable()
{
  // Disable TC5
  TC5->COUNT16.CTRLA.reg &= ~TC_CTRLA_ENABLE;
  while (tcIsSyncing());
}

AudioZeroClass AudioZero;

#ifdef __cplusplus
extern "C" {
#endif

void Audio_Handler (void) {
  // Write next sample
  if (__SampleIndex != __StopAtIndex) {
      __SampleIndex++;
      // If it was the last sample in the buffer, start again
      if (__SampleIndex == __NumberOfSamples) {
          __SampleIndex = 0;
      }
      analogWrite(A0, __WavSamples[__SampleIndex]);
  } else {
      analogWrite(A0, 128);
  }
  // Clear interrupt
  TC5->COUNT16.INTFLAG.bit.MC0 = 1;
}

void TC5_Handler (void) __attribute__ ((weak, alias("Audio_Handler")));

#ifdef __cplusplus
}
#endif
