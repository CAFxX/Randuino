/**
 * Randuino - A TRNG library for Arduino
 * Copyright (C) 2011 Carlo Alberto Ferraris <cafxx@strayorange.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "randuino.h"

void setup() {
  Serial.begin(9600);
  analogReference(INTERNAL);
}

void loop() {
  trng_benchmark();
}

static void printByte(uint8_t val) {
  if (val < 16) Serial.print('0');
  Serial.print(val, HEX);
}

static void trng_benchmark() {
  unsigned long t;
  unsigned char buf[1024], i, j;
  float tp;
  for (i=7; i<=14; i++) {
    for (j=0; j<=10; j++) {
      Serial.print("iter "); 
      Serial.print(1<<i); 
      Serial.print(", size "); 
      Serial.print(1<<j);
      Serial.print(": ");
      t = micros();
      randuino::rand(buf, 1<<j, 1<<i);
      t = micros() - t;
      tp = (1000000.0*(1<<j)/t);
      Serial.print(t);
      Serial.print(" (");
      Serial.print(tp, 2);
      Serial.println("bytes/s)");
    }
  }
}
