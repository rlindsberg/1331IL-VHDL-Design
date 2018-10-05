Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity rw_memory is
  Port (
    clk     :        std_logic;
    in_addr    :        address_bus;
    inout_Z    : inout  std_logic_vector(3 downto 0);
    in_ce      : in     std_logic;
    in_rw      : in     std_logic
    );
End Entity rw_memory;

Architecture behavourial of rw_memory is

  Type data_array is array (0 to 15) of data_bus;
  Signal sig_mem: data_array;
  Signal sig_Z: std_logic_vector(3 downto 0);

Begin

  inout_Z <= sig_Z when (in_ce = '0' and in_rw = '1') else (others=>'Z');

  -- Memory Write Block
  -- Write Operation : When ce active low, rw write on low
  MEM_WRITE: Process (clk) Begin
    if rising_edge(clk) and in_ce = '0' and in_rw = '0' then
      sig_mem(to_integer(unsigned(in_addr))) <= in_out_Z;
    end if;
  End Process;

  -- Memory Read Block
  -- Read Operation : When ce active low, rw read on high
  MEM_READ: Process (clk) Begin
    if (rising_edge(clk) AND in_ce = '0' and in_rw = '1') then
      sig_Z <= sig_mem(to_integer(unsigned(in_addr)));
    end if;
  End Process;
End behavourial;
