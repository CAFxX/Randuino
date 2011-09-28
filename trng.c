#include <WProgram.h>
#include "trng.h"

// analog pin to read noise from
#define inputPin 0

// internal constants of AES-256; DO NOT MOD!
#define bufSize 16
#define keySize 32

static void trng_step(aes256_context *ctx, unsigned char* buf, unsigned long nonce) {
  unsigned char i;
  unsigned int in;
  for (i=0; i<bufSize; i++) {
    in = analogRead(inputPin);
    buf[i] ^= in;
    buf[(i+1)%bufSize] ^= in >> 8;
  }
  *((unsigned long*)buf) ^= nonce;
  aes256_encrypt_ecb(ctx, buf);
}

int trng(unsigned char *out, unsigned int size, unsigned int iter) {
  unsigned char tmp;
  unsigned i=0, j;
  unsigned long step = 0;
  aes256_context ctx;
  uint8_t key[32] = {
    0x55, 0xD4, 0x59, 0x58, 0x74, 0x49, 0xD9, 0x73, 
    0x99, 0x5E, 0x74, 0xB4, 0xB0, 0xE0, 0x89, 0x27,
    0xDD, 0x0A, 0xF9, 0x26, 0x9E, 0xE9, 0x71, 0xFA, 
    0x7D, 0x01, 0xE9, 0x9A, 0xD4, 0xC4, 0x10, 0xB4
  };
  uint8_t buf[bufSize] = {};
  
  aes256_init(&ctx, key);
  while (i<size) {
    for (j=0; j<iter; j++)
      trng_step(&ctx, buf, step++);
    if (step >= iter * bufSize) {
      tmp = 0;
      for (j=0; j<bufSize/2; j++)
        tmp ^= buf[j];
      out[i++] = tmp;
    }
  }
  aes256_done(&ctx);
  return 0;
}

