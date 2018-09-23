-- Konstruera en 16-Counter som räknar varje förändring av
-- en insignal STEP. Countern skall triggas av FPGA-kortets
-- interna snabba klocksignal(CLK), men bara räkna upp om
-- STEP har förändrats. Counterns utvärden skall visas på
-- en sjusegmentdisplay.

Library IEEE;
Use IEEE.STD.LOGIC_1164.ALL

Entity Counter is
  Port(
    in_clk      : in std_logic;
    in_step     : in std_logic;
    in_reset    : in std_logic;
    out_clk     : out std_logic;
    out_counter : out std_logic_vector(data_size-1 downto 0)
  );
End;

Architecture arch of Counter is

Begin

  Process(in_clk, in_step)
    Variable internal_counter: std_logic_vector(data_size-1 downto 0);
    Variable internal_step_state: std_logic;

    Begin
      if in_reset = '1' then
        out_clk <= '0';
        out_counter <= (others=>'0'); -- reset to 0000
      end if;

      if Rising_edge(clk) then
        -- count to 16
        if internal_counter = "1111" then
          if internal_step_state /= in_step then
            internal_counter <= "0000";
            out_counter <= "0000";
            out_clk <= not out_clk;
          end if;
        -- not yet 16
        elsif internal_step_state /= in_step then
          -- counter++
          internal_counter <= internal_counter + "0001";
          out_counter <= internal_counter;
          -- save step state
          internal_step_state <= in_step;
        end if;

      end if;

End Architecture;
