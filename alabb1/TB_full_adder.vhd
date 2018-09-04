Library ieee;
Use ieee.std_logic_1164.all;

entity full_adder is
	port(
		a, b, cin: std_logic;
		sum,cout: out std_logic);
end entity;

architecture gooy_inside of full_adder is
	begin
		sum <= cin xor (a xor b) after 5 ns;
		cout <= (a and b) or (cin and (a xor b)) after 5 ns;
end architecture;