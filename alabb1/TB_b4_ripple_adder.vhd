library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity TB_b4_ripple_adder is
end entity;

architecture gooy_inside of TB_b4_ripple_adder is

	component b4_ripple_adder is
		port (
			a : std_logic_vector(3 downto 0);
			b : std_logic_vector(3 downto 0);
			c_in : std_logic;
			s : out std_logic_vector(3 downto 0);
			c_out : out std_logic);
	end component;

	signal A, B, S : std_logic_vector(3 downto 0);
	signal C_in, C_out : std_logic;
	
	begin
		TT : b4_ripple_adder
		port map(
			a => A,
			b => B,
			c_in => C_in,
			s => S,
			c_out => C_out
		);
		
		A <= std_logic_vector(to_unsigned(a, A'length));
		B <= std_logic_vector(to_unsigned(b, B'length));
		
			
end architecture;
