-- WIP
library ieee;
use ieee.std_logic_1164.all;

entity b8_carry_select_adder is
	port(
		A : std_logic_vector(7 downto 0);
		B : std_logic_vector(7 downto 0);
		Sum : std_logic_vector(7 downto 0);
		C_in : std_logic;
		C_out : std_logic);
end entity;

architecture gooy_inside of b8_carry_select_adder is
	component b4_ripple_adder
		port (
			a : std_logic_vector(3 downto 0);
			b : std_logic_vector(3 downto 0);
			c_in : std_logic;
			sum : out std_logic_vector(3 downto 0);
			c_out : out std_logic);
	end component;
	
	signal int_c, c_out0, c_out1, tmp_or : std_logic;
	signal int_sum_c0, int_sum_c1 : std_logic_vector(3 downto 0);
	
	begin
		RA0 : b4_ripple_adder port map (	A(3 downto 0), 
													B(3 downto 0), 
													C_in, 
													Sum(3 downto 0),
													int_c);
													
		RA1 : b4_ripple_adder port map (	A(7 downto 4),
													B(7 downto 4),
													'0',
													int_sum_c0(3 downto 0),
													c_out0);
													
		RA2 : b4_ripple_adder port map (	A(7 downto 4),
													B(7 downto 4),
													'1',
													int_sum_c1(3 downto 0),
													c_out1);
		pro_case : process (int_c)
			variable INT_C : std_logic;
			begin
				INT_C := int_c;
				
				case INT_C is
					when '0' => Sum(7 downto 4) <= int_sum_c0(3 downto 0) after 5 ns;
					when '1' => Sum(7 downto 4) <= int_sum_c1(3 downto 0) after 5 ns;
				end case;
			
			end process;
		tmp_or <= c_out0 or int_c after 3 ns;
		C_out <= c_out1 and tmp_or after 3 ns;
		
end architecture;