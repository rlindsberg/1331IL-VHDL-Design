Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
Use work.cpu_package.ALL;

Entity tb_Counter is End Entity;

Architecture RTL of tb_Counter is
  Component Counter
    Port(
      in_clk      : in  std_logic;
      in_step     : in  std_logic;
      in_reset    : in  std_logic;
      out_clk     : out std_logic;
      out_counter : out std_logic_vector(data_size-1 downto 0)
    );
  End Component Counter;

  Signal clk_in       : std_logic := '0';
  Signal step_in      : std_logic := '0';
  Signal reset_in     : std_logic := '0';
  Signal clk_out      : std_logic;
  Signal counter_out  : std_logic_vector(data_size-1 downto 0);

  Begin
  Counter_ins : Counter Port Map (
    in_clk      => clk_in,
    in_step     => step_in,
    in_reset    => reset_in,
    out_clk     => clk_out,
    out_counter => counter_out
  );

  -- clk_in should in practice be mapped to FPGA's clk
  clk_in <= not clk_in after 1 ns;
  step_in <= not step_in after 5 ns;
  reset_in <= '0' after 100 ns;
End Architecture;
