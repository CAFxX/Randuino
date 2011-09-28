#include "trng.h"

void setup() {
  Serial.begin(9600);
  analogReference(INTERNAL);
}

void loop() {
  unsigned char buf[1024/8], i;
  trng(buf, sizeof(buf), 1);
  for (i=0; i<sizeof(buf); i++)
    printByte(buf[i]);
  Serial.println();
  if (aes256_test())
    Serial.println("Error in aes256_test()");
}

static void printByte(uint8_t val) {
  if (val < 16) Serial.print('0');
  Serial.print(val, HEX);
}
