Entity RegisterFile is
  Port( clk: in std_logic;
        data_in: in std_logic;
        data_out_1: out data_word;
        data_out_0: out data_word;
        sel_in: in std_logic_vector (1 downto 0);
        sel_out_1: in std_logic_vector (1 downto 0);
        sel_out_0: in std_logic_vector (1 downto 0);
        rw_reg: in std_logic
  );
End;

Architecture behavioural of RegisterFile is
  Begin
    -- declare register file
    Type registerFile is array(0 to 3) of std_logic_vector(data_word downto 0);
    Signal register: registerFile;

    Process(clk)
      Begin
        if rising_edge(clk) then
          -- read before write to register file
          data_out_0 <= register(to_integer(unsigned(sel_out_0)));
          data_out_1 <= register(to_integer(unsigned(sel_out_1)));
          -- write upon re_reg is low
          if rw_reg = '0' then
            -- sel_in chooses to which register data_in is written
            register(to_integer(unsigned(sel_in))) <= data_in;
          end if;
          -- bypass the new written values to output
          if falling_edge then
            data_out_0 <= register(to_integer(unsigned(sel_out_0)));
            data_out_1 <= register(to_integer(unsigned(sel_out_1)));
          end if;
        end if;
    End Process;
End behavioural;
