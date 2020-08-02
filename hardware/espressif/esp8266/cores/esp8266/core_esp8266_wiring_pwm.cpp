/*
  pwm.c - analogWrite implementation for esp8266

  Use the shared TIMER1 utilities to generate PWM signals

  Original Copyright (c) 2015 Hristo Gochkov. All rights reserved.
  This file is part of the esp8266 core for Arduino environment.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#include <Arduino.h>
#include "core_esp8266_waveform.h"

extern "C" {

static int32_t analogScale = 1023;

extern void __analogWriteRange(uint32_t range) {
  if (range > 0) {
    analogScale = range;
  }
}

extern void __analogWriteFreq(uint32_t freq) {
  if (freq < 100) {
    freq = 100;
  } else if (freq > 60000) {
    freq = 60000;
  } else {
    freq = freq;
  }
  _setPWMFreq(freq);
}

extern void __analogWrite(uint8_t pin, int val) {
  if (pin > 16) {
    return;
  }

  if (val < 0) {
    val = 0;
  } else if (val > analogScale) {
    val = analogScale;
  }

  pinMode(pin, OUTPUT);
  _setPWM(pin, val, analogScale);
}

extern void analogWrite(uint8_t pin, int val) __attribute__((weak, alias("__analogWrite")));
extern void analogWriteFreq(uint32_t freq) __attribute__((weak, alias("__analogWriteFreq")));
extern void analogWriteRange(uint32_t range) __attribute__((weak, alias("__analogWriteRange")));

};