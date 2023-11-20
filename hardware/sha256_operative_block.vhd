library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_operative_block is port(
	clock, chip_reset : in std_logic;
	
	ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
	ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
	ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
	ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
	ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
	ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
	ctrl87,ctrl88,ctrl89,ctrl90,ctrl91,ctrl92,ctrl93,ctrl94,ctrl95,ctrl96,ctrl97,ctrl98,ctrl99,ctrl100,
	ctrl101,ctrl102,ctrl103,ctrl104,ctrl105,ctrl106,ctrl107,ctrl108,ctrl109,ctrl110,ctrl111,ctrl112,
	ctrl113,ctrl114,ctrl115,ctrl116,ctrl117,ctrl118,ctrl119,ctrl120,ctrl121,ctrl122
	: in std_logic;
	
	stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10 : out std_logic;
	
	output : out std_logic_vector(255 downto 0)
);
end sha256_operative_block;

architecture sha256_operative_block_arch of sha256_operative_block is
	
	component registerN is
	generic(	width: positive;
				generateLoad: boolean := false;
				clearValue: integer := 0 );
	port(	-- control
			clock, clear, load: in std_logic;
			-- data
			input: in std_logic_vector(width-1 downto 0);
			output: out std_logic_vector(width-1 downto 0));
	end component;
	
	
	component multiplexer2x1 is
	generic(	width: positive );
	port(	input0, input1: in std_logic_vector(width-1 downto 0);
			sel: in std_logic;
			output: out std_logic_vector(width-1 downto 0) );
	end component;
	
	
	component addersubtractor is
	generic(	width: positive;
			isAdder: boolean := false;
			isSubtractor: boolean := false;
			generateCout: boolean := false;
			generateOvf: boolean := false;
			fixedSecodOperand: integer := 0);
	port(	
		a, b: in std_logic_vector(width-1 downto 0);
		op: in std_logic;
		result: out std_logic_vector(width-1 downto 0);
		ovf, cout: out std_logic );
	end component;
	
	
	component compare is
	generic(	width: positive;
				isSigned: boolean := false;
				generateEqual: boolean := false ;
				generateLessThan: boolean := false;
				useFixedSecodOperand: boolean := false;
				fixedSecodOperand: integer := 0 );
	port(	input0, input1: in std_logic_vector(width-1 downto 0);
			lessThan, equal: out std_logic );
	end component;
	
	component ram_32 IS
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;
	
	component ram_8 IS
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END component;
	
	component ram_k IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;
	
	component ram_h IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END component;
	
	component ram
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	end component;
	
	component shifterRotator is
	generic(
		width: positive;
		isShifter: boolean;
		isLogical: boolean;
		toLeft: boolean;
		bitsToShift: positive
	);
	port(
		input: in std_logic_vector(width-1 downto 0);
		output: out std_logic_vector(width-1 downto 0)
	);
	end component;
	
	
	-- RAM MEMORY PART --
	signal main_ram_out, main_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal chunks_ram_aclr, chunks_ram_wren : std_logic;
	signal chunks_ram_out, chunks_ram_in, chunks_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal w_ram_aclr, w_ram_wren : std_logic;
	signal w_ram_out, w_ram_in, w_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal k_ram_aclr : std_logic;
	signal k_ram_out, k_ram_in, k_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal h_ram_aclr : std_logic;
	signal h_ram_out, h_ram_in, h_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal hc_ram_aclr, hc_ram_wren : std_logic;
	signal hc_ram_out, hc_ram_in, hc_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	-- END RAM MEMORY PART --
	
	
	
	-- REGISTERS IO --
	signal word_id_reg_out, word_id_reg_in : std_logic_vector(31 downto 0) := (others => '0');
	signal i_reg_out, i_reg_in : std_logic_vector(31 downto 0) := (others => '0');
	signal len_reg_out, len_reg_in : std_logic_vector(31 downto 0);
	signal k_bits_to_append_reg_out, k_bits_to_append_reg_in : std_logic_vector(31 downto 0);
	signal data_words_count_reg_out, data_words_count_reg_in : std_logic_vector(31 downto 0);
	signal data_bits_count_reg_out, data_bits_count_reg_in : std_logic_vector(31 downto 0);
	signal total_size_reg_out, total_size_reg_in : std_logic_vector(31 downto 0);
	signal is_module_of_512_reg_out, is_module_of_512_reg_in : std_logic_vector(31 downto 0);
	signal chunks_count_reg_out, chunks_count_reg_in : std_logic_vector(31 downto 0);
	signal max_chunks_count_reg_out, max_chunks_count_reg_in : std_logic_vector(31 downto 0);
	signal aux_reg_out, aux_reg_in : std_logic_vector(31 downto 0);
	signal chunk_id_reg_out, chunk_id_reg_in : std_logic_vector(31 downto 0);
	signal b3_reg_out, b3_reg_in : std_logic_vector(31 downto 0);
	signal b2_reg_out, b2_reg_in : std_logic_vector(31 downto 0);
	signal b1_reg_out, b1_reg_in : std_logic_vector(31 downto 0);
	signal b0_reg_out, b0_reg_in : std_logic_vector(31 downto 0);
	signal w_i_sub_15_reg_out, w_i_sub_15_reg_in : std_logic_vector(31 downto 0);
	signal w_i_sub_2_reg_out, w_i_sub_2_reg_in : std_logic_vector(31 downto 0);
	signal w_i_sub_16_reg_out, w_i_sub_16_reg_in : std_logic_vector(31 downto 0);
	signal w_i_sub_7_reg_out, w_i_sub_7_reg_in : std_logic_vector(31 downto 0);
	signal s0_reg_out, s0_reg_in : std_logic_vector(31 downto 0);
	signal s1_reg_out, s1_reg_in : std_logic_vector(31 downto 0);
	signal res_reg_out, res_reg_in : std_logic_vector(31 downto 0);
	
	signal a_reg_out, a_reg_in : std_logic_vector(31 downto 0);
	signal b_reg_out, b_reg_in : std_logic_vector(31 downto 0);
	signal c_reg_out, c_reg_in : std_logic_vector(31 downto 0);
	signal d_reg_out, d_reg_in : std_logic_vector(31 downto 0);
	signal e_reg_out, e_reg_in : std_logic_vector(31 downto 0);
	signal f_reg_out, f_reg_in : std_logic_vector(31 downto 0);
	signal g_reg_out, g_reg_in : std_logic_vector(31 downto 0);
	signal h_reg_out, h_reg_in : std_logic_vector(31 downto 0);
	
	signal ch_reg_out, ch_reg_in : std_logic_vector(31 downto 0);
	signal temp1_reg_out, temp1_reg_in : std_logic_vector(31 downto 0);
	signal maj_reg_out, maj_reg_in : std_logic_vector(31 downto 0);
	signal temp2_reg_out, temp2_reg_in : std_logic_vector(31 downto 0);
	
	signal val_reg_out, val_reg_in : std_logic_vector(31 downto 0);
	
	signal ob0_reg_out, ob0_reg_in : std_logic_vector(7 downto 0);
	signal ob1_reg_out, ob1_reg_in : std_logic_vector(7 downto 0);
	signal ob2_reg_out, ob2_reg_in : std_logic_vector(7 downto 0);
	signal ob3_reg_out, ob3_reg_in : std_logic_vector(7 downto 0);
	signal ob4_reg_out, ob4_reg_in : std_logic_vector(7 downto 0);
	signal ob5_reg_out, ob5_reg_in : std_logic_vector(7 downto 0);
	signal ob6_reg_out, ob6_reg_in : std_logic_vector(7 downto 0);
	signal ob7_reg_out, ob7_reg_in : std_logic_vector(7 downto 0);
	signal ob8_reg_out, ob8_reg_in : std_logic_vector(7 downto 0);
	signal ob9_reg_out, ob9_reg_in : std_logic_vector(7 downto 0);
	signal ob10_reg_out, ob10_reg_in : std_logic_vector(7 downto 0);
	signal ob11_reg_out, ob11_reg_in : std_logic_vector(7 downto 0);
	signal ob12_reg_out, ob12_reg_in : std_logic_vector(7 downto 0);
	signal ob13_reg_out, ob13_reg_in : std_logic_vector(7 downto 0);
	signal ob14_reg_out, ob14_reg_in : std_logic_vector(7 downto 0);
	signal ob15_reg_out, ob15_reg_in : std_logic_vector(7 downto 0);
	signal ob16_reg_out, ob16_reg_in : std_logic_vector(7 downto 0);
	signal ob17_reg_out, ob17_reg_in : std_logic_vector(7 downto 0);
	signal ob18_reg_out, ob18_reg_in : std_logic_vector(7 downto 0);
	signal ob19_reg_out, ob19_reg_in : std_logic_vector(7 downto 0);
	signal ob20_reg_out, ob20_reg_in : std_logic_vector(7 downto 0);
	signal ob21_reg_out, ob21_reg_in : std_logic_vector(7 downto 0);
	signal ob22_reg_out, ob22_reg_in : std_logic_vector(7 downto 0);
	signal ob23_reg_out, ob23_reg_in : std_logic_vector(7 downto 0);
	signal ob24_reg_out, ob24_reg_in : std_logic_vector(7 downto 0);
	signal ob25_reg_out, ob25_reg_in : std_logic_vector(7 downto 0);
	signal ob26_reg_out, ob26_reg_in : std_logic_vector(7 downto 0);
	signal ob27_reg_out, ob27_reg_in : std_logic_vector(7 downto 0);
	signal ob28_reg_out, ob28_reg_in : std_logic_vector(7 downto 0);
	signal ob29_reg_out, ob29_reg_in : std_logic_vector(7 downto 0);
	signal ob30_reg_out, ob30_reg_in : std_logic_vector(7 downto 0);
	signal ob31_reg_out, ob31_reg_in : std_logic_vector(7 downto 0);
	-- END REGISTERS IO --
	
	
	
	-- REGISTERS CONTROL --
	signal len_reg_load, len_reg_clear : std_logic;
	signal i_reg_load, i_reg_clear : std_logic;
	signal k_bits_to_append_reg_load, k_bits_to_append_reg_clear : std_logic;
	signal data_words_count_reg_load, data_words_count_reg_clear : std_logic;
	signal data_bits_count_reg_load, data_bits_count_reg_clear : std_logic;
	signal total_size_reg_load, total_size_reg_clear : std_logic;
	signal is_module_of_512_reg_load, is_module_of_512_reg_clear : std_logic;
	signal chunks_count_reg_load, chunks_count_reg_clear : std_logic;
	signal max_chunks_count_reg_load, max_chunks_count_reg_clear : std_logic;
	signal word_id_reg_load, word_id_reg_clear : std_logic;
	signal aux_reg_load, aux_reg_clear : std_logic;
	signal chunk_id_reg_load, chunk_id_reg_clear : std_logic;
	signal max_chunks_reg_load, max_chunks_reg_clear : std_logic;
	signal b3_reg_load, b3_reg_clear : std_logic;
	signal b2_reg_load, b2_reg_clear : std_logic;
	signal b1_reg_load, b1_reg_clear : std_logic;
	signal b0_reg_load, b0_reg_clear : std_logic;
	signal w_i_sub_15_reg_load, w_i_sub_15_reg_clear : std_logic;
	signal w_i_sub_2_reg_load, w_i_sub_2_reg_clear : std_logic;
	signal w_i_sub_16_reg_load, w_i_sub_16_reg_clear : std_logic;
	signal w_i_sub_7_reg_load, w_i_sub_7_reg_clear : std_logic;
	signal s0_reg_load, s0_reg_clear : std_logic;
	signal s1_reg_load, s1_reg_clear : std_logic;
	signal res_reg_load, res_reg_clear : std_logic;
	signal a_reg_load, a_reg_clear : std_logic;
	signal b_reg_load, b_reg_clear : std_logic;
	signal c_reg_load, c_reg_clear : std_logic;
	signal d_reg_load, d_reg_clear : std_logic;
	signal e_reg_load, e_reg_clear : std_logic;
	signal f_reg_load, f_reg_clear : std_logic;
	signal g_reg_load, g_reg_clear : std_logic;
	signal h_reg_load, h_reg_clear : std_logic;
	signal ch_reg_load, ch_reg_clear : std_logic;
	signal temp1_reg_load, temp1_reg_clear : std_logic;
	signal maj_reg_load, maj_reg_clear : std_logic;
	signal temp2_reg_load, temp2_reg_clear : std_logic;
	signal val_reg_load, val_reg_clear : std_logic;
	
	signal ob0_reg_load, ob0_reg_clear : std_logic;
	signal ob1_reg_load, ob1_reg_clear : std_logic;
	signal ob2_reg_load, ob2_reg_clear : std_logic;
	signal ob3_reg_load, ob3_reg_clear : std_logic;
	signal ob4_reg_load, ob4_reg_clear : std_logic;
	signal ob5_reg_load, ob5_reg_clear : std_logic;
	signal ob6_reg_load, ob6_reg_clear : std_logic;
	signal ob7_reg_load, ob7_reg_clear : std_logic;
	signal ob8_reg_load, ob8_reg_clear : std_logic;
	signal ob9_reg_load, ob9_reg_clear : std_logic;
	signal ob10_reg_load, ob10_reg_clear : std_logic;
	signal ob11_reg_load, ob11_reg_clear : std_logic;
	signal ob12_reg_load, ob12_reg_clear : std_logic;
	signal ob13_reg_load, ob13_reg_clear : std_logic;
	signal ob14_reg_load, ob14_reg_clear : std_logic;
	signal ob15_reg_load, ob15_reg_clear : std_logic;
	signal ob16_reg_load, ob16_reg_clear : std_logic;
	signal ob17_reg_load, ob17_reg_clear : std_logic;
	signal ob18_reg_load, ob18_reg_clear : std_logic;
	signal ob19_reg_load, ob19_reg_clear : std_logic;
	signal ob20_reg_load, ob20_reg_clear : std_logic;
	signal ob21_reg_load, ob21_reg_clear : std_logic;
	signal ob22_reg_load, ob22_reg_clear : std_logic;
	signal ob23_reg_load, ob23_reg_clear : std_logic;
	signal ob24_reg_load, ob24_reg_clear : std_logic;
	signal ob25_reg_load, ob25_reg_clear : std_logic;
	signal ob26_reg_load, ob26_reg_clear : std_logic;
	signal ob27_reg_load, ob27_reg_clear : std_logic;
	signal ob28_reg_load, ob28_reg_clear : std_logic;
	signal ob29_reg_load, ob29_reg_clear : std_logic;
	signal ob30_reg_load, ob30_reg_clear : std_logic;
	signal ob31_reg_load, ob31_reg_clear : std_logic;
	-- END REGISTERS CONTROL --
	
	
	
	
	-- LA OPERATIONS --
	signal len_shift_left_3 : std_logic_vector(31 downto 0) := (others => '0');
	signal word_id_add_1 : std_logic_vector(31 downto 0) := (others => '0');
	signal i_add_1 : std_logic_vector(31 downto 0) := (others => '0');
	
	signal data_bits_count_add_1 : std_logic_vector(31 downto 0);
	signal k_bits_to_append_add_64 : std_logic_vector(31 downto 0);
	signal data_bits_count_add_1_add_k_bits_to_append_add_64 : std_logic_vector(31 downto 0);
	
	signal total_size_and_1ff : std_logic_vector(31 downto 0) := (others => '0');
	signal total_size_shift_right_9 : std_logic_vector(31 downto 0) := (others => '0');
	
	signal chunks_count_higher_than_max_chunks_count : std_logic;
	signal word_id_less_than_data_words_count : std_logic;
	
	signal data_words_count_sub_1 : std_logic_vector(31 downto 0);
	signal i_shift_left_2 : std_logic_vector(31 downto 0);
	
	signal i_less_than_64 : std_logic;
	signal i_less_than_32 : std_logic;
	signal i_less_than_16 : std_logic;
	signal i_less_than_8 : std_logic;
	signal i_less_than_4 : std_logic;
	
	signal i_sub_16 : std_logic_vector(31 downto 0);
	signal i_sub_15 : std_logic_vector(31 downto 0);
	signal i_sub_7 : std_logic_vector(31 downto 0);
	signal i_sub_2 : std_logic_vector(31 downto 0);
	
	signal k_bits_to_append_add_1 : std_logic_vector(31 downto 0);
	signal k_bits_to_append_add_1_shift_right_3 : std_logic_vector(31 downto 0);
	
	signal aux_add_4 : std_logic_vector(31 downto 0);
	signal word_id_add_1_add_aux_add_4 : std_logic_vector(31 downto 0);
	signal word_id_add_1_add_aux_add_4_add_0 : std_logic_vector(31 downto 0);
	signal word_id_add_1_add_aux_add_4_add_1 : std_logic_vector(31 downto 0);
	signal word_id_add_1_add_aux_add_4_add_2 : std_logic_vector(31 downto 0);
	signal word_id_add_1_add_aux_add_4_add_3 : std_logic_vector(31 downto 0);
	
	
	signal data_bits_count_shift_right_24 : std_logic_vector(31 downto 0);
	signal data_bits_count_shift_right_16 : std_logic_vector(31 downto 0);
	signal data_bits_count_shift_right_8 : std_logic_vector(31 downto 0);
	
	signal data_bits_count_shift_right_24_and_ff : std_logic_vector(31 downto 0);
	signal data_bits_count_shift_right_16_and_ff : std_logic_vector(31 downto 0);
	signal data_bits_count_shift_right_8_and_ff : std_logic_vector(31 downto 0);
	
	signal data_bits_count_and_ff : std_logic_vector(31 downto 0);
	
	signal word_id_equal_data_words_count_sub_1 : std_logic;
	signal chunk_id_less_than_chunks_count : std_logic;
	signal is_module_of_512_equal_0 : std_logic;
	
	signal chunk_id_add_1 : std_logic_vector(31 downto 0);
	signal chunk_id_shift_left_6 : std_logic_vector(31 downto 0);
	signal chunk_id_shift_left_6_add_i_shift_left_2 : std_logic_vector(31 downto 0);
	signal chunk_id_shift_left_6_add_i_shift_left_2_add_0 : std_logic_vector(31 downto 0);
	signal chunk_id_shift_left_6_add_i_shift_left_2_add_1 : std_logic_vector(31 downto 0);
	signal chunk_id_shift_left_6_add_i_shift_left_2_add_2 : std_logic_vector(31 downto 0);
	signal chunk_id_shift_left_6_add_i_shift_left_2_add_3 : std_logic_vector(31 downto 0);
	signal b3_or_b2_or_b1_or_b0 : std_logic_vector(31 downto 0);

	signal w_i_sub_15_rotate_right_7 : std_logic_vector(31 downto 0);
	signal w_i_sub_15_rotate_right_18 : std_logic_vector(31 downto 0);
	signal w_i_sub_15_rotate_right_3 : std_logic_vector(31 downto 0);
	signal w_i_sub_15_rotate_right_7_xor_w_i_sub_15_rotate_right_18_xor_w_i_sub_15_shift_right_3 : std_logic_vector(31 downto 0);

	signal w_i_sub_2_rotate_right_17 : std_logic_vector(31 downto 0);
	signal w_i_sub_2_rotate_right_19 : std_logic_vector(31 downto 0);
	signal w_i_sub_2_rotate_right_10 : std_logic_vector(31 downto 0);
	signal w_i_sub_16_add_s0 : std_logic_vector(31 downto 0);
	signal w_i_sub_7_add_s1 : std_logic_vector(31 downto 0);
	signal w_i_sub_16_add_s0_add_w_i_sub_7_add_s1 : std_logic_vector(31 downto 0);

	signal e_rotate_right_6 : std_logic_vector(31 downto 0);
	signal e_rotate_right_11 : std_logic_vector(31 downto 0);
	signal e_rotate_right_25 : std_logic_vector(31 downto 0);
	signal e_rotate_right_6_xor_e_rotate_right_11_xor_e_rotate_right_25 : std_logic_vector(31 downto 0);
	signal e_and_f_xor_not_e_and_g : std_logic_vector(31 downto 0);
	signal h_add_s1 : std_logic_vector(31 downto 0);

	signal h_add_s1_add_ch : std_logic_vector(31 downto 0);
	signal k_i_add_w_i : std_logic_vector(31 downto 0);
	signal h_add_s1_add_ch_add_k_i_add_w_i : std_logic_vector(31 downto 0);
	signal a_rotate_right_2 : std_logic_vector(31 downto 0);
	signal a_rotate_right_13 : std_logic_vector(31 downto 0);
	signal a_rotate_right_22 : std_logic_vector(31 downto 0);
	signal a_rotate_right_2_xor_a_rotate_right_13_xor_a_rotate_right_22 : std_logic_vector(31 downto 0);
	signal a_and_b_xor_a_and_c_xor_b_and_c : std_logic_vector(31 downto 0);

	signal s0_add_maj : std_logic_vector(31 downto 0);
	signal d_add_temp1 : std_logic_vector(31 downto 0);
	signal temp1_add_temp2 : std_logic_vector(31 downto 0);
	
	signal w_i_sub_2_rotate_right_17_xor_w_i_sub_2_rotate_right_19_xor_w_i_sub_2_shift_right_10 : std_logic_vector(31 downto 0);
	
	signal hc_add_a : std_logic_vector(31 downto 0);
	signal hc_add_b : std_logic_vector(31 downto 0);
	signal hc_add_c : std_logic_vector(31 downto 0);
	signal hc_add_d : std_logic_vector(31 downto 0);
	signal hc_add_e : std_logic_vector(31 downto 0);
	signal hc_add_f : std_logic_vector(31 downto 0);
	signal hc_add_g : std_logic_vector(31 downto 0);
	signal hc_add_h : std_logic_vector(31 downto 0);
	
	signal hc_shift_right_24 : std_logic_vector(31 downto 0);
	signal hc_shift_right_16 : std_logic_vector(31 downto 0);
	signal hc_shift_right_8 : std_logic_vector(31 downto 0);
	signal hc_shift_right_24_and_ff : std_logic_vector(31 downto 0);
	signal hc_shift_right_16_and_ff : std_logic_vector(31 downto 0);
	signal hc_shift_right_8_and_ff : std_logic_vector(31 downto 0);
	signal hc_shift_right_0 : std_logic_vector(31 downto 0);
	signal hc_shift_right_0_and_ff : std_logic_vector(31 downto 0);
	
	-- END LA OPERATIONS --
	
	
	
	
	-- RAM ADDRESS MUXs OPs --
	signal mux_chunks_ram_address_0 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_1 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_2 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_3 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_4 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_5 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_6 : std_logic_vector(31 downto 0);
	signal mux_chunks_ram_address_7 : std_logic_vector(31 downto 0);
	
	
	signal mux_hc_ram_address_0 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_address_1 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_address_2 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_address_3 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_address_4 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_address_5 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_address_6 : std_logic_vector(31 downto 0);
	
	
	signal mux_w_ram_address_0 : std_logic_vector(31 downto 0);
	signal mux_w_ram_address_1 : std_logic_vector(31 downto 0);
	signal mux_w_ram_address_2 : std_logic_vector(31 downto 0);
	-- END RAM ADDRESS MUXs OPS --
	
	
	
	
	-- RAM IN MUXs OPs --
	signal mux_chunks_ram_in_0 : std_logic_vector(31 downto 0);
	
	signal mux_hc_ram_in_0 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_in_1 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_in_2 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_in_3 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_in_4 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_in_5 : std_logic_vector(31 downto 0);
	signal mux_hc_ram_in_6 : std_logic_vector(31 downto 0);
	-- END RAM IN MUXs OPs --
	
	
	
	
	-- REGISTERS IN MUXs OPs --
	signal mux_val_reg_in_0 : std_logic_vector(31 downto 0);
	signal mux_val_reg_in_1 : std_logic_vector(31 downto 0);
	-- END REGISTERS IN MUXs OPs --
	
begin
	
	-- RAM MEMORY INSTANCES --
	h_ram_0: ram_h port map
	(
		clock=>clock,
		address => h_ram_address(4 downto 0),
		data => h_ram_in,
		wren => '0',
		q	=> h_ram_out
	);
	
	hc_ram_0: ram_h port map
	(
		clock=>clock,
		address => hc_ram_address(4 downto 0),
		data => hc_ram_in,
		wren => hc_ram_wren,
		q	=> hc_ram_out
	);
	
	k_ram_0: ram_k port map
	(
		clock=>clock,
		address => k_ram_address(5 downto 0),
		data => k_ram_in,
		wren => '0',
		q	=> k_ram_out
	);
	
	chunks_ram: ram_32 PORT MAP
	(
		clock=>clock,
		address => chunks_ram_address(9 downto 0),
		data => chunks_ram_in,
		wren => chunks_ram_wren,
		q	=> chunks_ram_out
	);
	
	w_ram: ram_32 PORT MAP
	(
		clock=>clock,
		address => w_ram_address(9 downto 0),
		data => w_ram_in,
		wren => w_ram_wren,
		q	=> w_ram_out
	);
			
	main_ram_data: ram port map
	(
		clock=>clock,
		address	=> main_ram_address(7 DOWNTO 0),
		data => (others => '0'),
		wren => '0',
		q => main_ram_out(7 DOWNTO 0)
	);
	-- END RAM MEMORY INSTANCES --
	
	
	
	
	-- REGISTERS INSTANCES --
	len_reg_comp : registerN
	generic map(width => 32, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => len_reg_clear, load => len_reg_load, input => len_reg_in, output => len_reg_out);

	i_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => i_reg_clear, load => i_reg_load, input => i_reg_in, output => i_reg_out);

	k_bits_to_append_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => k_bits_to_append_reg_clear, load => k_bits_to_append_reg_load, input => k_bits_to_append_reg_in, output => k_bits_to_append_reg_out);

	data_words_count_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => data_words_count_reg_clear, load => data_words_count_reg_load, input => data_words_count_reg_in, output => data_words_count_reg_out);

	data_bits_count_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => data_bits_count_reg_clear, load => data_bits_count_reg_load, input => data_bits_count_reg_in, output => data_bits_count_reg_out);

	total_size_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => total_size_reg_clear, load => total_size_reg_load, input => total_size_reg_in, output => total_size_reg_out);

	is_module_of_512_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => is_module_of_512_reg_clear, load => is_module_of_512_reg_load, input => is_module_of_512_reg_in, output => is_module_of_512_reg_out);

	chunks_count_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => chunks_count_reg_clear, load => chunks_count_reg_load, input => chunks_count_reg_in, output => chunks_count_reg_out);

	max_chunks_count_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => max_chunks_count_reg_clear, load => max_chunks_count_reg_load, input => max_chunks_count_reg_in, output => max_chunks_count_reg_out);

	word_id_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => word_id_reg_clear, load => word_id_reg_load, input => word_id_reg_in, output => word_id_reg_out);

	aux_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => aux_reg_clear, load => aux_reg_load, input => aux_reg_in, output => aux_reg_out);

	chunk_id_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => chunk_id_reg_clear, load => chunk_id_reg_load, input => chunk_id_reg_in, output => chunk_id_reg_out);

	b3_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => b3_reg_clear, load => b3_reg_load, input => b3_reg_in, output => b3_reg_out);

	b2_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => b2_reg_clear, load => b2_reg_load, input => b2_reg_in, output => b2_reg_out);

	b1_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => b1_reg_clear, load => b1_reg_load, input => b1_reg_in, output => b1_reg_out);

	b0_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => b0_reg_clear, load => b0_reg_load, input => b0_reg_in, output => b0_reg_out);

	w_i_sub_15_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => w_i_sub_15_reg_clear, load => w_i_sub_15_reg_load, input => w_i_sub_15_reg_in, output => w_i_sub_15_reg_out);

	w_i_sub_2_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => w_i_sub_2_reg_clear, load => w_i_sub_2_reg_load, input => w_i_sub_2_reg_in, output => w_i_sub_2_reg_out);
	 
	 w_i_sub_16_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => w_i_sub_16_reg_clear, load => w_i_sub_16_reg_load, input => w_i_sub_16_reg_in, output => w_i_sub_16_reg_out);

	w_i_sub_7_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => w_i_sub_7_reg_clear, load => w_i_sub_7_reg_load, input => w_i_sub_7_reg_in, output => w_i_sub_7_reg_out);
	 
	s0_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => s0_reg_clear, load => s0_reg_load, input => s0_reg_in, output => s0_reg_out);

	s1_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => s1_reg_clear, load => s1_reg_load, input => s1_reg_in, output => s1_reg_out);

	res_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => res_reg_clear, load => res_reg_load, input => res_reg_in, output => res_reg_out);

	a_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => a_reg_clear, load => a_reg_load, input => a_reg_in, output => a_reg_out);

	b_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => b_reg_clear, load => b_reg_load, input => b_reg_in, output => b_reg_out);

	c_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => c_reg_clear, load => c_reg_load, input => c_reg_in, output => c_reg_out);

	d_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => d_reg_clear, load => d_reg_load, input => d_reg_in, output => d_reg_out);

	e_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => e_reg_clear, load => e_reg_load, input => e_reg_in, output => e_reg_out);

	f_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => f_reg_clear, load => f_reg_load, input => f_reg_in, output => f_reg_out);

	g_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => g_reg_clear, load => g_reg_load, input => g_reg_in, output => g_reg_out);

	h_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => h_reg_clear, load => h_reg_load, input => h_reg_in, output => h_reg_out);

	ch_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => ch_reg_clear, load => ch_reg_load, input => ch_reg_in, output => ch_reg_out);

	temp1_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => temp1_reg_clear, load => temp1_reg_load, input => temp1_reg_in, output => temp1_reg_out);

	maj_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => maj_reg_clear, load => maj_reg_load, input => maj_reg_in, output => maj_reg_out);

	temp2_reg_comp : registerN
	 generic map(width => 32, generateLoad => true, clearValue => 0)
	 port map(clock => clock, clear => temp2_reg_clear, load => temp2_reg_load, input => temp2_reg_in, output => temp2_reg_out);
	
	
	
	
	val_reg_comp : registerN
	generic map( width => 8, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => val_reg_clear, load => val_reg_load, input => val_reg_in(7 downto 0), output => val_reg_out(7 downto 0));
	
	
	ob0_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob0_reg_clear, load => ob0_reg_load, input => ob0_reg_in, output => ob0_reg_out);

	ob1_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob1_reg_clear, load => ob1_reg_load, input => ob1_reg_in, output => ob1_reg_out);

	ob2_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob2_reg_clear, load => ob2_reg_load, input => ob2_reg_in, output => ob2_reg_out);

	ob3_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob3_reg_clear, load => ob3_reg_load, input => ob3_reg_in, output => ob3_reg_out);

	ob4_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob4_reg_clear, load => ob4_reg_load, input => ob4_reg_in, output => ob4_reg_out);

	ob5_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob5_reg_clear, load => ob5_reg_load, input => ob5_reg_in, output => ob5_reg_out);

	ob6_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob6_reg_clear, load => ob6_reg_load, input => ob6_reg_in, output => ob6_reg_out);

	ob7_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob7_reg_clear, load => ob7_reg_load, input => ob7_reg_in, output => ob7_reg_out);

	ob8_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob8_reg_clear, load => ob8_reg_load, input => ob8_reg_in, output => ob8_reg_out);

	ob9_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob9_reg_clear, load => ob9_reg_load, input => ob9_reg_in, output => ob9_reg_out);

	ob10_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob10_reg_clear, load => ob10_reg_load, input => ob10_reg_in, output => ob10_reg_out);

	ob11_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob11_reg_clear, load => ob11_reg_load, input => ob11_reg_in, output => ob11_reg_out);

	ob12_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob12_reg_clear, load => ob12_reg_load, input => ob12_reg_in, output => ob12_reg_out);

	ob13_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob13_reg_clear, load => ob13_reg_load, input => ob13_reg_in, output => ob13_reg_out);

	ob14_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob14_reg_clear, load => ob14_reg_load, input => ob14_reg_in, output => ob14_reg_out);

	ob15_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob15_reg_clear, load => ob15_reg_load, input => ob15_reg_in, output => ob15_reg_out);

	ob16_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob16_reg_clear, load => ob16_reg_load, input => ob16_reg_in, output => ob16_reg_out);

	ob17_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob17_reg_clear, load => ob17_reg_load, input => ob17_reg_in, output => ob17_reg_out);

	ob18_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob18_reg_clear, load => ob18_reg_load, input => ob18_reg_in, output => ob18_reg_out);

	ob19_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob19_reg_clear, load => ob19_reg_load, input => ob19_reg_in, output => ob19_reg_out);

	ob20_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob20_reg_clear, load => ob20_reg_load, input => ob20_reg_in, output => ob20_reg_out);

	ob21_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob21_reg_clear, load => ob21_reg_load, input => ob21_reg_in, output => ob21_reg_out);

	ob22_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob22_reg_clear, load => ob22_reg_load, input => ob22_reg_in, output => ob22_reg_out);

	ob23_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob23_reg_clear, load => ob23_reg_load, input => ob23_reg_in, output => ob23_reg_out);

	ob24_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob24_reg_clear, load => ob24_reg_load, input => ob24_reg_in, output => ob24_reg_out);

	ob25_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob25_reg_clear, load => ob25_reg_load, input => ob25_reg_in, output => ob25_reg_out);

	ob26_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob26_reg_clear, load => ob26_reg_load, input => ob26_reg_in, output => ob26_reg_out);

	ob27_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob27_reg_clear, load => ob27_reg_load, input => ob27_reg_in, output => ob27_reg_out);

	ob28_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob28_reg_clear, load => ob28_reg_load, input => ob28_reg_in, output => ob28_reg_out);

	ob29_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob29_reg_clear, load => ob29_reg_load, input => ob29_reg_in, output => ob29_reg_out);

	ob30_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob30_reg_clear, load => ob30_reg_load, input => ob30_reg_in, output => ob30_reg_out);

	ob31_reg_comp : registerN
	generic map(width => 8, generateLoad => true, clearValue => 0)
	port map(clock => clock, clear => ob31_reg_clear, load => ob31_reg_load, input => ob31_reg_in, output => ob31_reg_out);

	-- END REGISTERS INSTANCES --
	
	
	
	
	
	
	-- LA OPERATIONS --
	--len<<3
	len_shift_left_3_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => true,
		bitsToShift => 3
	)
	port map(
		input => len_reg_out,
		output => len_shift_left_3
	);

	
	--(data_bits_count + 1 + k_bits_to_append + 64); 
	data_bits_count_add_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => data_bits_count_reg_out, b=>(others => '0'),
		result => data_bits_count_add_1 );
	
	k_bits_to_append_add_64_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 64)
	port map(	
		op => '0',
		a => k_bits_to_append_reg_out, b=>(others => '0'),
		result => k_bits_to_append_add_64 );
		
	data_bits_count_add_1_add_k_bits_to_append_add_64_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true)
	port map(	
		op => '0',
		a => data_bits_count_add_1, b => k_bits_to_append_add_64,
		result => data_bits_count_add_1_add_k_bits_to_append_add_64 );
	
	
	
	
	--(total_size & 0x1FF); 
	total_size_and_1ff <= total_size_reg_out and "00000000000000000000000111111111";
	
	
	
	--total_size >> 9;  
	total_size_shift_right_9_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 9
	)
	port map(
		input => total_size_reg_out,
		output => total_size_shift_right_9
	);
	
	
	--(is_module_of_512 == 0)
	is_module_of_512_equal_0_comp : compare
	generic map(	width => 32, generateEqual => true, useFixedSecodOperand => true, fixedSecodOperand => 0 )
	port  map(	input0 => is_module_of_512_reg_out, input1 => (others=>'0'), equal => is_module_of_512_equal_0);
	
	
	--(chunks_count > max_chunks_count)
	chunks_count_higher_than_max_chunks_count_comp: component compare
	generic map(	width => 32, generateLessThan => true )
	port map(	
			input0 => max_chunks_count_reg_out, 
			input1 => chunks_count_reg_out,
			lessThan => chunks_count_higher_than_max_chunks_count
		);
	
	
	--(word_id < data_words_count)
	word_id_less_than_data_words_count_comp: component compare
	generic map(	width => 32, generateLessThan => true )
	port map(	
			input0 => word_id_reg_out, 
			input1 => data_words_count_reg_out,
			lessThan => word_id_less_than_data_words_count
		);
	
	--word_id == data_words_count - 1
	word_id_equal_data_words_count_sub_1_comp: component compare
	generic map(	width => 32, generateLessThan => false, generateEqual => true )
	port map(	
			input0 => word_id_reg_out, 
			input1 => data_words_count_sub_1,
			equal => word_id_equal_data_words_count_sub_1
		);
	
		
	--1 + word_id
	word_id_add_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => word_id_reg_out, b=>(others => '0'),
		result => word_id_add_1 );	
		
		
		
		
		
	--data_words_count - 1
	data_words_count_sub_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => false,
			fixedSecodOperand => 1)
	port map(	
		op => '1',
		a => data_words_count_reg_out, b=>(others => '0'),
		result => data_words_count_sub_1 );	
		
	
	
	--i++
	i_add_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => i_reg_out, b=>(others => '0'),
		result => i_add_1 );
		
		
	
	--i<<2
	i_shift_left_2_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => true,
		bitsToShift => 2
	)
	port map(
		input => i_reg_out,
		output => i_shift_left_2
	);
	
	
	--(i < 16)
	i_less_than_16_comp: component compare
	generic map(	width => 32, generateLessThan => true,
				useFixedSecodOperand => true,
				fixedSecodOperand => 16  )
	port map(	
			input0 => i_reg_out, 
			input1 => (others => '0'),
			lessThan => i_less_than_16
		);
	
	--(i < 8)
	i_less_than_8_comp: component compare
	generic map(	width => 32, generateLessThan => true,
				useFixedSecodOperand => true,
				fixedSecodOperand => 8  )
	port map(	
			input0 => i_reg_out, 
			input1 => (others => '0'),
			lessThan => i_less_than_8
		);
		
	--(i < 4)
	i_less_than_4_comp: component compare
	generic map(	width => 32, generateLessThan => true,
				useFixedSecodOperand => true,
				fixedSecodOperand => 4  )
	port map(	
			input0 => i_reg_out, 
			input1 => (others => '0'),
			lessThan => i_less_than_4
		);
		
	--(i < 64)
	i_less_than_64_comp: component compare
	generic map(	width => 32, generateLessThan => true,
				useFixedSecodOperand => true,
				fixedSecodOperand => 64  )
	port map(	
			input0 => i_reg_out, 
			input1 => (others => '0'),
			lessThan => i_less_than_64
		);
		
	--(i < 32)
	i_less_than_32_comp: component compare
	generic map(	width => 32, generateLessThan => true,
				useFixedSecodOperand => true,
				fixedSecodOperand => 32  )
	port map(	
			input0 => i_reg_out, 
			input1 => (others => '0'),
			lessThan => i_less_than_32
		);
		
		
		
	--i-15
	i_sub_15_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => false,
			fixedSecodOperand => 15)
	port map(	
		op => '1',
		a => i_reg_out, b=>(others => '0'),
		result => i_sub_15 );	
		
		
		
	--i-2
	i_sub_2_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => false,
			fixedSecodOperand => 2)
	port map(	
		op => '1',
		a => i_reg_out, b=>(others => '0'),
		result => i_sub_2 );	
		
		
		
		
	--i-16
	i_sub_16_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => false,
			fixedSecodOperand => 16)
	port map(	
		op => '1',
		a => i_reg_out, b=>(others => '0'),
		result => i_sub_16 );	
		
		
		
	--i-7
	i_sub_7_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => false,
			fixedSecodOperand => 7)
	port map(	
		op => '1',
		a => i_reg_out, b=>(others => '0'),
		result => i_sub_7 );	
		
		
	
	
	
	--(k_bits_to_append+1) >> 3;
	k_bits_to_append_add_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => k_bits_to_append_reg_out, b=>(others => '0'),
		result => k_bits_to_append_add_1 );	
	
	k_bits_to_append_add_1_shift_right_3_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 3
	)
	port map(
		input => k_bits_to_append_add_1,
		output => k_bits_to_append_add_1_shift_right_3
	);
	
	
	
	--word_id + 1 + aux + 4 + 0
	aux_add_4_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 4)
	port map(	
		op => '0',
		a => aux_reg_out, b => (others=>'0'),
		result => aux_add_4 );
		
	word_id_add_1_add_aux_add_4_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => word_id_reg_out, b => aux_add_4,
		result => word_id_add_1_add_aux_add_4 );
		
	word_id_add_1_add_aux_add_4_add_0 <= word_id_add_1_add_aux_add_4;
		
		
		
	
	--word_id + 1 + aux + 4 + 1
	word_id_add_1_add_aux_add_4_add_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => word_id_add_1_add_aux_add_4, b => (others => '0'),
		result => word_id_add_1_add_aux_add_4_add_1 );
		
		
		
		
	--word_id + 1 + aux + 4 + 2
	word_id_add_1_add_aux_add_4_add_2_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 2)
	port map(	
		op => '0',
		a => word_id_add_1_add_aux_add_4, b => (others => '0'),
		result => word_id_add_1_add_aux_add_4_add_2 );
		
		
		
		
	--word_id + 1 + aux + 4 + 3
	word_id_add_1_add_aux_add_4_add_3_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 3)
	port map(	
		op => '0',
		a => word_id_add_1_add_aux_add_4, b => (others => '0'),
		result => word_id_add_1_add_aux_add_4_add_3 );
		
		
		
		
	--(data_bits_count >> 24) & 0xff
	data_bits_count_shift_right_24_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 24
	)
	port map(
		input => data_bits_count_reg_out,
		output => data_bits_count_shift_right_24
	);
	
	data_bits_count_shift_right_24_and_ff <= data_bits_count_shift_right_24 and "00000000000000000000000011111111";
	
	
	
	
	
	--(data_bits_count >> 16) & 0xff
	data_bits_count_shift_right_16_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 16
	)
	port map(
		input => data_bits_count_reg_out,
		output => data_bits_count_shift_right_16
	);
	
	data_bits_count_shift_right_16_and_ff <= data_bits_count_shift_right_16 and "00000000000000000000000011111111";
	
	
	
	
	
	--(data_bits_count >> 8) & 0xff
	data_bits_count_shift_right_8_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 8
	)
	port map(
		input => data_bits_count_reg_out,
		output => data_bits_count_shift_right_8
	);
	
	data_bits_count_shift_right_8_and_ff <= data_bits_count_shift_right_8 and "00000000000000000000000011111111";
	
	
	
	--(data_bits_count) & 0xff
	data_bits_count_and_ff <= data_bits_count_reg_out and "00000000000000000000000011111111";
	
	
	
	
	--(chunk_id < chunks_count)
	chunk_id_less_than_chunks_count_comp: component compare
	generic map(	width => 32, generateLessThan => true)
	port map(	
			input0 => chunk_id_reg_out, 
			input1 => chunks_count_reg_out,
			lessThan => chunk_id_less_than_chunks_count
		);
	
	
	
	
	--(chunk_id<<6) + (i<<2) + 0
	chunk_id_shift_left_6_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => true,
		bitsToShift => 6
	)
	port map(
		input => chunk_id_reg_out,
		output => chunk_id_shift_left_6
	);
	
	chunk_id_shift_left_6_add_i_shift_left_2_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => chunk_id_shift_left_6, b => i_shift_left_2,
		result => chunk_id_shift_left_6_add_i_shift_left_2 );
		
	chunk_id_shift_left_6_add_i_shift_left_2_add_0 <= chunk_id_shift_left_6_add_i_shift_left_2;
	
	
	
	
	--(chunk_id<<6) + (i<<2) + 1
	chunk_id_shift_left_6_add_i_shift_left_2_add_1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => chunk_id_shift_left_6_add_i_shift_left_2, b => (others=>'0'),
		result => chunk_id_shift_left_6_add_i_shift_left_2_add_1 );
			
	
	
	
	--(chunk_id<<6) + (i<<2) + 2
	chunk_id_shift_left_6_add_i_shift_left_2_add_2_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 2)
	port map(	
		op => '0',
		a => chunk_id_shift_left_6_add_i_shift_left_2, b => (others=>'0'),
		result => chunk_id_shift_left_6_add_i_shift_left_2_add_2 );
	
	
	
	
	--(chunk_id<<6) + (i<<2) + 3
	chunk_id_shift_left_6_add_i_shift_left_2_add_3_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 3)
	port map(	
		op => '0',
		a => chunk_id_shift_left_6_add_i_shift_left_2, b => (others=>'0'),
		result => chunk_id_shift_left_6_add_i_shift_left_2_add_3 );
	
	
	
	
	
	--(b3 | b2 | b1 | b0); 
	b3_or_b2_or_b1_or_b0 <= b3_reg_out or b2_reg_out or b1_reg_out or b0_reg_out;
	
	
	
	
	
	
	
	--right_rotate(w_i_sub_15, 7) ^ right_rotate(w_i_sub_15, 18) ^ (w_i_sub_15 >> 3);
	w_i_sub_15_rotate_right_7_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => false,
		isLogical => true,
		toLeft => false,
		bitsToShift => 7
	)
	port map(
		input => w_i_sub_15_reg_out,
		output => w_i_sub_15_rotate_right_7
	);
	
	w_i_sub_15_rotate_right_18_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => false,
		isLogical => true,
		toLeft => false,
		bitsToShift => 18
	)
	port map(
		input => w_i_sub_15_reg_out,
		output => w_i_sub_15_rotate_right_18
	);
	
	w_i_sub_15_shift_right_3_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 3
	)
	port map(
		input => w_i_sub_15_reg_out,
		output => w_i_sub_15_rotate_right_3
	);
	
	w_i_sub_15_rotate_right_7_xor_w_i_sub_15_rotate_right_18_xor_w_i_sub_15_shift_right_3 <= w_i_sub_15_rotate_right_7 xor w_i_sub_15_rotate_right_18 xor w_i_sub_15_rotate_right_3;
	
	
	
	
	
	
	--right_rotate(w_i_sub_2, 17) ^ right_rotate(w_i_sub_2, 19) ^ (w_i_sub_2 >> 10); 
	w_i_sub_2_rotate_right_17_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => false,
		isLogical => true,
		toLeft => false,
		bitsToShift => 17
	)
	port map(
		input => w_i_sub_2_reg_out,
		output => w_i_sub_2_rotate_right_17
	);
	
	w_i_sub_2_rotate_right_19_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => false,
		isLogical => true,
		toLeft => false,
		bitsToShift => 19
	)
	port map(
		input => w_i_sub_2_reg_out,
		output => w_i_sub_2_rotate_right_19
	);
	
	w_i_sub_2_shift_right_10_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 10
	)
	port map(
		input => w_i_sub_2_reg_out,
		output => w_i_sub_2_rotate_right_10
	);
	
	w_i_sub_2_rotate_right_17_xor_w_i_sub_2_rotate_right_19_xor_w_i_sub_2_shift_right_10 <= w_i_sub_2_rotate_right_17 xor w_i_sub_2_rotate_right_19 xor w_i_sub_2_rotate_right_10;
	
	
	
	
	--w_i_sub_16 + s0 + w_i_sub_7 + s1; 
	w_i_sub_16_add_s0_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => w_i_sub_16_reg_out, b=>s0_reg_out,
		result => w_i_sub_16_add_s0 );
		
	w_i_sub_7_add_s1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => w_i_sub_7_reg_out, b=>s1_reg_out,
		result => w_i_sub_7_add_s1 );
		
	w_i_sub_16_add_s0_add_w_i_sub_7_add_s1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => w_i_sub_16_add_s0, b=>w_i_sub_7_add_s1,
		result => w_i_sub_16_add_s0_add_w_i_sub_7_add_s1 );
	
	
	
	
	
	--rotate(right_e, 6) ^ rotate(right_e, 11) ^ rotate(right_e, 25); 
	e_rotate_right_6_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 6
	)
	port map(
		input => e_reg_out,
		output => e_rotate_right_6
	);
	
	e_rotate_right_11_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 11
	)
	port map(
		input => e_reg_out,
		output => e_rotate_right_11
	);
	
	e_rotate_right_25_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 25
	)
	port map(
		input => e_reg_out,
		output => e_rotate_right_25
	);
	
	e_rotate_right_6_xor_e_rotate_right_11_xor_e_rotate_right_25 <= e_rotate_right_6 xor e_rotate_right_11 xor e_rotate_right_25;
	
	
	
	--(e & f) ^ ((~e) & g); 
	e_and_f_xor_not_e_and_g <= (e_reg_out and f_reg_out) xor ((not e_reg_out) and g_reg_out);
	
	
	
	
	--(h + s1 + ch + K[i] + w[i]); 
	h_add_s1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => h_reg_out, b => s1_reg_out,
		result => h_add_s1 );
	
	h_add_s1_add_ch_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => h_add_s1, b => ch_reg_out,
		result => h_add_s1_add_ch );
		
	k_i_add_w_i_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => k_ram_out, b => w_ram_out,
		result => k_i_add_w_i );
		
	h_add_s1_add_ch_add_k_i_add_w_i_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => h_add_s1_add_ch, b => k_i_add_w_i,
		result => h_add_s1_add_ch_add_k_i_add_w_i );
		
	
	
	
	--right_rotate(a, 2) ^ right_rotate(a, 13) ^ right_rotate(a, 22); 
	a_rotate_right_2_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 2
	)
	port map(
		input => e_reg_out,
		output => a_rotate_right_2
	);
	
	a_rotate_right_13_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 13
	)
	port map(
		input => e_reg_out,
		output => a_rotate_right_13
	);
	
	a_rotate_right_22_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 22
	)
	port map(
		input => e_reg_out,
		output => a_rotate_right_22
	);
	
	a_rotate_right_2_xor_a_rotate_right_13_xor_a_rotate_right_22 <= a_rotate_right_2 xor a_rotate_right_13 xor a_rotate_right_22;
	
	
	
	--(a & b) ^ (a & c) ^ (b & c); 
	a_and_b_xor_a_and_c_xor_b_and_c <=(a_reg_out and b_reg_out) xor (a_reg_out and c_reg_out) xor (b_reg_out and c_reg_out); 
	
	
	
	--(s0 + maj); 
	s0_add_maj_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => s0_reg_out, b => maj_reg_out,
		result => s0_add_maj );
		
		
		
	--d + temp1; 
	d_add_temp1_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => d_reg_out, b => temp1_reg_out,
		result => d_add_temp1 );
		
		
		
		
	--temp1 + temp2; 
	temp1_add_temp2_comp: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 0)
	port map(	
		op => '0',
		a => temp1_reg_out, b => temp2_reg_out,
		result => temp1_add_temp2 );
	
	
	
	
	
	
	--(HC[i]>>24) & 0xff
	hc_shift_right_24_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 24
	)
	port map(
		input => hc_ram_out,
		output => hc_shift_right_24
	);
	hc_shift_right_24_and_ff <= hc_shift_right_24 and "00000000000000000000000011111111";
	

	--(HC[i]>>16) & 0xff
	hc_shift_right_16_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 16
	)
	port map(
		input => hc_ram_out,
		output => hc_shift_right_16
	);
	hc_shift_right_16_and_ff <= hc_shift_right_16 and "00000000000000000000000011111111";

	
	--(HC[i]>>8) & 0xff
	hc_shift_right_8_comp : shifterRotator
	generic map(
		width => 32,
		isShifter => true,
		isLogical => true,
		toLeft => false,
		bitsToShift => 8
	)
	port map(
		input => hc_ram_out,
		output => hc_shift_right_8
	);
	hc_shift_right_8_and_ff <= hc_shift_right_8 and "00000000000000000000000011111111";

	--(HC[i]>>0) & 0xff
	hc_shift_right_0 <= hc_ram_out;
	hc_shift_right_0_and_ff <= hc_shift_right_0 and "00000000000000000000000011111111";
	
	
	--HC + a
	hc_add_a_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => a_reg_out, result => hc_add_a);
	
	--HC + b
	hc_add_b_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => b_reg_out, result => hc_add_b);
	
	--HC + c
	hc_add_c_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => c_reg_out, result => hc_add_c);
	
	--HC + d
	hc_add_d_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => d_reg_out, result => hc_add_d);
	
	--HC + e
	hc_add_e_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => e_reg_out, result => hc_add_e);
	
	--HC + f
	hc_add_f_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => f_reg_out, result => hc_add_f);

	--HC + g
	hc_add_g_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => g_reg_out, result => hc_add_g);
	
	--HC + h
	hc_add_h_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 0 )
	port map( op => '0', a => hc_ram_out, b => h_reg_out, result => hc_add_h);
	
	
	
	--chunk_id + 1
	chunk_id_add_1_comp : addersubtractor
	generic map( width => 32, isAdder => true, fixedSecodOperand => 1 )
	port map( op => '0', a => chunk_id_reg_out, b => (others=>'0'), result => chunk_id_add_1);
	
	
	-- END LA OPERATIONS --
	
	
	
	
	
	
	
	
	
	-- RAM MEMORIES ADDRESS MUXs --
	
	--H[i]; //ctrl29
	h_ram_address <= i_reg_out;
	
	
	--K[i]  //ctrl61
	k_ram_address <= i_reg_out;
	
	
	--main ram address set
	--ram[0]; //ctrl1
	--ram[1 + word_id]; //ctrl14
	mux_main_ram_address: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => (others => '0'), 
			input1 => word_id_add_1,
			sel => ctrl14,
			output => main_ram_address
			);
	
	
	
	
	
	
	
	
	
	--chunks[640] = {0}; //ctrl12
	chunks_ram_aclr <= ctrl12;
	
	
	--chunks[word_id] //ctrl14
	--chunks[word_id + 1] = 0x80; //ctrl15
	mux_chunks_ram_address_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => word_id_reg_out, 
			input1 => word_id_add_1,
			sel => ctrl15,
			output => mux_chunks_ram_address_0
			);
			
	--chunks[word_id + 1 + aux + 4 + 0] //ctrl18
	mux_chunks_ram_address_1_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_0, 
			input1 => word_id_add_1_add_aux_add_4_add_0,
			sel => ctrl18,
			output => mux_chunks_ram_address_1
			);
			
	--chunks[word_id + 1 + aux + 4 + 1] //ctrl20
	mux_chunks_ram_address_2_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_1, 
			input1 => word_id_add_1_add_aux_add_4_add_1,
			sel => ctrl20,
			output => mux_chunks_ram_address_2
			);
			
	--chunks[word_id + 1 + aux + 4 + 2] //ctrl22
	mux_chunks_ram_address_3_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_2, 
			input1 => word_id_add_1_add_aux_add_4_add_2,
			sel => ctrl22,
			output => mux_chunks_ram_address_3
			);
	
	--chunks[word_id + 1 + aux + 4 + 3] //ctrl24
	mux_chunks_ram_address_4_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_3, 
			input1 => word_id_add_1_add_aux_add_4_add_3,
			sel => ctrl24,
			output => mux_chunks_ram_address_4
			);
			
	--chunks[(chunk_id<<6) + (i<<2) + 0] //ctrl34
	mux_chunks_ram_address_5_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_4, 
			input1 => chunk_id_shift_left_6_add_i_shift_left_2_add_0,
			sel => ctrl34,
			output => mux_chunks_ram_address_5
			);
			
	--chunks[(chunk_id<<6) + (i<<2) + 1] //ctrl35
	mux_chunks_ram_address_6_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_5, 
			input1 => chunk_id_shift_left_6_add_i_shift_left_2_add_1,
			sel => ctrl35,
			output => mux_chunks_ram_address_6
			);
			
	--chunks[(chunk_id<<6) + (i<<2) + 2]  //ctrl36
	mux_chunks_ram_address_7_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_6, 
			input1 => chunk_id_shift_left_6_add_i_shift_left_2_add_2,
			sel => ctrl36,
			output => mux_chunks_ram_address_7
			);
	
	--chunks[(chunk_id<<6) + (i<<2) + 3]     //ctrl37
	mux_chunks_ram_address_8_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_address_7, 
			input1 => chunk_id_shift_left_6_add_i_shift_left_2_add_3,
			sel => ctrl37,
			output => chunks_ram_address --mux_chunks_ram_address_8
			);
	
	
	
	
	
	
	
	--uint32_t HC[8] = {0}; //ctrl27
	hc_ram_aclr <= ctrl27;
	
	--HC[0] //ctrl74
	--HC[1] //ctrl75
	mux_hc_ram_address_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => (others => '0'), 
			input1 => (0 => '1', others => '0'),
			sel => ctrl75,
			output => mux_hc_ram_address_0);
		
	--HC[2] //ctrl76
	mux_hc_ram_address_1_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_0, 
			input1 => (1 => '1', others => '0'),
			sel => ctrl76,
			output => mux_hc_ram_address_1);
			
	--HC[3] //ctrl77
	mux_hc_ram_address_2_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_1, 
			input1 => (0 => '1', 1 => '1', others => '0'),
			sel => ctrl77,
			output => mux_hc_ram_address_2);
			
	--HC[4] //ctrl78
	mux_hc_ram_address_3_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_2, 
			input1 => (2 => '1', others => '0'),
			sel => ctrl78,
			output => mux_hc_ram_address_3);
			
	--HC[5] //ctrl79
	mux_hc_ram_address_4_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_3, 
			input1 => (0 => '1', 2 => '1', others => '0'),
			sel => ctrl79,
			output => mux_hc_ram_address_4);
			
	--HC[6] //ctrl80
	mux_hc_ram_address_5_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_4, 
			input1 => (2 => '1', 1 => '1', others => '0'),
			sel => ctrl80,
			output => mux_hc_ram_address_5);
			
	--HC[7] //ctrl81
	mux_hc_ram_address_6_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_5, 
			input1 => (2 => '1', 1 => '1', 0 => '1', others => '0'),
			sel => ctrl81,
			output => mux_hc_ram_address_6);
	

	--HC[i] //ctrl29 ctrl84 ctrl85 ctrl86 ctrl87 ctrl89 ctrl90 ctrl91 ctrl92 ctrl94 
	--			ctrl95 ctrl96 ctrl97 ctrl99 ctrl100 ctrl101 ctrl102 ctrl104 ctrl105 ctrl106 ctrl107 
	--			ctrl109 ctrl110 ctrl111 ctrl112 ctrl114 ctrl115 ctrl116 ctrl117 ctrl119 ctrl120 ctrl121 ctrl122
	mux_hc_ram_address_7_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_address_6, 
			input1 => i_reg_out,
			sel => (
				ctrl29 or ctrl84 or ctrl85 or ctrl86 or ctrl87 or ctrl89
				or ctrl90 or ctrl91 or ctrl92 or ctrl94 or ctrl95 or ctrl96 or ctrl97 or ctrl99 or ctrl100 or ctrl101 
				or ctrl102 or ctrl104 or ctrl105 or ctrl106 or ctrl107 or ctrl109 or ctrl110 or ctrl111 or ctrl112 
				or ctrl114 or ctrl115 or ctrl116 or ctrl117 or ctrl119 or ctrl120 or ctrl121 or ctrl122
			),
			output => hc_ram_address);
	
	
	
	
	
	
	
	
	
	
	
	
	--w[64] = {0} //ctrl32
	w_ram_aclr <= ctrl32;
	
	
	--w[i-15] //ctrl41
	--w[i-2] //ctrl42
	mux_w_ram_address_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => i_sub_15, 
			input1 => i_sub_2,
			sel => ctrl42,
			output => mux_w_ram_address_0);
	
	--w[i-16] //ctrl45
	mux_w_ram_address_1_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_w_ram_address_0, 
			input1 => i_sub_16,
			sel => ctrl45,
			output => mux_w_ram_address_1);
			
	--w[i-7] //ctrl46
	mux_w_ram_address_2_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_w_ram_address_1, 
			input1 => i_sub_7,
			sel => ctrl46,
			output => mux_w_ram_address_2);
	
	--w[i] //ctrl38
	--w[i] //ctrl48
	--w[i] //ctrl61
	mux_w_ram_3_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_w_ram_address_2, 
			input1 => i_reg_out,
			sel => (ctrl38 or ctrl48 or ctrl61),
			output => w_ram_address);

	-- END RAM MEMORIES ADDRESS MUXs --
	
	
	
	
	
	
	
	
	
	
	
	-- RAM MEMORIES IN MUXs --
	
	--chunks[word_id] = ram[1 + word_id]; //ctrl14
	--chunks[word_id + 1] = 0x80; //ctrl15
	mux_chunks_ram_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => main_ram_out, 
			input1 => (0 => '1', others => '0'),
			sel => ctrl15,
			output => mux_chunks_ram_in_0);
			
	--chunks[word_id + 1 + aux + 4 + 0] = val; //ctrl18
	--chunks[word_id + 1 + aux + 4 + 1] = val; //ctrl20
	--chunks[word_id + 1 + aux + 4 + 2] = val; //ctrl22
	--chunks[word_id + 1 + aux + 4 + 3] = val //ctrl24
	mux_chunks_ram_in_1_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_chunks_ram_in_0, 
			input1 => val_reg_out,
			sel => (ctrl18 or ctrl20 or ctrl22 or ctrl24),
			output => chunks_ram_in);
	
	chunks_ram_wren <= (ctrl14 or ctrl15 or ctrl18 or ctrl20 or ctrl22 or ctrl24);
	
	
	
	
	
	
	
	
	--w[i] = (b3 | b2 | b1 | b0); //ctrl38
	--w[i] = res; //ctrl48
	mux_w_ram_in_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => b3_or_b2_or_b1_or_b0, 
			input1 => res_reg_out,
			sel => ctrl48,
			output => w_ram_in);
	
	w_ram_wren <= (ctrl38 or ctrl48);
	
	
	
	
	
	
	
	
	
	--HC[i] = H[i]; //ctrl29
	--HC[0] += a;  //ctrl74
	mux_hc_ram_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => h_ram_out, 
			input1 => hc_add_a,
			sel => ctrl74,
			output => mux_hc_ram_in_0);
			
	--HC[1] += b;  //ctrl75
	mux_hc_ram_in_1_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_0, 
			input1 => hc_add_b,
			sel => ctrl75,
			output => mux_hc_ram_in_1);
			
	--HC[2] += c;  //ctrl76
	mux_hc_ram_in_2_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_1, 
			input1 => hc_add_c,
			sel => ctrl76,
			output => mux_hc_ram_in_2);
			
	--HC[3] += d;  //ctrl77
	mux_hc_ram_in_3_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_2, 
			input1 => hc_add_d,
			sel => ctrl77,
			output => mux_hc_ram_in_3);
			
	--HC[4] += e;  //ctrl78
	mux_hc_ram_in_4_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_3, 
			input1 => hc_add_e,
			sel => ctrl78,
			output => mux_hc_ram_in_4);
			
	--HC[5] += f;  //ctrl79
	mux_hc_ram_in_5_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_4, 
			input1 => hc_add_f,
			sel => ctrl79,
			output => mux_hc_ram_in_5);
			
	--HC[6] += g;  //ctrl80
	mux_hc_ram_in_6_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_5, 
			input1 => hc_add_g,
			sel => ctrl80,
			output => mux_hc_ram_in_6);
			
			
	--HC[7] += h;  //ctrl81
	mux_hc_ram_in_7_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_hc_ram_in_6, 
			input1 => hc_add_h,
			sel => ctrl81,
			output => hc_ram_in);
	
	-- END RAM MEMORIES IN MUXs --
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	-- REGISTERS IN MUXs --
	
	--uint32_t len = ram[0]; //ctrl1
	len_reg_load <= ctrl1;
	len_reg_in <= main_ram_out;
	
	
	
	
	--uint32_t i = 0; //ctrl2
	--i = 0; //ctrl28
	--i = 0; //ctrl33
	--i = 0; //ctrl58
	--i = 0; //ctrl83
	
	--i = 16; //ctrl40
	--i++; //ctrl30
	--i++; //ctrl39
	--i++; //ctrl49
	--i++;  //ctrl73
	--i++;  //ctrl88
	mux_i_reg_in_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => (4 => '1', others => '0'), 
			input1 => i_add_1,
			sel => (ctrl30 or ctrl39 or ctrl49 or ctrl73 or ctrl88 or ctrl93 or ctrl98 or ctrl103 or ctrl108 or ctrl113 or ctrl118),
			output => i_reg_in);
	
	i_reg_clear <= (ctrl2 or ctrl28 or ctrl33 or ctrl58 or ctrl83);
	i_reg_load <= (ctrl40 or ctrl30 or ctrl39 or ctrl49 or ctrl73 or ctrl88 or ctrl93 or ctrl98 or ctrl103 or ctrl108 or ctrl113 or ctrl118);
	
	
	
	
	
	
	
	--char val = (char)((data_bits_count >> 24) & 0xff); //ctrl17
	--val = (char)((data_bits_count >> 16) & 0xff); //ctrl19
	mux_val_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => data_bits_count_shift_right_24_and_ff, 
			input1 => data_bits_count_shift_right_16_and_ff,
			sel => ctrl19,
			output => mux_val_reg_in_0);
	
	--val = (char)((data_bits_count >> 8) & 0xff); //ctrl21
	mux_val_reg_in_1_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_val_reg_in_0, 
			input1 => data_bits_count_shift_right_8_and_ff,
			sel => ctrl21,
			output => mux_val_reg_in_1);
			
	--val = (char)((data_bits_count) & 0xff); //ctrl23
	mux_val_reg_in_2_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => mux_val_reg_in_1, 
			input1 => data_bits_count_and_ff,
			sel => ctrl23,
			output => val_reg_in);
	
	val_reg_load <= (ctrl17 or ctrl19 or ctrl21 or ctrl23);
	
	
	
	
	
	--uint32_t word_id = 0; //ctrl13
	--word_id++; //ctrl26
	word_id_reg_clear <= ctrl13;
	word_id_reg_load <= ctrl26;
	word_id_reg_in <= word_id_add_1;
	
	
	
	
	--uint32_t k_bits_to_append = 0; //ctrl3
	--k_bits_to_append++; //ctrl8
	k_bits_to_append_reg_clear <= ctrl3;
	k_bits_to_append_reg_load <= ctrl8;
	k_bits_to_append_reg_in <= k_bits_to_append_add_1;
	
	
	
	
	--uint32_t data_words_count = len; //ctrl4
	data_words_count_reg_load <= ctrl4;
	data_words_count_reg_in <= len_reg_out;
	
	
	
	--uint32_t data_bits_count = len<<3; //ctrl5
	data_bits_count_reg_load <= ctrl5;
	data_bits_count_reg_in <= len_shift_left_3;
	
	
	
	
	
	--uint32_t total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl6
	--total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl9
	total_size_reg_load <= (ctrl6 or ctrl9);
	total_size_reg_in <= data_bits_count_add_1_add_k_bits_to_append_add_64;
	
	
	
	
	--uint32_t is_module_of_512 = (total_size & 0x1FF); //ctrl7
	--is_module_of_512 = (total_size & 0x1FF) //ctrl10
	is_module_of_512_reg_load <= (ctrl7 or ctrl10);
	is_module_of_512_reg_in <= total_size_and_1ff;
	
	
	--uint32_t chunks_count = total_size >> 9;  //ctrl11
	chunks_count_reg_load <= ctrl11;
	chunks_count_reg_in <= total_size_shift_right_9;
	
	
	--uint32_t aux = (k_bits_to_append+1) >> 3; //ctrl16
	aux_reg_load <= ctrl16;
	aux_reg_in <= k_bits_to_append_add_1_shift_right_3;
	
	
	
	--uint32_t chunk_id = 0; //ctrl31
	--chunk_id++;  //ctrl82
	chunk_id_reg_clear <= ctrl31;
	chunk_id_reg_load <= ctrl82;
	chunk_id_reg_in <= chunk_id_add_1;
	
	
	
	
	--uint32_t b3 = chunks[(chunk_id<<6) + (i<<2) + 0]<<24; //ctrl34
	b3_reg_load <= ctrl34;
	b3_reg_in <= chunks_ram_out;
	
	--uint32_t b2 = chunks[(chunk_id<<6) + (i<<2) + 1]<<16; //ctrl35
	b2_reg_load <= ctrl35;
	b2_reg_in <= chunks_ram_out;
	
	--uint32_t b1 = chunks[(chunk_id<<6) + (i<<2) + 2]<<8;  //ctrl36
	b1_reg_load <= ctrl36;
	b1_reg_in <= chunks_ram_out;
	
	--uint32_t b0 = chunks[(chunk_id<<6) + (i<<2) + 3];     //ctrl37
	b0_reg_load <= ctrl37;
	b0_reg_in <= chunks_ram_out;
	
	
	
	--uint32_t w_i_sub_15 = w[i-15]; //ctrl41
	w_i_sub_15_reg_load <= ctrl41;
	w_i_sub_15_reg_in <= w_ram_out;
	
	--uint32_t w_i_sub_2 = w[i-2]; //ctrl42
	w_i_sub_2_reg_load <= ctrl42;
	w_i_sub_2_reg_in <= w_ram_out;
	
	--uint32_t w_i_sub_16 = w[i-16]; //ctrl45
	w_i_sub_16_reg_load <= ctrl45;
	w_i_sub_16_reg_in <= w_ram_out;
	
	--uint32_t w_i_sub_7 = w[i-7]; //ctrl46
	w_i_sub_7_reg_load <= ctrl46;
	w_i_sub_7_reg_in <= w_ram_out;
	
	
	
	--uint32_t s0 = right_rotate(w_i_sub_15, 7) ^ right_rotate(w_i_sub_15, 18) ^ (w_i_sub_15 >> 3); //ctrl43
	--uint32_t s0 = right_rotate(a, 2) ^ right_rotate(a, 13) ^ right_rotate(a, 22);  //ctrl62
	mux_s0_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => w_i_sub_15_rotate_right_7_xor_w_i_sub_15_rotate_right_18_xor_w_i_sub_15_shift_right_3, 
			input1 => a_rotate_right_2_xor_a_rotate_right_13_xor_a_rotate_right_22,
			sel => ctrl62,
			output => s0_reg_in);
	
	s0_reg_load <= (ctrl43 or ctrl62);
	
	
	--uint32_t s1 = right_rotate(w_i_sub_2, 17) ^ right_rotate(w_i_sub_2, 19) ^ (w_i_sub_2 >> 10); //ctrl44
	--uint32_t s1 = right_rotate(e, 6) ^ right_rotate(e, 11) ^ right_rotate(e, 25); //ctrl59
	mux_s1_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => w_i_sub_2_rotate_right_17_xor_w_i_sub_2_rotate_right_19_xor_w_i_sub_2_shift_right_10, 
			input1 => e_rotate_right_6_xor_e_rotate_right_11_xor_e_rotate_right_25,
			sel => ctrl59,
			output => s1_reg_in);
	
	s1_reg_load <= (ctrl44 or ctrl59);
	
	

	
	--uint32_t res = w_i_sub_16 + s0 + w_i_sub_7 + s1; //ctrl47
	res_reg_load <= ctrl47;
	res_reg_in <= w_i_sub_16_add_s0_add_w_i_sub_7_add_s1;
	
	
	--uint32_t ch = (e & f) ^ ((~e) & g);  //ctrl60
	ch_reg_load <= ctrl60;
	ch_reg_in <= e_and_f_xor_not_e_and_g;
	
	
	--uint32_t temp1 = (h + s1 + ch + K[i] + w[i]); //ctrl61
	temp1_reg_load <= ctrl61;
	temp1_reg_in <= h_add_s1_add_ch_add_k_i_add_w_i;
	
	--uint32_t maj = (a & b) ^ (a & c) ^ (b & c);  //ctrl63
	maj_reg_load <= ctrl63;
	maj_reg_in <= a_and_b_xor_a_and_c_xor_b_and_c;
	
	--uint32_t temp2 = (s0 + maj);  //ctrl64
	temp2_reg_load <= ctrl64;
	temp2_reg_in <= s0_add_maj;
	
	
	
	--uint32_t h = 0x5be0cd19; //ctrl57
	--h = g;  //ctrl65
	mux_h_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "01011011111000001100110100011001", 
			input1 => g_reg_out,
			sel => ctrl65,
			output => h_reg_in);
	
	h_reg_load <= (ctrl57 or ctrl65);
	
	
	--uint32_t g = 0x1f83d9ab; //ctrl56
	--g = f;  //ctrl66
	mux_g_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "00011111100000111101100110101011", 
			input1 => f_reg_out,
			sel => ctrl66,
			output => g_reg_in);
	
	g_reg_load <= (ctrl56 or ctrl66);
	
	
	--uint32_t f = 0x9b05688c; //ctrl55
	--f = e;  //ctrl67
	mux_f_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "10011011000001010110100010001100", 
			input1 => e_reg_out,
			sel => ctrl67,
			output => f_reg_in);
	
	f_reg_load <= (ctrl55 or ctrl67);
	
	
	--uint32_t e = 0x510e527f; //ctrl54
	--e = d + temp1;  //ctrl68
	mux_e_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "01010001000011100101001001111111", 
			input1 => d_add_temp1,
			sel => ctrl68,
			output => e_reg_in);
	
	e_reg_load <= (ctrl54 or ctrl68);
	
	
	--uint32_t d = 0xa54ff53a; //ctrl53
	--d = c;  //ctrl69
	mux_d_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "10100101010011111111010100111010", 
			input1 => c_reg_out,
			sel => ctrl69,
			output => d_reg_in);
	
	d_reg_load <= (ctrl53 or ctrl69);
	
	
	--uint32_t c = 0x3c6ef372; //ctrl52
	--c = b;  //ctrl70
	mux_c_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "00111100011011101111001101110010", 
			input1 => b_reg_out,
			sel => ctrl70,
			output => c_reg_in);
	
	c_reg_load <= (ctrl52 or ctrl70);
	
	
	
	--uint32_t b = 0xbb67ae85; //ctrl51
	--b = a;  //ctrl71
	mux_b_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "10111011011001111010111010000101", 
			input1 => a_reg_out,
			sel => ctrl71,
			output => b_reg_in);
	
	b_reg_load <= (ctrl51 or ctrl71);
	
	
	
	--uint32_t a = 0x6a09e667; //ctrl50
	--a = temp1 + temp2;  //ctrl72
	mux_a_reg_in_0_comp: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => "01101010000010011110011001100111", 
			input1 => temp1_add_temp2,
			sel => ctrl72,
			output => a_reg_in);
	
	a_reg_load <= (ctrl50 or ctrl72);
	
	
	
	
	
	
	
	ob0_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob1_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob2_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob3_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob4_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob5_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob6_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob7_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob8_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob9_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob10_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob11_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob12_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob13_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob14_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob15_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob16_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob17_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob18_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob19_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob20_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob21_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob22_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob23_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob24_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob25_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob26_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob27_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob28_reg_in <= hc_shift_right_24_and_ff(7 downto 0);
	ob29_reg_in <= hc_shift_right_16_and_ff(7 downto 0);
	ob30_reg_in <= hc_shift_right_8_and_ff(7 downto 0);
	ob31_reg_in <= hc_shift_right_0_and_ff(7 downto 0);
	ob0_reg_load <= ctrl84;
	ob1_reg_load <= ctrl85;
	ob2_reg_load <= ctrl86;
	ob3_reg_load <= ctrl87;
	ob4_reg_load <= ctrl89;
	ob5_reg_load <= ctrl90;
	ob6_reg_load <= ctrl91;
	ob7_reg_load <= ctrl92;
	ob8_reg_load <= ctrl94;
	ob9_reg_load <= ctrl95;
	ob10_reg_load <= ctrl96;
	ob11_reg_load <= ctrl97;
	ob12_reg_load <= ctrl99;
	ob13_reg_load <= ctrl100;
	ob14_reg_load <= ctrl101;
	ob15_reg_load <= ctrl102;
	ob16_reg_load <= ctrl104;
	ob17_reg_load <= ctrl105;
	ob18_reg_load <= ctrl106;
	ob19_reg_load <= ctrl107;
	ob20_reg_load <= ctrl109;
	ob21_reg_load <= ctrl110;
	ob22_reg_load <= ctrl111;
	ob23_reg_load <= ctrl112;
	ob24_reg_load <= ctrl114;
	ob25_reg_load <= ctrl115;
	ob26_reg_load <= ctrl116;
	ob27_reg_load <= ctrl117;
	ob28_reg_load <= ctrl119;
	ob29_reg_load <= ctrl120;
	ob30_reg_load <= ctrl121;
	ob31_reg_load <= ctrl122;
	
	
	
	
	-- END REGISTERS IN MUXs --
	
	
	
	
	
	
	
	
	
	
	-- STTs --
	
	--while (is_module_of_512 != 0){ //stt1
	stt1 <= not is_module_of_512_equal_0;
	
	--if (chunks_count > max_chunks_count) return;  //stt2
	stt2 <= chunks_count_higher_than_max_chunks_count;
	
			
	--while (word_id < data_words_count){ //stt3
	stt3 <= word_id_less_than_data_words_count;
	
	--if (word_id == data_words_count - 1){ //stt4
	stt4 <= word_id_equal_data_words_count_sub_1;
	
	--while (chunk_id < chunks_count){ //stt6
	stt6 <= chunk_id_less_than_chunks_count;
	
	--while (i < 8){ //stt5
	stt5 <= i_less_than_8;
	
	--while (i < 16){ //stt7
	stt7 <= i_less_than_16;
	
	--while (i < 64){ //stt8
	stt8 <= i_less_than_64;
	
	--while (i < 64){ //stt9
	stt9 <= i_less_than_64;
	
	--while (i < 32){ //stt10
	stt10 <= i_less_than_32;
	
	-- END STTs --
	
	
	
	
	output<= ob0_reg_out & ob1_reg_out & ob2_reg_out & ob3_reg_out & ob4_reg_out & ob5_reg_out 
	& ob6_reg_out & ob7_reg_out & ob8_reg_out & ob9_reg_out & ob10_reg_out & ob11_reg_out & ob12_reg_out 
	& ob13_reg_out & ob14_reg_out & ob15_reg_out & ob16_reg_out & ob17_reg_out & ob18_reg_out & ob19_reg_out 
	& ob20_reg_out & ob21_reg_out & ob22_reg_out & ob23_reg_out & ob24_reg_out & ob25_reg_out & ob26_reg_out 
	& ob27_reg_out & ob28_reg_out & ob29_reg_out & ob30_reg_out & ob31_reg_out;
	
	
	
end architecture;