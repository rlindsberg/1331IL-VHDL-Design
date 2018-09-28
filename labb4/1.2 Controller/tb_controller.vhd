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
begin
  process
  begin
    -- ADD --

    -- SUB
    -- AND
    -- OR
    -- XOR
    -- NOT
    -- MOV
    -- LDR
    -- STD
    -- LDI
    -- NOP
    -- BRZ
    -- BRN
    -- BRO
    -- BRA
  end process;
end architecture;
