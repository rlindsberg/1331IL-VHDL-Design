Library IEEE;
Use IEEE.std_logic;
Use IEEE.numeric_std;
use work.cpu_package.all;

Entity tb_register_file is
End Entity;

Architecture rtl of tb_register_file is
  Component register_file Port(
    clk         :     std_logic;
    data_in     :     data_word;
    data_out_1  : out data_word;
    data_out_0  : out data_word;
    sel_in      :     std_logic_vector(1 downto 0);
    sel_out_1   :     std_logic_vector(1 downto 0);
    sel_out_0   :     std_logic_vector(1 downto 0);
    rw_reg      :     std_logic);
  End Component;

  Signal clk, rw                          : std_logic;
  Signal data_in, data_out_1, data_out_0  : data_word;
  Signal sel_in, sel_out_1, sel_out_0     : std_logic_vector(1 downto 0);

  Begin
    R : register_file port map (
      clk,
      data_in,
      data_out_1,
      data_out_0,
      sel_in,
      sel_out_1,
      sel_out_0,
      rw
    );

    Process(clk)
      Begin
        clk <= not clk after 2 ns;
    End Process;

    Process
      Begin
      for i in "00" to "11" loop
        for j in "0000" to "1111" loop
          rw <= '1';
          sel_in <= i;
          data_in <= j;
          wait 2 ns;

          rw <= '0';
          wait 1 ns;

          sel_out_0 <= i;
          assert data_out_0 = j
          report "Value 0 not matching"
          severity warning;

          sel_out_1 <= i;
          assert data_out_1 = j
          report "Value 1 not matching"
          severity warning;
        End loop;
      End loop;
    End Process;
End Architecture;
