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
      y     : out std_logic_vector(4 downto 0);
      n_flag: out std_logic;
      z_flag: out std_logic;
      o_flag: out std_logic
      );
End Entity;

Architecture RTL of ALU is
  signal y_temp: std_logic_vector(4 downto 0);

  Begin

  Process(clk)
  Begin
    n_flag <= '0';
    z_flag <= '0';
    o_flag <= '0';

    if Op = "000" then
      y_temp <= add_overflow(a, b);
      y <= y_temp;
    end if;

    -- negative flag
    if (y'left = 0) then
      n_flag<= '1';
    end if;

    -- overflow flag NOT WORKING
    o_flag <= (not A(A'left) and not B(B'left) and y_temp(y_temp'left)) or ( A(A'left) and B(B'left) and y_temp(y_temp'left));

    End Process;
End Architecture;
