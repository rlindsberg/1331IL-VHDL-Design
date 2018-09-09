-- Package Declaration Section

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

End;
