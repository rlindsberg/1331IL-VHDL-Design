Library ieee;
Use ieee.std_logic.allL;

package rom_package is
  constant rom_width:integer:=10;
  constant rom_length:integer:=15;
  subtype rom_word is std_logic_vector(rom_width-1 downto 0);
  type rom_table is array (0 to rom_length-1) of rom_word;
  constant rom:rom_table:=rom_table'("1010_11_0011", "1001_11_1110", "1010_01_0001",
                                     "1010_00_1110", "0110_00_0010", "0000_10_0110",
                                     "0001_00_0100", "1100_00_1100", "1011_00_0000",
                                     "1111_00_0101", "1011_00_0000", "1011_00_0000",
                                     "1001_10_1111", "1111_00_1101", "1011_00_0000");
end package;
