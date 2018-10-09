Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity enchip is
  Port( clk        :     std_logic;
        in_reset   :     std_logic;
        in_stop    :     std_logic;
        in_choice  :     std_logic;
        out_s      : out std_logic_vector(3 downto 0));
End Entity;

Architecture structure of enchip is
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

  Component rom
    Port(   in_adr          :       address_bus;
            out_data        : out   instruction_bus;
            in_ce           :       std_logic);         --active low
  end Component;

  Component rw_memory
    Port (  clk             :       std_logic;
            in_adr          :       address_bus;
            inout_Z         : inout std_logic_vector(3 downto 0);
            in_ce           : in    std_logic;
            in_rw           : in    std_logic);
  end Component;

  -- signals
  signal  sig_adr, sig_adr_rom, sig_adr_rwm   : address_bus;
  signal  sig_ROM_data                        : instruction_bus;
  signal  sig_RWM_data                        : data_bus;
  signal  sig_RWM_en, sig_ROM_en, sig_rw_RWM  : std_logic;

Begin
  sig_adr_rom <= sig_adr;
  sig_adr_rwm <= sig_adr;

  PR : processor port map (
    out_adr         => sig_adr,
    in_data         => sig_ROM_data,
    in_stop         => in_stop,
    inout_RWM_data  => sig_RWM_data,
    out_rw_RWM      => sig_rw_RWM,
    out_ROM_en      => sig_ROM_en,
    out_RWM_en      => sig_RWM_en,
    clk             => clk,
    in_reset        => in_reset
  );

  RO : rom port map (
    in_adr          => sig_adr_rom,
    out_data        => sig_ROM_data,
    in_ce           => sig_ROM_en
  );

  RW : rw_memory port map (
    clk             => clk,
    in_adr          => sig_adr_rwm,
    inout_Z         => sig_RWM_data,
    in_ce           => sig_RWM_en,
    in_rw           => sig_rw_RWM
  );

  out_s <= sig_adr when in_choice = '0' else
           sig_RWM_data when in_choice = '1' else
           (others => 'X');

  -- Process(clk, in_choice, sig_adr, sig_RWM_data)
  -- begin
  --   if rising_edge(clk) and in_choice = '0' then
  --     out_s <= sig_adr;
  --
  --   elsif rising_edge(clk) and in_choice = '1' then
  --     out_s <= sig_RWM_data;
  --
  --   end if;
  -- end Process;
End Architecture;
