Library IEEE;
use ieee.std_logic_1164.all;
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
      n_flag: out std_logic := '0';
      z_flag: out std_logic := '0';
      o_flag: out std_logic := '0'
      );
End Entity;

Architecture RTL of ALU is
  Begin

  -- we need a process since functions from cpu_package can't be called outside one.
  Process(clk, En, Op, A, B)
  -- data_bus because it is only a midpoint between destinations
  Variable S  : data_bus;
  Variable al : std_logic;
  Variable bl : std_logic;
  Variable sl : std_logic;

  Begin
  -- time is needed for a value to propagate ergo we need to assign it after "begin".
  al := A(A'length-1);
  bl := B(B'length-1);

    -- with..select..others is a concurrent signal assignment statement used outside of a process. Thus, useing if.
    if (Rising_edge(clk) AND En='1') then
      -- reset flags
		  n_flag <= '0';
		  o_flag <= '0';
		  z_flag <= '0';

      -- decoding Op
		  S_CASE : case Op is
		    when "000" =>   S := add_overflow(a,b);
        when "001" =>   S := sub_overflow(a,b);
        when "010" =>   S := A and B;
        when "011" =>   S := A or B;
        when "100" =>   S := A xor B;
        when "101" =>   S := not A;
        when "110" =>   S := A;
        when others =>  S := S;
      end case;

      -- S gets its value in S_CASE and processes are sequential
      sl := S(S'length-1);

      -- using Op for deciding the way to calculate overflow flag.
      O_CASE : case Op is
        when "000" =>   o_flag <= (not al and not bl and sl) or (al and bl and not sl);
        when "001" =>   o_flag <= (not al and bl and sl) or (al and not bl and not sl);
        when others =>  o_flag <= '0';
      end case;

      -- setting y to S
      y <= S;

      -- negative flag
      n_flag <= sl;

      -- zero flag
      if unsigned(S) = 0 then z_flag <= '1';
      end if;

    end if;
  End Process;
End Architecture;
