Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
use work.cpu_package.all;

Entity multiplexer is
  Port(   in_sel         :     std_logic_vector(1 downto 0);
          in_data_in_2   :     data_word;
          in_data_in_1   :     data_word;
          in_data_in_0   :     data_word;
          out_data_out    : out data_word);
End Entity;

Architecture rtl of multiplexer is
Begin
  with sel select
    data_out <= data_in_0 when "00",
	              data_in_1 when "01",
				        data_in_2 when "10",
				        (others=>'U') when others;
End Architecture;
