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
  Signal mem: data_array;
  Signal data_out : data_bus;
Begin

-- Memory Write Block
-- Write Operation : When we = 1, cs = 1
  MEM_WRITE: process (adr, data, clk, ce, rw, mem) begin
    if rising_edge(clk) and ce = '0' then
      if rw = '0' then
        mem(to_integer(unsigned(adr))) <= data;
      end if;
    end if;
  end process;

 -- Tri-State Buffer control
  data <= data_out when (ce = '0' and rw = '1') else (others=>'Z');

 -- Memory Read Block
  MEM_READ: process (adr, ce, rw, data_out, mem) begin
    if (ce = '0' and rw = '1') then
      data_out <= mem(to_integer(unsigned(adr)));
    else
      data_out <= (others=>'0');
    end if;
  end process;
End Architecture;
