#include <WProgram.h>
#include "trng.h"

// analog pin to read noise from
#define inputPin 0

static void trng_step(Sha256Class* Sha256) {
  unsigned int in = analogRead(inputPin);
  Sha256.Write(in ^ (in >> 8));
}

int trng(unsigned char *out, unsigned int size, unsigned int iter) {
  unsigned char* result;
  unsigned int i, j;
  static unsigned long ctr = 0;
  Sha256Class Sha256;

  i = 0;
  while (i<size) {
    Sha256.init();
    Sha256.write(ctr);
    Sha256.write(ctr>>8);
    Sha256.write(ctr>>16);
    Sha256.write(ctr>>24);
    for (j=0; j<iter; j++)
      trng_step(&Sha256);
    result = Sha256.result();
    memcpy(out+i, result, min(HASH_LENGTH, size-i));
    i += HASH_LENGTH;
    ctr++;
  }

  return 0;
}

