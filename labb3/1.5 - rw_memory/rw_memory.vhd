Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity rw_memory is
  Port (
    clk     :        std_logic;
    addr    :        address_bus;
    Z       : inout  std_logic_vector(3 downto 0);
    ce      : in     std_logic;
    rw      : in     std_logic;
    A       : in     std_logic_vector(3 downto 0)
    );
End Entity rw_memory;

Architecture behavourial of rw_memory is

  Type data_array is array (0 to 15) of data_bus;
  Signal mem: data_array;
  Signal Z_internal: std_logic_vector(3 downto 0);

Begin

  Z <= Z_internal when (ce = '0' and rw = '1') else (others=>'Z');

  -- Memory Write Block
  -- Write Operation : When ce active low, rw write on low
  MEM_WRITE: Process (clk) Begin
    if rising_edge(clk) and ce = '0' and rw = '0' then
      mem(to_integer(unsigned(addr))) <= A;
    end if;
  End Process;

  -- Memory Read Block
  -- Read Operation : When ce active low, rw read on high
  MEM_READ: Process (clk) Begin
    if (rising_edge(clk) AND ce = '0' and rw = '1') then
      Z_internal <= mem(to_integer(unsigned(addr)));
    end if;
  End Process;
End behavourial;
