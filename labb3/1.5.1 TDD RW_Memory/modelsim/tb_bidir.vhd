library ieee;
use ieee.std_logic_1164.all;

Entity tb_bidir is End Entity;

architecture arch of tb_bidir is
  component bidir
  port (
    Z  : inout std_logic_vector(3 downto 0);
    Y  : out std_logic_vector(3 downto 0);
    OE : in  std_logic;
    WE : in    std_logic;
    A  : in  std_logic_vector(3 downto 0)
  );
  end component bidir;


  signal Z_inout: std_logic_vector(3 downto 0);
  signal Y_out: std_logic_vector(3 downto 0);
  signal OE_in: std_logic;
  signal WE_in: std_logic;
  signal A_in: std_logic_vector(3 downto 0);

  begin
    bidir_ins: bidir port map(Z_inout, Y_out, OE_in, WE_in, A_in);

    sim: process
    Begin
    A_in <= "1010";
    OE_in <= '0';
    WE_in <= '1';
    wait for 5 ns;

    OE_in<= '1';
    wait for 5 ns;

  end process;
end architecture;
