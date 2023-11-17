library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_control_block is
  port (
		clock, chip_select, chip_reset : in std_logic;
		chip_ready : out std_logic;
		 
		stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9 : in std_logic;
		 
		ctrl1,ctrl2,ctrl3,ctrl4,ctrl5,ctrl6,ctrl7,ctrl8,ctrl9,ctrl10,ctrl11,ctrl12,ctrl13,ctrl14,ctrl15,
		ctrl16,ctrl17,ctrl18,ctrl19,ctrl20,ctrl21,ctrl22,ctrl23,ctrl24,ctrl26,ctrl27,ctrl28,ctrl29,ctrl30,
		ctrl31,ctrl32,ctrl33,ctrl34,ctrl35,ctrl36,ctrl37,ctrl38,ctrl39,ctrl40,ctrl41,ctrl42,ctrl43,ctrl44,
		ctrl45,ctrl46,ctrl47,ctrl48,ctrl49,ctrl50,ctrl51,ctrl52,ctrl53,ctrl54,ctrl55,ctrl56,ctrl57,ctrl58,
		ctrl59,ctrl60,ctrl61,ctrl62,ctrl63,ctrl64,ctrl65,ctrl66,ctrl67,ctrl68,ctrl69,ctrl70,ctrl71,ctrl72,
		ctrl73,ctrl74,ctrl75,ctrl76,ctrl77,ctrl78,ctrl79,ctrl80,ctrl81,ctrl82,ctrl83,ctrl84,ctrl85,ctrl86,
		ctrl87,ctrl88 : out std_logic
  ) ;
end sha256_control_block;

architecture sha256_control_block_arch of sha256_control_block is

    type state is
    (
		L42,L43,L44,L45,L46,L47,L48,L49,L50,L51,L52,L53,L54,L55,L56,L57,L58,L59,L60,L61,L62,L63,
		L64,L65,L66,L67,L68,L69,L70,L71,L72,L73,L74,L75,L76,L77,L78,L79,L80,L81,L82,L83,L84,L85,
		L86,L87,L88,L89,L90,L91,L92,L93,L94,L95,L96,L97,L98,L99,L100,L101,L102,L103,L104,L105,L106,
		L107,L108,L109,L110,L111,L112,L113,L114,L115,L116,L117,L118,L119,L120,L121,L122,L123,L124,
		L125,L126,L127,L128,L129,L130,L131,L132,L133,L134,L135,L136,L137,L138
    );
    
    signal current_state, next_state : state;

begin

	next_state_logic_process: process(next_state, stt0, stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9)
	begin
		case current_state is			
						
			when L42 =>

			when L43 =>

			when L44 =>

			when L45 =>

			when L46 =>

			when L47 =>

			when L48 =>

			when L49 =>

			when L50 =>

			when L51 =>

			when L52 =>

			when L53 =>

			when L54 =>

			when L55 =>

			when L56 =>

			when L57 =>

			when L58 =>

			when L59 =>

			when L60 =>

			when L61 =>

			when L62 =>

			when L63, =>

			when L64 =>

			when L65 =>

			when L66 =>

			when L67 =>

			when L68 =>

			when L69 =>

			when L70 =>

			when L71 =>

			when L72 =>

			when L73 =>

			when L74 =>

			when L75 =>

			when L76 =>

			when L77 =>

			when L78 =>

			when L79 =>

			when L80 =>

			when L81 =>

			when L82 =>

			when L83 =>

			when L84 =>

			when L85, =>

			when L86 =>

			when L87 =>

			when L88 =>

			when L89 =>

			when L90 =>

			when L91 =>

			when L92 =>

			when L93 =>

			when L94 =>

			when L95 =>

			when L96 =>

			when L97 =>

			when L98 =>

			when L99 =>

			when L100 =>

			when L101 =>

			when L102 =>

			when L103 =>

			when L104 =>

			when L105 =>

			when L106, =>

			when L107 =>

			when L108 =>

			when L109 =>

			when L110 =>

			when L111 =>

			when L112 =>

			when L113 =>

			when L114 =>

			when L115 =>

			when L116 =>

			when L117 =>

			when L118 =>

			when L119 =>

			when L120 =>

			when L121 =>

			when L122 =>

			when L123 =>

			when L124, =>

			when L125 =>

			when L126 =>

			when L127 =>

			when L128 =>

			when L129 =>

			when L130 =>

			when L131 =>

			when L132 =>

			when L133 =>

			when L134 =>

			when L135 =>

			when L136 =>

			when L137 =>

			when L138 =>

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
	
	
	chip_ready <= '1' when current_state = L42 else '0';
	
	ctrl1 <= '1' when current_state = L else '0';
	ctrl2 <= '1' when current_state = L else '0';
	ctrl3 <= '1' when current_state = L else '0';
	ctrl4 <= '1' when current_state = L else '0';
	ctrl5 <= '1' when current_state = L else '0';
	ctrl6 <= '1' when current_state = L else '0';
	ctrl7 <= '1' when current_state = L else '0';
	ctrl8 <= '1' when current_state = L else '0';
	ctrl9 <= '1' when current_state = L else '0';
	ctrl10 <= '1' when current_state = L else '0';
	ctrl11 <= '1' when current_state = L else '0';
	ctrl12 <= '1' when current_state = L else '0';
	ctrl13 <= '1' when current_state = L else '0';
	ctrl14 <= '1' when current_state = L else '0';
	ctrl15 <= '1' when current_state = L else '0';
	ctrl16 <= '1' when current_state = L else '0';
	ctrl17 <= '1' when current_state = L else '0';
	ctrl18 <= '1' when current_state = L else '0';
	ctrl19 <= '1' when current_state = L else '0';
	ctrl20 <= '1' when current_state = L else '0';
	ctrl21 <= '1' when current_state = L else '0';
	ctrl22 <= '1' when current_state = L else '0';
	ctrl23 <= '1' when current_state = L else '0';
	ctrl24 <= '1' when current_state = L else '0';
	ctrl26 <= '1' when current_state = L else '0';
	ctrl27 <= '1' when current_state = L else '0';
	ctrl28 <= '1' when current_state = L else '0';
	ctrl29 <= '1' when current_state = L else '0';
	ctrl30 <= '1' when current_state = L else '0';
	ctrl31 <= '1' when current_state = L else '0';
	ctrl32 <= '1' when current_state = L else '0';
	ctrl33 <= '1' when current_state = L else '0';
	ctrl34 <= '1' when current_state = L else '0';
	ctrl35 <= '1' when current_state = L else '0';
	ctrl36 <= '1' when current_state = L else '0';
	ctrl37 <= '1' when current_state = L else '0';
	ctrl38 <= '1' when current_state = L else '0';
	ctrl39 <= '1' when current_state = L else '0';
	ctrl40 <= '1' when current_state = L else '0';
	ctrl41 <= '1' when current_state = L else '0';
	ctrl42 <= '1' when current_state = L else '0';
	ctrl43 <= '1' when current_state = L else '0';
	ctrl44 <= '1' when current_state = L else '0';
	ctrl45 <= '1' when current_state = L else '0';
	ctrl46 <= '1' when current_state = L else '0';
	ctrl47 <= '1' when current_state = L else '0';
	ctrl48 <= '1' when current_state = L else '0';
	ctrl49 <= '1' when current_state = L else '0';
	ctrl50 <= '1' when current_state = L else '0';
	ctrl51 <= '1' when current_state = L else '0';
	ctrl52 <= '1' when current_state = L else '0';
	ctrl53 <= '1' when current_state = L else '0';
	ctrl54 <= '1' when current_state = L else '0';
	ctrl55 <= '1' when current_state = L else '0';
	ctrl56 <= '1' when current_state = L else '0';
	ctrl57 <= '1' when current_state = L else '0';
	ctrl58 <= '1' when current_state = L else '0';
	ctrl59 <= '1' when current_state = L else '0';
	ctrl60 <= '1' when current_state = L else '0';
	ctrl61 <= '1' when current_state = L else '0';
	ctrl62 <= '1' when current_state = L else '0';
	ctrl63 <= '1' when current_state = L else '0';
	ctrl64 <= '1' when current_state = L else '0';
	ctrl65 <= '1' when current_state = L else '0';
	ctrl66 <= '1' when current_state = L else '0';
	ctrl67 <= '1' when current_state = L else '0';
	ctrl68 <= '1' when current_state = L else '0';
	ctrl69 <= '1' when current_state = L else '0';
	ctrl70 <= '1' when current_state = L else '0';
	ctrl71 <= '1' when current_state = L else '0';
	ctrl72 <= '1' when current_state = L else '0';
	ctrl73 <= '1' when current_state = L else '0';
	ctrl74 <= '1' when current_state = L else '0';
	ctrl75 <= '1' when current_state = L else '0';
	ctrl76 <= '1' when current_state = L else '0';
	ctrl77 <= '1' when current_state = L else '0';
	ctrl78 <= '1' when current_state = L else '0';
	ctrl79 <= '1' when current_state = L else '0';
	ctrl80 <= '1' when current_state = L else '0';
	ctrl81 <= '1' when current_state = L else '0';
	ctrl82 <= '1' when current_state = L else '0';
	ctrl83 <= '1' when current_state = L else '0';
	ctrl84 <= '1' when current_state = L else '0';
	ctrl85 <= '1' when current_state = L else '0';
	ctrl86 <= '1' when current_state = L else '0';
	ctrl87 <= '1' when current_state = L else '0';
	ctrl88 <= '1' when current_state = L else '0';

end sha256_control_block_arch ; -- sha256_control_block_arch