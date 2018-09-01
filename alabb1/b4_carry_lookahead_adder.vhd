-- https://www.electronicshub.org/carry-look-ahead-adder
Library ieee;
Use ieee.std_logic_1164.all;

entity b4_carry_lookahead_adder is
	port (
		a0, a1, a2, a3,
		b0, b1, b2, b3: std_logic;
		s0, s1, s2, s3: out std_logic);
end entity;

architecture gooy_inside of b4_carry_lookahead_adder is
	signal c0, c1, c2, c3: std_logic;
	signal t0, t1, t2, t3: std_logic;
	signal na0, na1, na2, na3: std_logic;
	signal no0, no1, no2, no3: std_logic;
	
	begin
		no0 <= a0 nor b0;
		no1 <= a1 nor b1;
		no2 <= a2 nor b2;
		no3 <= a3 nor b3;
		
		na0 <= a0 nand b0;
		na1 <= a1 nand b1;
		na2 <= a2 nand b2;
		na3 <= a3 nand b3;
	-- '0' och '1' är där ev. carry_in skulle varit och kan egentligen förkortas bort.
		c0 <= '0';
		t0 <= na0 and not no0;
		
		c1 <= ('1' and na0) nor no0;
		t1 <= na1 and not no1;
		
		c2 <= ('1' and na0 and na1) nor (na1 and no0) nor no1;
		t2 <= na2 and not no2;
		
		c3 <= ('1' and na0 and na1 and na2) nor (na1 and na2 and no0) nor (na2 and no1) nor no2;
		t3 <= na3 and not no3;
		
		s0 <= c0 xor t0;
		s1 <= c1 xor t1;
		s2 <= c2 xor t2;
		s3 <= c3 xor t3;
end architecture;
	