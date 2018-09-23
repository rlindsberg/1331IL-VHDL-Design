Library IEEE;
Use IEEE.std_logic;
Use IEEE.numeric_std;
use work.cpu_package.all;

Entity register is
  Port(   data_in     :     data_word;
          data_out    : out data_word;
          rw_reg      :     std_logic);
End Entity;

Architecture rtl of register_file is
  begin
    Variable data : data_word;

    process(clk, data, data_out, rw_reg)
      begin
        if rw_reg = '0' then -- write to data
          data <= data_in;
        elsif rw_reg = '1' then -- read from data
          data_out <= data;
        end if;
End Architecture;
