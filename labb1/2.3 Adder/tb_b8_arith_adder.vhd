Library IEEE;
Use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.to_unsigned;
Use WORK.ALL;

Entity tb_b8_arith_adder is
End Entity;

Architecture gooy_inside of tb_b8_arith_adder is
  Component b8_arith_adder is
    Port(
      a: unsigned(7 downto 0);
      b: unsigned(7 downto 0);
      sum: out unsigned(7 downto 0)
    );
  End Component;

  Signal A_int: unsigned(7 downto 0);
  Signal B_int: unsigned(7 downto 0);
  Signal Sum: unsigned(7 downto 0);

  Begin

    DUT: b8_arith_adder
      Port Map(
        a => A_int,
        b => B_int,
        Sum => sum
      );

  Process
    Begin
      A_int <= unsigned(to_unsigned(256, 8));
      B_int <= unsigned(to_unsigned(10, 8));
      wait for 10 ns;
  End Process;

End Architecture;
