-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "11/17/2023 00:11:23"

-- 
-- Device: Altera EP4CGX50DF27C6 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	sha256_top_level IS
    PORT (
	clock : IN std_logic;
	chip_select : IN std_logic;
	chip_reset : IN std_logic;
	chip_ready : BUFFER std_logic;
	output : BUFFER std_logic_vector(255 DOWNTO 0)
	);
END sha256_top_level;

-- Design Ports Information
-- chip_ready	=>  Location: PIN_AF12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[0]	=>  Location: PIN_AF16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[1]	=>  Location: PIN_J26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[2]	=>  Location: PIN_AC24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[3]	=>  Location: PIN_AD12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[4]	=>  Location: PIN_AC11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[5]	=>  Location: PIN_C5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[6]	=>  Location: PIN_AE21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[7]	=>  Location: PIN_Y25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[8]	=>  Location: PIN_D16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[9]	=>  Location: PIN_L26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[10]	=>  Location: PIN_H26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[11]	=>  Location: PIN_AC21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[12]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[13]	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[14]	=>  Location: PIN_AE25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[15]	=>  Location: PIN_B19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[16]	=>  Location: PIN_J25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[17]	=>  Location: PIN_E23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[18]	=>  Location: PIN_V26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[19]	=>  Location: PIN_AC19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[20]	=>  Location: PIN_G23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[21]	=>  Location: PIN_G24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[22]	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[23]	=>  Location: PIN_C26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[24]	=>  Location: PIN_D24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[25]	=>  Location: PIN_AD23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[26]	=>  Location: PIN_AE22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[27]	=>  Location: PIN_AF24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[28]	=>  Location: PIN_A22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[29]	=>  Location: PIN_U19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[30]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[31]	=>  Location: PIN_M26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[32]	=>  Location: PIN_B23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[33]	=>  Location: PIN_C14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[34]	=>  Location: PIN_AD21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[35]	=>  Location: PIN_G22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[36]	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[37]	=>  Location: PIN_H25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[38]	=>  Location: PIN_AB24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[39]	=>  Location: PIN_C4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[40]	=>  Location: PIN_AF23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[41]	=>  Location: PIN_AC26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[42]	=>  Location: PIN_V22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[43]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[44]	=>  Location: PIN_AF7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[45]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[46]	=>  Location: PIN_AF15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[47]	=>  Location: PIN_AD14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[48]	=>  Location: PIN_T21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[49]	=>  Location: PIN_AD6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[50]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[51]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[52]	=>  Location: PIN_AC14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[53]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[54]	=>  Location: PIN_B25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[55]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[56]	=>  Location: PIN_V21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[57]	=>  Location: PIN_M23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[58]	=>  Location: PIN_B18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[59]	=>  Location: PIN_A23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[60]	=>  Location: PIN_AC6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[61]	=>  Location: PIN_H23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[62]	=>  Location: PIN_AB18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[63]	=>  Location: PIN_T25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[64]	=>  Location: PIN_AA25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[65]	=>  Location: PIN_A25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[66]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[67]	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[68]	=>  Location: PIN_Y26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[69]	=>  Location: PIN_H24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[70]	=>  Location: PIN_AF17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[71]	=>  Location: PIN_R24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[72]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[73]	=>  Location: PIN_AB7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[74]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[75]	=>  Location: PIN_AC25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[76]	=>  Location: PIN_AE26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[77]	=>  Location: PIN_L25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[78]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[79]	=>  Location: PIN_A3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[80]	=>  Location: PIN_N24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[81]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[82]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[83]	=>  Location: PIN_L23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[84]	=>  Location: PIN_AC5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[85]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[86]	=>  Location: PIN_AE6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[87]	=>  Location: PIN_P19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[88]	=>  Location: PIN_D15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[89]	=>  Location: PIN_R23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[90]	=>  Location: PIN_D3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[91]	=>  Location: PIN_C7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[92]	=>  Location: PIN_T23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[93]	=>  Location: PIN_AD20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[94]	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[95]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[96]	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[97]	=>  Location: PIN_AE18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[98]	=>  Location: PIN_AD7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[99]	=>  Location: PIN_G25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[100]	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[101]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[102]	=>  Location: PIN_D23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[103]	=>  Location: PIN_R25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[104]	=>  Location: PIN_C17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[105]	=>  Location: PIN_AD26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[106]	=>  Location: PIN_F24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[107]	=>  Location: PIN_E24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[108]	=>  Location: PIN_A2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[109]	=>  Location: PIN_AC12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[110]	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[111]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[112]	=>  Location: PIN_E21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[113]	=>  Location: PIN_J23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[114]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[115]	=>  Location: PIN_AC17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[116]	=>  Location: PIN_AD10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[117]	=>  Location: PIN_U24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[118]	=>  Location: PIN_AE19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[119]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[120]	=>  Location: PIN_AD17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[121]	=>  Location: PIN_K23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[122]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[123]	=>  Location: PIN_AE15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[124]	=>  Location: PIN_AE23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[125]	=>  Location: PIN_P20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[126]	=>  Location: PIN_C20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[127]	=>  Location: PIN_AA26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[128]	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[129]	=>  Location: PIN_E7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[130]	=>  Location: PIN_AC16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[131]	=>  Location: PIN_AE3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[132]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[133]	=>  Location: PIN_AD4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[134]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[135]	=>  Location: PIN_T26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[136]	=>  Location: PIN_A24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[137]	=>  Location: PIN_L22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[138]	=>  Location: PIN_AC10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[139]	=>  Location: PIN_Y22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[140]	=>  Location: PIN_A21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[141]	=>  Location: PIN_AE10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[142]	=>  Location: PIN_AC4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[143]	=>  Location: PIN_R19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[144]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[145]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[146]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[147]	=>  Location: PIN_AF22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[148]	=>  Location: PIN_C23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[149]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[150]	=>  Location: PIN_B15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[151]	=>  Location: PIN_L24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[152]	=>  Location: PIN_AE5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[153]	=>  Location: PIN_AA23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[154]	=>  Location: PIN_D22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[155]	=>  Location: PIN_Y21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[156]	=>  Location: PIN_AF21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[157]	=>  Location: PIN_M19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[158]	=>  Location: PIN_B22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[159]	=>  Location: PIN_A19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[160]	=>  Location: PIN_A16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[161]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[162]	=>  Location: PIN_Y23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[163]	=>  Location: PIN_K21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[164]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[165]	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[166]	=>  Location: PIN_D20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[167]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[168]	=>  Location: PIN_U23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[169]	=>  Location: PIN_L19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[170]	=>  Location: PIN_D21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[171]	=>  Location: PIN_F26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[172]	=>  Location: PIN_AB14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[173]	=>  Location: PIN_B21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[174]	=>  Location: PIN_AD8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[175]	=>  Location: PIN_E2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[176]	=>  Location: PIN_N23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[177]	=>  Location: PIN_D18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[178]	=>  Location: PIN_AF4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[179]	=>  Location: PIN_N22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[180]	=>  Location: PIN_AD24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[181]	=>  Location: PIN_M24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[182]	=>  Location: PIN_A15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[183]	=>  Location: PIN_J24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[184]	=>  Location: PIN_M25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[185]	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[186]	=>  Location: PIN_AD9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[187]	=>  Location: PIN_AD16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[188]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[189]	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[190]	=>  Location: PIN_C24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[191]	=>  Location: PIN_AF6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[192]	=>  Location: PIN_D25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[193]	=>  Location: PIN_AB5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[194]	=>  Location: PIN_E26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[195]	=>  Location: PIN_W26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[196]	=>  Location: PIN_AD3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[197]	=>  Location: PIN_AF19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[198]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[199]	=>  Location: PIN_AB23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[200]	=>  Location: PIN_C21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[201]	=>  Location: PIN_AC18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[202]	=>  Location: PIN_AB26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[203]	=>  Location: PIN_H22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[204]	=>  Location: PIN_T24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[205]	=>  Location: PIN_R22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[206]	=>  Location: PIN_F23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[207]	=>  Location: PIN_R20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[208]	=>  Location: PIN_B26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[209]	=>  Location: PIN_AE13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[210]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[211]	=>  Location: PIN_K24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[212]	=>  Location: PIN_V23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[213]	=>  Location: PIN_AC20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[214]	=>  Location: PIN_C22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[215]	=>  Location: PIN_B9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[216]	=>  Location: PIN_AC13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[217]	=>  Location: PIN_AC9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[218]	=>  Location: PIN_D14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[219]	=>  Location: PIN_K22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[220]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[221]	=>  Location: PIN_M22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[222]	=>  Location: PIN_AD22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[223]	=>  Location: PIN_A20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[224]	=>  Location: PIN_AC22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[225]	=>  Location: PIN_D26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[226]	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[227]	=>  Location: PIN_AF18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[228]	=>  Location: PIN_AA22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[229]	=>  Location: PIN_D4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[230]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[231]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[232]	=>  Location: PIN_W22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[233]	=>  Location: PIN_AD19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[234]	=>  Location: PIN_AF20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[235]	=>  Location: PIN_AE2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[236]	=>  Location: PIN_AD13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[237]	=>  Location: PIN_AE17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[238]	=>  Location: PIN_W23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[239]	=>  Location: PIN_AC23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[240]	=>  Location: PIN_AB11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[241]	=>  Location: PIN_E22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[242]	=>  Location: PIN_K26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[243]	=>  Location: PIN_AF2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[244]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[245]	=>  Location: PIN_U26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[246]	=>  Location: PIN_AF9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[247]	=>  Location: PIN_AA21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[248]	=>  Location: PIN_AE9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[249]	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[250]	=>  Location: PIN_E25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[251]	=>  Location: PIN_AB9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[252]	=>  Location: PIN_L21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[253]	=>  Location: PIN_AD11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[254]	=>  Location: PIN_AE11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[255]	=>  Location: PIN_P23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- chip_select	=>  Location: PIN_AF13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_T15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- chip_reset	=>  Location: PIN_T14,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF sha256_top_level IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_chip_select : std_logic;
SIGNAL ww_chip_reset : std_logic;
SIGNAL ww_chip_ready : std_logic;
SIGNAL ww_output : std_logic_vector(255 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \chip_reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \chip_ready~output_o\ : std_logic;
SIGNAL \output[0]~output_o\ : std_logic;
SIGNAL \output[1]~output_o\ : std_logic;
SIGNAL \output[2]~output_o\ : std_logic;
SIGNAL \output[3]~output_o\ : std_logic;
SIGNAL \output[4]~output_o\ : std_logic;
SIGNAL \output[5]~output_o\ : std_logic;
SIGNAL \output[6]~output_o\ : std_logic;
SIGNAL \output[7]~output_o\ : std_logic;
SIGNAL \output[8]~output_o\ : std_logic;
SIGNAL \output[9]~output_o\ : std_logic;
SIGNAL \output[10]~output_o\ : std_logic;
SIGNAL \output[11]~output_o\ : std_logic;
SIGNAL \output[12]~output_o\ : std_logic;
SIGNAL \output[13]~output_o\ : std_logic;
SIGNAL \output[14]~output_o\ : std_logic;
SIGNAL \output[15]~output_o\ : std_logic;
SIGNAL \output[16]~output_o\ : std_logic;
SIGNAL \output[17]~output_o\ : std_logic;
SIGNAL \output[18]~output_o\ : std_logic;
SIGNAL \output[19]~output_o\ : std_logic;
SIGNAL \output[20]~output_o\ : std_logic;
SIGNAL \output[21]~output_o\ : std_logic;
SIGNAL \output[22]~output_o\ : std_logic;
SIGNAL \output[23]~output_o\ : std_logic;
SIGNAL \output[24]~output_o\ : std_logic;
SIGNAL \output[25]~output_o\ : std_logic;
SIGNAL \output[26]~output_o\ : std_logic;
SIGNAL \output[27]~output_o\ : std_logic;
SIGNAL \output[28]~output_o\ : std_logic;
SIGNAL \output[29]~output_o\ : std_logic;
SIGNAL \output[30]~output_o\ : std_logic;
SIGNAL \output[31]~output_o\ : std_logic;
SIGNAL \output[32]~output_o\ : std_logic;
SIGNAL \output[33]~output_o\ : std_logic;
SIGNAL \output[34]~output_o\ : std_logic;
SIGNAL \output[35]~output_o\ : std_logic;
SIGNAL \output[36]~output_o\ : std_logic;
SIGNAL \output[37]~output_o\ : std_logic;
SIGNAL \output[38]~output_o\ : std_logic;
SIGNAL \output[39]~output_o\ : std_logic;
SIGNAL \output[40]~output_o\ : std_logic;
SIGNAL \output[41]~output_o\ : std_logic;
SIGNAL \output[42]~output_o\ : std_logic;
SIGNAL \output[43]~output_o\ : std_logic;
SIGNAL \output[44]~output_o\ : std_logic;
SIGNAL \output[45]~output_o\ : std_logic;
SIGNAL \output[46]~output_o\ : std_logic;
SIGNAL \output[47]~output_o\ : std_logic;
SIGNAL \output[48]~output_o\ : std_logic;
SIGNAL \output[49]~output_o\ : std_logic;
SIGNAL \output[50]~output_o\ : std_logic;
SIGNAL \output[51]~output_o\ : std_logic;
SIGNAL \output[52]~output_o\ : std_logic;
SIGNAL \output[53]~output_o\ : std_logic;
SIGNAL \output[54]~output_o\ : std_logic;
SIGNAL \output[55]~output_o\ : std_logic;
SIGNAL \output[56]~output_o\ : std_logic;
SIGNAL \output[57]~output_o\ : std_logic;
SIGNAL \output[58]~output_o\ : std_logic;
SIGNAL \output[59]~output_o\ : std_logic;
SIGNAL \output[60]~output_o\ : std_logic;
SIGNAL \output[61]~output_o\ : std_logic;
SIGNAL \output[62]~output_o\ : std_logic;
SIGNAL \output[63]~output_o\ : std_logic;
SIGNAL \output[64]~output_o\ : std_logic;
SIGNAL \output[65]~output_o\ : std_logic;
SIGNAL \output[66]~output_o\ : std_logic;
SIGNAL \output[67]~output_o\ : std_logic;
SIGNAL \output[68]~output_o\ : std_logic;
SIGNAL \output[69]~output_o\ : std_logic;
SIGNAL \output[70]~output_o\ : std_logic;
SIGNAL \output[71]~output_o\ : std_logic;
SIGNAL \output[72]~output_o\ : std_logic;
SIGNAL \output[73]~output_o\ : std_logic;
SIGNAL \output[74]~output_o\ : std_logic;
SIGNAL \output[75]~output_o\ : std_logic;
SIGNAL \output[76]~output_o\ : std_logic;
SIGNAL \output[77]~output_o\ : std_logic;
SIGNAL \output[78]~output_o\ : std_logic;
SIGNAL \output[79]~output_o\ : std_logic;
SIGNAL \output[80]~output_o\ : std_logic;
SIGNAL \output[81]~output_o\ : std_logic;
SIGNAL \output[82]~output_o\ : std_logic;
SIGNAL \output[83]~output_o\ : std_logic;
SIGNAL \output[84]~output_o\ : std_logic;
SIGNAL \output[85]~output_o\ : std_logic;
SIGNAL \output[86]~output_o\ : std_logic;
SIGNAL \output[87]~output_o\ : std_logic;
SIGNAL \output[88]~output_o\ : std_logic;
SIGNAL \output[89]~output_o\ : std_logic;
SIGNAL \output[90]~output_o\ : std_logic;
SIGNAL \output[91]~output_o\ : std_logic;
SIGNAL \output[92]~output_o\ : std_logic;
SIGNAL \output[93]~output_o\ : std_logic;
SIGNAL \output[94]~output_o\ : std_logic;
SIGNAL \output[95]~output_o\ : std_logic;
SIGNAL \output[96]~output_o\ : std_logic;
SIGNAL \output[97]~output_o\ : std_logic;
SIGNAL \output[98]~output_o\ : std_logic;
SIGNAL \output[99]~output_o\ : std_logic;
SIGNAL \output[100]~output_o\ : std_logic;
SIGNAL \output[101]~output_o\ : std_logic;
SIGNAL \output[102]~output_o\ : std_logic;
SIGNAL \output[103]~output_o\ : std_logic;
SIGNAL \output[104]~output_o\ : std_logic;
SIGNAL \output[105]~output_o\ : std_logic;
SIGNAL \output[106]~output_o\ : std_logic;
SIGNAL \output[107]~output_o\ : std_logic;
SIGNAL \output[108]~output_o\ : std_logic;
SIGNAL \output[109]~output_o\ : std_logic;
SIGNAL \output[110]~output_o\ : std_logic;
SIGNAL \output[111]~output_o\ : std_logic;
SIGNAL \output[112]~output_o\ : std_logic;
SIGNAL \output[113]~output_o\ : std_logic;
SIGNAL \output[114]~output_o\ : std_logic;
SIGNAL \output[115]~output_o\ : std_logic;
SIGNAL \output[116]~output_o\ : std_logic;
SIGNAL \output[117]~output_o\ : std_logic;
SIGNAL \output[118]~output_o\ : std_logic;
SIGNAL \output[119]~output_o\ : std_logic;
SIGNAL \output[120]~output_o\ : std_logic;
SIGNAL \output[121]~output_o\ : std_logic;
SIGNAL \output[122]~output_o\ : std_logic;
SIGNAL \output[123]~output_o\ : std_logic;
SIGNAL \output[124]~output_o\ : std_logic;
SIGNAL \output[125]~output_o\ : std_logic;
SIGNAL \output[126]~output_o\ : std_logic;
SIGNAL \output[127]~output_o\ : std_logic;
SIGNAL \output[128]~output_o\ : std_logic;
SIGNAL \output[129]~output_o\ : std_logic;
SIGNAL \output[130]~output_o\ : std_logic;
SIGNAL \output[131]~output_o\ : std_logic;
SIGNAL \output[132]~output_o\ : std_logic;
SIGNAL \output[133]~output_o\ : std_logic;
SIGNAL \output[134]~output_o\ : std_logic;
SIGNAL \output[135]~output_o\ : std_logic;
SIGNAL \output[136]~output_o\ : std_logic;
SIGNAL \output[137]~output_o\ : std_logic;
SIGNAL \output[138]~output_o\ : std_logic;
SIGNAL \output[139]~output_o\ : std_logic;
SIGNAL \output[140]~output_o\ : std_logic;
SIGNAL \output[141]~output_o\ : std_logic;
SIGNAL \output[142]~output_o\ : std_logic;
SIGNAL \output[143]~output_o\ : std_logic;
SIGNAL \output[144]~output_o\ : std_logic;
SIGNAL \output[145]~output_o\ : std_logic;
SIGNAL \output[146]~output_o\ : std_logic;
SIGNAL \output[147]~output_o\ : std_logic;
SIGNAL \output[148]~output_o\ : std_logic;
SIGNAL \output[149]~output_o\ : std_logic;
SIGNAL \output[150]~output_o\ : std_logic;
SIGNAL \output[151]~output_o\ : std_logic;
SIGNAL \output[152]~output_o\ : std_logic;
SIGNAL \output[153]~output_o\ : std_logic;
SIGNAL \output[154]~output_o\ : std_logic;
SIGNAL \output[155]~output_o\ : std_logic;
SIGNAL \output[156]~output_o\ : std_logic;
SIGNAL \output[157]~output_o\ : std_logic;
SIGNAL \output[158]~output_o\ : std_logic;
SIGNAL \output[159]~output_o\ : std_logic;
SIGNAL \output[160]~output_o\ : std_logic;
SIGNAL \output[161]~output_o\ : std_logic;
SIGNAL \output[162]~output_o\ : std_logic;
SIGNAL \output[163]~output_o\ : std_logic;
SIGNAL \output[164]~output_o\ : std_logic;
SIGNAL \output[165]~output_o\ : std_logic;
SIGNAL \output[166]~output_o\ : std_logic;
SIGNAL \output[167]~output_o\ : std_logic;
SIGNAL \output[168]~output_o\ : std_logic;
SIGNAL \output[169]~output_o\ : std_logic;
SIGNAL \output[170]~output_o\ : std_logic;
SIGNAL \output[171]~output_o\ : std_logic;
SIGNAL \output[172]~output_o\ : std_logic;
SIGNAL \output[173]~output_o\ : std_logic;
SIGNAL \output[174]~output_o\ : std_logic;
SIGNAL \output[175]~output_o\ : std_logic;
SIGNAL \output[176]~output_o\ : std_logic;
SIGNAL \output[177]~output_o\ : std_logic;
SIGNAL \output[178]~output_o\ : std_logic;
SIGNAL \output[179]~output_o\ : std_logic;
SIGNAL \output[180]~output_o\ : std_logic;
SIGNAL \output[181]~output_o\ : std_logic;
SIGNAL \output[182]~output_o\ : std_logic;
SIGNAL \output[183]~output_o\ : std_logic;
SIGNAL \output[184]~output_o\ : std_logic;
SIGNAL \output[185]~output_o\ : std_logic;
SIGNAL \output[186]~output_o\ : std_logic;
SIGNAL \output[187]~output_o\ : std_logic;
SIGNAL \output[188]~output_o\ : std_logic;
SIGNAL \output[189]~output_o\ : std_logic;
SIGNAL \output[190]~output_o\ : std_logic;
SIGNAL \output[191]~output_o\ : std_logic;
SIGNAL \output[192]~output_o\ : std_logic;
SIGNAL \output[193]~output_o\ : std_logic;
SIGNAL \output[194]~output_o\ : std_logic;
SIGNAL \output[195]~output_o\ : std_logic;
SIGNAL \output[196]~output_o\ : std_logic;
SIGNAL \output[197]~output_o\ : std_logic;
SIGNAL \output[198]~output_o\ : std_logic;
SIGNAL \output[199]~output_o\ : std_logic;
SIGNAL \output[200]~output_o\ : std_logic;
SIGNAL \output[201]~output_o\ : std_logic;
SIGNAL \output[202]~output_o\ : std_logic;
SIGNAL \output[203]~output_o\ : std_logic;
SIGNAL \output[204]~output_o\ : std_logic;
SIGNAL \output[205]~output_o\ : std_logic;
SIGNAL \output[206]~output_o\ : std_logic;
SIGNAL \output[207]~output_o\ : std_logic;
SIGNAL \output[208]~output_o\ : std_logic;
SIGNAL \output[209]~output_o\ : std_logic;
SIGNAL \output[210]~output_o\ : std_logic;
SIGNAL \output[211]~output_o\ : std_logic;
SIGNAL \output[212]~output_o\ : std_logic;
SIGNAL \output[213]~output_o\ : std_logic;
SIGNAL \output[214]~output_o\ : std_logic;
SIGNAL \output[215]~output_o\ : std_logic;
SIGNAL \output[216]~output_o\ : std_logic;
SIGNAL \output[217]~output_o\ : std_logic;
SIGNAL \output[218]~output_o\ : std_logic;
SIGNAL \output[219]~output_o\ : std_logic;
SIGNAL \output[220]~output_o\ : std_logic;
SIGNAL \output[221]~output_o\ : std_logic;
SIGNAL \output[222]~output_o\ : std_logic;
SIGNAL \output[223]~output_o\ : std_logic;
SIGNAL \output[224]~output_o\ : std_logic;
SIGNAL \output[225]~output_o\ : std_logic;
SIGNAL \output[226]~output_o\ : std_logic;
SIGNAL \output[227]~output_o\ : std_logic;
SIGNAL \output[228]~output_o\ : std_logic;
SIGNAL \output[229]~output_o\ : std_logic;
SIGNAL \output[230]~output_o\ : std_logic;
SIGNAL \output[231]~output_o\ : std_logic;
SIGNAL \output[232]~output_o\ : std_logic;
SIGNAL \output[233]~output_o\ : std_logic;
SIGNAL \output[234]~output_o\ : std_logic;
SIGNAL \output[235]~output_o\ : std_logic;
SIGNAL \output[236]~output_o\ : std_logic;
SIGNAL \output[237]~output_o\ : std_logic;
SIGNAL \output[238]~output_o\ : std_logic;
SIGNAL \output[239]~output_o\ : std_logic;
SIGNAL \output[240]~output_o\ : std_logic;
SIGNAL \output[241]~output_o\ : std_logic;
SIGNAL \output[242]~output_o\ : std_logic;
SIGNAL \output[243]~output_o\ : std_logic;
SIGNAL \output[244]~output_o\ : std_logic;
SIGNAL \output[245]~output_o\ : std_logic;
SIGNAL \output[246]~output_o\ : std_logic;
SIGNAL \output[247]~output_o\ : std_logic;
SIGNAL \output[248]~output_o\ : std_logic;
SIGNAL \output[249]~output_o\ : std_logic;
SIGNAL \output[250]~output_o\ : std_logic;
SIGNAL \output[251]~output_o\ : std_logic;
SIGNAL \output[252]~output_o\ : std_logic;
SIGNAL \output[253]~output_o\ : std_logic;
SIGNAL \output[254]~output_o\ : std_logic;
SIGNAL \output[255]~output_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \chip_select~input_o\ : std_logic;
SIGNAL \sha256_control_block_0|next_state.S1~0_combout\ : std_logic;
SIGNAL \chip_reset~input_o\ : std_logic;
SIGNAL \chip_reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S1~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S2~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S2~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S3~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S3~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S4~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S4~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S8~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S8~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S9~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S9~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S10~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S10~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S11~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S11~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S12~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S12~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S22~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S22~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S23~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S23~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S24~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S24~q\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S53~feeder_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S53~q\ : std_logic;
SIGNAL \sha256_control_block_0|Selector0~0_combout\ : std_logic;
SIGNAL \sha256_control_block_0|current_state.S0~q\ : std_logic;
SIGNAL \ALT_INV_chip_reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \sha256_control_block_0|ALT_INV_current_state.S0~q\ : std_logic;

BEGIN

ww_clock <= clock;
ww_chip_select <= chip_select;
ww_chip_reset <= chip_reset;
chip_ready <= ww_chip_ready;
output <= ww_output;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);

\chip_reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \chip_reset~input_o\);
\ALT_INV_chip_reset~inputclkctrl_outclk\ <= NOT \chip_reset~inputclkctrl_outclk\;
\sha256_control_block_0|ALT_INV_current_state.S0~q\ <= NOT \sha256_control_block_0|current_state.S0~q\;

-- Location: IOOBUF_X33_Y0_N2
\chip_ready~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \sha256_control_block_0|ALT_INV_current_state.S0~q\,
	devoe => ww_devoe,
	o => \chip_ready~output_o\);

-- Location: IOOBUF_X42_Y0_N2
\output[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[0]~output_o\);

-- Location: IOOBUF_X81_Y50_N9
\output[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[1]~output_o\);

-- Location: IOOBUF_X81_Y3_N2
\output[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[2]~output_o\);

-- Location: IOOBUF_X29_Y0_N16
\output[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[3]~output_o\);

-- Location: IOOBUF_X19_Y0_N16
\output[4]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[4]~output_o\);

-- Location: IOOBUF_X17_Y67_N9
\output[5]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[5]~output_o\);

-- Location: IOOBUF_X56_Y0_N9
\output[6]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[6]~output_o\);

-- Location: IOOBUF_X81_Y10_N2
\output[7]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[7]~output_o\);

-- Location: IOOBUF_X44_Y67_N2
\output[8]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[8]~output_o\);

-- Location: IOOBUF_X81_Y47_N9
\output[9]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[9]~output_o\);

-- Location: IOOBUF_X81_Y53_N9
\output[10]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[10]~output_o\);

-- Location: IOOBUF_X65_Y0_N9
\output[11]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[11]~output_o\);

-- Location: IOOBUF_X15_Y67_N9
\output[12]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[12]~output_o\);

-- Location: IOOBUF_X81_Y2_N9
\output[13]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[13]~output_o\);

-- Location: IOOBUF_X81_Y4_N9
\output[14]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[14]~output_o\);

-- Location: IOOBUF_X54_Y67_N16
\output[15]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[15]~output_o\);

-- Location: IOOBUF_X81_Y52_N9
\output[16]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[16]~output_o\);

-- Location: IOOBUF_X70_Y67_N2
\output[17]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[17]~output_o\);

-- Location: IOOBUF_X81_Y14_N2
\output[18]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[18]~output_o\);

-- Location: IOOBUF_X52_Y0_N2
\output[19]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[19]~output_o\);

-- Location: IOOBUF_X81_Y63_N2
\output[20]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[20]~output_o\);

-- Location: IOOBUF_X81_Y62_N9
\output[21]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[21]~output_o\);

-- Location: IOOBUF_X22_Y67_N9
\output[22]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[22]~output_o\);

-- Location: IOOBUF_X81_Y64_N23
\output[23]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[23]~output_o\);

-- Location: IOOBUF_X81_Y65_N16
\output[24]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[24]~output_o\);

-- Location: IOOBUF_X68_Y0_N16
\output[25]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[25]~output_o\);

-- Location: IOOBUF_X56_Y0_N2
\output[26]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[26]~output_o\);

-- Location: IOOBUF_X58_Y0_N2
\output[27]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[27]~output_o\);

-- Location: IOOBUF_X56_Y67_N9
\output[28]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[28]~output_o\);

-- Location: IOOBUF_X81_Y12_N2
\output[29]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[29]~output_o\);

-- Location: IOOBUF_X26_Y67_N16
\output[30]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[30]~output_o\);

-- Location: IOOBUF_X81_Y44_N2
\output[31]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[31]~output_o\);

-- Location: IOOBUF_X63_Y67_N2
\output[32]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[32]~output_o\);

-- Location: IOOBUF_X42_Y67_N23
\output[33]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[33]~output_o\);

-- Location: IOOBUF_X65_Y0_N2
\output[34]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[34]~output_o\);

-- Location: IOOBUF_X81_Y65_N9
\output[35]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[35]~output_o\);

-- Location: IOOBUF_X22_Y67_N2
\output[36]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[36]~output_o\);

-- Location: IOOBUF_X81_Y53_N2
\output[37]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[37]~output_o\);

-- Location: IOOBUF_X81_Y3_N23
\output[38]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[38]~output_o\);

-- Location: IOOBUF_X17_Y67_N2
\output[39]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[39]~output_o\);

-- Location: IOOBUF_X58_Y0_N9
\output[40]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[40]~output_o\);

-- Location: IOOBUF_X81_Y8_N9
\output[41]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[41]~output_o\);

-- Location: IOOBUF_X81_Y7_N16
\output[42]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[42]~output_o\);

-- Location: IOOBUF_X24_Y67_N16
\output[43]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[43]~output_o\);

-- Location: IOOBUF_X26_Y0_N9
\output[44]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[44]~output_o\);

-- Location: IOOBUF_X8_Y67_N9
\output[45]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[45]~output_o\);

-- Location: IOOBUF_X42_Y0_N9
\output[46]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[46]~output_o\);

-- Location: IOOBUF_X40_Y0_N9
\output[47]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[47]~output_o\);

-- Location: IOOBUF_X81_Y10_N9
\output[48]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[48]~output_o\);

-- Location: IOOBUF_X15_Y0_N23
\output[49]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[49]~output_o\);

-- Location: IOOBUF_X54_Y67_N23
\output[50]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[50]~output_o\);

-- Location: IOOBUF_X44_Y67_N16
\output[51]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[51]~output_o\);

-- Location: IOOBUF_X40_Y0_N16
\output[52]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[52]~output_o\);

-- Location: IOOBUF_X44_Y67_N9
\output[53]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[53]~output_o\);

-- Location: IOOBUF_X81_Y64_N2
\output[54]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[54]~output_o\);

-- Location: IOOBUF_X31_Y67_N9
\output[55]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[55]~output_o\);

-- Location: IOOBUF_X81_Y6_N9
\output[56]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[56]~output_o\);

-- Location: IOOBUF_X81_Y41_N2
\output[57]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[57]~output_o\);

-- Location: IOOBUF_X49_Y67_N16
\output[58]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[58]~output_o\);

-- Location: IOOBUF_X65_Y67_N16
\output[59]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[59]~output_o\);

-- Location: IOOBUF_X10_Y0_N23
\output[60]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[60]~output_o\);

-- Location: IOOBUF_X81_Y61_N2
\output[61]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[61]~output_o\);

-- Location: IOOBUF_X52_Y0_N9
\output[62]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[62]~output_o\);

-- Location: IOOBUF_X81_Y19_N2
\output[63]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[63]~output_o\);

-- Location: IOOBUF_X81_Y9_N2
\output[64]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[64]~output_o\);

-- Location: IOOBUF_X61_Y67_N2
\output[65]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[65]~output_o\);

-- Location: IOOBUF_X26_Y67_N9
\output[66]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[66]~output_o\);

-- Location: IOOBUF_X15_Y67_N16
\output[67]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[67]~output_o\);

-- Location: IOOBUF_X81_Y11_N16
\output[68]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[68]~output_o\);

-- Location: IOOBUF_X81_Y61_N9
\output[69]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[69]~output_o\);

-- Location: IOOBUF_X49_Y0_N23
\output[70]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[70]~output_o\);

-- Location: IOOBUF_X81_Y25_N16
\output[71]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[71]~output_o\);

-- Location: IOOBUF_X29_Y67_N2
\output[72]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[72]~output_o\);

-- Location: IOOBUF_X6_Y0_N2
\output[73]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[73]~output_o\);

-- Location: IOOBUF_X52_Y67_N16
\output[74]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[74]~output_o\);

-- Location: IOOBUF_X81_Y8_N2
\output[75]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[75]~output_o\);

-- Location: IOOBUF_X81_Y4_N16
\output[76]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[76]~output_o\);

-- Location: IOOBUF_X81_Y47_N2
\output[77]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[77]~output_o\);

-- Location: IOOBUF_X42_Y67_N16
\output[78]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[78]~output_o\);

-- Location: IOOBUF_X19_Y67_N23
\output[79]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[79]~output_o\);

-- Location: IOOBUF_X81_Y42_N2
\output[80]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[80]~output_o\);

-- Location: IOOBUF_X33_Y67_N2
\output[81]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[81]~output_o\);

-- Location: IOOBUF_X29_Y67_N23
\output[82]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[82]~output_o\);

-- Location: IOOBUF_X81_Y49_N9
\output[83]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[83]~output_o\);

-- Location: IOOBUF_X3_Y0_N9
\output[84]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[84]~output_o\);

-- Location: IOOBUF_X81_Y39_N2
\output[85]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[85]~output_o\);

-- Location: IOOBUF_X17_Y0_N16
\output[86]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[86]~output_o\);

-- Location: IOOBUF_X81_Y25_N2
\output[87]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[87]~output_o\);

-- Location: IOOBUF_X42_Y67_N9
\output[88]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[88]~output_o\);

-- Location: IOOBUF_X81_Y23_N2
\output[89]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[89]~output_o\);

-- Location: IOOBUF_X13_Y67_N2
\output[90]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[90]~output_o\);

-- Location: IOOBUF_X10_Y67_N16
\output[91]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[91]~output_o\);

-- Location: IOOBUF_X81_Y16_N2
\output[92]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[92]~output_o\);

-- Location: IOOBUF_X56_Y0_N16
\output[93]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[93]~output_o\);

-- Location: IOOBUF_X10_Y67_N2
\output[94]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[94]~output_o\);

-- Location: IOOBUF_X29_Y67_N9
\output[95]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[95]~output_o\);

-- Location: IOOBUF_X24_Y67_N2
\output[96]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[96]~output_o\);

-- Location: IOOBUF_X49_Y0_N16
\output[97]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[97]~output_o\);

-- Location: IOOBUF_X10_Y0_N9
\output[98]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[98]~output_o\);

-- Location: IOOBUF_X81_Y61_N16
\output[99]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[99]~output_o\);

-- Location: IOOBUF_X19_Y67_N9
\output[100]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[100]~output_o\);

-- Location: IOOBUF_X49_Y67_N2
\output[101]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[101]~output_o\);

-- Location: IOOBUF_X70_Y67_N9
\output[102]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[102]~output_o\);

-- Location: IOOBUF_X81_Y23_N9
\output[103]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[103]~output_o\);

-- Location: IOOBUF_X49_Y67_N23
\output[104]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[104]~output_o\);

-- Location: IOOBUF_X81_Y4_N2
\output[105]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[105]~output_o\);

-- Location: IOOBUF_X81_Y63_N9
\output[106]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[106]~output_o\);

-- Location: IOOBUF_X81_Y63_N16
\output[107]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[107]~output_o\);

-- Location: IOOBUF_X19_Y67_N16
\output[108]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[108]~output_o\);

-- Location: IOOBUF_X22_Y0_N9
\output[109]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[109]~output_o\);

-- Location: IOOBUF_X24_Y67_N23
\output[110]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[110]~output_o\);

-- Location: IOOBUF_X29_Y67_N16
\output[111]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[111]~output_o\);

-- Location: IOOBUF_X70_Y67_N16
\output[112]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[112]~output_o\);

-- Location: IOOBUF_X81_Y56_N2
\output[113]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[113]~output_o\);

-- Location: IOOBUF_X8_Y67_N2
\output[114]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[114]~output_o\);

-- Location: IOOBUF_X44_Y0_N2
\output[115]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[115]~output_o\);

-- Location: IOOBUF_X26_Y0_N16
\output[116]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[116]~output_o\);

-- Location: IOOBUF_X81_Y11_N2
\output[117]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[117]~output_o\);

-- Location: IOOBUF_X54_Y0_N16
\output[118]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[118]~output_o\);

-- Location: IOOBUF_X63_Y67_N9
\output[119]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[119]~output_o\);

-- Location: IOOBUF_X47_Y0_N9
\output[120]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[120]~output_o\);

-- Location: IOOBUF_X81_Y58_N9
\output[121]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[121]~output_o\);

-- Location: IOOBUF_X47_Y67_N9
\output[122]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[122]~output_o\);

-- Location: IOOBUF_X42_Y0_N16
\output[123]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[123]~output_o\);

-- Location: IOOBUF_X58_Y0_N16
\output[124]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[124]~output_o\);

-- Location: IOOBUF_X81_Y25_N9
\output[125]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[125]~output_o\);

-- Location: IOOBUF_X58_Y67_N23
\output[126]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[126]~output_o\);

-- Location: IOOBUF_X81_Y11_N9
\output[127]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[127]~output_o\);

-- Location: IOOBUF_X54_Y67_N9
\output[128]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[128]~output_o\);

-- Location: IOOBUF_X8_Y67_N16
\output[129]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[129]~output_o\);

-- Location: IOOBUF_X44_Y0_N16
\output[130]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[130]~output_o\);

-- Location: IOOBUF_X6_Y0_N9
\output[131]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[131]~output_o\);

-- Location: IOOBUF_X33_Y67_N9
\output[132]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[132]~output_o\);

-- Location: IOOBUF_X6_Y0_N23
\output[133]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[133]~output_o\);

-- Location: IOOBUF_X81_Y52_N16
\output[134]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[134]~output_o\);

-- Location: IOOBUF_X81_Y21_N2
\output[135]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[135]~output_o\);

-- Location: IOOBUF_X63_Y67_N16
\output[136]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[136]~output_o\);

-- Location: IOOBUF_X81_Y46_N9
\output[137]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[137]~output_o\);

-- Location: IOOBUF_X24_Y0_N2
\output[138]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[138]~output_o\);

-- Location: IOOBUF_X81_Y2_N23
\output[139]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[139]~output_o\);

-- Location: IOOBUF_X54_Y67_N2
\output[140]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[140]~output_o\);

-- Location: IOOBUF_X33_Y0_N23
\output[141]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[141]~output_o\);

-- Location: IOOBUF_X3_Y0_N2
\output[142]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[142]~output_o\);

-- Location: IOOBUF_X81_Y21_N9
\output[143]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[143]~output_o\);

-- Location: IOOBUF_X17_Y67_N23
\output[144]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[144]~output_o\);

-- Location: IOOBUF_X31_Y67_N2
\output[145]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[145]~output_o\);

-- Location: IOOBUF_X10_Y67_N9
\output[146]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[146]~output_o\);

-- Location: IOOBUF_X58_Y0_N23
\output[147]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[147]~output_o\);

-- Location: IOOBUF_X68_Y67_N2
\output[148]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[148]~output_o\);

-- Location: IOOBUF_X17_Y67_N16
\output[149]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[149]~output_o\);

-- Location: IOOBUF_X42_Y67_N2
\output[150]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[150]~output_o\);

-- Location: IOOBUF_X81_Y49_N16
\output[151]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[151]~output_o\);

-- Location: IOOBUF_X17_Y0_N23
\output[152]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[152]~output_o\);

-- Location: IOOBUF_X81_Y2_N2
\output[153]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[153]~output_o\);

-- Location: IOOBUF_X65_Y67_N9
\output[154]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[154]~output_o\);

-- Location: IOOBUF_X70_Y0_N9
\output[155]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[155]~output_o\);

-- Location: IOOBUF_X56_Y0_N23
\output[156]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[156]~output_o\);

-- Location: IOOBUF_X81_Y44_N9
\output[157]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[157]~output_o\);

-- Location: IOOBUF_X58_Y67_N9
\output[158]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[158]~output_o\);

-- Location: IOOBUF_X52_Y67_N23
\output[159]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[159]~output_o\);

-- Location: IOOBUF_X47_Y67_N2
\output[160]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[160]~output_o\);

-- Location: IOOBUF_X33_Y67_N23
\output[161]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[161]~output_o\);

-- Location: IOOBUF_X81_Y2_N16
\output[162]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[162]~output_o\);

-- Location: IOOBUF_X81_Y54_N2
\output[163]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[163]~output_o\);

-- Location: IOOBUF_X81_Y39_N9
\output[164]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[164]~output_o\);

-- Location: IOOBUF_X49_Y67_N9
\output[165]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[165]~output_o\);

-- Location: IOOBUF_X61_Y67_N9
\output[166]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[166]~output_o\);

-- Location: IOOBUF_X6_Y67_N2
\output[167]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[167]~output_o\);

-- Location: IOOBUF_X81_Y6_N2
\output[168]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[168]~output_o\);

-- Location: IOOBUF_X81_Y43_N2
\output[169]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[169]~output_o\);

-- Location: IOOBUF_X58_Y67_N2
\output[170]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[170]~output_o\);

-- Location: IOOBUF_X81_Y55_N2
\output[171]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[171]~output_o\);

-- Location: IOOBUF_X44_Y0_N23
\output[172]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[172]~output_o\);

-- Location: IOOBUF_X56_Y67_N16
\output[173]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[173]~output_o\);

-- Location: IOOBUF_X10_Y0_N2
\output[174]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[174]~output_o\);

-- Location: IOOBUF_X6_Y67_N16
\output[175]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[175]~output_o\);

-- Location: IOOBUF_X81_Y41_N16
\output[176]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[176]~output_o\);

-- Location: IOOBUF_X52_Y67_N9
\output[177]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[177]~output_o\);

-- Location: IOOBUF_X17_Y0_N9
\output[178]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[178]~output_o\);

-- Location: IOOBUF_X81_Y41_N9
\output[179]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[179]~output_o\);

-- Location: IOOBUF_X68_Y0_N9
\output[180]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[180]~output_o\);

-- Location: IOOBUF_X81_Y42_N9
\output[181]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[181]~output_o\);

-- Location: IOOBUF_X44_Y67_N23
\output[182]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[182]~output_o\);

-- Location: IOOBUF_X81_Y55_N9
\output[183]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[183]~output_o\);

-- Location: IOOBUF_X81_Y46_N16
\output[184]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[184]~output_o\);

-- Location: IOOBUF_X15_Y67_N23
\output[185]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[185]~output_o\);

-- Location: IOOBUF_X15_Y0_N2
\output[186]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[186]~output_o\);

-- Location: IOOBUF_X44_Y0_N9
\output[187]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[187]~output_o\);

-- Location: IOOBUF_X10_Y67_N23
\output[188]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[188]~output_o\);

-- Location: IOOBUF_X6_Y67_N9
\output[189]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[189]~output_o\);

-- Location: IOOBUF_X81_Y65_N23
\output[190]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[190]~output_o\);

-- Location: IOOBUF_X19_Y0_N2
\output[191]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[191]~output_o\);

-- Location: IOOBUF_X81_Y59_N2
\output[192]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[192]~output_o\);

-- Location: IOOBUF_X3_Y0_N16
\output[193]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[193]~output_o\);

-- Location: IOOBUF_X81_Y58_N2
\output[194]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[194]~output_o\);

-- Location: IOOBUF_X81_Y16_N9
\output[195]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[195]~output_o\);

-- Location: IOOBUF_X6_Y0_N16
\output[196]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[196]~output_o\);

-- Location: IOOBUF_X54_Y0_N9
\output[197]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[197]~output_o\);

-- Location: IOOBUF_X31_Y67_N23
\output[198]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[198]~output_o\);

-- Location: IOOBUF_X81_Y3_N16
\output[199]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[199]~output_o\);

-- Location: IOOBUF_X58_Y67_N16
\output[200]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[200]~output_o\);

-- Location: IOOBUF_X49_Y0_N2
\output[201]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[201]~output_o\);

-- Location: IOOBUF_X81_Y9_N9
\output[202]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[202]~output_o\);

-- Location: IOOBUF_X81_Y62_N16
\output[203]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[203]~output_o\);

-- Location: IOOBUF_X81_Y20_N9
\output[204]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[204]~output_o\);

-- Location: IOOBUF_X81_Y25_N23
\output[205]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[205]~output_o\);

-- Location: IOOBUF_X81_Y62_N2
\output[206]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[206]~output_o\);

-- Location: IOOBUF_X81_Y20_N2
\output[207]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[207]~output_o\);

-- Location: IOOBUF_X81_Y64_N9
\output[208]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[208]~output_o\);

-- Location: IOOBUF_X31_Y0_N2
\output[209]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[209]~output_o\);

-- Location: IOOBUF_X26_Y67_N2
\output[210]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[210]~output_o\);

-- Location: IOOBUF_X81_Y52_N2
\output[211]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[211]~output_o\);

-- Location: IOOBUF_X81_Y7_N2
\output[212]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[212]~output_o\);

-- Location: IOOBUF_X63_Y0_N9
\output[213]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[213]~output_o\);

-- Location: IOOBUF_X65_Y67_N2
\output[214]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[214]~output_o\);

-- Location: IOOBUF_X19_Y67_N2
\output[215]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[215]~output_o\);

-- Location: IOOBUF_X31_Y0_N16
\output[216]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[216]~output_o\);

-- Location: IOOBUF_X15_Y0_N9
\output[217]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[217]~output_o\);

-- Location: IOOBUF_X31_Y67_N16
\output[218]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[218]~output_o\);

-- Location: IOOBUF_X81_Y54_N9
\output[219]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[219]~output_o\);

-- Location: IOOBUF_X15_Y67_N2
\output[220]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[220]~output_o\);

-- Location: IOOBUF_X81_Y46_N2
\output[221]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[221]~output_o\);

-- Location: IOOBUF_X65_Y0_N16
\output[222]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[222]~output_o\);

-- Location: IOOBUF_X56_Y67_N23
\output[223]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[223]~output_o\);

-- Location: IOOBUF_X63_Y0_N2
\output[224]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[224]~output_o\);

-- Location: IOOBUF_X81_Y59_N9
\output[225]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[225]~output_o\);

-- Location: IOOBUF_X8_Y67_N23
\output[226]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[226]~output_o\);

-- Location: IOOBUF_X49_Y0_N9
\output[227]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[227]~output_o\);

-- Location: IOOBUF_X70_Y0_N2
\output[228]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[228]~output_o\);

-- Location: IOOBUF_X6_Y67_N23
\output[229]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[229]~output_o\);

-- Location: IOOBUF_X13_Y67_N9
\output[230]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[230]~output_o\);

-- Location: IOOBUF_X24_Y67_N9
\output[231]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[231]~output_o\);

-- Location: IOOBUF_X81_Y6_N16
\output[232]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[232]~output_o\);

-- Location: IOOBUF_X54_Y0_N23
\output[233]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[233]~output_o\);

-- Location: IOOBUF_X54_Y0_N2
\output[234]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[234]~output_o\);

-- Location: IOOBUF_X8_Y0_N16
\output[235]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[235]~output_o\);

-- Location: IOOBUF_X31_Y0_N9
\output[236]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[236]~output_o\);

-- Location: IOOBUF_X47_Y0_N2
\output[237]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[237]~output_o\);

-- Location: IOOBUF_X81_Y3_N9
\output[238]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[238]~output_o\);

-- Location: IOOBUF_X81_Y4_N23
\output[239]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[239]~output_o\);

-- Location: IOOBUF_X19_Y0_N23
\output[240]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[240]~output_o\);

-- Location: IOOBUF_X70_Y67_N23
\output[241]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[241]~output_o\);

-- Location: IOOBUF_X81_Y49_N2
\output[242]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[242]~output_o\);

-- Location: IOOBUF_X8_Y0_N9
\output[243]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[243]~output_o\);

-- Location: IOOBUF_X26_Y67_N23
\output[244]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[244]~output_o\);

-- Location: IOOBUF_X81_Y17_N2
\output[245]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[245]~output_o\);

-- Location: IOOBUF_X31_Y0_N23
\output[246]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[246]~output_o\);

-- Location: IOOBUF_X68_Y0_N2
\output[247]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[247]~output_o\);

-- Location: IOOBUF_X29_Y0_N2
\output[248]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[248]~output_o\);

-- Location: IOOBUF_X56_Y67_N2
\output[249]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[249]~output_o\);

-- Location: IOOBUF_X81_Y59_N16
\output[250]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[250]~output_o\);

-- Location: IOOBUF_X15_Y0_N16
\output[251]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[251]~output_o\);

-- Location: IOOBUF_X81_Y50_N2
\output[252]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[252]~output_o\);

-- Location: IOOBUF_X22_Y0_N2
\output[253]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[253]~output_o\);

-- Location: IOOBUF_X29_Y0_N9
\output[254]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[254]~output_o\);

-- Location: IOOBUF_X81_Y26_N2
\output[255]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[255]~output_o\);

-- Location: IOIBUF_X38_Y0_N15
\clock~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G29
\clock~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~inputclkctrl_outclk\);

-- Location: IOIBUF_X38_Y0_N8
\chip_select~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_chip_select,
	o => \chip_select~input_o\);

-- Location: LCCOMB_X34_Y1_N22
\sha256_control_block_0|next_state.S1~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|next_state.S1~0_combout\ = (\chip_select~input_o\ & !\sha256_control_block_0|current_state.S0~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \chip_select~input_o\,
	datad => \sha256_control_block_0|current_state.S0~q\,
	combout => \sha256_control_block_0|next_state.S1~0_combout\);

-- Location: IOIBUF_X38_Y0_N22
\chip_reset~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_chip_reset,
	o => \chip_reset~input_o\);

-- Location: CLKCTRL_G28
\chip_reset~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \chip_reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \chip_reset~inputclkctrl_outclk\);

-- Location: FF_X34_Y1_N23
\sha256_control_block_0|current_state.S1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|next_state.S1~0_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S1~q\);

-- Location: LCCOMB_X34_Y1_N16
\sha256_control_block_0|current_state.S2~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S2~feeder_combout\ = \sha256_control_block_0|current_state.S1~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sha256_control_block_0|current_state.S1~q\,
	combout => \sha256_control_block_0|current_state.S2~feeder_combout\);

-- Location: FF_X34_Y1_N17
\sha256_control_block_0|current_state.S2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S2~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S2~q\);

-- Location: LCCOMB_X34_Y1_N18
\sha256_control_block_0|current_state.S3~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S3~feeder_combout\ = \sha256_control_block_0|current_state.S2~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S2~q\,
	combout => \sha256_control_block_0|current_state.S3~feeder_combout\);

-- Location: FF_X34_Y1_N19
\sha256_control_block_0|current_state.S3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S3~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S3~q\);

-- Location: LCCOMB_X34_Y1_N28
\sha256_control_block_0|current_state.S4~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S4~feeder_combout\ = \sha256_control_block_0|current_state.S3~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S3~q\,
	combout => \sha256_control_block_0|current_state.S4~feeder_combout\);

-- Location: FF_X34_Y1_N29
\sha256_control_block_0|current_state.S4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S4~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S4~q\);

-- Location: LCCOMB_X34_Y1_N10
\sha256_control_block_0|current_state.S8~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S8~feeder_combout\ = \sha256_control_block_0|current_state.S4~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S4~q\,
	combout => \sha256_control_block_0|current_state.S8~feeder_combout\);

-- Location: FF_X34_Y1_N11
\sha256_control_block_0|current_state.S8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S8~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S8~q\);

-- Location: LCCOMB_X34_Y1_N12
\sha256_control_block_0|current_state.S9~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S9~feeder_combout\ = \sha256_control_block_0|current_state.S8~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S8~q\,
	combout => \sha256_control_block_0|current_state.S9~feeder_combout\);

-- Location: FF_X34_Y1_N13
\sha256_control_block_0|current_state.S9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S9~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S9~q\);

-- Location: LCCOMB_X34_Y1_N26
\sha256_control_block_0|current_state.S10~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S10~feeder_combout\ = \sha256_control_block_0|current_state.S9~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S9~q\,
	combout => \sha256_control_block_0|current_state.S10~feeder_combout\);

-- Location: FF_X34_Y1_N27
\sha256_control_block_0|current_state.S10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S10~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S10~q\);

-- Location: LCCOMB_X34_Y1_N4
\sha256_control_block_0|current_state.S11~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S11~feeder_combout\ = \sha256_control_block_0|current_state.S10~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sha256_control_block_0|current_state.S10~q\,
	combout => \sha256_control_block_0|current_state.S11~feeder_combout\);

-- Location: FF_X34_Y1_N5
\sha256_control_block_0|current_state.S11\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S11~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S11~q\);

-- Location: LCCOMB_X34_Y1_N30
\sha256_control_block_0|current_state.S12~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S12~feeder_combout\ = \sha256_control_block_0|current_state.S11~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sha256_control_block_0|current_state.S11~q\,
	combout => \sha256_control_block_0|current_state.S12~feeder_combout\);

-- Location: FF_X34_Y1_N31
\sha256_control_block_0|current_state.S12\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S12~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S12~q\);

-- Location: LCCOMB_X34_Y1_N20
\sha256_control_block_0|current_state.S22~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S22~feeder_combout\ = \sha256_control_block_0|current_state.S12~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sha256_control_block_0|current_state.S12~q\,
	combout => \sha256_control_block_0|current_state.S22~feeder_combout\);

-- Location: FF_X34_Y1_N21
\sha256_control_block_0|current_state.S22\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S22~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S22~q\);

-- Location: LCCOMB_X34_Y1_N6
\sha256_control_block_0|current_state.S23~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S23~feeder_combout\ = \sha256_control_block_0|current_state.S22~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S22~q\,
	combout => \sha256_control_block_0|current_state.S23~feeder_combout\);

-- Location: FF_X34_Y1_N7
\sha256_control_block_0|current_state.S23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S23~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S23~q\);

-- Location: LCCOMB_X34_Y1_N0
\sha256_control_block_0|current_state.S24~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S24~feeder_combout\ = \sha256_control_block_0|current_state.S23~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S23~q\,
	combout => \sha256_control_block_0|current_state.S24~feeder_combout\);

-- Location: FF_X34_Y1_N1
\sha256_control_block_0|current_state.S24\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S24~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S24~q\);

-- Location: LCCOMB_X34_Y1_N2
\sha256_control_block_0|current_state.S53~feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|current_state.S53~feeder_combout\ = \sha256_control_block_0|current_state.S24~q\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \sha256_control_block_0|current_state.S24~q\,
	combout => \sha256_control_block_0|current_state.S53~feeder_combout\);

-- Location: FF_X34_Y1_N3
\sha256_control_block_0|current_state.S53\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|current_state.S53~feeder_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S53~q\);

-- Location: LCCOMB_X34_Y1_N24
\sha256_control_block_0|Selector0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \sha256_control_block_0|Selector0~0_combout\ = (!\sha256_control_block_0|current_state.S53~q\ & ((\chip_select~input_o\) # (\sha256_control_block_0|current_state.S0~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \chip_select~input_o\,
	datac => \sha256_control_block_0|current_state.S0~q\,
	datad => \sha256_control_block_0|current_state.S53~q\,
	combout => \sha256_control_block_0|Selector0~0_combout\);

-- Location: FF_X34_Y1_N25
\sha256_control_block_0|current_state.S0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \sha256_control_block_0|Selector0~0_combout\,
	clrn => \ALT_INV_chip_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \sha256_control_block_0|current_state.S0~q\);

ww_chip_ready <= \chip_ready~output_o\;

ww_output(0) <= \output[0]~output_o\;

ww_output(1) <= \output[1]~output_o\;

ww_output(2) <= \output[2]~output_o\;

ww_output(3) <= \output[3]~output_o\;

ww_output(4) <= \output[4]~output_o\;

ww_output(5) <= \output[5]~output_o\;

ww_output(6) <= \output[6]~output_o\;

ww_output(7) <= \output[7]~output_o\;

ww_output(8) <= \output[8]~output_o\;

ww_output(9) <= \output[9]~output_o\;

ww_output(10) <= \output[10]~output_o\;

ww_output(11) <= \output[11]~output_o\;

ww_output(12) <= \output[12]~output_o\;

ww_output(13) <= \output[13]~output_o\;

ww_output(14) <= \output[14]~output_o\;

ww_output(15) <= \output[15]~output_o\;

ww_output(16) <= \output[16]~output_o\;

ww_output(17) <= \output[17]~output_o\;

ww_output(18) <= \output[18]~output_o\;

ww_output(19) <= \output[19]~output_o\;

ww_output(20) <= \output[20]~output_o\;

ww_output(21) <= \output[21]~output_o\;

ww_output(22) <= \output[22]~output_o\;

ww_output(23) <= \output[23]~output_o\;

ww_output(24) <= \output[24]~output_o\;

ww_output(25) <= \output[25]~output_o\;

ww_output(26) <= \output[26]~output_o\;

ww_output(27) <= \output[27]~output_o\;

ww_output(28) <= \output[28]~output_o\;

ww_output(29) <= \output[29]~output_o\;

ww_output(30) <= \output[30]~output_o\;

ww_output(31) <= \output[31]~output_o\;

ww_output(32) <= \output[32]~output_o\;

ww_output(33) <= \output[33]~output_o\;

ww_output(34) <= \output[34]~output_o\;

ww_output(35) <= \output[35]~output_o\;

ww_output(36) <= \output[36]~output_o\;

ww_output(37) <= \output[37]~output_o\;

ww_output(38) <= \output[38]~output_o\;

ww_output(39) <= \output[39]~output_o\;

ww_output(40) <= \output[40]~output_o\;

ww_output(41) <= \output[41]~output_o\;

ww_output(42) <= \output[42]~output_o\;

ww_output(43) <= \output[43]~output_o\;

ww_output(44) <= \output[44]~output_o\;

ww_output(45) <= \output[45]~output_o\;

ww_output(46) <= \output[46]~output_o\;

ww_output(47) <= \output[47]~output_o\;

ww_output(48) <= \output[48]~output_o\;

ww_output(49) <= \output[49]~output_o\;

ww_output(50) <= \output[50]~output_o\;

ww_output(51) <= \output[51]~output_o\;

ww_output(52) <= \output[52]~output_o\;

ww_output(53) <= \output[53]~output_o\;

ww_output(54) <= \output[54]~output_o\;

ww_output(55) <= \output[55]~output_o\;

ww_output(56) <= \output[56]~output_o\;

ww_output(57) <= \output[57]~output_o\;

ww_output(58) <= \output[58]~output_o\;

ww_output(59) <= \output[59]~output_o\;

ww_output(60) <= \output[60]~output_o\;

ww_output(61) <= \output[61]~output_o\;

ww_output(62) <= \output[62]~output_o\;

ww_output(63) <= \output[63]~output_o\;

ww_output(64) <= \output[64]~output_o\;

ww_output(65) <= \output[65]~output_o\;

ww_output(66) <= \output[66]~output_o\;

ww_output(67) <= \output[67]~output_o\;

ww_output(68) <= \output[68]~output_o\;

ww_output(69) <= \output[69]~output_o\;

ww_output(70) <= \output[70]~output_o\;

ww_output(71) <= \output[71]~output_o\;

ww_output(72) <= \output[72]~output_o\;

ww_output(73) <= \output[73]~output_o\;

ww_output(74) <= \output[74]~output_o\;

ww_output(75) <= \output[75]~output_o\;

ww_output(76) <= \output[76]~output_o\;

ww_output(77) <= \output[77]~output_o\;

ww_output(78) <= \output[78]~output_o\;

ww_output(79) <= \output[79]~output_o\;

ww_output(80) <= \output[80]~output_o\;

ww_output(81) <= \output[81]~output_o\;

ww_output(82) <= \output[82]~output_o\;

ww_output(83) <= \output[83]~output_o\;

ww_output(84) <= \output[84]~output_o\;

ww_output(85) <= \output[85]~output_o\;

ww_output(86) <= \output[86]~output_o\;

ww_output(87) <= \output[87]~output_o\;

ww_output(88) <= \output[88]~output_o\;

ww_output(89) <= \output[89]~output_o\;

ww_output(90) <= \output[90]~output_o\;

ww_output(91) <= \output[91]~output_o\;

ww_output(92) <= \output[92]~output_o\;

ww_output(93) <= \output[93]~output_o\;

ww_output(94) <= \output[94]~output_o\;

ww_output(95) <= \output[95]~output_o\;

ww_output(96) <= \output[96]~output_o\;

ww_output(97) <= \output[97]~output_o\;

ww_output(98) <= \output[98]~output_o\;

ww_output(99) <= \output[99]~output_o\;

ww_output(100) <= \output[100]~output_o\;

ww_output(101) <= \output[101]~output_o\;

ww_output(102) <= \output[102]~output_o\;

ww_output(103) <= \output[103]~output_o\;

ww_output(104) <= \output[104]~output_o\;

ww_output(105) <= \output[105]~output_o\;

ww_output(106) <= \output[106]~output_o\;

ww_output(107) <= \output[107]~output_o\;

ww_output(108) <= \output[108]~output_o\;

ww_output(109) <= \output[109]~output_o\;

ww_output(110) <= \output[110]~output_o\;

ww_output(111) <= \output[111]~output_o\;

ww_output(112) <= \output[112]~output_o\;

ww_output(113) <= \output[113]~output_o\;

ww_output(114) <= \output[114]~output_o\;

ww_output(115) <= \output[115]~output_o\;

ww_output(116) <= \output[116]~output_o\;

ww_output(117) <= \output[117]~output_o\;

ww_output(118) <= \output[118]~output_o\;

ww_output(119) <= \output[119]~output_o\;

ww_output(120) <= \output[120]~output_o\;

ww_output(121) <= \output[121]~output_o\;

ww_output(122) <= \output[122]~output_o\;

ww_output(123) <= \output[123]~output_o\;

ww_output(124) <= \output[124]~output_o\;

ww_output(125) <= \output[125]~output_o\;

ww_output(126) <= \output[126]~output_o\;

ww_output(127) <= \output[127]~output_o\;

ww_output(128) <= \output[128]~output_o\;

ww_output(129) <= \output[129]~output_o\;

ww_output(130) <= \output[130]~output_o\;

ww_output(131) <= \output[131]~output_o\;

ww_output(132) <= \output[132]~output_o\;

ww_output(133) <= \output[133]~output_o\;

ww_output(134) <= \output[134]~output_o\;

ww_output(135) <= \output[135]~output_o\;

ww_output(136) <= \output[136]~output_o\;

ww_output(137) <= \output[137]~output_o\;

ww_output(138) <= \output[138]~output_o\;

ww_output(139) <= \output[139]~output_o\;

ww_output(140) <= \output[140]~output_o\;

ww_output(141) <= \output[141]~output_o\;

ww_output(142) <= \output[142]~output_o\;

ww_output(143) <= \output[143]~output_o\;

ww_output(144) <= \output[144]~output_o\;

ww_output(145) <= \output[145]~output_o\;

ww_output(146) <= \output[146]~output_o\;

ww_output(147) <= \output[147]~output_o\;

ww_output(148) <= \output[148]~output_o\;

ww_output(149) <= \output[149]~output_o\;

ww_output(150) <= \output[150]~output_o\;

ww_output(151) <= \output[151]~output_o\;

ww_output(152) <= \output[152]~output_o\;

ww_output(153) <= \output[153]~output_o\;

ww_output(154) <= \output[154]~output_o\;

ww_output(155) <= \output[155]~output_o\;

ww_output(156) <= \output[156]~output_o\;

ww_output(157) <= \output[157]~output_o\;

ww_output(158) <= \output[158]~output_o\;

ww_output(159) <= \output[159]~output_o\;

ww_output(160) <= \output[160]~output_o\;

ww_output(161) <= \output[161]~output_o\;

ww_output(162) <= \output[162]~output_o\;

ww_output(163) <= \output[163]~output_o\;

ww_output(164) <= \output[164]~output_o\;

ww_output(165) <= \output[165]~output_o\;

ww_output(166) <= \output[166]~output_o\;

ww_output(167) <= \output[167]~output_o\;

ww_output(168) <= \output[168]~output_o\;

ww_output(169) <= \output[169]~output_o\;

ww_output(170) <= \output[170]~output_o\;

ww_output(171) <= \output[171]~output_o\;

ww_output(172) <= \output[172]~output_o\;

ww_output(173) <= \output[173]~output_o\;

ww_output(174) <= \output[174]~output_o\;

ww_output(175) <= \output[175]~output_o\;

ww_output(176) <= \output[176]~output_o\;

ww_output(177) <= \output[177]~output_o\;

ww_output(178) <= \output[178]~output_o\;

ww_output(179) <= \output[179]~output_o\;

ww_output(180) <= \output[180]~output_o\;

ww_output(181) <= \output[181]~output_o\;

ww_output(182) <= \output[182]~output_o\;

ww_output(183) <= \output[183]~output_o\;

ww_output(184) <= \output[184]~output_o\;

ww_output(185) <= \output[185]~output_o\;

ww_output(186) <= \output[186]~output_o\;

ww_output(187) <= \output[187]~output_o\;

ww_output(188) <= \output[188]~output_o\;

ww_output(189) <= \output[189]~output_o\;

ww_output(190) <= \output[190]~output_o\;

ww_output(191) <= \output[191]~output_o\;

ww_output(192) <= \output[192]~output_o\;

ww_output(193) <= \output[193]~output_o\;

ww_output(194) <= \output[194]~output_o\;

ww_output(195) <= \output[195]~output_o\;

ww_output(196) <= \output[196]~output_o\;

ww_output(197) <= \output[197]~output_o\;

ww_output(198) <= \output[198]~output_o\;

ww_output(199) <= \output[199]~output_o\;

ww_output(200) <= \output[200]~output_o\;

ww_output(201) <= \output[201]~output_o\;

ww_output(202) <= \output[202]~output_o\;

ww_output(203) <= \output[203]~output_o\;

ww_output(204) <= \output[204]~output_o\;

ww_output(205) <= \output[205]~output_o\;

ww_output(206) <= \output[206]~output_o\;

ww_output(207) <= \output[207]~output_o\;

ww_output(208) <= \output[208]~output_o\;

ww_output(209) <= \output[209]~output_o\;

ww_output(210) <= \output[210]~output_o\;

ww_output(211) <= \output[211]~output_o\;

ww_output(212) <= \output[212]~output_o\;

ww_output(213) <= \output[213]~output_o\;

ww_output(214) <= \output[214]~output_o\;

ww_output(215) <= \output[215]~output_o\;

ww_output(216) <= \output[216]~output_o\;

ww_output(217) <= \output[217]~output_o\;

ww_output(218) <= \output[218]~output_o\;

ww_output(219) <= \output[219]~output_o\;

ww_output(220) <= \output[220]~output_o\;

ww_output(221) <= \output[221]~output_o\;

ww_output(222) <= \output[222]~output_o\;

ww_output(223) <= \output[223]~output_o\;

ww_output(224) <= \output[224]~output_o\;

ww_output(225) <= \output[225]~output_o\;

ww_output(226) <= \output[226]~output_o\;

ww_output(227) <= \output[227]~output_o\;

ww_output(228) <= \output[228]~output_o\;

ww_output(229) <= \output[229]~output_o\;

ww_output(230) <= \output[230]~output_o\;

ww_output(231) <= \output[231]~output_o\;

ww_output(232) <= \output[232]~output_o\;

ww_output(233) <= \output[233]~output_o\;

ww_output(234) <= \output[234]~output_o\;

ww_output(235) <= \output[235]~output_o\;

ww_output(236) <= \output[236]~output_o\;

ww_output(237) <= \output[237]~output_o\;

ww_output(238) <= \output[238]~output_o\;

ww_output(239) <= \output[239]~output_o\;

ww_output(240) <= \output[240]~output_o\;

ww_output(241) <= \output[241]~output_o\;

ww_output(242) <= \output[242]~output_o\;

ww_output(243) <= \output[243]~output_o\;

ww_output(244) <= \output[244]~output_o\;

ww_output(245) <= \output[245]~output_o\;

ww_output(246) <= \output[246]~output_o\;

ww_output(247) <= \output[247]~output_o\;

ww_output(248) <= \output[248]~output_o\;

ww_output(249) <= \output[249]~output_o\;

ww_output(250) <= \output[250]~output_o\;

ww_output(251) <= \output[251]~output_o\;

ww_output(252) <= \output[252]~output_o\;

ww_output(253) <= \output[253]~output_o\;

ww_output(254) <= \output[254]~output_o\;

ww_output(255) <= \output[255]~output_o\;
END structure;


