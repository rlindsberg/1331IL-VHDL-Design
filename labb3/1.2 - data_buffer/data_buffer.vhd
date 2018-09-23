Library IEEE;
Use IEEE.std_logic;
use work.cpu_package.all;

Entity data_buffer is
  Port(   out_en    :     std_logic;
          data_in   :     data_word;
          data_out  : out data_word);
End Entity;

architecture rtl of data_buffer is
begin
  process(out_en)
  begin
    if out_en = '1' then
      data_out <= data_in;
    else
      data_out <= ((data_out'length-1 downto 0) => 'Z');
    end if;
  end process;
end architecture;
