# TRNG Arduino Library
A true random number generator library for the Arduino family.

## Description
This library allows the generation of true random data on a bare Arduino board (i.e. no external components are needed). It works by sampling noise data from one of the analog pins and hashing the samples with AES-256 in (pseudo-)CBC mode.

