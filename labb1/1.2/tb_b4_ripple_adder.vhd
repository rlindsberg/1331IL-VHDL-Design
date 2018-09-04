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
Signal adder_cin : std_logic;

--outputs
Signal answer : std_logic_vector (3 downto 0);
Signal overflow : std_logic;

Begin

  DUT: b4_ripple_adder Port Map(
		A => A_int,
		B => B_int,
		Cin =>adder_cin,
		Cout => overflow,
		Sum => answer
	);

	process
	Begin
		num1 <= 8;
		num2 <= 1;
		adder_cin <='0';
		wait for 10 ns;

		num1 <= 2;
		num2 <= 2;
		adder_cin <='0';
		wait for 10 ns;

	End process;

	A_int <= std_logic_vector(to_unsigned(num1,a_int'length));
	B_int <= std_logic_vector(to_unsigned(num2,b_int'length));

End architecture;
