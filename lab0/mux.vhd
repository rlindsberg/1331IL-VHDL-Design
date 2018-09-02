Entity mux is

Port(
  D0: IN Bit; -- Input data signal A
  D1: IN Bit; -- Input data signal B
  S : IN Bit; -- Control signal
  Z : OUT Bit --Output data signal
);
End;

Architecture rtl of mux is
  Component nandgate
    Port(
      A: IN Bit;
      B: IN Bit;
      Q: OUT Bit
    );
  End Component

  -- S_inv, Z_prim_1, Z_prim_2 are intern signals, thus:
  Signal S_inv, Z_prim_1, Z_prim_2: Bit;

Begin
  N1: nandgate Port Map(D0, S, Z_prim_1);
  N2: nandgate Port Map(S, S, S_inv);
  N3: nandgate Port Map(D1, S_inv, Z_prim_1);
  N4: nandgate Port Map(Z_prim_1, Z_prim_2, Z);
End rtl;
