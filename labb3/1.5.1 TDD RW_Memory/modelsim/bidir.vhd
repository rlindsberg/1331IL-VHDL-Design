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
  process(ce)
  begin
    if ce = '0' then
      Z <= A;
    elsif ce = '1' then
      Z <= "ZZZZ";
    end if;


  end process;
end behave;
