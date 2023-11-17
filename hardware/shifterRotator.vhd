library ieee;
use ieee.std_logic_1164.all;

entity shifterRotator is
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
	begin
		assert (bitsToShift < width) severity error;
end entity;

architecture behav of shifterRotator is
    -- Complete
begin
    -- Complete
    
    -- test4TFT1 
    sll_gen: if isShifter and toLeft generate
        sll_l2: for i in 0 to bitsToShift-1 generate
            output(i) <= '0';
        end generate;
        sll_l1: for i in bitsToShift to width-1 generate
            output(i) <= input(i-bitsToShift);
        end generate;
    end generate;
    
    
    --test9TFF3 
    sr_gen: if isShifter and not toLeft generate
        sr_l1: for i in width-1 downto width-bitsToShift generate
           sra_gen: if not isLogical generate
                output(i) <= input(width-1);
           end generate;
           srl_gen: if isLogical generate
                output(i) <= '0';
           end generate;
        end generate;
        
        sr_l2: for i in width-1-bitsToShift downto 0 generate
            output(i) <= input(i+bitsToShift);
        end generate;
    end generate;



    --test6FTT4 
    rll_gen: if not isShifter and toLeft generate
        rll_loop1: for i in width-1 downto 0 generate
            output(i) <= input(integer((i-bitsToShift) mod (width)));
        end generate;
    end generate;
    
    
    --test8FFF1 
    rrl_gen: if not isShifter and not toLeft generate
        rrl_loop1: for i in width-1 downto 0 generate
            output(i) <= input(integer((i+bitsToShift) mod (width)));
        end generate;
    end generate;

    
end architecture; 