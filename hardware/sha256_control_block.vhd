library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_control_block is
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

	next_state_logic_process: process(next_state, stt1, stt2, stt3, stt4, stt5, stt6, stt7, stt8, stt9, stt10)
	begin
		next_state <= current_state;
		
		case current_state is			
			
			when L42 =>
				if chip_select = '1' then
					next_state <= L43;
				end if;

			when L43 =>
				next_state <= L44;

			when L44 =>
				next_state <= L45;

			when L45 =>
				next_state <= L46;

			when L46 =>
				next_state <= L47;

			when L47 =>
				next_state <= L48;

			when L48 =>
				next_state <= L49;

			
			--STT1
			when L49 =>
				if stt1 = '1' then
					next_state <= L50;
				else
					next_state <= L53;
				end if;

			when L50 =>
				next_state <= L51;

			when L51 =>
				next_state <= L52;

			when L52 =>
				next_state <= L49;

			
			
			
			
			when L53 =>
				next_state <= L54;
			
			
			
			
			--STT
			when L54 =>
				if stt2 = '1' then
					next_state <= L42;
				else
					next_state <= L55;
				end if;
			

			
			
			when L55 =>
				next_state <= L56;

			when L56 =>
				next_state <= L57;

				
			
			--STT
			when L57 =>
				if stt3 = '1' then
					next_state <= L58;
				else
					next_state <= L71;
				end if;

			when L58 =>
				next_state <= L59;

			when L59 =>
				if stt4 = '1' then
					next_state <= L60;
				else
					next_state <= L70;
				end if;

			when L60 =>
				next_state <= L61;

			when L61 =>
				next_state <= L62;

			when L62 =>
				next_state <= L63;

			when L63 =>
				next_state <= L64;

			when L64 =>
				next_state <= L65;

			when L65 =>
				next_state <= L66;

			when L66 =>
				next_state <= L67;

			when L67 =>
				next_state <= L68;

			when L68 =>
				next_state <= L69;

			when L69 =>
				next_state <= L70;

			when L70 =>
				next_state <= L57;

			
			
			
			when L71 =>
				next_state <= L72;

			when L72 =>
				next_state <= L73;
			
			
			
			
			--STT
			when L73 =>
				if stt5 = '1' then
					next_state <= L74;
				else
					next_state <= L76;
				end if;

			when L74 =>
				next_state <= L75;

			when L75 =>
				next_state <= L73;
			
			

			when L76 =>
				next_state <= L77;
			
			
			
			--STT
			when L77 =>
				if stt6 = '1' then
					next_state <= L78;
				else
					next_state <= L132;
				end if;

			when L78 =>
				next_state <= L79;

			when L79 =>
				next_state <= L80;

			when L80 =>
				if stt7 = '1' then
					next_state <= L81;
				else
					next_state <= L87;
				end if;
			
			when L81 =>
				next_state <= L82;

			when L82 =>
				next_state <= L83;

			when L83 =>
				next_state <= L84;

			when L84 =>
				next_state <= L85;

			when L85 =>
				next_state <= L86;

			when L86 =>
				next_state <= L80;

			when L87 =>
				next_state <= L88;

			when L88 =>
				if stt8 = '1' then
					next_state <= L89;
				else
					next_state <= L98;
				end if;

			when L89 =>
				next_state <= L90;

			when L90 =>
				next_state <= L91;

			when L91 =>
				next_state <= L92;	

			when L92 =>
				next_state <= L93;

			when L93 =>
				next_state <= L94;

			when L94 =>
				next_state <= L95;

			when L95 =>
				next_state <= L96;

			when L96 =>
				next_state <= L97;

			when L97 =>
				next_state <= L88;

			when L98 =>
				next_state <= L99;

			when L99 =>
				next_state <= L100;

			when L100 =>
				next_state <= L101;

			when L101 =>
				next_state <= L102;

			when L102 =>
				next_state <= L103;

			when L103 =>
				next_state <= L104;

			when L104 =>
				next_state <= L105;

			when L105 =>
				next_state <= L106;

			when L106 =>
				next_state <= L107;

			when L107 =>
				if stt9 = '1' then
					next_state <= L108;
				else
					next_state <= L123;
				end if;
				
			when L108 =>
				next_state <= L109;

			when L109 =>
				next_state <= L110;

			when L110 =>
				next_state <= L111;

			when L111 =>
				next_state <= L112;

			when L112 =>
				next_state <= L113;

			when L113 =>
				next_state <= L114;

			when L114 =>
				next_state <= L115;

			when L115 =>
				next_state <= L116;

			when L116 =>
				next_state <= L117;

			when L117 =>
				next_state <= L118;

			when L118 =>
				next_state <= L119;

			when L119 =>
				next_state <= L120;

			when L120 =>
				next_state <= L121;

			when L121 =>
				next_state <= L122;

			when L122 =>
				next_state <= L107;

			when L123 =>
					next_state <= L124;

			when L124 =>
				next_state <= L125;

			when L125 =>
				next_state <= L126;

			when L126 =>
				next_state <= L127;

			when L127 =>
				next_state <= L128;

			when L128 =>
				next_state <= L129;

			when L129 =>
				next_state <= L130;

			when L130 =>
				next_state <= L131;

			when L131 =>
				next_state <= L77;



			when L132 =>
				next_state <= L133;

			when L133 =>
				if stt10 = '1' then
					next_state <= L134;
				else
					next_state <= L42;
				end if;

			when L134 =>
				next_state <= L135;

			when L135 =>
				next_state <= L136;

			when L136 =>
				next_state <= L137;

			when L137 =>
				next_state <= L138;

			when L138 =>
				next_state <= L133;

		end case;
	end process;
	
	
	
	next_state_reg_process: process(clock, chip_reset)
	begin
		if chip_reset = '1' then
			current_state <= L42;
		elsif rising_edge(clock) then
			current_state <= next_state;
		end if;
	end process;
	
	
	chip_ready <= '1' when current_state = L42 else '0';
	
	ctrl1 <= '1' when current_state = L42 else '0';
	ctrl2 <= '1' when current_state = L43 else '0';
	ctrl3 <= '1' when current_state = L44 else '0';
	ctrl4 <= '1' when current_state = L45 else '0';
	ctrl5 <= '1' when current_state = L46 else '0';
	ctrl6 <= '1' when current_state = L47 else '0';
	ctrl7 <= '1' when current_state = L48 else '0';
	ctrl8 <= '1' when current_state = L50 else '0';
	ctrl9 <= '1' when current_state = L51 else '0';
	ctrl10 <= '1' when current_state = L52 else '0';
	ctrl11 <= '1' when current_state = L53 else '0';
	ctrl12 <= '1' when current_state = L55 else '0';
	ctrl13 <= '1' when current_state = L56 else '0';
	ctrl14 <= '1' when current_state = L58 else '0';
	ctrl15 <= '1' when current_state = L60 else '0';
	ctrl16 <= '1' when current_state = L61 else '0';
	ctrl17 <= '1' when current_state = L62 else '0';
	ctrl18 <= '1' when current_state = L63 else '0';
	ctrl19 <= '1' when current_state = L64 else '0';
	ctrl20 <= '1' when current_state = L65 else '0';
	ctrl21 <= '1' when current_state = L66 else '0';
	ctrl22 <= '1' when current_state = L67 else '0';
	ctrl23 <= '1' when current_state = L68 else '0';
	ctrl24 <= '1' when current_state = L69 else '0';
	ctrl26 <= '1' when current_state = L70 else '0';
	ctrl27 <= '1' when current_state = L71 else '0';
	ctrl28 <= '1' when current_state = L72 else '0';
	ctrl29 <= '1' when current_state = L74 else '0';
	ctrl30 <= '1' when current_state = L75 else '0';
	ctrl31 <= '1' when current_state = L76 else '0';
	ctrl32 <= '1' when current_state = L78 else '0';
	ctrl33 <= '1' when current_state = L79 else '0';
	ctrl34 <= '1' when current_state = L81 else '0';
	ctrl35 <= '1' when current_state = L82 else '0';
	ctrl36 <= '1' when current_state = L83 else '0';
	ctrl37 <= '1' when current_state = L84 else '0';
	ctrl38 <= '1' when current_state = L85 else '0';
	ctrl39 <= '1' when current_state = L86 else '0';
	ctrl40 <= '1' when current_state = L87 else '0';
	ctrl41 <= '1' when current_state = L89 else '0';
	ctrl42 <= '1' when current_state = L90 else '0';
	ctrl43 <= '1' when current_state = L91 else '0';
	ctrl44 <= '1' when current_state = L92 else '0';
	ctrl45 <= '1' when current_state = L93 else '0';
	ctrl46 <= '1' when current_state = L94 else '0';
	ctrl47 <= '1' when current_state = L95 else '0';
	ctrl48 <= '1' when current_state = L96 else '0';
	ctrl49 <= '1' when current_state = L97 else '0';
	ctrl50 <= '1' when current_state = L98 else '0';
	ctrl51 <= '1' when current_state = L99 else '0';
	ctrl52 <= '1' when current_state = L100 else '0';
	ctrl53 <= '1' when current_state = L101 else '0';
	ctrl54 <= '1' when current_state = L102 else '0';
	ctrl55 <= '1' when current_state = L103 else '0';
	ctrl56 <= '1' when current_state = L104 else '0';
	ctrl57 <= '1' when current_state = L105 else '0';
	ctrl58 <= '1' when current_state = L106 else '0';
	ctrl59 <= '1' when current_state = L108 else '0';
	ctrl60 <= '1' when current_state = L109 else '0';
	ctrl61 <= '1' when current_state = L110 else '0';
	ctrl62 <= '1' when current_state = L111 else '0';
	ctrl63 <= '1' when current_state = L112 else '0';
	ctrl64 <= '1' when current_state = L113 else '0';
	ctrl65 <= '1' when current_state = L114 else '0';
	ctrl66 <= '1' when current_state = L115 else '0';
	ctrl67 <= '1' when current_state = L116 else '0';
	ctrl68 <= '1' when current_state = L117 else '0';
	ctrl69 <= '1' when current_state = L118 else '0';
	ctrl70 <= '1' when current_state = L119 else '0';
	ctrl71 <= '1' when current_state = L120 else '0';
	ctrl72 <= '1' when current_state = L121 else '0';
	ctrl73 <= '1' when current_state = L122 else '0';
	ctrl74 <= '1' when current_state = L123 else '0';
	ctrl75 <= '1' when current_state = L124 else '0';
	ctrl76 <= '1' when current_state = L125 else '0';
	ctrl77 <= '1' when current_state = L126 else '0';
	ctrl78 <= '1' when current_state = L127 else '0';
	ctrl79 <= '1' when current_state = L128 else '0';
	ctrl80 <= '1' when current_state = L129 else '0';
	ctrl81 <= '1' when current_state = L130 else '0';
	ctrl82 <= '1' when current_state = L131 else '0';
	ctrl83 <= '1' when current_state = L132 else '0';
	ctrl84 <= '1' when current_state = L134 else '0';
	ctrl85 <= '1' when current_state = L135 else '0';
	ctrl86 <= '1' when current_state = L136 else '0';
	ctrl87 <= '1' when current_state = L137 else '0';
	ctrl88 <= '1' when current_state = L138 else '0';

end sha256_control_block_arch ; -- sha256_control_block_arch