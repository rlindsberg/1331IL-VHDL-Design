Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Use WORK.ALL;

Entity tb_structural_b4_carry_lookahead_adder is
End tb_structural_b4_carry_lookahead_adder;

Architecture behavioural of tb_structural_b4_carry_lookahead_adder is

Component structural_b4_carry_lookahead_adder is
  Port (
    A: std_logic_vector(3 downto 0);
    B: std_logic_vector(3 downto 0);
    Sum: OUT std_logic_vector(3 downto 0);
	 Carry : out std_logic);
End Component;

--inputs
Signal num1: integer;
Signal num2: integer;
Signal A_int: std_logic_vector (3 downto 0);
Signal B_int : std_logic_vector (3 downto 0);

--outputs
Signal Sum : std_logic_vector (3 downto 0);
Signal Carry : std_logic;

Begin

  DUT: structural_b4_carry_lookahead_adder Port Map(
		A => A_int,
		B => B_int,
		Sum => Sum,
		Carry => Carry
	);

	process
	Begin
    -- testing 1000 + 0001 = 1001
		num1 <= 8;
		num2 <= 1;
		wait for 50 ns;

    -- testing 1111 + 011 + 1 = 1 0010
		num1 <= 15;
		num2 <= 3;
		wait for 50 ns;

	End process;

	A_int <= std_logic_vector(to_unsigned(num1, A_int'length));
	B_int <= std_logic_vector(to_unsigned(num2, A_int'length));

End architecture;
