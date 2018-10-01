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

  type inst_table is array (0 to 15) of instruction_bus;
  constant  inst_list	:	    inst_table := (
      B"0000_11_00_11",   -- ADD
      B"0001_11_11_10",   -- SUB
      B"0010_01_00_01",   -- AND
      B"0011_00_11_10",   -- OR
      B"0100_00_00_10",   -- XOR
      B"0101_10_0_1_10",  -- NOT
      B"0110_00_0_1_00",  -- MOV
      B"0111_00_1100",    -- does not exist
      B"1000_00_0000",    -- LDR
      B"1001_00_0101",    -- STR
      B"1010_00_0_0_0_0", -- LDI
      B"1011_00_00_00",   -- NOP
      B"1100_10_1111",    -- BRZ
      B"1101_00_1101",    -- BRN
      B"1110_00_0000",    -- BRO
      B"1111_00_0000"     -- BRA
    );

  signal address        :   address_bus;
  signal data_in        :   program_word;
  signal rwm_rw         :   std_logic;
  signal rwm_en         :   std_logic := '1';
  signal rom_en         :   std_logic := '0';
  signal clock          :   std_logic := '0';
  signal reset          :   std_logic := '0';
  signal reg_rw         :   std_logic;
  signal reg_sel_out_1  :   unsigned(1 downto 0);
  signal reg_sel_out_0  :   unsigned(1 downto 0);
  signal reg_sel_in     :   unsigned(1 downto 0);
  signal mux_sel        :   unsigned(1 downto 0);
  signal alu_op         :   unsigned(2 downto 0);
  signal alu_en         :   std_logic;
  signal alu_flag_z     :   std_logic := '0';
  signal alu_flag_n     :   std_logic := '0';
  signal alu_flag_o     :   std_logic := '0';
  signal buffer_en      :   std_logic;
  signal data_out_imm   :   data_word;

begin

  CTR : controller port map (
    adr       =>    address,
    data      =>    data_in,        -- in
    rw_RWM    =>    rwm_rw,
    RWM_en    =>    rwm_en,
    ROM_en    =>    rom_en,
    clk       =>    clock,          -- in
    reset     =>    reset,          -- in
    rw_reg    =>    reg_rw,
    sel_op_1  =>    reg_sel_out_1,
    sel_op_0  =>    reg_sel_out_0,
    sel_in    =>    reg_sel_in,
    sel_mux   =>    mux_sel,
    alu_op    =>    alu_op,
    alu_en    =>    alu_en,
    z_flag    =>    alu_flag_z,     -- in
    n_flag    =>    alu_flag_n,     -- in
    o_flag    =>    alu_flag_o,     -- in
    out_en    =>    buffer_en,
    data_imm  =>    data_out_imm
  );

  --clock <= not clock after 100 ps;

  -- IDEA: look at controller OUT ports,
  -- read in instruction and other IN values,
  -- check value of OUT ports.
  process--(clock)
  begin
    -- if rom_en = '0' then
    --   data_in <= inst_list(to_integer(unsigned(address)));
    -- end if;
    -- ADD --
    data_in <= inst_list(0);
    wait for 9 ns;

    -- SUB
    data_in <= inst_list(1);
    wait for 9 ns;


  end process;
end architecture;
