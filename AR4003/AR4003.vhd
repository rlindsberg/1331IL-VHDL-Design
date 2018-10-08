Library IEEE;
Use IEEE.std_logic_1164.all;
Use IEEE.numeric_std.all;
Use work.cpu_package.all;

Entity AR4003 is
  Port( out_adr         : out   address_bus;
        in_data         :       instruction_bus;
        in_stop         :       std_logic;
        inout_RWM_data  : inout data_bus;
        out_rw_RWM      : out   std_logic;
        out_ROM_en      : out   std_logic;
        out_RWM_en      : out   std_logic;
        clk             :       std_logic;
        in_reset        :       std_logic);
end Entity;

Architecture Structure of AR4003 is
  Component ALU
    Port (  in_Op      : in std_logic_vector(2 downto 0);
            in_A       : in data_word;
            in_B       : in data_word;
            in_En      : in std_logic;
            clk        : in std_logic;
            out_y      : out data_word;
            out_n_flag : out std_logic;
            out_z_flag : out std_logic;
            out_o_flag : out std_logic);
  end Component;

  Component controller
    Port(   out_adr       : out address_bus;              -- unsigned
            in_data       :     program_word;             -- unsigned
            out_rw_RWM    : out std_logic;                -- read on high
            out_RWM_en    : out std_logic;                -- active low
            out_ROM_en    : out std_logic;                -- active low
            clk           :     std_logic;
            in_reset      :     std_logic;                -- active high
            out_rw_reg    : out std_logic;                -- read on high
            out_sel_op_1  : out unsigned(1 downto 0);
            out_sel_op_0  : out unsigned(1 downto 0);
            out_sel_in    : out unsigned(1 downto 0);
            out_sel_mux   : out unsigned(1 downto 0);
            out_alu_op    : out unsigned(2 downto 0);
            out_alu_en    : out std_logic;                -- active high
            in_z_flag     :     std_logic;                -- active high
            in_n_flag     :     std_logic;                -- active high
            in_o_flag     :     std_logic;                -- active high
            out_out_en    : out std_logic;                -- active high
            out_data_imm  : out data_word;                -- signed
            in_stop       :     std_logic);
  end Component;

  Component data_buffer
    Port(   in_out_en     :     std_logic;
            in_data_in    :     data_word;
            out_data_out  : out data_word);
  end component;

  Component multiplexer
    Port(   in_sel         :     std_logic_vector(1 downto 0);
            in_data_in_2   :     data_word;
            in_data_in_1   :     data_word;
            in_data_in_0   :     data_word;
            out_data_out   : out data_word);
  end Component;

  Component register_file
    Port(   clk            : in std_logic;
            in_data_in     : in data_word;
            out_data_out_1 : out data_word;
            out_data_out_0 : out data_word;
            in_sel_in      : in std_logic_vector (1 downto 0);
            in_sel_out_1   : in std_logic_vector (1 downto 0);
            in_sel_out_0   : in std_logic_vector (1 downto 0);
            in_rw_reg      : in std_logic);
  end Component;

  -- ALU signals
  signal sig_z_flag, sig_n_flag, sig_o_flag, sig_alu_en   : std_logic;
  signal sig_alu_op                           : unsigned(2 downto 0);
  signal sig_alu_out                          : data_word;

  -- controller signal
  signal sig_data_imm                         : data_word;

  -- register_file signals
  signal sig_rw_reg                           : std_logic;
  signal sig_sel_out_0, sig_sel_out_1, sig_sel_in         : unsigned(1 downto 0);
  signal sig_reg_data_out_0, sig_reg_data_out_1           : data_word;

  -- multiplexer signals
  signal sig_sel_mux                          : unsigned(1 downto 0);
  signal sig_mux_data_out                     : data_word;

  -- data_buffer signals
  signal sig_out_en                           : std_logic;

Begin
  Ctl_inst: controller port map (
    out_adr         =>  out_adr,              -- out
    in_data         =>  in_data,
    out_rw_RWM      =>  out_rw_RWM,           -- out
    out_RWM_en      =>  out_RWM_en,           -- out
    out_ROM_en      =>  out_ROM_en,           -- out
    clk             =>  clk,
    in_reset        =>  in_reset,
    out_rw_reg      =>  sig_rw_reg,           -- out
    out_sel_op_1    =>  sig_sel_out_1,        -- out
    out_sel_op_0    =>  sig_sel_out_0,        -- out
    out_sel_in      =>  sig_sel_in,           -- out
    out_sel_mux     =>  sig_sel_mux,          -- out
    out_alu_op      =>  sig_alu_op,           -- out
    out_alu_en      =>  sig_alu_en,           -- out
    in_z_flag       =>  sig_z_flag,
    in_n_flag       =>  sig_n_flag,
    in_o_flag       =>  sig_o_flag,
    out_out_en      =>  sig_out_en,           -- out
    out_data_imm    =>  sig_data_imm,         -- out
    in_stop         =>  in_stop
  );

  ALU_inst: ALU port map (
    in_Op           =>  std_logic_vector(sig_alu_op),
    in_A            =>  sig_reg_data_out_1,
    in_B            =>  sig_reg_data_out_0,
    in_En           =>  sig_alu_en,
    clk             =>  clk,
    out_y           =>  sig_alu_out,          -- out
    out_n_flag      =>  sig_n_flag,           -- out
    out_z_flag      =>  sig_z_flag,           -- out
    out_o_flag      =>  sig_o_flag            -- out
  );

  reg_file_inst: register_file port map (
    clk             =>  clk,
    in_data_in      =>  sig_mux_data_out,
    out_data_out_1  =>  sig_reg_data_out_1,   -- out
    out_data_out_0  =>  sig_reg_data_out_0,   -- out
    in_sel_in       =>  std_logic_vector(sig_sel_in),
    in_sel_out_1    =>  std_logic_vector(sig_sel_out_1),
    in_sel_out_0    =>  std_logic_vector(sig_sel_out_0),
    in_rw_reg       =>  sig_rw_reg
  );

  MUX_inst: multiplexer port map (
    in_sel          =>  std_logic_vector(sig_sel_mux),
    in_data_in_2    =>  sig_data_imm,
    in_data_in_1    =>  inout_RWM_data,
    in_data_in_0    =>  sig_alu_out,
    out_data_out    =>  sig_mux_data_out      -- out
  );

  buffer_inst: data_buffer port map (
    in_out_en       =>  sig_out_en,
    in_data_in      =>  sig_reg_data_out_1,
    out_data_out    =>  inout_RWM_data          -- out
  );

end Architecture;
