Library IEEE;
Use IEEE.std_logic;
Use IEEE.numeric_std;
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

  Signal high_ohm           : std_logic_vector;
  Signal data_in, data_out  : data_bus;

  high_ohm  := ((data'length-1 downto 0)=>'Z');

Begin
  R : single_port_ram port map(adr, clk, data_in, ce, rw, data_out);

  Process(clk)
  Begin

    if ce'high then
      data <= high_ohm;

    elsif (ce'low and rw'low) and clk = '1' then
      data_in <= data;

    elsif ce'low and rw'high then
      data <= data_out;

    end if;
  End Process;
End Architecture;
