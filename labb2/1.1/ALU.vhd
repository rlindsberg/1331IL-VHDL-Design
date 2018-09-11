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
  -- variable declared outside subprogram or process must be a shared variable
  Shared Variable S: std_logic_vector(data_size-1 downto 0);

  Begin

  Process(clk, En, Op, A, B)
  Begin
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

      -- setting o_flag
      O_CASE : case Op is
        when "000" =>   o_flag <= (not A(A'left) and not B(B'left) and S(S'left)) or
                             (A(A'left) and B(B'left) and not S(S'left));

        when "001" =>   o_flag <= (not A(A'left) and B(B'left) and S(S'left)) or
                             (A(A'left) and not B(B'left) and not S(S'left));

        when others =>  o_flag <= '0';
      end case;

      -- setting y to S
      y <= S;

      -- negative flag
      n_flag <= S(S'left);

      -- zero flag
      if unsigned(S) = 0 then z_flag <= '1';
      end if;
    end if;
  End Process;
End Architecture;
