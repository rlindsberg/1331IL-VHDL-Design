Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

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
  Begin
    data_list := (B"1010_11_0011", B"1001_11_1110", B"1010_01_0001", B"1010_00_1110", B"0110_00_0010",
                  B"0000_10_0110", B"0001_00_0100", B"1100_00_1100", B"1011_00_0000", B"1111_00_0101",
                  B"1011_00_0000", B"1011_00_0000", B"1001_10_1111", B"1111_00_1101", B"1011_00_0000");

    en <= '0';
    for i in 0 to 15 loop
	   en <= '0';
      addr <= std_logic_vector(to_unsigned(i,4));

      wait for 2 ns;

      assert data = data_list(i);
      report "Values not matching"
      severity warning;

    end loop;
  end process;
End Architecture;
