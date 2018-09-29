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
        data_imm  : out data_word);               -- signed
end entity;

architecture fun_part of controller is
  SUBTYPE state_type IS integer RANGE 0 TO 3;
  signal pres_state       :   state_type := 0;
  signal next_state       :   state_type := 0;

  signal inst             :   program_word;
  signal program_counter  :   integer := 0;

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
      pres_state <= 0;
    elsif rising_edge(clk) then
      pres_state <= next_state;
    end if;
  end process;

  PRES : process(pres_state)
  begin
    case pres_state is
      when 0 => next_state <= pres_state + 1;
      when 1 => next_state <= pres_state + 1;
      when 2 => next_state <= pres_state + 1;
      when 3 => next_state <= 1;
    end case;
  end process;

  LOGIC : process(clk, pres_state) -- decode + branching
  begin
    if rising_edge(clk) then
    case pres_state is
      when 0 =>
        program_counter <= 0;

      when 1 =>
        ROM_en <= '0'; -- active low
        adr <= std_logic_vector(to_unsigned(program_counter, address_size));
        ROM_en <= '1' after 100 ps; -- deactive high

      when 2 =>
        inst <= data;

      when 3 =>
        case inst_op is
          -- add, sub, and, or, xor, not, mov
          when "0000" => -- add --TODO behövdes visst ändå :(
          when "0001" => -- sub --TODO
          when "0010" => -- and --TODO
          when "0011" => -- or  --TODO
          when "0100" => -- xor --TODO
          when "0101" => -- not --TODO
    	    when "0110" => -- mov --TODO
            --state <= 4;
            alu_op      <=  unsigned(inst_alu_op);
            sel_op_1    <=  unsigned(inst_r1);       -- r1; reg to read from
            sel_in      <=  unsigned(inst_r3);       -- r3; reg to save to
            sel_mux     <=  "00";                   -- alu output

            -- "00" for NOT and MOV, r2 for the rest
            if inst(8 downto 6) = "101" or inst(8 downto 6) = "111" then
              sel_op_0 <= "00";
            else
              sel_op_0 <= unsigned(inst_r1);
            end if;

            alu_en      <=  '1';                    -- enable alu
            rw_reg          <=  '0';                    -- enable write to reg

            program_counter <= program_counter + 1; -- TODO inte hållbart, måste endast printa ut det nya värdet

          -- ldr
          when "1000" => --state <= 5;
            RWM_en      <=  '0'; -- activate RWM
            ROM_en      <=  '1'; -- deactivate ROM
            adr         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rw_RWM          <=  '1';                -- set RWM in 'read from' mode
            sel_mux      <=  "01";               -- inst from RWM
            sel_in      <=  unsigned(inst_r1);   -- r1; reg to save to
            rw_reg          <=  '0';
            program_counter <= program_counter + 1;
            RWM_en      <=  '1' after 100 ps; -- deactivate RWM

          -- str
          when "1001" => --state <= 6;
            RWM_en      <=  '0'; -- activate RWM
            ROM_en      <=  '1'; -- deactivate ROM
            adr         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rw_RWM          <=  '0';                -- set RWM in 'write to' mode
            sel_op_1   <=  unsigned(inst_r1);
            out_en      <=  '1';
            program_counter <= program_counter + 1;   -- TODO inte hållbart, måste endast printa ut det nya värdet
            RWM_en      <=  '1' after 100 ps; -- deactivate RWM

          -- ldi
          when "1010" => --state <= 7;
            sel_in      <=  unsigned(inst_r1);
            sel_mux      <=  "10";
            data_imm          <=  inst_data_imm;
            program_counter <= program_counter + 1;   -- TODO inte hållbart, måste endast printa ut det nya värdet

          -- nop
          when "1011" =>
            program_counter <= program_counter + 1;   -- TODO inte hållbart, måste endast printa ut det nya värdet

          -- brz
          when "1100" =>
            if z_flag = '1' then
              program_counter <= to_integer(unsigned(inst_mem));
            else
              program_counter <= program_counter + 1;   -- TODO inte hållbart, måste endast printa ut det nya värdet
            end if;

          -- brn
          when "1101" =>
            if n_flag = '1' then
              program_counter <= to_integer(unsigned(inst_mem));
            else
              program_counter <= program_counter + 1;   -- TODO inte hållbart, måste endast printa ut det nya värdet
            end if;

          -- bro
          when "1110" =>
            if o_flag = '1' then
              program_counter <= to_integer(unsigned(inst_mem));
            else
              program_counter <= program_counter + 1;   -- TODO inte hållbart, måste endast printa ut det nya värdet
            end if;

          -- bra
          when "1111" =>
            program_counter <= to_integer(unsigned(inst_mem));

          when others =>
            program_counter <= 0;
        end case;
    end case;
  end if;
  end process;
end architecture;
