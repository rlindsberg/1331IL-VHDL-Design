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
    End;

    -- negative flag
    if y'left = '0' then n_flag <= '1';

    -- zero flag
    -- if y is inactive at all bits
    if -y'active then z_flag <= '1';

    -- overflow flag
