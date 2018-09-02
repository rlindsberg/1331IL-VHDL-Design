Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
Use WORK.ALL;

Entity TB_full_adder is end TB_full_adder;

Architecture behavioural of TB_full_adder is

	Component full_adder is
		Port(
			A: IN std_logic;
			B: IN	std_logic;
			Cin: IN	std_logic;
			Carry: OUT std_logic;
			Sum: OUT std_logic
		);
	End Component;

	-- Inputs to the adder
	Signal numA:	std_logic:='0';
	Signal numB:	std_logic:='0';
	Signal numCin:	std_logic:='0';

	--outputs from the adder
	Signal numCarry: std_logic:='0';
	Signal numSum: std_logic:='0';


	Begin

		C1: full_adder Port Map(
			A	=> numA,
			B	=> numB,
			Cin	=> numCin,
			Carry	=> numCarry,
			Sum	=> numSum
		);


		--Adder test Stimulus

		numCin	<= NOT (numCin) After 10ns;
		numA	<= NOT (numA) After 20ns;
		numB	<= NOT (numB) After 30ns;

End behavioural;
