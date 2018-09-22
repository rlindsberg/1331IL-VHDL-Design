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
    Begin
      if in_reset = '1' then
        out_clk <= '0';
        out_counter <= (others=>'0'); -- reset to 0000
      end if;

      if clk'event AND clk='1' then

      end if;

End Architecture;
