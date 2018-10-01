Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cpu_package.all;

entity controller is
  port( adr       : out address_bus;              -- unsigned
        data      :     program_word;             -- unsigned
        rw_RWM    : out std_logic;                -- read on high
        RWM_en    : out std_logic;                -- active low
        ROM_en    : out std_logic := '0';                -- active low
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
    elsif rising_edge(clk) then
      state <= next_state;
    end if;
  end process;

  LOGIC : process(clk, state) -- decode + branching
  begin
    if rising_edge(clk) then
      case state is
      when 0 =>
        ROM_en      <= '1';
        next_pc     <= 0;
        next_state  <= state + 1;

        ROM_debug   <= '0'; -- active low
        ROM_en      <= ROM_debug;

      when 1 =>
        adr         <= std_logic_vector(to_unsigned(pc, address_size));
        pc          <= next_pc;
        next_state  <= state + 1;
        pc          <= next_pc;

      when 2 =>

        -- test 1: testing ROM_en's value from state 1
        -- test 1 should success at 1000 ps, 7000 ps and 1300 ps
        assert ROM_debug = '0'
        report "test 1 failed: ROM_en should be 0 but isn't."
        severity warning;

        -- moved from state 1
        ROM_en      <= '1'; -- deactive high
        inst        <= data;
        next_state  <= state + 1;

      when 3 =>

        -- test 2: testing ROM_en's value from state 2
        -- test 2 should success at 2500 ps, 8500 ps, 14500 ps
        assert ROM_debug = '1'
        report "test 2 failed: ROM_en should be 1 but isn't."
        severity warning;


        case inst_op is
          when "0000" => -- add
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          when "0001" => -- sub
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          when "0010" => -- and
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          when "0011" => -- or
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          when "0100" => -- xor
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  unsigned(inst_r2); -- r2
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          when "0101" => -- not
            alu_op          <=  unsigned(inst_alu_op);
            sel_op_1        <=  unsigned(inst_r1);       -- r1; reg to read from
            -- sel_in chooses to which register data_in is written
            sel_in          <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux         <=  "00";                   -- alu output
            sel_op_0        <=  "00";
            alu_en          <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg
            next_pc         <=  pc + 1;

          -- mov --TODO
          when "0110" =>
            --state <= 4;
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
          when "1000" => --state <= 5;
            RWM_en          <=  '0'; -- activate RWM
            adr             <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rw_RWM          <=  '1';                -- set RWM in 'read from' mode
            sel_mux         <=  "01";               -- inst from RWM
            sel_in          <=  unsigned(inst_r1);   -- r1; reg to save to
            rw_reg          <=  '0';
            RWM_en          <=  '1' after 1 ns; -- deactivate RWM
            next_pc         <=  pc + 1;

          -- str
          when "1001" => --state <= 6;
            RWM_en          <=  '0'; -- activate RWM
            adr             <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rw_RWM          <=  '0';                -- set RWM in 'write to' mode
            sel_op_1        <=  unsigned(inst_r1);
            out_en          <=  '1';
            RWM_en          <=  '1' after 1 ns; -- deactivate RWM
            next_pc         <=  pc + 1;

          -- ldi
          when "1010" => --state <= 7;
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
        next_state <= 1 after 3500 ps;
      end case;
    end if;
  end process;
end architecture;
