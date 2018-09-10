library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.all;

entity adder is
  port (
    a   : std_logic_vector(7 downto 0);
    b   : std_logic_vector(7 downto 0);
    sum : out std_logic_vector(7 downto 0)
  );
end entity;

architecture gooy_inside of adder is
  begin

    sum <= a + b after 5 ns;
    
end architecture;
