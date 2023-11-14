#include "stdio.h"
#include "../header/sha256.h"

int main(){

    char* data = "hello world"; // b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9
    char* computed_hash = compute_sha256(data, 11);
    printf(computed_hash);
    
    return 0;
}