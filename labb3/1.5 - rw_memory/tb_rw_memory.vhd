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
    Variable test_data_0, test_data_1, test_data_2, test_data_3  :  data_bus;
    Variable z_data     :  data_bus;
  Begin
    test_data_0 := ( test_data_0'length-1 downto 2 =>'0', 1 downto 0 =>'1'); --0011
    test_data_1 := ( test_data_1'length-1 downto 2 =>'0', 1 => '1', 0 => '0'); --0010
	  test_data_2 := ( test_data_2'length-1 downto 2 =>'0', 1 => '0', 0 => '1'); --0001
    test_data_3 := ( test_data_3'length-1 downto 2 =>'0', 1 => '0', 0 => '0'); --0000
    z_data := (others => 'Z');

    -- write to mem when ce = '0' rw = '0'
    -- read from mem when ce = '0' rw = '0'
    -- should write to mem.
    ce <= '0';
    rw <= '0';
    wait for 1 ns;

    adr <= "0000";
    data <= test_data_0;

    wait for 1 ns;

    rw <= '1';

    wait for 4 ns;

    assert data = test_data_0
    report "Values does not match ce=0 rw=0"
    severity warning;

    wait for 1 ns;

    -- write to mem when ce = '0' rw = '1'
    -- read from mem when ce = '0' rw = '1'
    -- should read from mem.
    ce <= '0';
    rw <= '1';
    wait for 1 ns;

    adr <= "0001";
    data <= test_data_1;

    wait for 1 ns;

    rw <= '1';

    assert data /= test_data_1
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
    data <= test_data_2;

    wait for 1 ns;

    rw <= '1';

    assert data = z_data
    report "Values does not match ce=1 rw=0"
    severity warning;

    wait for 1 ns;

    -- write to mem when ce = '1' rw = '1'
    -- read from mem when ce = '1' rw = '1'
    -- Should become ZZZZ...
    ce <= '1';
    rw <= '1';
    wait for 1 ns;

    adr <= "0011";
    data <= test_data_3;

    wait for 1 ns;

    rw <= '1';

    assert data = z_data
    report "Values does not match ce=1 rw=1"
    severity warning;

    wait for 1 ns;

  End Process;
End Architecture;
