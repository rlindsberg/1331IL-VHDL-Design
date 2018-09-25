Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

entity bidir is
    port (
        clk:       std_logic;
        Z  : inout  std_logic_vector(3 downto 0);
        ce : in     std_logic;
        rw : in     std_logic;
        A  : in     std_logic_vector(3 downto 0)
        );
end Entity bidir;

architecture behave of bidir is

  Type data_array is array (0 to 15) of data_bus;
  Signal mem: data_array;
  Signal Z_internal: std_logic_vector(3 downto 0);

begin

  -- Memory Write Block
  -- Write Operation : When we = 1, cs = 1
    MEM_WRITE: process (clk) begin
      if rising_edge(clk) and ce = '0' and rw = '0' then
        mem(0) <= A;
      end if;
    end process;

    -- Memory Read Block
     MEM_READ: process (clk) begin
       if (rising_edge(clk) and ce = '0' and rw = '1') then
         Z_internal <= mem(0);
       else
         Z_internal <= (others=>'0');
       end if;
     end process;
end behave;
