-- Lab 0
-- Test bench for a NAND gate

Entity test is

End test;

Architecture testNand of test is

  Component nandgate
    port (
      A: in bit;
      B: in bit;
      Q: out bit
    );
  End Component;

  Signal testVector: BIT_VECTOR (1 downto 0);
  Signal result: bit;

Begin

  C1: nandgate Port Map (
    A => testVector(1),
    B => testVector(0),
    Q => result
  );

  testVector <= "00",
    "01" After 10 ns,
    "11" After 20 ns,
    "10" After 30 ns,
    "00" After 40 ns;

  End testNand;
