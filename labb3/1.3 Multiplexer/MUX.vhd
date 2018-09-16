Entity MUX is
  Port(
    sel: in std_logic_vector(1 downto 0);
    data_in_0: in data_word;
    data_in_1: in data_bus;
    data_in_2: in data_word;
    data_out: out data_word
  );
End;

Architecture behavioural of MUX is
  Signal
  Begin
    -- 00 selects data_in_0
    if sel = "00" then
      data_out <= data_in_0;
    -- 01 selects data_in_1
    elseif sel = "01" then
      data_out <= data_word(data_in_1);
    -- 10 selects data_in_2
    elseif sel = "10" then
      data_out <= data_in_2;
    end if;

End behavioural;
