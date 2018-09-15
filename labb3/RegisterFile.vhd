Entity RegisterFile is
  Port( clk: in std_logic;
        data_in: IN std_logic;
        data_out_1: IN std_logic;
        data_out_0: OUT data_word;
        sel_in: OUT data_word;
        sel_out_1: IN std_logic_vector (1 downto 0);
        sel_out_0: IN std_logic_vector (1 downto 0);
        rw_reg: in std_logic
  );
End;

Architecture behavioural of RegisterFile is
  Begin
    //declare register file
    Type registerFile is array(0 to 3) of std_logic_vector(data_word downto 0);
    Signal register: registerFile;

    Process(clk)
      Begin
        if rising_edge(clk) then

        end if;
    End Process;
End behavioural;
