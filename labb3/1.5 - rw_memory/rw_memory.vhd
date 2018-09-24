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
  Signal internal_data : data_bus;
Begin
  
  Process(clk)
    Variable data_table : data_array;
  Begin
    if rising_edge(clk) and ce = '0' then
      if rw = '0' then
        data_table(to_integer(unsigned(adr))) := data;

      elsif rw = '1' then
        internal_data <= data_table(to_integer(unsigned(adr)));
		  
		end if;
    End if;
  End Process;
  data <= (others => 'Z') when ce = '1' else internal_data;
End Architecture;
