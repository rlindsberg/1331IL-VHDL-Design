library ieee;
use ieee.std_logic_1164.all;
use work.all;

entity Adder8 is
	port(
		a 					: in std_logic_vector(7 downto 0);
		b 					: in std_logic_vector(7 downto 0);
		carry_in 		: in std_logic;
		sum 				: out std_logic_vector(7 downto 0);
		carry_out 	: out std_logic);
end entity Adder8;

architecture gooy_inside of Adder8 is

	component b4_ripple_adder
		port (
			a         : std_logic_vector(3 downto 0);
			b         : std_logic_vector(3 downto 0);
			c_in      : std_logic;
			s         : out std_logic_vector(3 downto 0);
			c_out     : out std_logic);
	end component;

  -- Carry signals
	signal c_mux_switch   : std_logic;
  signal c_out0         : std_logic;
  signal c_out1         : std_logic;

  -- for adding OR-gate related delay
  signal tmp_or         : std_logic;

  -- for the sum from the parallell Adders
	signal int_sum_c0     : std_logic_vector(3 downto 0);
  signal int_sum_c1     : std_logic_vector(3 downto 0);

	begin
		RA0 : b4_ripple_adder port map (  a(3 downto 0),
                                      b(3 downto 0),
                                      carry_in,
                                      sum(3 downto 0),
                                      c_mux_switch);

		RA1 : b4_ripple_adder port map (  a(7 downto 4),
                                      b(7 downto 4),
                                      '0',
                                      int_sum_c0(3 downto 0),
                                      c_out0);

		RA2 : b4_ripple_adder port map (	a(7 downto 4),
                                      b(7 downto 4),
                                      '1',
                                      int_sum_c1(3 downto 0),
                                      c_out1);


      sum(7 downto 4) <= int_sum_c0(3 downto 0) after 4 ns when c_mux_switch='0' else
                         int_sum_c1(3 downto 0) after 4 ns;

		tmp_or <= c_out0 or c_mux_switch after 3 ns;
		carry_out <= c_out1 and tmp_or after 3 ns;

end architecture;
