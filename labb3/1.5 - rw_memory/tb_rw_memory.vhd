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

Begin
  RM : rw_memory port map(adr, data, clk, ce, rw);

  Process
    Variable test_data  :  data_bus;
    Variable z_data     :  data_bus;
  Begin
    test_data := ( test_data'length-1 downto 2 =>'0', --0011
                   1 downto 0 =>'1');
    z_data := (others => 'Z');

    -- write to mem when ce = '0' rw = '0'
    -- read from mem when ce = '0' rw = '0'
    -- should write to mem.
    ce <= '0';
    rw <= '0';
    wait for 2 ns;

    adr <= "0000";
    data <= test_data;

    wait for 2 ns;

    rw <= '1';

    assert data = test_data
    report "Values does not match ce=0 rw=0"
    severity warning;

    rw <= '0';
    wait for 1 ns;

    -- write to mem when ce = '0' rw = '1'
    -- read from mem when ce = '0' rw = '1'
    -- should read from mem.
    ce <= '0';
    rw <= '1';
    wait for 2 ns;

    adr <= "0001";
    data <= test_data;

    wait for 2 ns;

    rw <= '1';

    assert data /= test_data
    report "Values does not match ce=0 rw=1"
    severity warning;

    wait for 1 ns;

    -- write to mem when ce = '1' rw = '0'
    -- read from mem when ce = '1' rw = '0'
    -- should become ZZZZ...
    ce <= '1';
    rw <= '0';
    wait for 2 ns;

    adr <= "0010";
    data <= test_data;

    wait for 2 ns;

    rw <= '1';
    data <= data;

    assert data = z_data
    report "Values does not match ce=1 rw=0"
    severity warning;

    wait for 1 ns;

    -- write to mem when ce = '1' rw = '1'
    -- read from mem when ce = '1' rw = '1'
    -- Should become ZZZZ...
    ce <= '1';
    rw <= '1';
    wait for 2 ns;

    adr <= "0011";
    data <= test_data;

    wait for 2 ns;

    rw <= '1';

    assert data = z_data
    report "Values does not match ce=1 rw=1"
    severity warning;

    wait for 1 ns;

  End Process;
End Architecture;
