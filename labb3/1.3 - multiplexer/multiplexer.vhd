Library IEEE;
Use IEEE.std_logic;
Use IEEE.numeric_std;
use work.cpu_package.all;

Entity multiplexer is
  Port(   sel         :     std_logic_vector(1 downto 0);
          data_in_2   :     data_word;
          data_in_1   :     data_word;
          data_in_0   :     data_word;
          data_out    : out data_word);
End Entity;

Architecture rtl of multiplexer is
  Begin
    if sel = "00" then
      data_out <= data_in_0;

    elsif sel = "01" then
      data_out <= data_in_1;

    elsif sel = "10" then
      data_out <= data_in_2;

    End if;
End Architecture;
