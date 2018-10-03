Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
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
  with sel select
    data_out <= data_in_0 when "00",
	              data_in_1 when "01",
				        data_in_2 when "10",
				        (others=>'U') when others;
End Architecture;
