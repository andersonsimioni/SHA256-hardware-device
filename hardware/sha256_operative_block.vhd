library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_operative_block is port(
	clock, chip_reset : in std_logic;
	
	ctrl0, ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7, ctrl8, ctrl9,
	 ctrl10, ctrl11, ctrl12, ctrl13, ctrl14, ctrl15, ctrl16, ctrl17, ctrl18, ctrl19,
	 ctrl20, ctrl21, ctrl22, ctrl23, ctrl24, ctrl25, ctrl26, ctrl27, ctrl28, ctrl29,
	 ctrl30, ctrl31, ctrl32, ctrl33, ctrl34, ctrl35, ctrl36, ctrl37, ctrl38, ctrl39,
	 ctrl40, ctrl41, ctrl42, ctrl43, ctrl44, ctrl45, ctrl46, ctrl47, ctrl48, ctrl49,
	 ctrl50, ctrl51, ctrl52, ctrl53, ctrl54, ctrl55, ctrl56, ctrl57, ctrl58, ctrl59,
	 ctrl60, ctrl61 : in std_logic;
	
	stt0, stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8 : out std_logic;
	
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
	
	signal chunks_ram_aclr : std_logic;
	signal chunks_ram_out, chunks_ram_in, chunks_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal w_ram_aclr : std_logic;
	signal w_ram_out, w_ram_in, w_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal k_ram_aclr : std_logic;
	signal k_ram_out, k_ram_in, k_ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
	signal h_ram_aclr : std_logic;
	signal h_ram_out, h_ram_in, h_ram_address : std_logic_vector(31 downto 0) := (others => '0');
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
	
	signal val_reg_out, val_reg_in : std_logic_vector(7 downto 0);
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
	signal i_less_than_16 : std_logic;
	signal i_less_than_18 : std_logic;
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
	
	signal chunk_id_less_than_chunks_count : std_logic;
	
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

	-- END LA OPERATIONS --
	
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
		wren => '0',
		q	=> chunks_ram_out
	);
	
	w_ram: ram_32 PORT MAP
	(
		clock=>clock,
		address => w_ram_address(9 downto 0),
		data => w_ram_in,
		wren => '0',
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
	port map( clock=>clock, clear => val_reg_clear, load => val_reg_load, input => val_reg_in, output => val_reg_out);
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
	addersubtractor1: addersubtractor
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
			lessThan => i_less_than_18
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
	
	
	-- END LA OPERATIONS --
	
	
	
	
	
	
	--main ram address set
	--ram[0]; //ctrl0
	--ram[1 + word_id]; //ctrl11
	mux_main_ram_address: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => (others => '0'), 
			input1 => word_id_add_1,
			sel => ctrl11,
			output => main_ram_address
			);
	
	
	
	
end architecture;