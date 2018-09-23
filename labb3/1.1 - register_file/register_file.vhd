Library IEEE;
Use IEEE.std_logic;
Use IEEE.numeric_std;
use work.cpu_package.all;

Entity register_file is
  Port(   clk         :     std_logic;
          data_in     :     data_word;
          data_out_1  : out data_word;
          data_out_0  : out data_word;
          sel_in      :     std_logic_vector(1 downto 0);
          sel_out_1   :     std_logic_vector(1 downto 0);
          sel_out_0   :     std_logic_vector(1 downto 0);
          rw_reg      :     std_logic);
End Entity;

Architecture rtl of register_file is
  Component register
    Port(   data_in     :     data_word;
            data_out    : out data_word;
            rw_reg      :     std_logic);
  End Component;

  Signal d_in_0, d_in_1, d_in_2, d_in_3     : data_word;
  Signal d_out_0, d_out_1, d_out_2, d_out_3 : data_word;

  begin
    R0 : register Port Map(d_in_0, d_out_0, rw_reg);
    R1 : register Port Map(d_in_1, d_out_1, rw_reg);
    R2 : register Port Map(d_in_2, d_out_2, rw_reg);
    R3 : register Port Map(d_in_3, d_out_3, rw_reg);

    -- Write data to mem
    process(clk)
    begin
      if clk = '1' then
        if sel_in = "00" then
          d_in_0 <= data_in;

        elsif sel_in = "01" then
          d_in_1 <= data_in;

        elsif sel_in = "10" then
          d_in_2 <= data_in;

        elsif sel_in = "11" then
          d_in_3 <= data_in;

        end if;
      end if;
    end process;

    -- read from mem to data_out_0
    process(clk)
    begin
      if clk = '1' then
        if sel_out_0 = "00" then
          data_out_0 <= d_out_0

        elsif sel_out_0 = "01" then
          data_out_0 <= d_out_1

        elsif sel_out_0 = "10" then
          data_out_0 <= d_out_2

        elsif sel_out_0 = "11" then
          data_out_0 <= d_out_3

        end if;
      end if;
    end process;

    -- read from mem to data_out_1
    process(clk)
    begin
      if clk = '1' then
        if sel_out_1 = "00" then
          data_out_1 <= d_out_0

        elsif sel_out_1 = "01" then
          data_out_1 <= d_out_1

        elsif sel_out_1 = "10" then
          data_out_1 <= d_out_2

        elsif sel_out_1 = "11" then
          data_out_1 <= d_out_3

        end if;
      end if;
    end process;

End Architecture;
