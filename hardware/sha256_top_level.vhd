library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_top_level is
  port (
    clock, chip_select, chip_ready, chip_reset : in std_logic;
	 output : out std_logic_vector(255 downto 0)
  ) ;
end sha256_top_level;

architecture sha256_top_level_arch of sha256_top_level is

    signal 
        ctrl0, ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7, ctrl8, ctrl9,
        ctrl10, ctrl11, ctrl12, ctrl13, ctrl14, ctrl15, ctrl16, ctrl17, ctrl18, ctrl19,
        ctrl20, ctrl21, ctrl22, ctrl23, ctrl24, ctrl25, ctrl26, ctrl27, ctrl28, ctrl29,
        ctrl30, ctrl31, ctrl32, ctrl33, ctrl34, ctrl35, ctrl36, ctrl37, ctrl38, ctrl39,
        ctrl40, ctrl41, ctrl42, ctrl43, ctrl44, ctrl45, ctrl46, ctrl47, ctrl48, ctrl49,
        ctrl50, ctrl51, ctrl52, ctrl53, ctrl54, ctrl55, ctrl56, ctrl57, ctrl58, ctrl59,
        ctrl60
    : std_logic;

    signal 
        stt0, stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8
    : std_logic;

begin

end sha256_top_level_arch ; -- sha256_top_level_arch