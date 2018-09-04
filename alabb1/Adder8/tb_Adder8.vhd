library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_Adder8 is
end entity;

architecture gooy_inside of tb_Adder8 is
	component Adder8 is
		port(
			a 					: in std_logic_vector(7 downto 0);
			b 					: in std_logic_vector(7 downto 0);
			carry_in 		: in std_logic;
			sum 				: out std_logic_vector(7 downto 0);
			carry_out 	: out std_logic);
	end component;

	signal A, B, SUM 		: std_logic_vector(7 downto 0);
	signal C_in, C_out 	: std_logic;

	begin

		TA : Adder8
		port map (
			a => A,
			b => B,
			carry_in => C_in,
			sum => SUM,
			carry_out => C_out
		);

		A <= std_logic_vector(to_unsigned(A, a'length));
		B <= std_logic_vector(to_unsigned(B, b'length));

		process
			begin
				A <= 256;
				B <= 1;
				wait for 10 ns;

				A <= 128;
				B <= 128;
				wait for 10 ns;

				A <= 0;
				b <= 1;
				wait for 10 ns;
		end process;

end architecture;
