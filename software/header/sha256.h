#include "stdint.h"
#include "stdlib.h"

#ifndef SHA256_HEADER
#define SHA256_HEADER

const uint32_t K[], H[], chunk_bits_count, max_chunks_count, chunk_word_count, chunk_word_size;

uint32_t left_rotate(uint32_t n, uint32_t d);
uint32_t right_rotate(uint32_t n, uint32_t d);

extern char* compute_sha256(unsigned char* ram);

#endif