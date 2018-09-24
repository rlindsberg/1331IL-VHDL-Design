Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity rw_memory is
  Port (  adr   :       address_bus;
          data  : inout data_bus;
          clk   :       std_logic;
          ce    :       std_logic;        -- active low
          rw    :       std_logic);       -- read on high
End Entity;

Architecture behaviour of rw_memory is
  Component single_port_ram
    Port(   address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        		clock     : IN STD_LOGIC  := '1';
        		data      : IN STD_LOGIC_VECTOR (7 DOWNTO 0);   --data in
        		rden      : IN STD_LOGIC  := '1';               --enable
        		wren      : IN STD_LOGIC;                       --read-write
        		q         : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)   --data out
	  );
  End Component;

  Signal data_in, data_out  : data_bus;

Begin
  R : single_port_ram port map(adr, clk, data_in, ce, rw, data_out); -- Maybe not then. Remake single_port_ram into rw_memory?

  Process(clk)
  Begin
    if rising_edge(clk) then
      if ce = '1' then
        data <= (others => 'Z');

      elsif (ce = '0' and rw = '0') and clk = '1' then
        data_in <= data;

      elsif ce = '0' and rw = '1' then
        data <= data_out;

      end if;
    End if;
  End Process;
End Architecture;
