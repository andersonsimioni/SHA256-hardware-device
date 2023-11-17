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
	
	
	-- RAM MEMORY PART --
	signal ram_read_data, ram_address : std_logic_vector(31 downto 0) := (others => '0');
	
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
	signal aux_reg_out, aux_reg_in : std_logic_vector(31 downto 0);
	signal chunk_id_reg_out, chunk_id_reg_in : std_logic_vector(31 downto 0);
	signal b3_reg_out, b3_reg_in : std_logic_vector(31 downto 0);
	signal b2_reg_out, b2_reg_in : std_logic_vector(31 downto 0);
	signal b1_reg_out, b1_reg_in : std_logic_vector(31 downto 0);
	signal b0_reg_out, b0_reg_in : std_logic_vector(31 downto 0);
	signal w_i_sub_15_reg_out, w_i_sub_15_reg_in : std_logic_vector(31 downto 0);
	signal w_i_sub_2_reg_out, w_i_sub_2_reg_in : std_logic_vector(31 downto 0);
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
	
	
	
	
	
	
	signal word_id_add_1 : std_logic_vector(31 downto 0) := (others => '0');
	signal i_add_1 : std_logic_vector(31 downto 0) := (others => '0');
	
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
		address	=> ram_address(7 DOWNTO 0),
		data => (others => '0'),
		wren => '0',
		q => ram_read_data(7 DOWNTO 0)
	);
	-- END RAM MEMORY INSTANCES --
	
	
	
	
	-- REGISTERS INSTANCES --
	reg_len : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => len_reg_in, output => len_reg_out);

	reg_i : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => ctrl1, load => (ctrl16 or ctrl11 or ctrl26), input => i_reg_in, output => i_reg_out);

	reg_k_bits_to_append : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => k_bits_to_append_reg_in, output => k_bits_to_append_reg_out);

	reg_data_words_count : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => ctrl1, load => ctrl3, input => data_words_count_reg_in, output => data_words_count_reg_out);

	reg_data_bits_count : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => data_bits_count_reg_in, output => data_bits_count_reg_out);

	reg_total_size : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => total_size_reg_in, output => total_size_reg_out);

	reg_is_module_of_512 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => is_module_of_512_reg_in, output => is_module_of_512_reg_out);

	reg_chunks_count : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => chunks_count_reg_in, output => chunks_count_reg_out);

	reg_word_id : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => word_id_reg_in, output => word_id_reg_out);

	reg_aux : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => aux_reg_in, output => aux_reg_out);

	reg_chunk_id : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => chunk_id_reg_in, output => chunk_id_reg_out);

	reg_b3 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => b3_reg_in, output => b3_reg_out);

	reg_b2 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => b2_reg_in, output => b2_reg_out);

	reg_b1 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => b1_reg_in, output => b1_reg_out);

	reg_b0 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => b0_reg_in, output => b0_reg_out);

	reg_w_i_sub_15 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => w_i_sub_15_reg_in, output => w_i_sub_15_reg_out);

	reg_w_i_sub_2 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => w_i_sub_2_reg_in, output => w_i_sub_2_reg_out);

	reg_s0 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => s0_reg_in, output => s0_reg_out);

	reg_s1 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => s1_reg_in, output => s1_reg_out);

	reg_res : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => res_reg_in, output => res_reg_out);

	reg_a : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => a_reg_in, output => a_reg_out);

	reg_b : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => b_reg_in, output => b_reg_out);

	reg_c : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => c_reg_in, output => c_reg_out);

	reg_d : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => d_reg_in, output => d_reg_out);

	reg_e : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => e_reg_in, output => e_reg_out);

	reg_f : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => f_reg_in, output => f_reg_out);

	reg_g : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => g_reg_in, output => g_reg_out);

	reg_h : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => h_reg_in, output => h_reg_out);

	reg_ch : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => ch_reg_in, output => ch_reg_out);

	reg_temp1 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => temp1_reg_in, output => temp1_reg_out);

	reg_maj : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => maj_reg_in, output => maj_reg_out);

	reg_temp2 : registerN
	generic map( width => 32, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => temp2_reg_in, output => temp2_reg_out);
	
	reg_val : registerN
	generic map( width => 8, generateLoad => true, clearValue => 0 )
	port map( clock=>clock, clear => '0', load => '0', input => val_reg_in, output => val_reg_out);
	-- END REGISTERS INSTANCES --
	
	
	
	
	
	
	
	--uint32_t len = ram[0]; //ctrl0
	--chunks[word_id] = ram[word_id+1]; //ctrl11
	--word_id+1
	addersubtractor0: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => word_id_reg_out, b=>(others => '0'),
		result => word_id_add_1 );
	
	-- if ctrl11 ram_address = 0 else ram_address = word_id + 1 
	mux0: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => word_id_add_1, 
			input1 => (others => '0'),
			sel => ctrl11,
			output => ram_address
			);
			
			

			
	
	--uint32_t i = 0; //ctrl1
	--i++; //ctrl16
	--i = 16; //ctrl26
	
	mux1: multiplexer2x1
	generic map(	width => 32 )
	port map(	
			input0 => i_add_1_out, 
			input1 => (5 => '1', others => '0'), --16
			sel => ctrl26,
			output => i_reg_in
			);
	
	--i++;
	addersubtractor1: addersubtractor
	generic map(	
			width => 32,
			isAdder => true,
			fixedSecodOperand => 1)
	port map(	
		op => '0',
		a => i_reg_out, b=>(others => '0'),
		result => i_add_1 );
	
	
	
	
	
	
	
	--uint32_t data_words_count = len; //ctrl3
	--uint32_t data_bits_count = len<<3; //ctrl4
	--uint32_t total_size = (data_bits_count + 1 + k_bits_to_append + 64); //ctrl5
	--uint32_t is_module_of_512 = (total_size & 0x1FF); //ctrl6;
	
	
	
	
end architecture;