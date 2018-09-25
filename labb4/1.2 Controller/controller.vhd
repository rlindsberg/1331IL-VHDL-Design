Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

entity controller is
  port( adr       : out address_bus;              -- unsigned
        data      :     program_word;             -- unsigned
        rw_RWM    : out std_logic;                -- read on high
        RWM_en    : out std_logic;                -- active low
        ROM_en    : out std_logic;                -- active low
        clk       :     std_logic;
        reset     : out std_logic;                -- active high
        rw_reg    : out std_logic;                -- read on high
        sel_op_1  : out unsigned(1 downto 0);
        sel_op_0  : out unsigned(1 downto 0);
        sel_in    : out unsigned(1 downto 0);
        sel_mux   : out unsigned(1 downto 0);
        alu_op    : out unsigned(1 downto 0);
        alu_en    : out std_logic;                -- active high
        z_flag    :     std_logic;                -- active high
        n_flag    :     std_logic;                -- active high
        o_flag    :     std_logic;                -- active high
        out_en    : out std_logic;                -- active high
        data_imm  : out data_word);               -- signed
end entity;

architecture fun_part of controller is
  -- components
  component ALU
    port( Op          :     std_logic_vector(2 downto 0);
          A           :     data_word;
          B           :     data_word;
          En          :     std_logic;
          clk         :     std_logic;
          y           : out data_word;
          n_flag      : out std_logic;
          z_flag      : out std_logic;
          o_flag      : out std_logic);
  end component;

  component DataBuffer
    port( out_en      :     std_logic;
          data_in     :     data_word;
          data_out    : out data_word);
  end component;

  component MUX
    port( sel         :     std_logic_vector(1 downto 0);
          data_in_2   :     data_word;
          data_in_1   :     data_word;
          data_in_0   :     data_word;
          data_out    : out data_word);
  end component;

  component RegisterFile
    port( clk         :     std_logic;
          data_in     :     data_word;
          data_out_1  : out data_word;
          data_out_0  : out data_word;
          sel_in      :     std_logic_vector (1 downto 0);
          sel_out_1   :     std_logic_vector (1 downto 0);
          sel_out_0   :     std_logic_vector (1 downto 0);
          rw_reg      :     std_logic);
  end component;

  -- signals
  signal AAA  :   data_word; -- reg_file, alu, buffer
  signal BBB  :   data_word; -- reg_file, alu
  signal CCC  :   data_word; -- alu, mux
  signal DDD  :   data_word: -- mux, reg_file
begin
  -- components port map
  ALU : ALU port map(
      Op          => alu_op,
      A           => AAA, -- from register_file data_out_1
      B           => BBB, -- from register_file data_out_0
      En          => alu_en,
      clk         => clk,
      y           => CCC, --out (to mux data_in_0)
      n_flag      => n_flag, --out
      z_flag      => z_flag, --out
      o_flag      => o_flag); -- out

  data_buffer : data_buffer port map(
      out_en      => out_en,
      data_in     => AAA, -- from register_file data_out_1
      data_out    =>); --out

  MUX : multiplexer port map(
      sel         => sel_mux,
      data_in_2   => data_imm,
      data_in_1   =>, -- from ?
      data_in_0   => CCC, -- from ALU y
      data_out    => DDD); --out (to register_file data_in)

  register_file : RegisterFile port map(
      clk         => clk,
      data_in     => DDD, -- from mux data_out
      data_out_1  => AAA, --out (to buffer data_in & ALU A)
      data_out_0  => data_out_0_to_B, --out (to ALU B)
      sel_in      => sel_in,
      sel_out_1   => sel_op_1,
      sel_out_0   => sel_op_0,
      rw_reg      => rw_reg);

end architecture;
