# SHA256-hardware-device

# SHA256 Implementation in C and VHDL

This repository contains two separate implementations of the Secure Hash Algorithm 256-bit (SHA256). One implementation is written in the C programming language for software applications, and the other is described in VHDL for hardware integrations (e.g., FPGA or ASIC).

## SHA256 Overview

SHA256 is a cryptographic hash function that produces a fixed-size 256-bit (32-byte) hash. It is one of the functions in the SHA-2 family designed by the National Security Agency (NSA) and is a widely used algorithm in various security applications and protocols, including TLS and SSL, PGP, SSH, and IPsec.

## C Implementation

The C implementation is designed to be portable and efficient, suitable for integration into various applications that require reliable cryptographic hashing.

### Features

- High portability across different platforms
- Optimized for performance with a focus on minimal memory footprint
- Easy-to-use API for hashing data
- Comprehensive set of unit tests ensuring algorithm correctness

### Usage

1. Clone the repository.
2. Navigate to the `C` directory.
3. Compile the C code using the provided Makefile.
4. Run the executable with the data you want to hash.

### Building

```shell
gcc -o sha256c sha256.c -std=c99
./sha256c "Your input string here"
