Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity CPU is
  Port( adr       : out   address_bus;
        data      :       instruction_bus;
        stop      :       std_logic;
        RWM_data  : inout data_bus;
        rw_RWM    : out   std_logic;
        ROM_en    : out   std_logic;
        RWM_en    : out   std_logic;
        clk       :       std_logic;
        reset     :       std_logic);
end Entity;

Architecture Structure of CPU is
  Component ALU
    Port (  Op    : in std_logic_vector(2 downto 0);
            A     : in data_word;
            B     : in data_word;
            En    : in std_logic;
            clk   : in std_logic;
            y     : out data_word;
            n_flag: out std_logic := '0';
            z_flag: out std_logic := '0';
            o_flag: out std_logic := '0');
  end Component;

  Component controller
    Port(   adr       : out address_bus;              -- unsigned
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
            data_imm  : out data_word;                -- signed
            stop      :     std_logic);
  end Component;

  Component data_buffer
    Port(   out_en    :     std_logic;
            data_in   :     data_word;
            data_out  : out data_word);
  end component;

  Component multiplexer
    Port(   sel         :     std_logic_vector(1 downto 0);
            data_in_2   :     data_word;
            data_in_1   :     data_word;
            data_in_0   :     data_word;
            data_out    : out data_word);
  end Component;

  Component register_file
    Port(   clk         : in std_logic;
            data_in     : in data_word;
            data_out_1  : out data_word;
            data_out_0  : out data_word;
            sel_in      : in std_logic_vector (1 downto 0);
            sel_out_1   : in std_logic_vector (1 downto 0);
            sel_out_0   : in std_logic_vector (1 downto 0);
            rw_reg      : in std_logic);
  end Component;

  -- ALU signals
  signal z_flag, n_flag, o_flag, alu_en   : std_logic;
  signal alu_op                           : std_logic_vector(2 downto 0);
  signal alu_out                          : data_word;

  -- controller signal
  signal data_imm                         : data_word;

  -- register_file signals
  signal rw_reg                           : std_logic;
  signal sel_out_0, sel_out_1, sel_in     : std_logic_vector(1 downto 0);
  signal reg_data_out_0, reg_data_out_1   : data_word;

  -- multiplexer signals
  signal sel_mux                          : std_logic_vector(1 downto 0);
  signal mux_data_out                     : data_word;

  -- data_buffer signals
  signal out_en                           : std_logic;

Begin
  controller port map (
    adr         =>  adr,              -- out
    data        =>  data,
    rw_RWM      =>  rw_RWM,           -- out
    RWM_en      =>  RWM_en,           -- out
    ROM_en      =>  ROM_en,           -- out
    clk         =>  clk,
    reset       =>  reset,
    rw_reg      =>  rw_reg,           -- out
    sel_op_1    =>  sel_out_1,        -- out
    sel_op_0    =>  sel_out_0,        -- out
    sel_in      =>  sel_in,           -- out
    sel_mux     =>  sel_mux,          -- out
    alu_op      =>  alu_op,           -- out
    alu_en      =>  alu_en,           -- out
    z_flag      =>  z_flag,
    n_flag      =>  n_flag,
    o_flag      =>  o_flag,
    out_en      =>  out_en,           -- out
    data_imm    =>  data_imm,         -- out
    stop        =>  stop,
  );

  ALU port map (
    Op          =>  alu_op,
    A           =>  reg_data_out_1,
    B           =>  reg_data_out_0,
    En          =>  alu_en,
    clk         =>  clk,
    y           =>  alu_out,          -- out
    n_flag      =>  n_flag,           -- out
    z_flag      =>  z_flag,           -- out
    o_flag      =>  o_flag,           -- out
  );

  register_file port map (
    clk         =>  clk,
    data_in     =>  mux_data_out,
    data_out_1  =>  reg_data_out_1,   -- out
    data_out_0  =>  reg_data_out_0,   -- out
    sel_in      =>  sel_in,
    sel_out_1   =>  sel_out_1,
    sel_out_0   =>  sel_out_0,
    rw_reg      =>  rw_reg,
  );

  multiplexer port map (
    sel         =>  sel_mux,
    data_in_2   =>  data_imm,
    data_in_1   =>  RWM_data,
    data_in_0   =>  alu_out,
    data_out    =>  mux_data_out      -- out
  );

  data_buffer port map (
    out_en      =>  out_en,
    data_in     =>  reg_data_out_1,
    data_out    =>  RWM_data,         -- out
  );

end Architecture;
