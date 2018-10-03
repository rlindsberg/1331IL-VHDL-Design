library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.to_unsigned;
use work.all;

Entity tb_adder is
End Entity;

Architecture gooy_inside of tb_adder is
  Component adder is
    Port(
      a   : std_logic_vector(7 downto 0);
		b   : std_logic_vector(7 downto 0);
		sum : out std_logic_vector(7 downto 0)
    );
  End Component;

  Signal A_int: std_logic_vector(7 downto 0);
  Signal B_int: std_logic_vector(7 downto 0);
  Signal Sum: std_logic_vector(7 downto 0);

  Begin

    DUT: adder
      Port Map(
        a => A_int,
        b => B_int,
        Sum => sum
      );

  Process
    Begin
      A_int <= std_logic_vector(to_unsigned(120, 8));
      B_int <= std_logic_vector(to_unsigned(10, 8));
      wait for 10 ns;
  End Process;

End Architecture;
