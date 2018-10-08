Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_processor is
end Entity;

Architecture test of tb_processor is
  Component processor
    Port(   out_adr         : out   address_bus;
            in_data         :       instruction_bus;
            in_stop         :       std_logic;
            inout_RWM_data  : inout data_bus;
            out_rw_RWM      : out   std_logic;
            out_ROM_en      : out   std_logic;
            out_RWM_en      : out   std_logic;
            clk             :       std_logic;
            in_reset        :       std_logic);
  end Component;

  signal sig_adr            : address_bus;
  signal sig_data           : instruction_bus;
  signal sig_stop           : std_logic;
  signal sig_RWM_data       : data_bus;
  signal sig_rw_RWM         : std_logic;
  signal sig_ROM_en         : std_logic;
  signal sig_RWM_en         : std_logic;
  signal clock              : std_logic;
  signal sig_reset          : std_logic;

begin
  C : processor port map(
    out_adr         =>  sig_adr,
    in_data         =>  sig_data,
    in_stop         =>  sig_stop,
    inout_RWM_data  =>  sig_RWM_data,
    out_rw_RWM      =>  sig_rw_RWM,
    out_ROM_en      =>  sig_ROM_en,
    out_RWM_en      =>  sig_RWM_en,
    clk             =>  clock,
    in_reset        =>  sig_reset);
end Architecture;
