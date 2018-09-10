Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

Entity tb_ALU is
End Entity;

Architecture RTL of tb_ALU is
  Component ALU is
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
  End Component;

  Signal op_in                              : std_logic_vector(2 downto 0);
  Signal A_in, B_in                         : data_word;
  Signal A_int, B_int                       : integer;
  Signal En_in                              : std_logic;
  Signal clk_in                             : std_logic := '0';
  Signal y_out                              : std_logic_vector(4 downto 0);
  Signal n_flag_out,z_flag_out,o_flag_out   : std_logic;

  Begin

    C : ALU Port Map (
      Op      =>  op_in,
      A       =>  A_in,
      B       =>  B_in,
      En      =>  En_in,
      clk     =>  clk_in,
      y       =>  y_out,
      n_flag  =>  n_flag_out,
      z_flag  =>  z_flag_out,
      o_flag  =>  o_flag_out
    );

    A_in <= std_logic_vector(to_signed(A_int, A_in'length));
    B_in <= std_logic_vector(to_signed(B_int, B_in'length));

    Process(clk_in)
      Begin
    	  clk_in <= NOT clk_in After 2 ns;

    End Process;

    Process
      Begin
        op_in <= "000"; -- addition
        En_in <= '1';
        A_int <= 3;
        B_int <= 3;

        wait for 10 ns;

        A_int <= 8;
        B_int <= 8;
        wait for 10 ns;

        op_in <= "001"; -- subtraction
        A_int <= 4;
        B_int <= 3;
        wait for 10 ns;

        A_int <= 8;
        B_int <= -8;
        wait for 10 ns;
    End Process;

End Architecture;
