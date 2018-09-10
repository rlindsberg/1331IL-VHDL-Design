Library IEEE;
use ieee.std_logic_1164.all;
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
End ALU;

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
    --if y'left = '0' then n_flag <= '1';
	 n_flag<= '1' when y'left='0' else '0';

    -- zero flag
    -- if y is inactive at all bits
    --if -y'active then z_flag <= '1';
	 n_flag<= '1' when -y'active else '0';

    -- overflow flag
    o_flag <= (not a'left and not b'left and y'left) or (a'left and b'left and not y'left);
End Architecture;
