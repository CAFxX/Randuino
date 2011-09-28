#include "trng.h"

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
  for (i=0; i<=4; i++) {
    for (j=0; j<=10; j++) {
      Serial.print("iter "); 
      Serial.print(1<<i); 
      Serial.print(", size "); 
      Serial.print(1<<j);
      Serial.print(": ");
      t = micros();
      trng(buf, 1<<j, 1<<i);
      t = micros() - t;
      tp = (1000000.0*(1<<j)/t);
      Serial.print(t);
      Serial.print(" (");
      Serial.print(tp, 2);
      Serial.println("bytes/s)");
    }
  }
}
