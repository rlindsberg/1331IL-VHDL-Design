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
  signal program_counter  : integer := 0; -- only signal for easier test benching
begin

  PC : process(clk, reset, program_counter, data)
  begin
    if reset = '1' then program_counter <= 0;
    end if;
    if rising_edge(clk) then
      if data(9) = '0' then                   -- ALU operations --
        alu_op    <=  unsigned(data(8 downto 6));       -- alu operation
        sel_op_1 <=  unsigned(data(5 downto 4));       -- r1; reg to read from
        sel_in    <=  unsigned(data(1 downto 0));       -- r3; reg to save to
        sel_mux   <=  "00";                   -- alu output

        -- "00" for NOT and MOV, r2 for the rest
        if data(8 downto 6) = "101" or data(8 downto 6) = "111" then
          sel_op_0 <= "00";
        else
          sel_op_0 <= unsigned(data(5 downto 4));
        end if;

        alu_en    <=  '1';                    -- enable alu
        rw_reg    <=  '0';                    -- enable write to reg

        program_counter <= program_counter + 1;
        -- TODO återställa rw_reg? timing?
      elsif data(8 downto 6) = "000" then       -- r1 = <mem>
        RWM_en      <=  '1';
        ROM_en      <=  '0';
        adr         <=  data(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
        rw_RWM      <=  '1';                -- set RWM in 'read from' mode
        sel_mux     <=  "01";               -- data from RWM
        sel_in      <=  unsigned(data(5 downto 4));   -- r1; reg to save to
        rw_reg      <=  '0';
        program_counter <= program_counter + 1;

      elsif data(8 downto 6) = "001" then    -- mem = r1
        RWM_en      <=  '1';
        ROM_en      <=  '0';
        adr         <=  data(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
        rw_RWM      <=  '0';                -- set RWM in 'write to' mode
        sel_op_1    <=  unsigned(data(5 downto 4));
  		out_en      <=  '1';
        program_counter <= program_counter + 1;

      elsif data(8 downto 6) = "010" then    -- r1 = d1d2d3d4
        sel_in      <=  unsigned(data(5 downto 4));
        sel_mux     <=  "10";
        data_imm    <=  data(3 downto 0);
        program_counter <= program_counter + 1;

      elsif data(8 downto 6) = "100" then     -- z = '1' -> pc = mem; z = '0' -> pc += 1;
        if z_flag = '1' then
          program_counter <= to_integer(unsigned(data(3 downto 0)));
        else
          program_counter <= program_counter + 1;
        end if;

      elsif data(8 downto 6) = "101" then     -- n = '1' -> pc = mem; n = '0' -> pc += 1;
        if n_flag = '1' then
          program_counter <= to_integer(unsigned(data(3 downto 0)));
        else
          program_counter <= program_counter + 1;
        end if;

      elsif data(8 downto 6) = "110" then     -- o = '1' -> pc = mem; o = '0' -> pc += 1;
        if o_flag = '1' then
          program_counter <= to_integer(unsigned(data(3 downto 0)));
        else
          program_counter <= program_counter + 1;
        end if;

      else
        program_counter <= to_integer(unsigned(data(3 downto 0)));
      end if;
    end if;
  end process;
end architecture;
