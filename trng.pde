#include "trng.h"

void setup() {
  Serial.begin(9600);
  analogReference(INTERNAL);
}

void loop() {
  unsigned char buf[1024/8], i;
  trng(buf, sizeof(buf), 32);
  for (i=0; i<sizeof(buf); i++)
    printByte(buf[i]);
  Serial.println();
}

static void printByte(uint8_t val) {
  if (val < 16) Serial.print('0');
  Serial.print(val, HEX);
}
