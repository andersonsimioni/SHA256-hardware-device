library ieee;
use ieee.std_logic_1164.all;
-- arch 
use ieee.numeric_std.all;

entity compare is
	generic(	width: positive;
				isSigned: boolean := false;
				generateEqual: boolean := false ;
				generateLessThan: boolean := false;
				useFixedSecodOperand: boolean := false;
				fixedSecodOperand: integer := 0 );
	port(	input0, input1: in std_logic_vector(width-1 downto 0);
			lessThan, equal: out std_logic );
end entity;


architecture behav0 of compare is
signal secondOp: std_logic_vector(width-1 downto 0);
begin
	fixed: if useFixedSecodOperand generate
		secondOp <= std_logic_vector(to_unsigned(fixedSecodOperand, secondOp'length)); -- not relevant if signed or unsigned
	end generate;
	notfixed: if not useFixedSecodOperand generate
		secondOp <= input1;
	end generate;

	if0: if generateEqual generate
		equal <= '1' when input0 = secondOp else '0';
	end generate;
	if1: if generateLessThan generate
		if2: if isSigned generate
			lessThan <= '1' when signed(input0) < signed(secondOp) else '0';
		end generate;
		if3: if not isSigned generate
			lessThan <= '1' when unsigned(input0) < unsigned(secondOp) else '0';
		end generate;
	end generate;
end architecture;