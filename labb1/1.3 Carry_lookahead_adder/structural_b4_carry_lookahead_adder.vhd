Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
Use WORK.ALL;

Entity structural_b4_carry_lookahead_adder is
  Port(
    A: IN std_logic_vector(3 downto 0);
    B: IN std_logic_vector(3 downto 0);
    Sum: OUT std_logic_vector(3 downto 0);
	 Carry: out std_logic
    );
End structural_b4_carry_lookahead_adder;


Architecture behavioural of structural_b4_carry_lookahead_adder is

  Component full_adder is
    Port (
      A: IN std_logic;
      B: IN	std_logic;
      Cin: IN	std_logic;
      Carry: OUT std_logic;
      Sum: OUT std_logic
    );
  End Component;

  Signal w_G: std_logic_vector(3 downto 0); -- Generate
  Signal w_P: std_logic_vector(3 downto 0); -- Propagate
  Signal w_C: std_logic_vector(3 downto 0); -- Carry

  Signal w_SUM: std_logic_vector(3 downto 0);

Begin

  FULL_ADDER_BIT_0 : full_adder
    Port map (
      A  => A(0),
      B  => B(0),
      Cin => w_C(0),
      Sum   => w_SUM(0),
      Carry => open
      );

  FULL_ADDER_BIT_1 : full_adder
    Port map (
      A  => A(1),
      B  => B(1),
      Cin => w_C(1),
      Sum   => w_SUM(1),
      Carry => open
      );

  FULL_ADDER_BIT_2 : full_adder
    Port map (
      A  => A(2),
      B  => B(2),
      Cin => w_C(2),
      Sum   => w_SUM(2),
      Carry => open
      );

  FULL_ADDER_BIT_3 : full_adder
    Port map (
      A  => A(3),
      B  => B(3),
      Cin => w_C(3),
      Sum   => w_SUM(3),
      Carry => open
      );

  -- Create the Generate (G) Terms:  Gi=Ai*Bi
  w_G(0) <= A(0) and B(0);
  w_G(1) <= A(1) and B(1);
  w_G(2) <= A(2) and B(2);
  w_G(3) <= A(3) and B(3);

  -- Create the Propagate Terms: Pi=Ai+Bi
  w_P(0) <= A(0) or B(0);
  w_P(1) <= A(1) or B(1);
  w_P(2) <= A(2) or B(2);
  w_P(3) <= A(3) or B(3);

  -- Create the Carry Terms:
  w_C(0) <= '0'; -- no carry input
  w_C(1) <= w_G(0) or (w_P(0) and w_C(0));
  w_C(2) <= w_G(1) or (w_P(1) and w_C(1));
  w_C(3) <= w_G(2) or (w_P(2) and w_C(2));
  --w_C(4) <= w_G(3) or (w_P(3) and w_C(3));

  -- Final Answer
  --Sum <= w_C(4) & w_SUM;  -- VHDL Concatenation
  Sum <= w_SUM;
  Carry <= w_G(3) or (w_P(3) and w_C(3));
  

end behavioural;
