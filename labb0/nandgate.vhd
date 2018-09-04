ENTITY nandgate IS
  PORT(
    A: IN BIT;
    B: IN BIT;
    Q: OUT BIT -- NB! No ‘;’ here!
  );
END nandgate;

ARCHITECTURE dataflow OF nandgate IS
  SIGNAL Q_prim: BIT;

BEGIN
  -- All statements in the architecture are executed in parallel.

  Q_prim <= A AND B; -- The AND-operation. (1)
  Q <= NOT Q_prim; -- The inverter. (2)

END dataflow;
