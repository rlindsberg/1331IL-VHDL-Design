Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity rom is
  Port( in_adr    :     address_bus;
        out_data  : out instruction_bus;
        in_ce      :     std_logic);         --active low
End Entity;

Architecture rtl of rom is
  constant const_rom_length:integer:=15;
  type rom_table is array (0 to const_rom_length-1) of instruction_bus;
  constant const_rom_data	:	rom_table := (
      B"1010_11_0011",  -- LDI r3 3
      B"1001_11_1110",  -- STR r3 14
      B"1010_01_0001",  -- LDI r1 1
      B"1010_00_1110",  -- LDR r0 14
      B"0110_00_0010",  -- MOV r0 r2
      B"0000_10_0110",  -- ADD r2 r1 r2
      B"0001_00_0100",  -- SUB r0 r1 r0
      B"1100_00_1100",  -- BRZ 12
      B"1011_00_0000",  -- NOP
      B"1111_00_0101",  -- BRA 5
      B"1011_00_0000",  -- NOP
      B"1011_00_0000",  -- NOP
      B"1001_10_1111",  -- STR r2 15
      B"1111_00_1101",  -- BRA 13
      B"1011_00_0000"); -- NOP

Begin
  Process(in_ce, in_adr)
  Begin
    if in_ce = '0' then
      out_data <= const_rom_data(to_integer(unsigned(in_adr)));    --data from rom memory
    else
      out_data <= (others => 'Z');
    end if;
  End Process;
End Architecture;
