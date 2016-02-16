# Randuino
A true/hardware random number generator library for the Arduino board family.

## Description
This library allows the generation of true random data on a bare Arduino board (i.e. no external components are needed). It works by sampling noise data from one of the analog pins and hashing the samples with SHA-256.

## Usage

    #include "randuino.h"
    
    // the buffer that will hold the generated random data
    unsigned char buf[64];
    
    // number of iterations to be done; if you expect the noise samples 
    // to have N bits of randomness on average, you should set this value
    // to 256 / N
    unsigned int iterations = 1 << 10;
    
    // invoke the generator
    randuino::rand( buf, sizeof(buf), iterations );

## Performance
The iterations parameter controls the speed of the generator; doubling its value will halve the generation speed. On a Arduino Uno with iterations = 1024 it generates about 104 bytes/s. Keep in mind that data is generated in blocks of 32 bytes.

Inside trng.pde, there is a function called trng_benchmark that prints on serial the throughput for different parameters. This is an example output on a Arduino Uno (ATmega328):

| iter  | size | time    | bytes/s |
|------:|-----:|--------:|--------:|
| 128   | 32   | 47868   | 668.51  |
| 256   | 32   | 84520   | 378.61  |
| 512   | 32   | 158128  | 202.37  |
| 1024  | 32   | 305220  | 104.84  |
| 2048  | 32   | 599388  | 53.39   |
| 4096  | 32   | 1187912 | 26.94   |
| 8192  | 32   | 2364804 | 13.53   |
| 16384 | 32   | 4718668 | 6.78    |

## Components
The SHA-256 library is a (slightly) modified version of the one available on http://code.google.com/p/cryptosuite/
