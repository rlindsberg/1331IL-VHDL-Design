Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_rw_memory_simple is
End Entity;

Architecture test of tb_rw_memory_simple is
  Component rw_memory
    Port (  adr   :       address_bus;
            data  : inout data_bus;
            clk   :       std_logic;
            ce    :       std_logic;        -- active low
            rw    :       std_logic);       -- read on high
  End Component;

  Signal adress                       :   address_bus;
  Signal data_inout                   :   data_bus;
  Signal clock, disable, read_write   :   std_logic;
  Signal out_0, out_1                 :   data_bus;

Begin
  RM : rw_memory port map(adr => adress,
                          data => data_inout,
                          clk => clock,
                          ce => disable,
                          rw => read_write);

  Process
  Begin
    disable <= '0';
    read_write <= '0';
    wait for 1 ns;

-- write values to mem
    adress <= "0000";
    data_inout <= "1000";
    wait for 4 ns;

    adress <= "0001";
    data_inout <= "0100";
    wait for 4 ns;

-- read values from mem
    read_write <= '1';
    adress <= "0000";
    out_0 <= data_inout;
    wait for 4 ns;

    adress <= "0001";
    out_1 <= data_inout;

    wait for 4 ns;

-- assert correctness
    assert data_inout = "1000"
    report "adress 0000 != 1000"
    severity warning;

    assert data_inout = "0100"
    report "adress 0001 != 0100"
    severity warning;

  End Process;
End Architecture;
