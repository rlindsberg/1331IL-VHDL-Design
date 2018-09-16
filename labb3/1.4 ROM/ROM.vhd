Entity ROM is
  Port(
    addr: in address_bus;
    data: out instruction_bus;
    ce: in std_logic
  );
End;

Architecture behavioural of ROM is
  Type InstructionMem is array (0 to 15) of instruction_bus;
  Signal memory: InstructionMem;

  Begin
    -- define memory instruction set
    memory(0)  <= "1010110011"; -- LDI R3,  3
    memory(1)  <= "1001011110"; -- STR R3, 14
    memory(2)  <= "1010010001"; -- LDI R1,  1
    memory(3)  <= "1000001110"; -- LDR R0, 14
    memory(4)  <= "0110000010"; -- MOV r0, R2
    memory(5)  <= "0000100110"; -- ADD R2, R1, R2
    memory(6)  <= "0001000100"; -- SUB R0, R1, R0
    memory(7)  <= "1100001100"; -- BRZ 12
    memory(8)  <= "1011000000"; -- NOP
    memory(9)  <= "1111000101"; -- BRA 5
    memory(10) <= "1011000000"; -- NOP
    memory(11) <= "1011000000"; -- NOP
    memory(12) <= "1001101111"; -- STR R2, 15
    memory(13) <= "1111001101"; -- BRA 13
    memory(14) <= "1011000000"; -- NOP
    memory(15) <= "1011000000"; -- NOP

    Process
      Begin

End behavioural;
