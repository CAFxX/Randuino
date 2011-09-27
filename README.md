# TRNG Arduino Library
A true random number generator library for the Arduino family.

## Description
This library allows the generation of true random data on a bare Arduino board (i.e. no external components are needed). It works by sampling noise data from one of the analog pins and hashing the samples with AES-256 in (pseudo-)CBC mode.

## Usage

    #include "trng.h"
    
    // the buffer that will hold the generated random data
    unsigned char buf[64];
    // number of iterations to be done; if you expect the noise samples 
    // to have N bits of randomness on average, you should set this value
    // to 1 / (2 * N)
    unsigned int iterations = 8;
    
    trng( buf, sizeof(buf), iterations );

## Performance
The iterations parameter controls the speed of the generator; doubling its value will halve the generation speed.

On a Arduino Uno with iterations = 8 it generates about 40 bytes/sec.

## Components
The AES-256 library is a (slightly) modified version of the one available on http://www.literatecode.com/2007/11/11/aes256/