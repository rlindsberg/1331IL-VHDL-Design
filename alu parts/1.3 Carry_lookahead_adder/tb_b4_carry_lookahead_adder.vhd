Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
Use WORK.ALL;

Entity tb_b4_carry_lookahead_adder is
End tb_b4_carry_lookahead_adder;

Architecture behavioural of tb_b4_carry_lookahead_adder is

Component b4_carry_lookahead_adder is
  Port (
    A: std_logic_vector(3 downto 0);
    B: std_logic_vector(3 downto 0);
    s: OUT std_logic_vector(3 downto 0));
End Component;

--inputs
Signal num1: integer;
Signal num2: integer;
Signal A_int: std_logic_vector (3 downto 0);
Signal B_int : std_logic_vector (3 downto 0);
--Signal Cin : std_logic;

--outputs
Signal Sum : std_logic_vector (3 downto 0);
--Signal Overflow : std_logic;

Begin

  DUT: b4_carry_lookahead_adder Port Map(
		A => A_int,
		B => B_int,
--		Cin => Cin,
--		Cout => Overflow,
		s => Sum
	);

	process
	Begin
    -- testing 1000 + 0001 = 1001
		num1 <= 8;
		num2 <= 1;
--		Cin <= '0';
		wait for 50 ns;

    -- testing 1111 + 011 + 1 = 1 0011
		num1 <= 15;
		num2 <= 3;
--		Cin <= '1';
		wait for 50 ns;

	End process;

	A_int <= std_logic_vector(to_unsigned(num1, A_int'length));
	B_int <= std_logic_vector(to_unsigned(num2, A_int'length));

End architecture;
