Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_enchip is
end Entity;

Architecture test of tb_enchip is
  Port( clk     :     std_logic;
        reset   :     std_logic;
        stop    :     std_logic;
        choice  :     std_logic;
        s       : out std_logic_vector(3 downto 0));

  signal clock      : std_logic;
  signal sig_reset  : std_logic;
  signal sig_stop   : std_logic;
  signal sig_choice : std_logic;
  signal sig_s      : std_logic_vector(3 downto 0);

begin
  E : enchip port map(
      clk     =>  clock,
      reset   =>  sig_reset,
      stop    =>  sig_stop,
      choice  =>  sig_choice,
      s       =>  sig_s);
end Architecture;
