library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_control_block is
  port (
    clock, chip_select, chip_ready, chip_reset : in std_logic;
	 
	 stt0, stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8 : in std_logic;
	 
	 ctrl0, ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7, ctrl8, ctrl9,
	 ctrl10, ctrl11, ctrl12, ctrl13, ctrl14, ctrl15, ctrl16, ctrl17, ctrl18, ctrl19,
	 ctrl20, ctrl21, ctrl22, ctrl23, ctrl24, ctrl25, ctrl26, ctrl27, ctrl28, ctrl29,
	 ctrl30, ctrl31, ctrl32, ctrl33, ctrl34, ctrl35, ctrl36, ctrl37, ctrl38, ctrl39,
	 ctrl40, ctrl41, ctrl42, ctrl43, ctrl44, ctrl45, ctrl46, ctrl47, ctrl48, ctrl49,
	 ctrl50, ctrl51, ctrl52, ctrl53, ctrl54, ctrl55, ctrl56, ctrl57, ctrl58, ctrl59,
	 ctrl60, ctrl61 : out std_logic
	 
  ) ;
end sha256_control_block;

architecture sha256_control_block_arch of sha256_control_block is

    type state is
    (
        S0,  S1,  S2,  S3,  S4,  S5,  S6,  S7,  S8,  S9,
        S10, S11, S12, S13, S14, S15, S16, S17, S18, S19,
        S20, S21, S22, S23, S24, S25, S26, S27, S28, S29,
        S30, S31, S32, S33, S34, S35, S36, S37, S38, S39,
        S40, S41, S42, S43, S44, S45, S46, S47, S48, S49,
        S50, S51, S52, S53
    );
    
    signal current_state, next_state : state;

begin

	next_state_logic_process: process(next_state, stt0, stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8)
	begin
		case current_state is			
			when S0 =>
				if chip_select='1' then
					next_state <= S1;
				else
					next_state <= S0;
				end if;
				
			when S1 =>
				next_state <= S2;

			when S2 =>
				next_state <= S3;

			when S3 =>
				next_state <= S4;

			when S4 =>
				if stt0='1' then
					next_state <= S5;
				else
					next_state <= S8;
				end if;

			when S5 =>
				next_state <= S6;

			when S6 =>
				next_state <= S7;

			when S7 =>
				next_state <= S4;

			when S8 =>
				next_state <= S9;

			when S9 =>
				if stt1='1' then
					next_state <= S0; --TODO: ERROR STATE
				else
					next_state <= S10;
				end if;

			when S10 =>
				next_state <= S11;

			when S11 =>
				next_state <= S12;

			when S12 =>
				if stt2='1' then
					next_state <= S13;
				else
					next_state <= S22;
				end if;

			when S13 =>
				next_state <= S14;

			when S14 =>
				if stt3='1' then
					next_state <= S15;
				else
					next_state <= S21;
				end if;

			when S15 =>
				next_state <= S16;

			when S16 =>
				next_state <= S17;

			when S17 =>
				if stt4='1' then
					next_state <= S18;
				else
					next_state <= S21;
				end if;

			when S18 =>
				next_state <= S19;

			when S19 =>
				next_state <= S20;

			when S20 =>
				next_state <= S17;

			when S21 =>
				next_state <= S12;

			when S22 =>
				next_state <= S23;

			when S23 =>
				next_state <= S24;

			when S24 =>
				if stt5='1' then
					next_state <= S25;
				else
					next_state <= S53;
				end if;

			when S25 =>
				next_state <= S26;

			when S26 =>
				next_state <= S27;

			when S27 =>
				if stt6='1' then
					next_state <= S28;
				else
					next_state <= S31;
				end if;

			when S28 =>
				next_state <= S29;

			when S29 =>
				next_state <= S30;

			when S30 =>
				next_state <= S27;

			when S31 =>
				next_state <= S32;

			when S32 =>
				if stt7='1' then
					next_state <= S33;
				else
					next_state <= S36;
				end if;

			when S33 =>
				next_state <= S34;

			when S34 =>
				next_state <= S35;

			when S35 =>
				next_state <= S32;

			when S36 =>
				next_state <= S37;

			when S37 =>
				next_state <= S38;

			when S38 =>
				if stt8='1' then
					next_state <= S39;
				else
					next_state <= S51;
				end if;

			when S39 =>
				next_state <= S40;

			when S40 =>
				next_state <= S41;

			when S41 =>
				next_state <= S42;

			when S42 =>
				next_state <= S43;

			when S43 =>
				next_state <= S44;

			when S44 =>
				next_state <= S45;

			when S45 =>
				next_state <= S46;

			when S46 =>
				next_state <= S47;

			when S47 =>
				next_state <= S48;

			when S48 =>
				next_state <= S49;

			when S49 =>
				next_state <= S50;

			when S50 =>
				next_state <= S38;

			when S51 =>
				next_state <= S52;

			when S52 =>
				next_state <= S24;

			when S53 =>
				next_state <= S0;
		
		end case;
	end process;
	
	
	
	next_state_reg_process: process(clock, chip_reset)
	begin
		if chip_reset = '1' then
			current_state <= S0;
		elsif rising_edge(clock) then
			current_state <= next_state;
		end if;
	end process;
	
	
	
	ctrl0 <= '1' when current_state = S0 else '0';
	
	--i=0
	ctrl1 <= '1' when current_state = S1 or current_state = S16 or current_state = S26 or current_state = S37 else '0'; --TODO MULTI STATE
	
	ctrl2 <= '1' when current_state = S1 else '0';
	ctrl3 <= '1' when current_state = S1 else '0';
	ctrl4 <= '1' when current_state = S1 else '0';
	ctrl5 <= '1' when current_state = S2 else '0';
	ctrl6 <= '1' when current_state = S3 else '0';
	ctrl7 <= '1' when current_state = S5 else '0';
	ctrl8 <= '1' when current_state = S8 else '0';
	ctrl9 <= '1' when current_state = S10 else '0';
	ctrl10 <= '1' when current_state = S11 else '0';
	ctrl11 <= '1' when current_state = S13 else '0';
	ctrl12 <= '1' when current_state = S15 else '0';
	ctrl13 <= '1' when current_state = S18 else '0';
	ctrl14 <= '1' when current_state = S8 else '0';
	ctrl15 <= '1' when current_state = S19 else '0';
	
	--i++
	ctrl16 <= '1' when current_state = S20 or current_state = S30 or current_state = S35 or current_state = S50 else '0'; --TODO MULTI STATE
	
	ctrl17 <= '1' when current_state = S21 else '0';
	ctrl18 <= '1' when current_state = S22 else '0';
	ctrl19 <= '1' when current_state = S23 else '0';
	ctrl20 <= '1' when current_state = S25 else '0';
	ctrl21 <= '1' when current_state = S8 else '0';
	ctrl22 <= '1' when current_state = S8 else '0';
	ctrl23 <= '1' when current_state = S8 else '0';
	ctrl24 <= '1' when current_state = S8 else '0';
	ctrl25 <= '1' when current_state = S29 else '0';
	ctrl26 <= '1' when current_state = S31 else '0';
	ctrl27 <= '1' when current_state = S33 else '0';
	ctrl28 <= '1' when current_state = S33 else '0';
	ctrl29 <= '1' when current_state = S34 else '0';
	ctrl30 <= '1' when current_state = S35 else '0';
	ctrl31 <= '1' when current_state = S36 else '0';
	ctrl32 <= '1' when current_state = S36 else '0';
	ctrl33 <= '1' when current_state = S36 else '0';
	ctrl34 <= '1' when current_state = S36 else '0';
	ctrl35 <= '1' when current_state = S36 else '0';
	ctrl36 <= '1' when current_state = S36 else '0';
	ctrl37 <= '1' when current_state = S36 else '0';
	ctrl38 <= '1' when current_state = S36 else '0';
	ctrl39 <= '1' when current_state = S39 else '0';
	ctrl40 <= '1' when current_state = S39 else '0';
	ctrl41 <= '1' when current_state = S40 else '0';
	ctrl42 <= '1' when current_state = S40 else '0';
	ctrl43 <= '1' when current_state = S40 else '0';
	ctrl44 <= '1' when current_state = S41 else '0';
	ctrl45 <= '1' when current_state = S42 else '0';
	ctrl46 <= '1' when current_state = S43 else '0';
	ctrl47 <= '1' when current_state = S44 else '0';
	ctrl48 <= '1' when current_state = S45 else '0';
	ctrl49 <= '1' when current_state = S46 else '0';
	ctrl50 <= '1' when current_state = S47 else '0';
	ctrl51 <= '1' when current_state = S48 else '0';
	ctrl52 <= '1' when current_state = S49 else '0';
	ctrl53 <= '1' when current_state = S51 else '0';
	ctrl54 <= '1' when current_state = S51 else '0';
	ctrl55 <= '1' when current_state = S51 else '0';
	ctrl56 <= '1' when current_state = S51 else '0';
	ctrl57 <= '1' when current_state = S51 else '0';
	ctrl58 <= '1' when current_state = S51 else '0';
	ctrl59 <= '1' when current_state = S51 else '0';
	ctrl60 <= '1' when current_state = S51 else '0';
	
	ctrl61 <= '1' when current_state = S52 else '0';

end sha256_control_block_arch ; -- sha256_control_block_arch