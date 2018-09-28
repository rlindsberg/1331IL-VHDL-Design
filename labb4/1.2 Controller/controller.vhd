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

  signal program_counter  : integer := 0; -- only signal for easier test benching
  signal pres_state       : state_type := 0;
  signal next_state       : state_type := 0;
  signal inst             : program_word;
  -- signal adr_s1           : address_bus;
  -- signal adr_s5           : address_bus;
  -- signal adr_s6           : address_bus;
  -- signal ROM_en       : std_logic;

  alias inst_op:std_logic_vector(3 downto 0) is inst(9 downto 6);
begin

  COUNT : process(clk, reset)
  begin
    if reset = '1' then
      pres_state <= 0;
    elsif rising_edge(clk) then
      pres_state <= next_state;
    end if;
  end process;

  LOGIC : process(pres_state) -- decode + branching
  begin
    case pres_state is
      when 0 =>
        next_state <= pres_state + 1;
        program_counter <= 0;

      when 1 =>
        adr <= std_logic_vector(to_unsigned(program_counter, address_size));
        ROM_en <= '1';

        next_state <= pres_state + 1;

      when 2 =>
        inst <= data;

        next_state <= pres_state + 1;

      when 3 =>
        case inst_op is
          -- add, sub, and, or, xor, not, mov
          when "0000" => -- add
          when "0001" => -- sub
          when "0010" => -- and
          when "0011" => -- or
          when "0100" => -- xor
          when "0101" => -- not
    	    when "0110" => -- mov
            --state <= 4;
            alu_op    <=  unsigned(inst(8 downto 6));       -- alu operation
            sel_op_1  <=  unsigned(inst(5 downto 4));       -- r1; reg to read from
            sel_in    <=  unsigned(inst(1 downto 0));       -- r3; reg to save to
            sel_mux   <=  "00";                   -- alu output

            -- "00" for NOT and MOV, r2 for the rest
            if inst(8 downto 6) = "101" or inst(8 downto 6) = "111" then
              sel_op_0 <= "00";
            else
              sel_op_0 <= unsigned(inst(5 downto 4));
            end if;

            alu_en    <=  '1';                    -- enable alu
            rw_reg    <=  '0';                    -- enable write to reg

            program_counter <= program_counter + 1;

          -- ldr
          when "0111" => next_state <= 1;
          when "1000" => --state <= 5;
            RWM_en      <=  '1';
            ROM_en      <=  '0';
            adr         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rw_RWM      <=  '1';                -- set RWM in 'read from' mode
            sel_mux     <=  "01";               -- inst from RWM
            sel_in      <=  unsigned(inst(5 downto 4));   -- r1; reg to save to
            rw_reg      <=  '0';
            program_counter <= program_counter + 1;

          -- str
          when "1001" => --state <= 6;
            RWM_en      <=  '1';
            ROM_en      <=  '0';
            adr         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rw_RWM      <=  '0';                -- set RWM in 'write to' mode
            sel_op_1    <=  unsigned(inst(5 downto 4));
            out_en      <=  '1';
            program_counter <= program_counter + 1;

          -- ldi
          when "1010" => --state <= 7;
            sel_in      <=  unsigned(inst(5 downto 4));
            sel_mux     <=  "10";
            data_imm    <=  inst(3 downto 0);
            program_counter <= program_counter + 1;

          -- nop
          when "1011" =>
            program_counter <= program_counter + 1;

          -- brz
          when "1100" =>
            if z_flag = '1' then
              program_counter <= to_integer(unsigned(inst( 3 downto 0)));
            else
              program_counter <= program_counter + 1;
            end if;

          -- brn
          when "1101" =>
            if n_flag = '1' then
              program_counter <= to_integer(unsigned(inst( 3 downto 0)));
            else
              program_counter <= program_counter + 1;
            end if;

          -- bro
          when "1110" =>
            if o_flag = '1' then
              program_counter <= to_integer(unsigned(inst( 3 downto 0)));
            else
              program_counter <= program_counter + 1;
            end if;

          -- bra
          when "1111" =>
            program_counter <= to_integer(unsigned(inst(3 downto 0)));

        end case;

        next_state <= 1;
    end case;
  end process;
end architecture;
