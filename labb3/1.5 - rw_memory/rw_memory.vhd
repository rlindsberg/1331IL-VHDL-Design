Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity rw_memory is
  Port (  adr   :       address_bus;
          data  : inout data_bus;
          clk   :       std_logic;
          ce    :       std_logic;        -- active low
          rw    :       std_logic);       -- read on high
End Entity;

Architecture behaviour of rw_memory is
  Type data_array is array (0 to 15) of data_bus;
  Signal data_out       :   data_bus;
  Signal data_table     :   data_array;
Begin

  data <= data_out when ce = '0' else (others => 'Z');

  READ : Process(clk, rw, ce, adr, data)
  Begin
    if (clk'event and clk = '1') and rw = '1' then
      data_out <= data_table(to_integer(unsigned(adr)));
    else
      data_out <= (others => 'Z');
    end if;
  End Process;

  WRITE : Process(clk, rw, ce, adr, data)
  Begin
    if (clk'event and clk = '1') and rw = '0' then
      data_table(to_integer(unsigned(adr))) <= data;
    end if;
  End Process;
End Architecture;
