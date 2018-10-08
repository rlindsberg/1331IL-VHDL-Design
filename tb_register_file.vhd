Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
use work.cpu_package.all;

Entity tb_register_file is
End Entity;

Architecture rtl of tb_register_file is
  Component register_file is Port(
    clk             : in std_logic;
    in_data_in      : in data_word;
    out_data_out_1  : out data_word;
    out_data_out_0  : out data_word;
    in_sel_in       : in std_logic_vector (1 downto 0);
    in_sel_out_1    : in std_logic_vector (1 downto 0);
    in_sel_out_0    : in std_logic_vector (1 downto 0);
    in_rw_reg       : in std_logic);
  End Component;

  Signal clk, rw                          : std_logic := '0';
  Signal data_in, data_out_1, data_out_0  : data_word;
  Signal sel_in, sel_out_1, sel_out_0     : std_logic_vector(1 downto 0);

  Begin
    RegisterFile_inst : register_file port map (
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
        clk <= not clk after 2500 ps;
    End Process;

    Process
      Begin
      for i in 0 to 3 loop
        for j in 0 to 15 loop
          rw <= '1';
          sel_in <= std_logic_vector(to_unsigned(i, 2));
          data_in <= std_logic_vector(to_unsigned(j, 4));
          wait for 15 ns;

          rw <= '0';
          wait for 15 ns;

          sel_out_0 <= std_logic_vector(to_unsigned(i, 2));
          sel_out_1 <= std_logic_vector(to_unsigned(i, 2));

        End loop;
      End loop;
    End Process;
End Architecture;
