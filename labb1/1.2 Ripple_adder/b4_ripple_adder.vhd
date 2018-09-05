Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
Use WORK.ALL;

Entity b4_ripple_adder is
	Port(
		A: IN std_logic_vector(3 downto 0);
		B: IN	std_logic_vector(3 downto 0);
		Cin: IN	std_logic;
		Cout: OUT std_logic;
		Sum: OUT std_logic_vector(3 downto 0));
End;

Architecture structral_b4_ripple_adder of b4_ripple_adder is
  Component full_adder
    Port(
      A: IN std_logic;
      B: IN	std_logic;
      Cin: IN	std_logic;
      Carry: OUT std_logic;
      Sum: OUT std_logic);
  End Component;

Signal C:std_logic_vector(3 downto 1);

Begin
  FA0: full_adder Port Map(A(0), B(0), Cin, C(1), Sum(0));
  FA1: full_adder Port Map(A(1), B(1), C(1), C(2), Sum(1));
  FA2: full_adder Port Map(A(2), B(2), C(2), C(3), Sum(2));
  FA3: full_adder Port Map(A(3), B(3), C(3), Cout, Sum(3));

End Architecture;
