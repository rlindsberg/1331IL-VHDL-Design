Library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

Entity ALU is
   Port (
      Op    : in std_logic_vector(2 downto 0);
      A     : in data_word;
      B     : in data_word;
      En    : in std_logic;
      clk   : in std_logic;
      y     : out data_word;
      n_flag: out std_logic;
      z_flag: out std_logic;
      o_flag: out std_logic
      );
End Entity;

Architecture RTL of ALU is
  Begin

    With Op Select
      y <=  add_overflow(a, b) when "000",
            sub_overflow(a, b) when "001",
            a AND b when "010",
            a OR b when "011",
            a XOR b when "100",
            NOT a when "101",
            a when "110";

    -- negative flag
	 n_flag<= '1' when y'left=0 else '0';

    -- zero flag
	 n_flag<= '1' when not y'active else '0';

    -- overflow flag NOT WORKING
    o_flag <= (not A'left and not B'left and y'left) or (A'left and B'left and y'left);
End Architecture;
