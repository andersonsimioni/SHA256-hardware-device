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
    /*L42*/ uint32_t len = ram[0]; //ctrl1
    /*L43*/ uint32_t i = 0; //ctrl2
    /*L44*/ uint32_t k_bits_to_append = 0; //ctrl3
    /*L45*/ uint32_t data_words_count = len; //ctrl4
    /*L46*/ uint32_t data_bits_count = len<<3; //ctrl5
    /*L47*/ uint32_t total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl6
    /*L48*/ uint32_t is_module_of_512 = (total_size & 0x1FF); //ctrl7
    /*L49*/ while (is_module_of_512 != 0){ //stt1
        /*L50*/ k_bits_to_append++; //ctrl8
        /*L51*/ total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl9
        /*L52*/ is_module_of_512 = (total_size & 0x1FF);} //ctrl10
    /*L53*/ uint32_t chunks_count = total_size >> 9;  //ctrl11
    /*L54*/ if (chunks_count > max_chunks_count) return;  //stt2
    /*L55*/ unsigned char chunks[640] = {0}; //ctrl12
    /*L56*/ uint32_t word_id = 0; //ctrl13
    /*L57*/ while (word_id < data_words_count){ //stt3
        /*L58*/ chunks[word_id] = ram[1 + word_id]; //ctrl14
        /*L59*/ if (word_id == data_words_count - 1){ //stt4
            /*L60*/ chunks[word_id + 1] = 0x80; //ctrl15
            /*L61*/ uint32_t aux = (k_bits_to_append+1) >> 3; //ctrl16
            /*L62*/ char val = (char)((data_bits_count >> 24) & 0xff); //ctrl17
            /*L63*/ chunks[word_id + 1 + aux + 4 + 0] = val; //ctrl18
            /*L64*/ val = (char)((data_bits_count >> 16) & 0xff); //ctrl19
            /*L65*/ chunks[word_id + 1 + aux + 4 + 1] = val; //ctrl20
            /*L66*/ val = (char)((data_bits_count >> 8) & 0xff); //ctrl21
            /*L67*/ chunks[word_id + 1 + aux + 4 + 2] = val; //ctrl22
            /*L68*/ val = (char)((data_bits_count) & 0xff); //ctrl23
            /*L69*/ chunks[word_id + 1 + aux + 4 + 3] = val;} //ctrl24
        /*L70*/ word_id++;} //ctrl26
    /*L71*/ uint32_t HC[8] = {0}; //ctrl27
    /*L72*/ i = 0; //ctrl28
    /*L73*/ while (i < 8){ //stt5
        /*L74*/ HC[i] = H[i]; //ctrl29
        /*L75*/ i++;} //ctrl30
    /*L76*/ uint32_t chunk_id = 0; //ctrl31
    /*L77*/ while (chunk_id < chunks_count){ //stt6
        /*L78*/ uint32_t w[64] = {0}; //ctrl32
        /*L79*/ i = 0; //ctrl33
        /*L80*/ while (i < 16){ //stt7
            /*L81*/ uint32_t b3 = chunks[(chunk_id<<6) + (i<<2) + 0]<<24; //ctrl34
            /*L82*/ uint32_t b2 = chunks[(chunk_id<<6) + (i<<2) + 1]<<16; //ctrl35
            /*L83*/ uint32_t b1 = chunks[(chunk_id<<6) + (i<<2) + 2]<<8;  //ctrl36
            /*L84*/ uint32_t b0 = chunks[(chunk_id<<6) + (i<<2) + 3];     //ctrl37
            /*L85*/ w[i] = (b3 | b2 | b1 | b0); //ctrl38
            /*L86*/ i++;} //ctrl39
        /*L87*/ i = 16; //ctrl40
        /*L88*/ while (i < 64){ //stt8
            /*L89*/ uint32_t w_i_sub_15 = w[i-15]; //ctrl41
            /*L90*/ uint32_t w_i_sub_2 = w[i-2]; //ctrl42
            /*L91*/ uint32_t s0 = right_rotate(w_i_sub_15, 7) ^ right_rotate(w_i_sub_15, 18) ^ (w_i_sub_15 >> 3); //ctrl43
            /*L92*/ uint32_t s1 = right_rotate(w_i_sub_2, 17) ^ right_rotate(w_i_sub_2, 19) ^ (w_i_sub_2 >> 10); //ctrl44
            /*L93*/ uint32_t w_i_sub_16 = w[i-16]; //ctrl45
            /*L94*/ uint32_t w_i_sub_7 = w[i-7]; //ctrl46
            /*L95*/ uint32_t res = w_i_sub_16 + s0 + w_i_sub_7 + s1; //ctrl47
            /*L96*/ w[i] = res; //ctrl48
            /*L97*/ i++;} //ctrl49
        /*L98*/ uint32_t a = 0x6a09e667; //ctrl50
        /*L99*/ uint32_t b = 0xbb67ae85; //ctrl51
        /*L100*/ uint32_t c = 0x3c6ef372; //ctrl52
        /*L101*/ uint32_t d = 0xa54ff53a; //ctrl53
        /*L102*/ uint32_t e = 0x510e527f; //ctrl54
        /*L103*/ uint32_t f = 0x9b05688c; //ctrl55
        /*L104*/ uint32_t g = 0x1f83d9ab; //ctrl56
        /*L105*/ uint32_t h = 0x5be0cd19; //ctrl57
        /*L106*/ i = 0; //ctrl58
        /*L107*/ while (i < 64){ //stt9
            /*L108*/ uint32_t s1 = right_rotate(e, 6) ^ right_rotate(e, 11) ^ right_rotate(e, 25); //ctrl59
            /*L109*/ uint32_t ch = (e & f) ^ ((~e) & g);  //ctrl60
            /*L110*/ uint32_t temp1 = (h + s1 + ch + K[i] + w[i]); //ctrl61
            /*L111*/ uint32_t s0 = right_rotate(a, 2) ^ right_rotate(a, 13) ^ right_rotate(a, 22);  //ctrl62
            /*L112*/ uint32_t maj = (a & b) ^ (a & c) ^ (b & c);  //ctrl63
            /*L113*/ uint32_t temp2 = (s0 + maj);  //ctrl64
            /*L114*/ h = g;  //ctrl65
            /*L115*/ g = f;  //ctrl66
            /*L116*/ f = e;  //ctrl67
            /*L117*/ e = d + temp1;  //ctrl68
            /*L118*/ d = c;  //ctrl69
            /*L119*/ c = b;  //ctrl70
            /*L120*/ b = a;  //ctrl71
            /*L121*/ a = temp1 + temp2;  //ctrl72
            /*L122*/ i++;}  //ctrl73
        /*L123*/ HC[0] += a;  //ctrl74
        /*L124*/ HC[1] += b;  //ctrl75
        /*L125*/ HC[2] += c;  //ctrl76
        /*L126*/ HC[3] += d;  //ctrl77
        /*L127*/ HC[4] += e;  //ctrl78
        /*L128*/ HC[5] += f;  //ctrl79
        /*L129*/ HC[6] += g;  //ctrl80
        /*L130*/ HC[7] += h;  //ctrl81
        /*L131*/ chunk_id++;}  //ctrl82
    /*L132*/ i=0;  //ctrl83
    /*L133*/ while (i < 32){ //stt10
        /*L134*/ output[(i<<2)] = (HC[i]>>24) & 0xff;  //ctrl84
        /*L135*/ output[(i<<2)+1] = (HC[i]>>16) & 0xff;  //ctrl85
        /*L136*/ output[(i<<2)+2] = (HC[i]>>8) & 0xff;  //ctrl86
        /*L137*/ output[(i<<2)+3] = (HC[i]>>0) & 0xff;  //ctrl87
        /*L138*/ i++;}  //ctrl88
    return;
}