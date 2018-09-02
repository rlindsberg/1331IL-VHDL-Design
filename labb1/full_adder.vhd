Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
Use WORK.ALL;

Entity full_adder is
	Port(
		A: IN std_logic;
		B: IN	std_logic;
		Cin: IN	std_logic;
		Carry: OUT std_logic;
		Sum: OUT std_logic
	);
End;

Architecture behavioural of full_adder is

Begin

	Sum <= A XOR B XOR Cin After 5 ns;
	Carry <= (A AND B) OR (A AND Cin) OR (Cin AND B) After 5 ns;

End behavioural;
