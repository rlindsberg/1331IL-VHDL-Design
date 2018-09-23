Library IEEE;
Use IEEE.std_logic;
use work.cpu_package.all;

Entity tb_multiplexer is
End Entity;

Architecture rtl of tb_multiplexer is
  Component multiplexer
    Port(   sel         :     std_logic_vector(1 downto 0);
            data_in_2   :     data_word;
            data_in_1   :     data_word;
            data_in_0   :     data_word;
            data_out    : out data_word);
  End Component;

  Signal sel                            :   std_logic_vector(1 downto 0);
  Signal d_in_2, d_in_1, d_in_0, d_out  :   data_word;

  Begin
    M : multiplexer port map (
      sel,
      d_in_2,
      d_in_1,
      d_in_0,
      d_out
    );

    Process
      Begin
        data_in_0 <= "0001";
        data_in_1 <= "0010";
        data_in_2 <= "0100";

        wait 2 ns;

        sel <= "00";

        wait 2 ns;

        assert data_out = "0001"
        report "Value should be 0001 but isn't"
        severity warning;

        sel <= "01";

        wait 2 ns;

        assert data_out = "0010"
        report "Value should be 0001 but isn't"
        severity warning;

        sel <= "10";

        wait 2 ns;

        assert data_out = "0100"
        report "Value should be 0001 but isn't"
        severity warning;
End Architecture;
