library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

Entity tb_full_adder is

end tb_full_adder;

Architecture test of tb_full_adder is

component full_adder is
  Port (
    A : in STD_LOGIC;
    B : in STD_LOGIC;
    Cin : in STD_LOGIC;
    S : out STD_LOGIC;
    Cout : out STD_LOGIC
  );
end component;

--input
signal numA: STD_LOGIC = '0';
signal numB: STD_LOGIC = '0';
signal numCin: STD_LOGIC = '0';

--output
signal numOut: STD_LOGIC = '0';
signal sum: STD_LOGIC = '0';

DUT: full_adder
  port map(
    A => numA;
    B => num;
    Cin => numCin;
    Cout => numOut;
    S => sum;
  );

--out test stimulus

numCin <= not (numCin) after 10 ns;
numA <= not (numA) after 10 ns;
numB <= not (numB);


end Architecture;
