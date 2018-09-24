Library IEEE;
Use IEEE.std_logic_1164.all;
use work.cpu_package.all;

Entity tb_data_buffer is
End Entity;

architecture rtl of tb_data_buffer is
  Component data_buffer Port(
    out_en    :     std_logic;
    data_in   :     data_word;
    data_out  : out data_word);
  End Component;

  Signal en             :     std_logic;
  Signal d_in, d_out    :     data_word;

Begin
  DB : data_buffer port map(en, d_in, d_out);

  Process(en)
    Variable z  :   data_word;

  Begin
    z := (others=>'Z');

    en <= '0';
    wait for 2 ns;

    assert d_out = z
    report "data_out should be Z but isn't"
    severity warning;

    d_in <= "1010";
    en <= '1';
    wait for 2 ns;

    assert d_out = "1010"
    report "data_out should be 1010 but isn't"
    severity warning;
  End Process;
End Architecture;
