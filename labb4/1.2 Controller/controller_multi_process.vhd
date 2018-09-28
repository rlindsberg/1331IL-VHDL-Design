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
  signal state            : integer := 0;
  signal inst             : program_word;
  signal adr_s1           : address_bus;
  signal adr_s5           : address_bus;
  signal adr_s6           : address_bus;
  signal rom_enable       : std_logic;
begin

  RST : process(clk, reset)
  begin
    if rising_edge(clk) then
      if reset = '1' then program_counter <= 0;
      end if;

      case state is
        when 1 to 7 => state <= state + 1;
        when others => state <= 1;
      end case;
    end if;
  end process;

  FETCH : process(clk, state)
  begin
    if rising_edge(clk) and state = 1 then
      adr_s1 <= std_logic_vector(to_unsigned(program_counter, address_size));
      rom_enable <= '1';
    end if;
  end process;

  LOAD : process(clk, state)
  begin
    if rising_edge(clk) and state = 2 then
      inst <= data;
    end if;
  end process;

  DECODE : process(clk, state) -- decode + branching
  begin
    if rising_edge(clk) and state = 3 then
      case inst(9 downto 6) is
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
          state     <=  1;

        -- ldr
        when "1000" => --state <= 5;
          RWM_en      <=  '1';
          rom_enable  <=  '0';
          adr_s5     <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
          rw_RWM      <=  '1';                -- set RWM in 'read from' mode
          sel_mux     <=  "01";               -- inst from RWM
          sel_in      <=  unsigned(inst(5 downto 4));   -- r1; reg to save to
          rw_reg      <=  '0';
          program_counter <= program_counter + 1;
          state <= 1;

        -- str
        when "1001" => --state <= 6;
          RWM_en      <=  '1';
          rom_enable      <=  '0';
          adr_s6         <=  inst(3 downto 0);   -- adr is connected texpressiono both RWM and ROM
          rw_RWM      <=  '0';                -- set RWM in 'write to' mode
          sel_op_1    <=  unsigned(inst(5 downto 4));
          out_en      <=  '1';
          program_counter <= program_counter + 1;
          state <= 1;

        -- ldi
        when "1010" => --state <= 7;
          sel_in      <=  unsigned(inst(5 downto 4));
          sel_mux     <=  "10";
          data_imm    <=  inst(3 downto 0);
          program_counter <= program_counter + 1;
          state <= 1;

        -- nop
        when "1011" =>
          program_counter <= program_counter + 1;
          state <= 1;

        -- brz
        when "1100" =>
          if z_flag = '1' then
            program_counter <= to_integer(unsigned(inst( 3 downto 0)));
          else
            program_counter <= program_counter + 1;
          end if;
          state <= 1;

        -- brn
        when "1101" =>
          if n_flag = '1' then
            program_counter <= to_integer(unsigned(inst( 3 downto 0)));
          else
            program_counter <= program_counter + 1;
          end if;
          state <= 1;

        -- bro
        when "1110" =>
          if o_flag = '1' then
            program_counter <= to_integer(unsigned(inst( 3 downto 0)));
          else
            program_counter <= program_counter + 1;
          end if;
          state <= 1;

        -- bra
        when "1111" =>
          program_counter <= to_integer(unsigned(inst(3 downto 0)));
          state <= 1;

        when others => state <= 0;
      end case;
    end if;
  end process;

  -- ALU : process(clk, state) -- ALU
  -- begin
  --  if rising_edge(clk) and state = 4 then
  --   end if;
  -- end process;
  --
  -- LOADD : process(clk, state) -- r1 = <mem>
  -- begin
  --   if rising_edge(clk) and state = 5 then
  --   end if;
  -- end process;
  --
  -- STORED : process(clk, state) -- <mem> = r1
  -- begin
  --   if rising_edge(clk) and state = 6 then
  --   end if;
  -- end process;
  --
  -- LOADI : process(clk, state) -- r1 = d1d2d3d4
  -- begin
  --   if rising_edge(clk) and state = 7 then
  --   end if;
  -- end process;

  adr   <=  adr_s1 when state = 1 else
            adr_s5 when state = 5 else
            adr_s6 when state = 6 else
            (others => 'X');
  ROM_en <= rom_enable;
end architecture;
