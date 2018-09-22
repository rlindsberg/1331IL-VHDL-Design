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
    out_counter : out std_logic
  );
End;
