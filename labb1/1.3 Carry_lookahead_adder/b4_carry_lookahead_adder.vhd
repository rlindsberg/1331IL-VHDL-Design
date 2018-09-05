-- Credit: A.N.

Library ieee;
Use ieee.std_logic_1164.all;
Use work.all;

entity b4_carry_lookahead_adder is
	port (
		A: std_logic_vector(3 downto 0);
    B: std_logic_vector(3 downto 0);
    s: OUT std_logic_vector(3 downto 0));
end entity;

architecture gooy_inside of b4_carry_lookahead_adder is
	signal c0, c1, c2, c3: std_logic;
	signal t0, t1, t2, t3: std_logic;
	signal na0, na1, na2, na3: std_logic;
	signal no0, no1, no2, no3: std_logic;

	begin
		no0 <= A(0) nor B(0);
		no1 <= A(1) nor B(1);
		no2 <= A(2) nor B(2);
		no3 <= A(3) nor B(3);

		na0 <= A(0) nand B(0);
		na1 <= A(1) nand B(1);
		na2 <= A(2) nand B(2);
		na3 <= A(3) nand B(3);
	-- '0' och '1' är där ev. carry_in skulle varit och kan egentligen förkortas bort.
		c0 <= '0';
		t0 <= na0 and not no0;

		c1 <= ('1' and na0) nor no0;
		t1 <= na1 and not no1;

		c2 <= (('1' and na0 and na1) nor (na1 and no0)) nor no1;
		t2 <= na2 and not no2;

		c3 <= (('1' and na0 and na1 and na2) nor (na1 and na2 and no0)) nor ((na2 and no1) nor no2);
		t3 <= na3 and not no3;

		s(0) <= c0 xor t0;
		s(1) <= c1 xor t1;
		s(2) <= c2 xor t2;
		s(3) <= c3 xor t3;
end architecture;
