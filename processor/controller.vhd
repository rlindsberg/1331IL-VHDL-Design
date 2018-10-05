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

  COUNT : process(clk, reset)
  begin
    if reset = '1' then
      state <= 0;
    elsif rising_edge(clk) and stop /= '1' then
      state <= next_state;
    end if;
  end process;

  LOGIC : process(clk, state) -- decode + branching
  begin
    if rising_edge(clk) then
      case state is
      when 0 =>
        ROM_en      <= '1';
        next_pc     <=  0;
        out_en      <= '0';
        rw_reg      <= '1';
        next_state  <= state + 1;

      when 1 =>
        adr         <= std_logic_vector(to_unsigned(pc, address_size));
        pc          <= next_pc;
        next_state  <= state + 1;

      when 2 =>

        -- -- test 1: testing ROM_en's value from state 1
        -- -- test 1 should success at 1000 ps, 7000 ps and 1300 ps

        -- moved from state 1
        ROM_en      <= '1'; -- deactive high
        inst        <= data;
        next_state  <= state + 1;

        case inst_op is
          when "1000" =>
            RWM_en      <= '0'; -- deactive high
            adr         <=  data(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
          when "1001" =>
            RWM_en      <= '0'; -- deactive high
            adr         <=  data(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
          when others =>
            RWM_en      <= '1'; -- deactive high
        end case;

      when 3 =>

        -- test 2: testing ROM_en's value from state 2
        -- test 2 should success at 2500 ps, 8500 ps, 14500 ps

        case inst_op is
          -- add
          when "0000" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- sub
          when "0001" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- and
          when "0010" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- or
          when "0011" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- xor
          when "0100" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- not
          when "0101" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  "00";
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- mov
          when "0110" =>
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  "00";
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- ldr
          when "1000" =>
            rw_RWM          <=  '1';                -- set RWM in 'read from' mode
            sel_mux         <=  "01";               -- inst from RWM
            sel_in          <=  unsigned(inst_r1);   -- r1; reg to save to
            rw_reg          <=  '0';
            next_pc         <=  pc + 1;

          -- str
          when "1001" =>
            rw_RWM          <=  '0';                -- set RWM in 'write to' mode
            sel_op_1        <=  unsigned(inst_r1);
            out_en          <=  '1';
            next_pc         <=  pc + 1;

          -- ldi
          when "1010" =>
            sel_in          <=  unsigned(inst_r1);
            sel_mux         <=  "10";
            data_imm        <=  inst_data_imm;
            next_pc         <=  pc + 1;

          -- nop
          when "1011" =>
            next_pc         <=  pc + 1;

          -- brz
          when "1100" =>
            if z_flag = '1' then
              next_pc <= to_integer(unsigned(inst_mem));
            elsif state = next_state then
              next_pc <= pc + 1;
            end if;

          -- brn
          when "1101" =>
            if n_flag = '1' then
              next_pc <= to_integer(unsigned(inst_mem));
            elsif state = next_state then
              next_pc <= pc + 1;
            end if;

          -- bro
          when "1110" =>
            if o_flag = '1' then
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
        RWM_en      <= '1' after 100 ps; -- active low
        ROM_en      <= '0' after 100 ps;
        out_en      <= '0' after 100 ps;
        rw_reg      <= '1' after 100 ps;

        next_state  <=  1 after 100 ps;
      end case;
    end if;
  end process;
end architecture;
