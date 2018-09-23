Library IEEE;
Use IEEE.std_logic;
Use IEEE.numeric_std;
Use work.cpu_package.all;
Use work.rom_package.all;

Entity tb_rom is
End Entity;

Architecture rtl of tb_rom is
  Component rom
    Port( adr   :     address_bus;
          data  : out instruction_bus;
          ce    :     std_logic);         --active low
  End Component;

  type data_array is array (0 to 14) of std_logic_vector(9 downto 0);
  Signal addr : address_bus;
  Signal data : instruction_bus;
  Signal en   : std_logic;

Begin

  R : rom port map(addr, data, en);

  Process
    Variable data_list   :   data_array;
    data_list := ("1010_11_0011", "1001_11_1110", "1010_01_0001", "1010_00_1110", "0110_00_0010",
                  "0000_10_0110", "0001_00_0100", "1100_00_1100", "1011_00_0000", "1111_00_0101",
                  "1011_00_0000", "1011_00_0000", "1001_10_1111", "1111_00_1101", "1011_00_0000");
  Begin
    en <= "0";
    for i in "0000" to "1111" loop
      addr <= i;

      wait 2 ns;

      assert data = data_list(to_integer(i));
      report "Values not matching"
      severity warning;

    end loop;
  end process;
End Architecture;
