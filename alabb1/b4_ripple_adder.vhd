library ieee;
use ieee.std_logic_1164.all;

entity b4_ripple_adder is
	port (
		a : std_logic_vector(3 downto 0);
		b : std_logic_vector(3 downto 0);
		c_in : std_logic;
		s : out std_logic_vector(3 downto 0);
		c_out : out std_logic);
end entity;

architecture gooy_inside of b4_ripple_adder is

	component full_adder
		port (a, b, cin: std_logic;
				sum, cout: out std_logic);
	end component;

	signal c : std_logic_vector(2 downto 0);
	
	begin
			f0: full_adder port map (a(0), b(0), c_in, s(0), c(0));
			f1: full_adder port map (a(1), b(1), c(0), s(1), c(1));
			f2: full_adder port map (a(2), b(2), c(1), s(2), c(2));
			f3: full_adder port map (a(3), b(3), c(2), s(3), c_out);
end architecture;
