Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
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

  Process
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

    for i in 0 to 15 loop
	    en <= '1';
      d_in <= std_logic_vector(to_unsigned(i,4));

      wait for 2 ns;

      assert d_out = d_in
      report "d_out should be d_in but isn't"
      severity warning;

    end loop;

  End Process;
End Architecture;
