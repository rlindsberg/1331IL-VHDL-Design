library ieee;
use ieee.std_logic_1164.all;

entity cla_sub_comp is
	port(
			a, b: std_logic;
			no_out, na_out: out std_logic);
end entity;

architecture gooy_inside of cla_sub_comp is
	begin
		no_out <= a nor b;
		na_out <= a nand b;
end architecture;