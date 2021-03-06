Library IEEE;
Use IEEE.std_logic_1164.all;
use work.cpu_package.all;

Entity data_buffer is
  Port(   in_out_en    :     std_logic;
          in_data_in   :     data_word;
          out_data_out  : out data_word);
End Entity;

architecture rtl of data_buffer is
begin
  process(in_out_en, in_data_in)
  begin
    if in_out_en = '1' then
      out_data_out <= in_data_in;
    else
      out_data_out <= (others => 'Z');
    end if;
  end process;
end architecture;
