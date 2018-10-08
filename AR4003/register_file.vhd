Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity register_file is
  Port( clk             : in std_logic;
        in_data_in      : in data_word;
        out_data_out_1  : out data_word;
        out_data_out_0  : out data_word;
        in_sel_in       : in std_logic_vector (1 downto 0);
        in_sel_out_1    : in std_logic_vector (1 downto 0);
        in_sel_out_0    : in std_logic_vector (1 downto 0);
        in_rw_reg       : in std_logic); -- read on high
End Entity;

Architecture behavioural of register_file is
	-- declare register file
	Type registerFile is array(0 to 3) of data_word;
  Signal register_inst	: registerFile;

  Begin

    Process(clk)
      Begin
        if rising_edge(clk) then
          -- read before write to register file
          out_data_out_0 <= register_inst(to_integer(unsigned(in_sel_out_0)));
          out_data_out_1 <= register_inst(to_integer(unsigned(in_sel_out_1)));
          -- write upon re_reg is low
          if in_rw_reg = '0' then
            -- sel_in chooses to which register data_in is written
            register_inst(to_integer(unsigned(in_sel_in))) <= in_data_in;
          end if;
          -- bypass the new written values to output
            out_data_out_0 <= register_inst(to_integer(unsigned(in_sel_out_0)));
            out_data_out_1 <= register_inst(to_integer(unsigned(in_sel_out_1)));
        end if;
    End Process;
End behavioural;
