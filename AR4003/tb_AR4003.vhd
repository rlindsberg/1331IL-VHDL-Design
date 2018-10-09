Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity tb_AR4003 is
end Entity;

Architecture test of tb_AR4003 is
  Component AR4003
    Port(   out_adr         : out   address_bus;
            in_data         :       instruction_bus;
            in_stop         :       std_logic;
            inout_RWM_data  : inout data_bus;
            out_rw_RWM      : out   std_logic;
            out_ROM_en      : out   std_logic;
            out_RWM_en      : out   std_logic;
            clk             :       std_logic;
            in_reset        :       std_logic);
  end Component;

  signal sig_adr            : address_bus;
  signal sig_ROM_data       : instruction_bus;
  signal sig_stop           : std_logic := '0';
  signal sig_RWM_data       : data_bus;
  signal sig_rw_RWM         : std_logic;
  signal sig_ROM_en         : std_logic;
  signal sig_RWM_en         : std_logic;
  signal clk                : std_logic;
  signal sig_reset          : std_logic := '0';

  type inst_table is array (0 to 14) of instruction_bus;
  constant  inst_list	:	    inst_table := (
      -- (reg<n> = value in register <n>)
      B"0000_11_00_11",   -- ADD  0000   reg3 + reg0 => reg3     pc += 1
      B"0001_11_11_10",   -- SUB  0001   reg3 - reg3 => reg2     pc += 1
      B"0010_01_00_01",   -- AND  0010   reg1 & reg0 => reg1     pc += 1
      B"0011_00_11_10",   -- OR   0011   reg0 | reg3 => reg2     pc += 1
      B"0100_00_00_10",   -- XOR  0100   reg0 xor reg0 => reg2   pc += 1
      B"0101_10_0_1_10",  -- NOT  0101   !reg2 => reg2           pc += 1
      B"0110_00_0_1_00",  -- MOV  0110   reg0 => reg0            pc += 1
      B"1000_00_0000",    -- LDR  0111   mem<0000> => reg0       pc += 1
      B"1001_00_0101",    -- STR  1000   reg0 => mem<0101>       pc += 1
      B"1010_00_0_0_0_0", -- LDI  1001   0000 => reg0            pc += 1
      B"1011_00_00_00",   -- NOP  1010  nothing                  pc += 1
      B"1100_10_1100",    -- BRZ  1011  om z_flag = 1 => pc = 11 (1100), om z_flag = 0 => pc += 1
      B"1101_00_1101",    -- BRN  1100  om n_flag = 1 => pc = 12 (1101), om n_flag = 0 => pc += 1
      B"1110_00_1110",    -- BRO  1101  om o_flag = 1 => pc = 13 (1110), om o_flag = 0 => pc += 1
      B"1111_00_0000"     -- BRA  1110  0000 => pc
    );

begin
  Pocesor_inst : AR4003 port map(
    out_adr         =>  sig_adr,
    in_data         =>  sig_ROM_data,
    in_stop         =>  sig_stop,
    inout_RWM_data  =>  sig_RWM_data,
    out_rw_RWM      =>  sig_rw_RWM,
    out_ROM_en      =>  sig_ROM_en,
    out_RWM_en      =>  sig_RWM_en,
    clk             =>  clk,
    in_reset        =>  sig_reset);

  Process(clk, sig_ROM_en)
  begin
    if sig_ROM_en = '0' then
      sig_ROM_data <= inst_list(to_integer(unsigned(sig_adr)));
    end if;
  end Process;
end Architecture;
