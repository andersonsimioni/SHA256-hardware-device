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

char* compute_sha256(char* data, uint8_t data_len)
{
    //S0:
    //chip_ready = 1
    //READ FROM RAM
    uint32_t len = data_len; //ctrl0
    //if chip_select ->S1 else ->S0

    //S1:
    uint32_t i = 0; //ctrl1
    uint32_t k_bits_to_append = 0; //ctrl2
    uint32_t data_words_count = len; //ctrl3
    uint32_t data_bits_count = len<<3; //ctrl4
    //->S2
    
    //S2:
    uint32_t total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl5
    //->S3

    //S3:
    uint32_t is_module_of_512 = (total_size & 0x1FF); //ctrl6;
    //->S4

    //S4:
    //Calculate k_bits_to_append to append to make data multiple of 512
    while (is_module_of_512 != 0) //stt0 = (is_module_of_512 != 0)
    //if stt0 then ->S5 else ->S8
    {
        //S5:
        k_bits_to_append++; //ctrl7
        //->S6

        //S6:
        total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl5
        //->S7

        //S7:
        is_module_of_512 = (total_size & 0x1FF); //ctrl6
        //->S4
    }
    
    //S8:
    //chunks_count = (total_size / 512);
    uint32_t chunks_count = total_size >> 9;  //ctrl8
    //->S9
    
    //S9:
    if (chunks_count > max_chunks_count) //stt1 = (chunks_count > max_chunks_count)
        return; //goto ERROR STATE
    //if stt1 then ->ERROR else ->S10
    
    //S10:
    //Alloc memory to chunks, initialize max chunks by (hardware limitation)
    unsigned char chunks[640] = {0}; //ctrl9
    //->S11

    //S11:
    uint32_t word_id = 0; //ctrl10
    //->S12

    //S12:
    //Copy data to chunks
    while (word_id < data_words_count) //stt2 = (word_id < data_words_count)
    //if stt2 then ->S13 else ->S22
    {
        //S13:
        //READ FROM RAM
        chunks[word_id] = data[word_id]; //ctrl11
        //->S14

        //S14
        if (word_id == data_words_count - 1) //stt3 = (word_id == data_words_count - 1)
        //if stt3 then ->S15 else ->S21
        {
            //S15:
            //Append 1 bit at the end
            chunks[word_id + 1] = 0x80; //ctrl12
            //->S16

            //S16:
            i = 0; //ctrl1
            //->S17

            //S17:
            //Set data_bits_len big endian at the end of the last chunk
            while (i < 4) //stt4 = (i < 4)
            //if stt4 then ->S18 else ->S21
            {
                //S18:
                uint32_t aux = (k_bits_to_append+1)/8; //ctrl13
                char val = (char)((data_bits_count >> ((3-i)<<3)) & 0xff); //ctrl14
                //->S19
                
                //S19:
                chunks[word_id + 1 + aux + 4 + i] = val; //ctrl15
                //->S20

                //S20
                i++; //ctrl16
                //->S17
            }
        }

        //S21:
        word_id++; //ctrl17
        //->S12
    }
    

    //S22:
    //VHDL: PARALLEL
    uint32_t HC[8] = {0};
    for (int i = 0; i < 8; i++) HC[i] = H[i]; //ctrl18 (HC <= H (PARALLEL))
    //->S23
    
    //S23:
    uint32_t chunk_id = 0; //ctrl19
    //->S24

    //S24:
    //VHDL: SEQUENTIAL
    //Process message for each 512-bits chunk
    while (chunk_id < chunks_count) //stt5 = (chunk_id < chunks_count)
    //if stt5 then ->S25 else ->S53
    {
        //S25:
        uint32_t w[64] = {0}; //ctrl20
        //->S26
        
        //S26:
        i = 0; //ctrl1
        //->S27
        
        //S27:
        //VHDL: PARALLEL
        //Copy chunk to initial 16 32-bits words from w 
        while (i < 16) //stt6 = (i < 16)
        //if stt6 then ->S28 else ->S31
        {
            //S28:
            //w0 = m0 = 00000000 00000000 00000000 00000000 (CHUNK 8-bits WORDS)
            //w1 = m1 = 00000000 00000000 00000000 00000000 (CHUNK 8-bits WORDS)
            //w[i] = chunks[chunk_id*chunk_word_count + i*4 + n] && chunks[chunk_id*chunk_word_count + i*4 + (n+1)]..
            uint32_t b3 = chunks[(chunk_id<<6) + (i<<2) + 0]<<24;  //ctrl21
            uint32_t b2 = chunks[(chunk_id<<6) + (i<<2) + 1]<<16;  //ctrl22
            uint32_t b1 = chunks[(chunk_id<<6) + (i<<2) + 2]<<8;   //ctrl23
            uint32_t b0 = chunks[(chunk_id<<6) + (i<<2) + 3];      //ctrl24
            //->S29

            //S29:
            w[i] = (b3 | b2 | b1 | b0); //ctrl25
            //->S30

            //S30:
            i++; //ctrl16
            //->S27
        }
        
        //S31:
        i = 16; //ctrl26
        //->S32

        //S32:
        //VHDL: SEQUENTIAL
        //Extend first 16 words
        while (i < 64) //stt7 = (i < 64)
        //if stt7 then ->S33 else ->S36
        {
            //S33:
            uint32_t s0 = right_rotate(w[i-15], 7) ^ right_rotate(w[i-15], 18) ^ (w[i-15] >> 3); //ctrl27
            uint32_t s1 = right_rotate(w[i-2], 17) ^ right_rotate(w[i-2], 19) ^ (w[i-2] >> 10); //ctrl28
            //->S34

            //S34:
            uint32_t res = w[i-16] + s0 + w[i-7] + s1; //ctrl29
            //->S35

            //S35:
            w[i] = res; //ctrl30
            i++; //ctrl16
            //->S32
        }
        
        
        //S36:
        //VHDL: PARALLEL
        //Initialize working variables
        uint32_t a = H[0]; //ctrl31
        uint32_t b = H[1]; //ctrl32
        uint32_t c = H[2]; //ctrl33
        uint32_t d = H[3]; //ctrl34
        uint32_t e = H[4]; //ctrl35
        uint32_t f = H[5]; //ctrl36
        uint32_t g = H[6]; //ctrl37
        uint32_t h = H[7]; //ctrl38
        //->S37

        //S37
        i = 0; //ctrl1
        //->S38

        //S38:
        //VHDL: SEQUENTIAL
        while (i < 64) //stt8 = (i < 64)
        //if stt8 then ->S39 else ->S51
        {
            //S39:
            uint32_t s1 = right_rotate(e, 6) ^ right_rotate(e, 11) ^ right_rotate(e, 25); //ctrl39
            uint32_t ch = (e & f) ^ ((~e) & g); //ctrl40
            //->S40

            //S40:
            uint32_t temp1 = (h + s1 + ch + K[i] + w[i]); //ctrl41
            uint32_t s0 = right_rotate(a, 2) ^ right_rotate(a, 13) ^ right_rotate(a, 22); //ctrl42
            uint32_t maj = (a & b) ^ (a & c) ^ (b & c); //ctrl43
            //->S41

            //S41:
            uint32_t temp2 = (s0 + maj); //ctrl44
            //->S42

            //S42:
            h = g; //ctrl45
            //->S43

            //S43:
            g = f; //ctrl46
            //->S44
            
            //S44:
            f = e; //ctrl47
            //->S45
            
            //S45:
            e = d + temp1; //ctrl48
            //->S46
            
            //S46:
            d = c; //ctrl49
            //->S47
            
            //S47:
            c = b; //ctrl50
            //->S48
            
            //S48:
            b = a; //ctrl51
            //->S49
            
            //S49:
            a = temp1 + temp2; //ctrl52
            //->S50

            //S50:
            i++; //ctrl16
            //->S38
        }
        
        
        //S51:
        //VHDL: PARALLEL
        HC[0] += a; //ctrl53
        HC[1] += b; //ctrl54
        HC[2] += c; //ctrl55
        HC[3] += d; //ctrl56
        HC[4] += e; //ctrl57
        HC[5] += f; //ctrl58
        HC[6] += g; //ctrl59
        HC[7] += h; //ctrl60
        //->S52
        
        //S52:
        chunk_id++; //ctrl61
        //->S24
    }

    //S53:
    printf("\n%x %x %x %x %x %x %x %x", HC[0], HC[1], HC[2], HC[3], HC[4], HC[5], HC[6], HC[7]);
    return "   SUCCESS";
    //->S0
}
