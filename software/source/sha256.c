#include "stdint.h"
#include "stdlib.h"
#include "stdio.h"
#include "../header/sha256.h"

const uint32_t chunk_bits_count = 512, chunk_word_count = 64, chunk_word_size = 8, max_chunks_count = 10;

const uint32_t K[64] = {
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
};

const uint32_t H[8] = {
    0x6a09e667,
    0xbb67ae85,
    0x3c6ef372,
    0xa54ff53a,
    0x510e527f,
    0x9b05688c,
    0x1f83d9ab,
    0x5be0cd19
};

uint32_t left_rotate(uint32_t n, uint32_t d)
{
    return (n << d) | (n >> (sizeof(int)*8 - d));
}
 
uint32_t right_rotate(uint32_t n, uint32_t d)
{
    return (n >> d) | (n << (sizeof(uint32_t)*8 - d));
}

void compute_sha256(unsigned char* ram, unsigned char* output)
{
    uint32_t len = ram[0];
    uint32_t i = 0;
    uint32_t k_bits_to_append = 0;
    uint32_t data_words_count = len;
    uint32_t data_bits_count = len<<3;
    uint32_t total_size = (data_bits_count + 1 + k_bits_to_append + 64);
    uint32_t is_module_of_512 = (total_size & 0x1FF);
    while (is_module_of_512 != 0){
        k_bits_to_append++;
        total_size = (data_bits_count + 1 + k_bits_to_append + 64);
        is_module_of_512 = (total_size & 0x1FF);}
    uint32_t chunks_count = total_size >> 9; 
    if (chunks_count > max_chunks_count) return; 
    unsigned char chunks[640] = {0};
    uint32_t word_id = 0;
    while (word_id < data_words_count){
        chunks[word_id] = ram[1 + word_id];
        if (word_id == data_words_count - 1){
            chunks[word_id + 1] = 0x80;
            uint32_t aux = (k_bits_to_append+1) >> 3;
            char val = (char)((data_bits_count >> 24) & 0xff);
            chunks[word_id + 1 + aux + 4 + 0] = val;
            val = (char)((data_bits_count >> 16) & 0xff);
            chunks[word_id + 1 + aux + 4 + 1] = val;
            val = (char)((data_bits_count >> 8) & 0xff);
            chunks[word_id + 1 + aux + 4 + 2] = val;
            val = (char)((data_bits_count) & 0xff);
            chunks[word_id + 1 + aux + 4 + 3] = val;}
        word_id++;}
    uint32_t HC[8] = {0};
    i = 0;
    while (i < 8){
        HC[i] = H[i];
        i++;}
    uint32_t chunk_id = 0;
    while (chunk_id < chunks_count){
        uint32_t w[64] = {0};
        i = 0;
        while (i < 16){
            uint32_t b3 = chunks[(chunk_id<<6) + (i<<2) + 0]<<24; 
            uint32_t b2 = chunks[(chunk_id<<6) + (i<<2) + 1]<<16; 
            uint32_t b1 = chunks[(chunk_id<<6) + (i<<2) + 2]<<8;  
            uint32_t b0 = chunks[(chunk_id<<6) + (i<<2) + 3];     
            w[i] = (b3 | b2 | b1 | b0);
            i++;}
        i = 16;
        while (i < 64){
            uint32_t w_i_sub_15 = w[i-15];
            uint32_t w_i_sub_2 = w[i-2];
            uint32_t s0 = right_rotate(w_i_sub_15, 7) ^ right_rotate(w_i_sub_15, 18) ^ (w_i_sub_15 >> 3);
            uint32_t s1 = right_rotate(w_i_sub_2, 17) ^ right_rotate(w_i_sub_2, 19) ^ (w_i_sub_2 >> 10);
            uint32_t w_i_sub_16 = w[i-16];
            uint32_t w_i_sub_7 = w[i-7];
            uint32_t res = w_i_sub_16 + s0 + w_i_sub_7 + s1;
            w[i] = res;
            i++;}
        uint32_t a = 0x6a09e667;
        uint32_t b = 0xbb67ae85;
        uint32_t c = 0x3c6ef372;
        uint32_t d = 0xa54ff53a;
        uint32_t e = 0x510e527f;
        uint32_t f = 0x9b05688c;
        uint32_t g = 0x1f83d9ab;
        uint32_t h = 0x5be0cd19;
        i = 0;
        while (i < 64){
            uint32_t s1 = right_rotate(e, 6) ^ right_rotate(e, 11) ^ right_rotate(e, 25);
            uint32_t ch = (e & f) ^ ((~e) & g);
            uint32_t temp1 = (h + s1 + ch + K[i] + w[i]);
            uint32_t s0 = right_rotate(a, 2) ^ right_rotate(a, 13) ^ right_rotate(a, 22);
            uint32_t maj = (a & b) ^ (a & c) ^ (b & c);
            uint32_t temp2 = (s0 + maj);
            h = g;
            g = f;
            f = e;
            e = d + temp1;
            d = c;
            c = b;
            b = a;
            a = temp1 + temp2;
            i++;}
        HC[0] += a;
        HC[1] += b;
        HC[2] += c;
        HC[3] += d;
        HC[4] += e;
        HC[5] += f;
        HC[6] += g;
        HC[7] += h;
        chunk_id++;}
    i=0;
    while (i < 32){
        output[(i<<2)] = (HC[i]>>24) & 0xff;
        output[(i<<2)+1] = (HC[i]>>16) & 0xff;
        output[(i<<2)+2] = (HC[i]>>8) & 0xff;
        output[(i<<2)+3] = (HC[i]>>0) & 0xff;
        i++;}
    return;
}