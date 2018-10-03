Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

entity tb_controller is
end entity;

architecture test of tb_controller is
  component controller
      port( adr       : out address_bus;              -- unsigned
            data      :     program_word;             -- unsigned
            rw_RWM    : out std_logic;                -- read on high
            RWM_en    : out std_logic;                -- active low
            ROM_en    : out std_logic;                -- active low
            clk       :     std_logic;
            reset     :     std_logic;                -- active high
            rw_reg    : out std_logic;                -- read on high
            sel_op_1  : out unsigned(1 downto 0);
            sel_op_0  : out unsigned(1 downto 0);
            sel_in    : out unsigned(1 downto 0);
            sel_mux   : out unsigned(1 downto 0);
            alu_op    : out unsigned(2 downto 0);
            alu_en    : out std_logic;                -- active high
            z_flag    :     std_logic;                -- active high
            n_flag    :     std_logic;                -- active high
            o_flag    :     std_logic;                -- active high
            out_en    : out std_logic;                -- active high
            data_imm  : out data_word);               -- signed
  end component;

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
      B"1011_00_00_00",   -- NOP  1010  nothing                 pc += 1
      B"1101_00_1101",    -- BRN  1100  om n_flag = 1 => pc = 13 (1101), om n_flag = 0 => pc += 1
      B"1110_00_1110",    -- BRO  1101  om o_flag = 1 => pc = 14 (1110), om o_flag = 0 => pc += 1
      B"1111_00_0000"     -- BRA  1110  0000 => pc
    );

  signal adr            :   address_bus;
  signal data           :   program_word;
  signal rw_RWM         :   std_logic;
  signal RWM_en         :   std_logic;
  signal ROM_en         :   std_logic;
  signal clk            :   std_logic := '0';
  signal reset          :   std_logic := '0';
  signal rw_reg         :   std_logic;
  signal sel_op_1       :   unsigned(1 downto 0);
  signal sel_op_0       :   unsigned(1 downto 0);
  signal sel_in         :   unsigned(1 downto 0);
  signal sel_mux        :   unsigned(1 downto 0);
  signal alu_op         :   unsigned(2 downto 0);
  signal alu_en         :   std_logic;
  signal z_flag         :   std_logic := '1';
  signal n_flag         :   std_logic := '1';
  signal o_flag         :   std_logic := '1';
  signal out_en         :   std_logic;
  signal data_imm       :   data_word;

begin

  CTR : controller port map (
    adr       =>    adr,
    data      =>    data,           -- in
    rw_RWM    =>    rw_RWM,
    RWM_en    =>    RWM_en,
    ROM_en    =>    ROM_en,
    clk       =>    clk,            -- in
    reset     =>    reset,          -- in
    rw_reg    =>    rw_reg,
    sel_op_1  =>    sel_op_1,
    sel_op_0  =>    sel_op_0,
    sel_in    =>    sel_in,
    sel_mux   =>    sel_mux,
    alu_op    =>    alu_op,
    alu_en    =>    alu_en,
    z_flag    =>    z_flag,         -- in
    n_flag    =>    n_flag,         -- in
    o_flag    =>    o_flag,         -- in
    out_en    =>    out_en,
    data_imm  =>    data_imm
  );



  -- IDEA: look at controller OUT ports,
  -- read in instruction and other IN values,
  -- check value of OUT ports.
  process(clk)
  begin
    if ROM_en = '0' then
      data <= inst_list(to_integer(unsigned(adr)));
    end if;
  end process;
end architecture;
