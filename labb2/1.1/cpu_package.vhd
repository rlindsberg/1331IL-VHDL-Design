Library IEEE;
Use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_unsigned.all;

Package cpu_package is
  Constant adress_size: integer := 4;
  Constant data_size: integer := 4;
  Constant operation_size: integer := 4;
  Constant instruction_size: integer := 10;

  Subtype data_word is std_logic_vector(data_size-1 downto 0);
  Subtype address_bus is std_logic_vector(adress_size-1 downto 0);
  Subtype data_bus is std_logic_vector(data_size-1 downto 0);
  Subtype instruction_bus is std_logic_vector(instruction_size-1 downto 0);
  Subtype program_word is std_logic_vector(instruction_size-1 downto 0);
  Subtype command_word is std_logic_vector(operation_size-1 downto 0);

  Function add_overflow(a, b: std_logic_vector) Return std_logic_vector;
  Function sub_overflow(a, b: std_logic_vector) Return std_logic_vector;

End;

Package Body cpu_package is
  Function add_overflow(
    a, b: data_word
  )
  -- carry out is the most sig. bit
  Return std_logic_vector is
    Variable in_A: signed(data_size-1 downto 0);
    Variable in_B: signed(data_size-1 downto 0);
    Variable out_A: std_logic_vector(data_size downto 0);
    Variable sum : signed(in_A'length downto 0);

    Begin
      in_A := signed(a);
      in_B := signed(b);
      sum := ('0' & in_A) + in_B;
      out_A := std_logic_vector(sum);
      Return out_A;
    End;
    -- end function add_overflow

    Function sub_overflow(
      a, b: data_word
    )
    -- carry out is the most sig. bit
    Return std_logic_vector is
      Variable in_A: signed(data_size-1 downto 0);
      Variable in_B: signed(data_size-1 downto 0);
      Variable out_A: std_logic_vector(data_size downto 0);
      Variable diff : signed(in_A'length downto 0);

      Begin
        in_A := signed(a);
        in_B := signed(b);
        diff := ('0' & in_A) - in_B;
        out_A := std_logic_vector(unsigned(diff));
        Return out_A;
      End;
End Package Body;
