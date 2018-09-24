Library IEEE;
<<<<<<< HEAD
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
=======
Use IEEE.std_logic;
Use IEEE.numeric_std;
>>>>>>> e85dea860244f0257a0a7bf72ed202a4c506bed9
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

  Signal out_data         :   data_bus;
  Signal test_data      :   data_bus;
<<<<<<< HEAD

Begin
  test_data <= ( test_data'length-1 downto 5 =>'0',
  4 downto 0 =>'1');

  RM : rw_memory port map(adr, data, clk, ce, rw);
  
  Process
  Begin

    -- write to mem when ce = '0' rw = '0'
    -- read from mem when ce = '0' rw = '0'
    ce <= '0';
    rw <= '0';
    wait for 2 ns;

    data <= test_data;

    wait for 2 ns;

    rw <= '1';
    out_data <= data;

    assert out_data = test_data
    report "Values does not match ce=0 rw=0"
    severity warning;

    -- "zero" memory
    data <= (others => 'U');
    wait for 2 ns;

    -- write to mem when ce = '0' rw = '1'
    -- read from mem when ce = '0' rw = '1'
    ce <= '0';
    rw <= '1';
    wait for 2 ns;

    data <= test_data;

    wait for 2 ns;

    rw <= '1';
    out_data <= data;

    assert out_data /= test_data
    report "Values does not match ce=0 rw=1"
    severity warning;

    -- "zero" memory
    data <= (others => 'U');
    wait for 2 ns;

    -- write to mem when ce = '1' rw = '0'
    -- read from mem when ce = '1' rw = '0'
    ce <= '1';
    rw <= '0';
    wait for 2 ns;

    data <= test_data;

    wait for 2 ns;

    rw <= '1';
    out_data <= data;

    assert out_data = (others => 'Z')
    report "Values does not match ce=1 rw=0"
    severity warning;

    -- "zero" memory
    data <= (others => 'U');
    wait for 2 ns;
    -- write to mem when ce = '1' rw = '1'
    -- read from mem when ce = '1' rw = '1'
    ce <= '1';
    rw <= '1';
    wait for 2 ns;

    data <= test_data;

    wait for 2 ns;

    rw <= '1';
    out_data <= data;

    assert out_data = (others => 'Z')
    report "Values does not match ce=1 rw=1"
    severity warning;
  End Process;
=======
  test_data <= ((test_data'length-1 downto 5)=>'0',
                (4 downto 0)=>'1');

Begin
  RM : rw_memory port map(adr, data, clk, ce, rw);

  -- write to mem when ce = '0' rw = '0'
  -- read from mem when ce = '0' rw = '0'
  ce <= '0';
  rw <= '0';
  wait 2 ns;

  data <= test_data

  wait 2 ns;

  rw <= '1';
  out_data <= data;

  assert out_data = test_data
  report "Values does not match ce=0 rw=0"
  severity warning;

  -- "zero" memory
  data <= ((data'length-1 downto 0)=>'U');
  wait 2 ns;

  -- write to mem when ce = '0' rw = '1'
  -- read from mem when ce = '0' rw = '1'
  ce <= '0';
  rw <= '1';
  wait 2 ns;

  data <= test_data

  wait 2 ns;

  rw <= '1';
  out_data <= data;

  assert out_data /= test_data
  report "Values does not match ce=0 rw=1"
  severity warning;

  -- "zero" memory
  data <= ((data'length-1 downto 0)=>'U');
  wait 2 ns;

  -- write to mem when ce = '1' rw = '0'
  -- read from mem when ce = '1' rw = '0'
  ce <= '1';
  rw <= '0';
  wait 2 ns;

  data <= test_data

  wait 2 ns;

  rw <= '1';
  out_data <= data;

  assert out_data = ((out_data'length-1 downto 0)=>'Z')
  report "Values does not match ce=1 rw=0"
  severity warning;

  -- "zero" memory
  data <= ((data'length-1 downto 0)=>'U');
  wait 2 ns;
  -- write to mem when ce = '1' rw = '1'
  -- read from mem when ce = '1' rw = '1'
  ce <= '1';
  rw <= '1';
  wait 2 ns;

  data <= test_data

  wait 2 ns;

  rw <= '1';
  out_data <= data;

  assert out_data = ((out_data'length-1 downto 0)=>'Z')
  report "Values does not match ce=1 rw=1"
  severity warning;
>>>>>>> e85dea860244f0257a0a7bf72ed202a4c506bed9
End Architecture;
