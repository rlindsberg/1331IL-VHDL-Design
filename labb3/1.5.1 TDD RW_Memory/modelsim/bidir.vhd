library ieee;
use ieee.std_logic_1164.all;

entity bidir is
    port (
        Z  : inout std_logic_vector(3 downto 0);
        Y  : out   std_logic_vector(3 downto 0);
        OE : in    std_logic;
        WE : in    std_logic;
        A  : in    std_logic_vector(3 downto 0)
        );
end Entity bidir;

architecture behave of bidir is
begin

    Z <= A        when (OE = '0' and WE = '1') else
         "ZZZZ"   when (OE = '1')              else
         "XXXX";


    Y <= TO_X01(Z);

end behave;
