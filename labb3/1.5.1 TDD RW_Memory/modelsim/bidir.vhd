library ieee;
use ieee.std_logic_1164.all;

entity bidir is
    port (
        Z  : inout  std_logic_vector(3 downto 0);
        ce : in     std_logic;
        rw : in     std_logic;
        A  : in     std_logic_vector(3 downto 0)
        );
end Entity bidir;

architecture behave of bidir is
begin

    Z <= A        when (ce = '0' and rw = '1') else -- read
         "ZZZZ"   when (ce = '1')              else -- disabled
         "XXXX";                                    -- unknown

end behave;
