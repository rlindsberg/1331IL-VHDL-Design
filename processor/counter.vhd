-- Konstruera en 16-Counter som räknar varje förändring av
-- en insignal STEP. Countern skall triggas av FPGA-kortets
-- interna snabba klocksignal(CLK), men bara räkna upp om
-- STEP har förändrats. Counterns utvärden skall visas på
-- en sjusegmentdisplay.

Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
Use work.cpu_package.ALL;

Entity counter is
  Port(
    in_clk      : in std_logic;
    in_step     : in std_logic;
    in_reset    : in std_logic;
    out_clk     : out std_logic;
    out_counter : out std_logic_vector(data_size-1 downto 0)
  );
End;

Architecture arch of counter is

  Signal internal_counter: std_logic_vector(data_size-1 downto 0);
  Signal internal_clk: std_logic;
  Signal internal_step_state: std_logic;

Begin

  Process(in_clk, in_step)
    Begin

      if Rising_edge(in_clk) then

        -- reset counter
        if in_reset = '1' then
          internal_clk <= '0';
          internal_counter <= (others=>'0'); -- reset to 0000
        end if;

        -- count to 16
        if internal_counter = "1111" then
          if internal_step_state /= in_step then
            internal_counter <= "0000";
            -- toggle clk when counter reaches 16
            internal_clk <= '1';
          end if;
        -- not yet 16
        elsif internal_step_state /= in_step then
          -- keep clk to 0 when counter is less than 16
          internal_clk <= '0';
          -- counter++
          internal_counter <= internal_counter + "0001";
          -- save step state
          internal_step_state <= in_step;
        end if;

      end if;
  End Process;

  out_counter <= internal_counter;
  out_clk <= internal_clk;

End Architecture;
