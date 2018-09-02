-- Lab 0
-- Test bench for 2:1 MUX

Entity test is End test;

Architecture testMux of test is

  Component mux
    Port(
      D0: IN Bit; -- Input data signal A.
      D1: IN Bit; -- Input data signal B.
      S: IN Bit; -- Control signal.
      Z: OUT Bit -- Output data signal.
    );

  End Component;

  -- D0, D1 and S
  Signal testVector: BIT_VECTOR(2 downto 0);
  Signal result: Bit;

  Begin

    C1: mux Port Map(
      D0 => testVector(2),
      D1 => testVector(1),
      S => testVector(0),
      Z => result
      );

    testVector <=
      "001",
      "101" AFTER 10 ns,
      "011" AFTER 15 ns,
      "111" AFTER 20 ns,
      "000" AFTER 25 ns,
      "100" AFTER 30 ns,
      "010" AFTER 35 ns,
      "110" AFTER 40 ns;

  End testMux;
