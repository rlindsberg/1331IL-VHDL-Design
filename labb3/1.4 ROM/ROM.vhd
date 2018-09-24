Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity rom is
  Port( adr   :     address_bus;
        data  : out instruction_bus;
        ce    :     std_logic);         --active low
End Entity;

Architecture rtl of rom is
  constant rom_length:integer:=15;
  type rom_table is array (0 to rom_length-1) of instruction_bus;
  constant rom_data	:	rom_table := (B"1010_11_0011", B"1001_11_1110", B"1010_01_0001",
                                    B"1010_00_1110", B"0110_00_0010", B"0000_10_0110",
                                    B"0001_00_0100", B"1100_00_1100", B"1011_00_0000",
                                    B"1111_00_0101", B"1011_00_0000", B"1011_00_0000",
                                    B"1001_10_1111", B"1111_00_1101", B"1011_00_0000");

Begin
  Process(ce, adr)
  Begin
    if ce = '0' then
      data<=rom_data(to_integer(unsigned(adr)));    --data from rom memory
    else
      data<=(others => 'Z');
    end if;
  End Process;
End Architecture;
