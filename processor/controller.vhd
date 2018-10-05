Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

entity controller is
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
end entity;

architecture fun_part of controller is
  subtype state_type is integer range 0 to 3;
  signal state            :   state_type := 0;
  signal next_state       :   state_type := 0;
  signal next_pc          :   integer := 0;

  signal ROM_debug        :   std_logic;

  signal inst             :   program_word;
  signal pc               :   integer := 0;

  alias inst_op           :   std_logic_vector(3 downto 0) is inst(9 downto 6);
  alias inst_alu_op       :   std_logic_vector(2 downto 0) is inst(8 downto 6);
  alias inst_r1           :   std_logic_vector(1 downto 0) is inst(5 downto 4);
  alias inst_r2           :   std_logic_vector(1 downto 0) is inst(3 downto 2);
  alias inst_r3           :   std_logic_vector(1 downto 0) is inst(1 downto 0);
  alias inst_mem          :   std_logic_vector(3 downto 0) is inst(3 downto 0);
  alias inst_data_imm     :   std_logic_vector(3 downto 0) is inst(3 downto 0);

begin

  COUNT : process(clk, in_reset, in_stop)
  begin
    if in_reset = '1' then
      state <= 0;
    elsif rising_edge(clk) and in_stop /= '1' then
      state <= next_state;
    end if;
  end process;

  LOGIC : process(clk, state) -- decode + branching
  begin
    if rising_edge(clk) then
      case state is
      when 0 =>
        out_ROM_en      <= '1';
        next_pc     <=  0;
        out_out_en      <= '0';
        out_rw_reg      <= '1';
        next_state  <= state + 1;

      when 1 =>
        out_adr         <= std_logic_vector(to_unsigned(pc, address_size));
        pc          <= next_pc;
        next_state  <= state + 1;

      when 2 =>

        -- -- test 1: testing out_ROM_en's value from state 1
        -- -- test 1 should success at 1000 ps, 7000 ps and 1300 ps

        -- moved from state 1
        out_ROM_en      <= '1'; -- deactive high
        inst        <= in_data;
        next_state  <= state + 1;

        case inst_op is
          when "1000" =>
            out_RWM_en      <= '0'; -- deactive high
            out_adr         <=  in_data(3 downto 0);   -- out_adr is connected texpressiono both RWM and ROM
          when "1001" =>
            out_RWM_en      <= '0'; -- deactive high
            out_adr         <=  in_data(3 downto 0);   -- out_adr is connected texpressiono both RWM and ROM
          when others =>
            out_RWM_en      <= '1'; -- deactive high
        end case;

      when 3 =>

        -- test 2: testing out_ROM_en's value from state 2
        -- test 2 should success at 2500 ps, 8500 ps, 14500 ps

        case inst_op is
          -- add
          when "0000" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  unsigned(inst_r2); -- r2
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- sub
          when "0001" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  unsigned(inst_r2); -- r2
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- and
          when "0010" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  unsigned(inst_r2); -- r2
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- or
          when "0011" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  unsigned(inst_r2); -- r2
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- xor
          when "0100" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  unsigned(inst_r2); -- r2
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- not
          when "0101" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  "00";
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- mov
          when "0110" =>
            out_alu_op          <=  unsigned(inst_alu_op);
            out_sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- out_sel_in chooses to which register data_in is written
            out_sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            out_sel_mux         <=  "00";                   -- alu output
            out_sel_op_0        <=  "00";
            out_alu_en          <=  '1';                    -- enable alu
            out_rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- ldr
          when "1000" =>
            out_rw_RWM          <=  '1';                -- set RWM in 'read from' mode
            out_sel_mux         <=  "01";               -- inst from RWM
            out_sel_in          <=  unsigned(inst_r1);   -- r1; reg to save to
            out_rw_reg          <=  '0';
            next_pc         <=  pc + 1;

          -- str
          when "1001" =>
            out_rw_RWM          <=  '0';                -- set RWM in 'write to' mode
            out_sel_op_1        <=  unsigned(inst_r1);
            out_out_en          <=  '1';
            next_pc         <=  pc + 1;

          -- ldi
          when "1010" =>
            out_sel_in          <=  unsigned(inst_r1);
            out_sel_mux         <=  "10";
            out_data_imm        <=  inst_data_imm;
            next_pc         <=  pc + 1;

          -- nop
          when "1011" =>
            next_pc         <=  pc + 1;

          -- brz
          when "1100" =>
            if in_z_flag = '1' then
              next_pc <= to_integer(unsigned(inst_mem));
            elsif state = next_state then
              next_pc <= pc + 1;
            end if;

          -- brn
          when "1101" =>
            if in_n_flag = '1' then
              next_pc <= to_integer(unsigned(inst_mem));
            elsif state = next_state then
              next_pc <= pc + 1;
            end if;

          -- bro
          when "1110" =>
            if in_o_flag = '1' then
              next_pc <= to_integer(unsigned(inst_mem));
            elsif state = next_state then
              next_pc <= pc + 1;
            end if;

          -- bra
          when "1111" =>
            next_pc <= to_integer(unsigned(inst_mem));

          when others =>
            next_pc <= 0;

        end case;

        -- prepare for state 1
        out_RWM_en      <= '1' after 100 ps; -- active low
        out_ROM_en      <= '0' after 100 ps;
        out_out_en      <= '0' after 100 ps;
        out_rw_reg      <= '1' after 100 ps;

        next_state  <=  1 after 100 ps;
      end case;
    end if;
  end process;
end architecture;
