Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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

  Function add_overflow(a, b: std_logic_vector) Return data_word;
  Function sub_overflow(a, b: std_logic_vector) Return data_word;

End;

Package Body cpu_package is
  Function add_overflow(
    a, b: data_word
  )
  -- carry out is the most sig. bit
  Return data_word is
    Begin
      Return data_word(unsigned(a) + unsigned(b));
    End;
    -- end function add_overflow

    Function sub_overflow(
      a, b: data_word
    )
    -- carry out is the most sig. bit
    Return data_word is
      Begin
        Return data_word(unsigned(a)-unsigned(b));
      End;
End Package Body;
