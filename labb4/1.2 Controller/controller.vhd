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
  signal pres_state       : state_type := 0;
  signal next_state       : state_type := 0;

  signal inst             : program_word;
  signal program_counter  : integer := 0; -- only signal for easier test benching

  signal address          :     address_bus;              -- unsigned
  signal rwm_rw           :     std_logic;                -- read on high
  signal rwm_enable       :     std_logic;                -- active low
  signal rom_enable       :     std_logic;                -- active low
  signal reg_rw           :     std_logic;                -- read on high
  signal sel_reg_out_1    :     unsigned(1 downto 0);
  signal sel_reg_out_0    :     unsigned(1 downto 0);
  signal sel_reg_in       :     unsigned(1 downto 0);
  signal sel_mux_in       :     unsigned(1 downto 0);
  signal alu_op_code      :     unsigned(2 downto 0);
  signal alu_enable       :     std_logic;                -- active highh
  signal out_enable       :     std_logic;                -- active high
  signal data_i           :     data_word;               -- signed

  alias inst_op           :   std_logic_vector(3 downto 0) is inst(9 downto 6);
  alias inst_alu_op       :   std_logic_vector(2 downto 0) is inst(8 downto 6);
  alias inst_r1           :   std_logic_vector(1 downto 0) is inst(5 downto 4);
  alias inst_r2           :   std_logic_vector(1 downto 0) is inst(3 downto 2);
  alias inst_r3           :   std_logic_vector(1 downto 0) is inst(1 downto 0);
  alias inst_mem          :   std_logic_vector(3 downto 0) is inst(3 downto 0);

begin

  COUNT : process(clk, reset)
  begin
    if reset = '1' then
      pres_state <= 0;
    elsif rising_edge(clk) then
      pres_state <= next_state;
    end if;
  end process;

  REG : process(clk)
  begin
    if clk'event and clk = '1' then
      adr <= address;
      rw_RWM <= rwm_rw;
      RWM_en <= rwm_enable;
      ROM_en <= rom_enable;
      rw_reg <= reg_rw;
      sel_op_1 <= sel_reg_out_1;
      sel_op_0 <= sel_reg_out_0;
      sel_in <= sel_reg_in;
      sel_mux <= sel_mux_in;
      alu_op <= alu_op_code;
      alu_en <= alu_enable;
      out_en <= out_enable;
      data_imm <= data_i;
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
        address <= std_logic_vector(to_unsigned(program_counter, address_size));
        rom_enable <= '1';

      when 2 =>
        inst <= data;

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
            alu_op_code     <=  unsigned(inst_alu_op);
            sel_reg_out_1   <=  unsigned(inst(5 downto 4));       -- r1; reg to read from
            sel_reg_in      <=  unsigned(inst(1 downto 0));       -- r3; reg to save to
            sel_mux_in      <=  "00";                   -- alu output

            -- "00" for NOT and MOV, r2 for the rest
            if inst(8 downto 6) = "101" or inst(8 downto 6) = "111" then
              sel_reg_out_0 <= "00";
            else
              sel_reg_out_0 <= unsigned(inst(5 downto 4));
            end if;

            alu_enable      <=  '1';                    -- enable alu
            reg_rw          <=  '0';                    -- enable write to reg

            program_counter <= program_counter + 1;

          -- ldr
          when "0111" => -- null
          when "1000" => --state <= 5;
            rwm_enable      <=  '1';
            rom_enable      <=  '0';
            address         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rwm_rw          <=  '1';                -- set RWM in 'read from' mode
            sel_mux_in      <=  "01";               -- inst from RWM
            sel_reg_in      <=  unsigned(inst(5 downto 4));   -- r1; reg to save to
            reg_rw          <=  '0';
            program_counter <= program_counter + 1;

          -- str
          when "1001" => --state <= 6;
            rwm_enable      <=  '1';
            rom_enable      <=  '0';
            address         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
            rwm_rw          <=  '0';                -- set RWM in 'write to' mode
            sel_reg_out_1   <=  unsigned(inst(5 downto 4));
            out_enable      <=  '1';
            program_counter <= program_counter + 1;

          -- ldi
          when "1010" => --state <= 7;
            sel_reg_in      <=  unsigned(inst(5 downto 4));
            sel_mux_in      <=  "10";
            data_i          <=  inst(3 downto 0);
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
    end case;
  end if;
  end process;
end architecture;
