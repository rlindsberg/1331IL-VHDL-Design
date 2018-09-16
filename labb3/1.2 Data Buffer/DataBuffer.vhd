Entity DataBuffer is
  Port(
    out_en: in std_logic;
    data_in: in data_word;
    data_out: out data_bus
  );
End;

Architecture behavioural of DataBuffer is

  Signal

Begin

  Process(clk)
    Begin
      if rising_edge(clk) then
        -- pass data_in to data_out when out_en is high
        if out_en = '1' then
          data_out <= data_in;
        else
          -- data_out remains high impedans when out_en is low
          data_out <= 'Z';
        end if;
      end if;

End behavioural;
