len<<3
(data_bits_count + 1 + k_bits_to_append + 64); 
(total_size & 0x1FF); 
(data_bits_count + 1 + k_bits_to_append + 64); 
(total_size & 0x1FF); 
(total_size / 512);
total_size >> 9;  
(chunks_count > max_chunks_count)
(word_id < data_words_count)
1 + word_id 
data_words_count - 1
(i < 4)
(k_bits_to_append+1) >> 3; 
((data_bits_count >> ((3-i)<<3)) & 0xff); 
(i < 8)
(chunk_id < chunks_count)
(i < 16)
(chunk_id<<6) + (i<<2) + 0
(chunk_id<<6) + (i<<2) + 1
(chunk_id<<6) + (i<<2) + 2
(chunk_id<<6) + (i<<2) + 3
(b3 | b2 | b1 | b0); 
(i < 64)
i-15
i-2
right_rotate(w_i_sub_15, 7) ^ right_rotate(w_i_sub_15, 18) ^ (w_i_sub_15 >> 3); 
right_rotate(w_i_sub_2, 17) ^ right_rotate(w_i_sub_2, 19) ^ (w_i_sub_2 >> 10); 
w[i-16] + s0 + w[i-7] + s1; 
i < 64
right_rotate(e, 6) ^ right_rotate(e, 11) ^ right_rotate(e, 25); 
(e & f) ^ ((~e) & g); 
(h + s1 + ch + K[i] + w[i]); 
right_rotate(a, 2) ^ right_rotate(a, 13) ^ right_rotate(a, 22); 
(a & b) ^ (a & c) ^ (b & c); 
(s0 + maj); 
d + temp1; 
temp1 + temp2; 