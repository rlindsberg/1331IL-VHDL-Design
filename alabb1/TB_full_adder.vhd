library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity TB_full_adder is
end entity;

architecture gooy_inside of TB_full_adder is
	component full_adder is
		port(
			a, b, cin: std_logic;
			sum,cout: out std_logic);
	end component;
	
	-- inputs
	signal A, B, Cin : std_logic := '0';
	
	-- outputs
	signal Sum, Cout : std_logic := '0';
	
	begin
		TT : full_adder port map (
									a=>A,
									b => B,
									cin => Cin,
									sum => Sum,
									cout => Cout);
		
		Cin <= not Cin after 10ns;
		A <= not A after 20ns;
		B <= not B after 30ns;
		
end architecture;