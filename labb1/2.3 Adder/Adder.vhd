Library IEEE;
Use IEEE.STD_LOGIC_ARITH.ALL;
Use WORK.ALL;

entity Adder is
  port(
    a : unsigned(7 downto 0);
    b : unsigned(7 downto 0);
    sum: out unsigned(7 downto 0)
  );
End;

Architecture behavioural of Adder is
  Begin

    sum <= a + b After 5 ns;

End behavioural;
