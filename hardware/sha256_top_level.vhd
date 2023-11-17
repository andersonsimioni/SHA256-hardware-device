library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_top_level is
  port (
    clock, chip_select, chip_reset : in std_logic;
	 chip_ready : out std_logic;
	 output : out std_logic_vector(255 downto 0)
  ) ;
end sha256_top_level;

architecture sha256_top_level_arch of sha256_top_level is
	
	component sha256_control_block is
	  port (
			clock, chip_select, chip_reset : in std_logic;
			chip_ready : out std_logic;
		 
			stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10 : in std_logic;
		 
			ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
			ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
			ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
			ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
			ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
			ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
			ctrl87,ctrl88 : out std_logic
		 
	  ) ;
	end component;
	
	component sha256_operative_block is port(
		clock, chip_reset : in std_logic;
		
		ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
		ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
		ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
		ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
		ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
		ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
		ctrl87,ctrl88 : in std_logic;
		
		stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10 : out std_logic;
		
		output : out std_logic_vector(255 downto 0)
	);
	end component;




    signal 
		ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
		ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
		ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
		ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
		ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
		ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
		ctrl87,ctrl88
    : std_logic;

    signal 
        stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10
    : std_logic;
	 

begin



	sha256_control_block_0: sha256_control_block
	  port map(
		clock, chip_select, chip_reset,
		chip_ready,
		 
		stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10,
		 
		ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
		ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
		ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
		ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
		ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
		ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
		ctrl87,ctrl88
		 
	  ) ;
	  
	  




	sha256_operative_block_0: sha256_operative_block  port map(
		clock, chip_reset,
		
		ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
		ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
		ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
		ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
		ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
		ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
		ctrl87,ctrl88,
		
		stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10,
		
		output=>output
	);
	
	
	
	
	
	

end sha256_top_level_arch ; -- sha256_top_level_arch