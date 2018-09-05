Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Use WORK.ALL;

Entity tb_b4_ripple_adder is
End tb_b4_ripple_adder;

Architecture behavioural of tb_b4_ripple_adder is

Component b4_ripple_adder is
  Port(
    A: IN std_logic_vector(3 downto 0);
    B: IN	std_logic_vector(3 downto 0);
    Cin: IN	std_logic;
    Cout: OUT std_logic;
    Sum: OUT std_logic_vector(3 downto 0));
End Component;

--inputs
Signal num1: integer;
Signal num2: integer;
Signal A_int: std_logic_vector (3 downto 0);
Signal B_int : std_logic_vector (3 downto 0);
Signal Cin : std_logic;

--outputs
Signal Sum : std_logic_vector (3 downto 0);
Signal Overflow : std_logic;

Begin

  DUT: b4_ripple_adder Port Map(
		A => A_int,
		B => B_int,
		Cin => Cin,
		Cout => Overflow,
		Sum => Sum
	);

	process
	Begin
		num1 <= 8;
		num2 <= 1;
		Cin <= '0';
		wait for 50 ns;

		num1 <= 2;
		num2 <= 2;
		Cin <= '0';
		wait for 50 ns;

	End process;

	A_int <= std_logic_vector(to_unsigned(num1, A_int'length));
	B_int <= std_logic_vector(to_unsigned(num2, A_int'length));

End architecture;
