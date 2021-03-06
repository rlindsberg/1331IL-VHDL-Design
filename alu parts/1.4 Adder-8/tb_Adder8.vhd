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

  signal A_int    : integer;
  signal B_int    : integer;
  signal A, B 		: std_logic_vector(7 downto 0);
	signal C_in 	  : std_logic;

  signal SUM      : std_logic_vector(7 downto 0);
  signal C_out    : std_logic;

	begin

		TA : Adder8
		port map (
      a => A,
			b => B,
			carry_in => C_in,
			sum => SUM,
			carry_out => C_out
		);

		A <= std_logic_vector(to_unsigned(A_int, A'length));
		B <= std_logic_vector(to_unsigned(B_int, B'length));
    C_in <= '0';

		process
			begin
				A_int <= 128;
				B_int <= 1;
				wait for 20 ns;

				A_int <= 64;
				B_int <= 64;
				wait for 20 ns;

				A_int <= 64;
				B_int <= 96;
				wait for 20 ns;

				A_int <= 0;
				B_int <= 1;
				wait for 20 ns;
		end process;

end architecture;
