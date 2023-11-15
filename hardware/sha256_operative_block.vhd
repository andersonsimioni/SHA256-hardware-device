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
	
	
	signal ram_address : std_logic_vector(7 downto 0);
	signal ram_read_data : std_logic_vector(31 downto 0);
	
	signal word_id_add_1 : std_logic_vector(31 downto 0);
	signal word_id_reg_out : std_logic_vector(31 downto 0);
	
begin
	
	--uint32_t len = ram[0]; //ctrl0
	--chunks[word_id] = ram[word_id+1]; //ctrl11
	
	reg_ram_data: registerN
	generic map(	width => 32,
				generateLoad => true,
				clearValue => 0 )
	port map(	-- control
			clock, clear => chip_reset, load => (ctrl0 or ctrl11),
			-- data
			input => ram_address,
			output => ram_read_data);
	
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
			input0=>(others => '0'), 
			input1=> word_id_add_1,
			sel => ctrl11,
			output => ram_address
			);

			
	
	--uint32_t i = 0; //ctrl1
	--i++; //ctrl16
	--i = 16; //ctrl26
	
	reg_i: registerN
	generic map(	width => 32,
				generateLoad => true,
				clearValue => 0 )
	port map(	-- control
			clock, clear => chip_reset, load => (ctrl16 or ctrl11 or ctrl26),
			-- data
			input => ram_address,
			output => ram_read_data);
	
end architecture;