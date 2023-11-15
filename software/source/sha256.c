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

char* compute_sha256(char* data, int len)
{
    uint32_t k_bits_to_append = 0;
    uint32_t data_words_count = len;
    uint32_t data_bits_count = data_words_count*8;

    printf("data_words_count: %i\n", data_words_count);
    printf("data_bits_count: %i\n", data_bits_count);
    
    //Calculate k_bits_to_append to append to make data multiple of 512
    while (((data_bits_count + 1 + k_bits_to_append + 64) % chunk_bits_count)) 
        k_bits_to_append++;

    printf("k_bits_to_append: %i\n", k_bits_to_append);

    uint32_t chunks_count = (data_bits_count / chunk_bits_count) + 1;
    if (chunks_count > max_chunks_count) return "MAX CHUNKS COUNT ERROR";

    //Alloc memory to chunks, initialize max chunks, (hardware limitation)
    unsigned char chunks[640] = {0};

    //Copy data to chunks
    for (int word_id = 0; word_id < data_words_count; word_id++)
    {
        chunks[word_id] = data[word_id];
        if (word_id == data_words_count - 1)
        {
            //Append 1 bit at the end
            chunks[word_id + 1] = 0x80;

            //Set data_bits_len big endian at the end of the last chunk
            for (int i = 0; i < 4; i++)
            {
                uint32_t aux = (k_bits_to_append+1)/8 ;
                char val = (char)((data_bits_count >> (8*(3-i))) & 0xff);
                chunks[word_id + 1 + aux + 4 + i] = val;
            }
        }
    }

    //VHDL: PARALLEL
    uint32_t HC[8] = {0}; //*(uint32_t*)&H;
    for (int i = 0; i < 8; i++){
        HC[i] = H[i];
    }
    
    //VHDL: SEQUENTIAL
    //Process message for each 512-bits chunk
    for (int chunk_id = 0; chunk_id < chunks_count; chunk_id++)
    {
        uint32_t w[64] = {0};

        //VHDL: PARALLEL
        //Copy chunk to initial 16 32-bits words from w 
        for (int i = 0; i < 16; i++)
        {   
            //w0 = m0 = 00000000 00000000 00000000 00000000 (CHUNK 8-bits WORDS)
            //w1 = m1 = 00000000 00000000 00000000 00000000 (CHUNK 8-bits WORDS)
            //w[i] = chunks[chunk_id*chunk_word_count + i*4 + n] && chunks[chunk_id*chunk_word_count + i*4 + (n+1)]..
            uint32_t b3 = chunks[chunk_id*chunk_word_count + i*4 + 0];
            uint32_t b2 = chunks[chunk_id*chunk_word_count + i*4 + 1];
            uint32_t b1 = chunks[chunk_id*chunk_word_count + i*4 + 2];
            uint32_t b0 = chunks[chunk_id*chunk_word_count + i*4 + 3];
            w[i] = (b3<<8*3) | (b2<<8*2) | (b1<<8*1) | (b0<<8*0);
        }

        //VHDL: SEQUENTIAL
        //Extend first 16 words
        for (int i = 16; i < 64; i++)
        {
            uint32_t s0 = right_rotate(w[i-15], 7) ^ right_rotate(w[i-15], 18) ^ (w[i-15] >> 3);
            uint32_t s1 = right_rotate(w[i-2], 17) ^ right_rotate(w[i-2], 19) ^ (w[i-2] >> 10);
            uint32_t res = w[i-16] + s0 + w[i-7] + s1;

            w[i] = res;
        }
        
        //VHDL: PARALLEL
        //Initialize working variables
        uint32_t a = H[0];
        uint32_t b = H[1];
        uint32_t c = H[2];
        uint32_t d = H[3];
        uint32_t e = H[4];
        uint32_t f = H[5];
        uint32_t g = H[6];
        uint32_t h = H[7];

        //VHDL: SEQUENTIAL
        //BUG RANDOM HASH IN i=6
        for (int i = 0; i < 64; i++)
        {
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
        }
        
        //VHDL: PARALLEL
        HC[0] += a;
        HC[1] += b;
        HC[2] += c;
        HC[3] += d;
        HC[4] += e;
        HC[5] += f;
        HC[6] += g;
        HC[7] += h;
    }

    printf("\n%x %x %x %x %x %x %x %x", HC[0], HC[1], HC[2], HC[3], HC[4], HC[5], HC[6], HC[7]);

    return "   SUCCESS";
}
