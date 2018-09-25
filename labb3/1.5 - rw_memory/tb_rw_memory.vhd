Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_rw_memory is End Entity;

architecture arch of tb_rw_memory is
  component rw_memory
  port (
    clk:       std_logic;
    addr:       address_bus;
    Z  : inout  std_logic_vector(3 downto 0);
    ce : in     std_logic;
    rw : in     std_logic;
    A  : in     std_logic_vector(3 downto 0)
  );
  end component rw_memory;

  Signal clk_in: std_logic;
  Signal addr_in: address_bus;
  signal Z_inout: std_logic_vector(3 downto 0);
  signal ce_in: std_logic;
  signal rw_in: std_logic;
  signal A_in: std_logic_vector(3 downto 0);

  begin
    rw_memory_ins: rw_memory port map(clk_in, addr_in, Z_inout, ce_in, rw_in, A_in);

    sim: process
    Begin
    addr_in <= "0000";
    A_in <= "1010";
    ce_in <= '0';
    rw_in <= '0';
    wait for 1 ns;
    ce_in <= '1';
    wait for 5 ns;


    addr_in <= "0001";
    A_in <= "1011";
    ce_in <= '0';
    rw_in <= '0';
    wait for 1 ns;
    ce_in <= '1';
    wait for 5 ns;

    addr_in <= "0000";
    ce_in <= '0';
    rw_in<= '1';
    wait for 1 ns;
    ce_in <= '1';
    wait for 5 ns;

  end process;
end architecture;
