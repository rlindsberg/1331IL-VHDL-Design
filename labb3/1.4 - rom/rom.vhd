Library IEEE;
Use IEEE.std_logic_1164;
Use IEEE.numeric_std;
Use work.cpu_package.all;
Use work.rom_package.all;

Entity rom is
  Port( adr   :     address_bus;
        data  : out instruction_bus;
        ce    :     std_logic);         --active low
End Entity;

Architecture rtl of rom is
  Signal high_ohm : std_logic_vector := ((data'length-1 downto 0)=>'Z');
Begin
  if ce'low then
    q<=rom_package(to_integer(adr));    --data from rom memory
  else
    q<=high_ohm;
  end if;
End Architecture;
