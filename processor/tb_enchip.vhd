Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_enchip is
end Entity;

Architecture test of tb_enchip is
  Component enchip
    Port( clk        :     std_logic;
          in_reset   :     std_logic;
          in_stop    :     std_logic;
          in_choice  :     std_logic;
          out_s      : out std_logic_vector(3 downto 0));
  end Component;

    signal clock      : std_logic;
    signal sig_reset  : std_logic := '0';
    signal sig_stop   : std_logic := '0';
    signal sig_choice : std_logic := '0';
    signal sig_s      : std_logic_vector(3 downto 0);

  begin
    E : enchip port map(
        clk        =>  clock,
        in_reset   =>  sig_reset,
        in_stop    =>  sig_stop,
        in_choice  =>  sig_choice,
        out_s      =>  sig_s);

    tb: Process(clock)
    Begin
      sig_choice  <=  not sig_choice after 2500 ps;
    end Process;
end Architecture;
