Library IEEE;
Use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

Package cpu_package is
  Constant adress_size: integer := 4;
  Constant data_size: integer := 4;
  Constant operation_size: integer := 4;
  Constant instruction_size: integer := 10;

  Subtype data_word is std_logic_vector(3 downto 0);
  Subtype address_bus is std_logic_vector(3 downto 0);
  Subtype data_bus is std_logic_vector(3 downto 0);
  Subtype instruction_bus is std_logic_vector(9 downto 0);
  Subtype program_word is std_logic_vector(9 downto 0);
  Subtype command_word is std_logic_vector(3 downto 0);

  Function add_overflow(a, b: std_logic_vector) Return std_logic_vector;

End;

Package Body cpu_package is
  Function add_overflow(
    a, b: std_logic_vector
  )
  -- carry out is the most sig. bit
  Return std_logic_vector is
    Variable in_A: unsigned;
    Variable in_B: unsigned;
    Variable out_A: std_logic_vector;
    Variable sum : unsigned(in_A'length downto 0);

    Begin
      in_A := unsigned(a);
      in_B := unsigned(b);
      sum := ('0' & in_A) + in_B;
      out_A := std_logic_vector(unsigned(sum));
      Return out_A;
    End;

End Package Body;
