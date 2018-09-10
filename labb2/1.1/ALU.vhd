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
  -- ariable declared outside subprogram or process must be a shared variable
  Shared Variable y_temp: std_logic_vector(4 downto 0);

  Begin

  Process(clk)
  Begin
    n_flag <= '0';
    z_flag <= '0';
    o_flag <= '0';

    -- with..select..others is a concurrent signal assignment statement used outside of a process. Thus, useing if.
    if (Rising_edge(clk) AND En='1') then
      -- reset flags
			o_flag <= '0';
			z_flag <= '0';

      -- decode op
			if (Op = "000") then
        -- save to y_temp for determining o_flag later
				y_temp := add_overflow(a, b);
				y <= y_temp;
			elsif  (Op = "001") then
				y_temp := sub_overflow(a, b);
        y <= y_temp;
			elsif (Op = "010") then
				y <= ('0' & A) AND B;
			elsif (Op = "011") then
				y <= ('0' & A) OR B;
			elsif (Op = "100") then
				y <= ('0' & A) XOR B;
			elsif (Op = "101") then
				y <= '0' & (NOT A);
			elsif (Op = "110") then
				y <= ('0' & A);
			end if;

    end if;

    if Op = "000" then
      y_temp := add_overflow(a, b);
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
