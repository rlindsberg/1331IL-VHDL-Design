Library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

Entity ALU is
  Port (  in_Op      : in std_logic_vector(2 downto 0);
          in_A       : in data_word;
          in_B       : in data_word;
          in_En      : in std_logic;
          clk        : in std_logic;
          out_y      : out data_word;
          out_n_flag : out std_logic := '0';
          out_z_flag : out std_logic := '0';
          out_o_flag : out std_logic := '0'
      );
End Entity;

Architecture RTL of ALU is
  Begin

  -- we need a process since functions from cpu_package can't be called outside one.
  Process(clk, in_En, in_Op, in_A, in_B)
  -- data_bus because it is only a midpoint between destinations
  Variable S  : data_bus;
  Variable al : std_logic;
  Variable bl : std_logic;
  Variable sl : std_logic;

  Begin
  -- time is needed for a value to propagate ergo we need to assign it after "begin".
  al := in_A(in_A'length-1);
  bl := in_B(in_B'length-1);

    -- with..select..others is a concurrent signal assignment statement used outside of a process. Thus, useing if.
    if (Rising_edge(clk) AND in_En='1') then
      -- reset flags
		  out_n_flag <= '0';
		  out_o_flag <= '0';
		  out_z_flag <= '0';

      -- decoding Op
		  S_CASE : case in_Op is
		    when "000" =>   S := add_overflow(in_A, in_B);
        when "001" =>   S := sub_overflow(in_A, in_B);
        when "010" =>   S := in_A and in_B;
        when "011" =>   S := in_A or in_B;
        when "100" =>   S := in_A xor in_B;
        when "101" =>   S := not in_A;
        when "110" =>   S := in_A;
        when others =>  S := S;
      end case;

      -- S gets its value in S_CASE and processes are sequential
      sl := S(S'length-1);

      -- using Op for deciding the way to calculate overflow flag.
      O_CASE : case in_Op is
        when "000" =>   out_o_flag <= (not al and not bl and sl) or (al and bl and not sl);
        when "001" =>   out_o_flag <= (not al and bl and sl) or (al and not bl and not sl);
        when others =>  out_o_flag <= '0';
      end case;

      -- setting y to S
      out_y <= S;

      -- negative flag
      out_n_flag <= sl;

      -- zero flag
      if unsigned(S) = 0 then out_z_flag <= '1';
      end if;

    end if;
  End Process;
End Architecture;
