# Randuino
A true/hardware random number generator library for the Arduino board family.

## Description
This library allows the generation of true random data on a bare Arduino board (i.e. no external components are needed). It works by sampling noise data from one of the analog pins and hashing the samples with AES-256 in (pseudo)CBC mode.

## Usage

    #include "trng.h"
    
    // the buffer that will hold the generated random data
    unsigned char buf[64];
    
    // number of iterations to be done; if you expect the noise samples 
    // to have N bits of randomness on average, you should set this value
    // to 1 / (2 * N)
    unsigned int iterations = 4;
    
    // invoke the generator
    trng( buf, sizeof(buf), iterations );

## Performance
The iterations parameter controls the speed of the generator; doubling its value will halve the generation speed. On a Arduino Uno with iterations = 8 it generates about 45 bytes/s.

Inside trng.pde, there is a function called trng_benchmark that prints on serial the throughput for different parameters. This is an example output on a Arduino Uno (ATmega328):

    iter 1, size 1: 43032 (23.24bytes/s)
    iter 1, size 2: 45660 (43.80bytes/s)
    iter 1, size 4: 51000 (78.43bytes/s)
    iter 1, size 8: 61780 (129.49bytes/s)
    iter 1, size 16: 83264 (192.16bytes/s)
    iter 1, size 32: 126188 (253.59bytes/s)
    iter 1, size 64: 212148 (301.68bytes/s)
    iter 1, size 128: 383976 (333.35bytes/s)
    iter 1, size 256: 727668 (351.81bytes/s)
    iter 1, size 512: 1414852 (361.88bytes/s)
    iter 1, size 1024: 2789656 (367.07bytes/s)
    iter 2, size 1: 85604 (11.68bytes/s)
    iter 2, size 2: 90960 (21.99bytes/s)
    iter 2, size 4: 101568 (39.38bytes/s)
    iter 2, size 8: 123028 (65.03bytes/s)
    iter 2, size 16: 165780 (96.51bytes/s)
    iter 2, size 32: 251344 (127.32bytes/s)
    iter 2, size 64: 422444 (151.50bytes/s)
    iter 2, size 128: 764756 (167.37bytes/s)
    iter 2, size 256: 1449232 (176.65bytes/s)
    iter 2, size 512: 2818132 (181.68bytes/s)
    iter 2, size 1024: 5555948 (184.31bytes/s)
    iter 4, size 1: 170788 (5.86bytes/s)
    iter 4, size 2: 181416 (11.02bytes/s)
    iter 4, size 4: 202736 (19.73bytes/s)
    iter 4, size 8: 245488 (32.59bytes/s)
    iter 4, size 16: 330848 (48.36bytes/s)
    iter 4, size 32: 501664 (63.79bytes/s)
    iter 4, size 64: 843088 (75.91bytes/s)
    iter 4, size 128: 1526240 (83.87bytes/s)
    iter 4, size 256: 2892352 (88.51bytes/s)
    iter 4, size 512: 5624644 (91.03bytes/s)
    iter 4, size 1024: 11089528 (92.34bytes/s)
    iter 8, size 1: 341080 (2.93bytes/s)
    iter 8, size 2: 362484 (5.52bytes/s)
    iter 8, size 4: 405112 (9.87bytes/s)
    iter 8, size 8: 490432 (16.31bytes/s)
    iter 8, size 16: 660984 (24.21bytes/s)
    iter 8, size 32: 1002156 (31.93bytes/s)
    iter 8, size 64: 1684632 (37.99bytes/s)
    iter 8, size 128: 3049124 (41.98bytes/s)
    iter 8, size 256: 5778800 (44.30bytes/s)
    iter 8, size 512: 11237684 (45.56bytes/s)
    iter 8, size 1024: 22155156 (46.22bytes/s)
    iter 16, size 1: 681928 (1.47bytes/s)
    iter 16, size 2: 724536 (2.76bytes/s)
    iter 16, size 4: 809812 (4.94bytes/s)
    iter 16, size 8: 980188 (8.16bytes/s)
    iter 16, size 16: 1321360 (12.11bytes/s)
    iter 16, size 32: 2003264 (15.97bytes/s)
    iter 16, size 64: 3367148 (19.01bytes/s)
    iter 16, size 128: 6094988 (21.00bytes/s)
    iter 16, size 256: 11550464 (22.16bytes/s)
    iter 16, size 512: 22461772 (22.79bytes/s)
    iter 16, size 1024: 44284876 (23.12bytes/s)

## Components
The AES-256 library is a (slightly) modified version of the one available on http://www.literatecode.com/2007/11/11/aes256/