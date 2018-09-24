Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_rw_memory is
End Entity;

Architecture test of tb_rw_memory is
  Component rw_memory
    Port (  adr   :       address_bus;
            data  : inout data_bus;
            clk   :       std_logic;
            ce    :       std_logic;        -- active low
            rw    :       std_logic);       -- read on high
  End Component;

  Signal adr            :   address_bus;
  Signal data           :   data_bus;
  Signal clk, ce, rw    :   std_logic;
  Signal data_out_from_mem : data_bus;

Begin
  RM : rw_memory port map(adr, data, clk, ce, rw);

  Simulation: Process
    Variable test_data  :  data_bus;
    Variable z_data     :  data_bus;
  Begin
    test_data := ( test_data'length-1 downto 2 =>'0', --0011
                   1 downto 0 =>'1');
    z_data := (others => 'Z');

-- test 1: ce 0, oe X, we 0
    -- write to mem when ce = '0' rw = '0'
    -- should write to mem.
    -- 11 ns
    ce <= '0';
    rw <= '0';
    adr <= "0000";
    data <= "0011"; wait for 1 ns;
    ce <= '1';
    wait for 10 ns;

-- test 2: ce 0, oe X, we 0
    -- 11 ns
    ce <= '0';
    rw <= '0';
    adr <= "0000";
    data <= "0100"; wait for 1 ns;
    ce <= '1';
    wait for 10 ns;

-- test 3: ce 1, oe X, we 0
    -- test writing to mem when ce is high, mem should not be overwritten
    ce <= '1';
    rw <= '0';
    adr <= "0000";
    data <= "0101"; wait for 1 ns;
    wait for 10 ns;

  End Process;
End Architecture;
