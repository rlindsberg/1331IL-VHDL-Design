Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_rw_memory is End Entity;

Architecture arch of tb_rw_memory is
  Component rw_memory
  Port (
    clk     :        std_logic;
    addr    :        address_bus;
    Z       : inout  std_logic_vector(3 downto 0);
    ce      : in     std_logic;
    rw      : in     std_logic
  );
  End Component rw_memory;

  Signal clk_in   : std_logic;
  Signal addr_in  : address_bus;
  Signal Z_inout  : std_logic_vector(3 downto 0);
  Signal ce_in    : std_logic;
  Signal rw_in    : std_logic;

  Begin
    rw_memory_ins: rw_memory Port Map(clk_in, addr_in, Z_inout, ce_in, rw_in);

    sim: Process
    Begin

    -- test 1: write 1010 to mem(0000)
    -- bring ce to low for 1 ns
    -- bring rw to low for writing
    -- bring ce to high
    -- time: 6 ns
    addr_in <= "0000";
    ce_in <= '0';
    rw_in <= '0';
    Z_inout <= "1010";

    wait for 1 ns;
    Z_inout <= "ZZZZ";
    ce_in <= '1';
    wait for 5 ns;

    -- test 2: write 1011 to mem(0001)
    -- bring ce to low for 1 ns
    -- bring rw to low for writing
    -- bring ce to high
    -- time: 6 ns
    addr_in <= "0001";
    ce_in <= '0';
    rw_in <= '0';
    Z_inout <= "1011";

    wait for 1 ns;
    Z_inout <= "ZZZZ";
    ce_in <= '1';
    wait for 5 ns;

    -- test 3: read from mem(0000), expecting 1010
    -- bring ce to low for 1 ns
    -- keep rw at high for reading
    -- bring ce to high
    -- time: 6 ns
    addr_in <= "0000";
    ce_in <= '0';
    rw_in<= '1';
    wait for 1 ns;
    ce_in <= '1';
    wait for 5 ns;

  end Process;
end architecture;
