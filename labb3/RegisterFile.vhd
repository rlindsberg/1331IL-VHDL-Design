Entity RegisterFile is
    Port(   clk: in std_logic;
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

End behavioural;
