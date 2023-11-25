#include "stdio.h"
#include "stdint.h"
#include "stdlib.h"
#include "../header/sha256.h"

int main(){

    unsigned char* output = (unsigned char*)malloc(32);
    unsigned char* data = ("\vhello world"); // b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9
    unsigned char* data2[1] = {(unsigned char)0x0}; // b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9
    compute_sha256(data, output);
    for (int i = 0; i < 32; i++) printf("%x", output[i]);

    return 0;
}