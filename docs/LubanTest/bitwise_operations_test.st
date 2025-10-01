PROGRAM BitwiseOperationsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 *)
 TestByte1 : BYTE;
 TestByte2 : BYTE;
 TestWord1 : WORD;
 TestWord2 : WORD;
 TestDWord1 : DWORD;
 TestDWord2 : DWORD;
 
 (* AND测试结果变量 *)
 ANDByteResult : BYTE;
 ANDWordResult : WORD;
 ANDDWordResult : DWORD;
 
 (* OR测试结果变量 *)
 ORByteResult : BYTE;
 ORWordResult : WORD;
 ORDWordResult : DWORD;
 
 (* XOR测试结果变量 *)
 XORByteResult : BYTE;
 XORWordResult : WORD;
 XORDWordResult : DWORD;
 
 (* NOT测试结果变量 *)
 NOTByteResult : BYTE;
 NOTWordResult : WORD;
 NOTDWordResult : DWORD;
 
 (* 期望结果变量 *)
 ExpectedByte : BYTE;
 ExpectedWord : WORD;
 ExpectedDWord : DWORD;
 
 (* 测试结果判断变量 *)
 ANDByteOK : BOOL;
 ANDWordOK : BOOL;
 ANDDWordOK : BOOL;
 ORByteOK : BOOL;
 ORWordOK : BOOL;
 ORDWordOK : BOOL;
 XORByteOK : BOOL;
 XORWordOK : BOOL;
 XORDWordOK : BOOL;
 NOTByteOK : BOOL;
 NOTWordOK : BOOL;
 NOTDWordOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  TestByte1 := 16#F0;     (* 11110000 *)
  TestByte2 := 16#AA;     (* 10101010 *)
  TestWord1 := 16#FF00;   (* 1111111100000000 *)
  TestWord2 := 16#AAAA;   (* 1010101010101010 *)
  TestDWord1 := 16#FFFF0000; (* 11111111111111110000000000000000 *)
  TestDWord2 := 16#AAAAAAAA; (* 10101010101010101010101010101010 *)

  IF Enable THEN
      
      (* AND BYTE测试 - 按位与 *)
      TestStep := 1;
      ANDByteResult := AND(TestByte1, TestByte2);
      (* F0 AND AA = 11110000 AND 10101010 = 10100000 = A0 *)
      ExpectedByte := 16#A0;
      ANDByteOK := (ANDByteResult = ExpectedByte);
      
      (* AND WORD测试 - 按位与 *)
      TestStep := 2;
      ANDWordResult := AND(TestWord1, TestWord2);
      (* FF00 AND AAAA = 1111111100000000 AND 1010101010101010 = 1010101000000000 = AA00 *)
      ExpectedWord := 16#AA00;
      ANDWordOK := (ANDWordResult = ExpectedWord);
      
      (* AND DWORD测试 - 按位与 *)
      TestStep := 3;
      ANDDWordResult := AND(TestDWord1, TestDWord2);
      (* FFFF0000 AND AAAAAAAA = AAAA0000 *)
      ExpectedDWord := 16#AAAA0000;
      ANDDWordOK := (ANDDWordResult = ExpectedDWord);
      
      (* OR BYTE测试 - 按位或 *)
      TestStep := 4;
      ORByteResult := OR(TestByte1, TestByte2);
      (* F0 OR AA = 11110000 OR 10101010 = 11111010 = FA *)
      ExpectedByte := 16#FA;
      ORByteOK := (ORByteResult = ExpectedByte);
      
      (* OR WORD测试 - 按位或 *)
      TestStep := 5;
      ORWordResult := OR(TestWord1, TestWord2);
      (* FF00 OR AAAA = 1111111100000000 OR 1010101010101010 = 1111111110101010 = FFAA *)
      ExpectedWord := 16#FFAA;
      ORWordOK := (ORWordResult = ExpectedWord);
      
      (* OR DWORD测试 - 按位或 *)
      TestStep := 6;
      ORDWordResult := OR(TestDWord1, TestDWord2);
      (* FFFF0000 OR AAAAAAAA = FFFFAAAA *)
      ExpectedDWord := 16#FFFFAAAA;
      ORDWordOK := (ORDWordResult = ExpectedDWord);
      
      (* XOR BYTE测试 - 按位异或 *)
      TestStep := 7;
      XORByteResult := XOR(TestByte1, TestByte2);
      (* F0 XOR AA = 11110000 XOR 10101010 = 01011010 = 5A *)
      ExpectedByte := 16#5A;
      XORByteOK := (XORByteResult = ExpectedByte);
      
      (* XOR WORD测试 - 按位异或 *)
      TestStep := 8;
      XORWordResult := XOR(TestWord1, TestWord2);
      (* FF00 XOR AAAA = 1111111100000000 XOR 1010101010101010 = 0101010110101010 = 55AA *)
      ExpectedWord := 16#55AA;
      XORWordOK := (XORWordResult = ExpectedWord);
      
      (* XOR DWORD测试 - 按位异或 *)
      TestStep := 9;
      XORDWordResult := XOR(TestDWord1, TestDWord2);
      (* FFFF0000 XOR AAAAAAAA = 5555AAAA *)
      ExpectedDWord := 16#5555AAAA;
      XORDWordOK := (XORDWordResult = ExpectedDWord);
      
      (* NOT BYTE测试 - 按位非 *)
      TestStep := 10;
      NOTByteResult := NOT(TestByte1);
      (* NOT F0 = NOT 11110000 = 00001111 = 0F *)
      ExpectedByte := 16#0F;
      NOTByteOK := (NOTByteResult = ExpectedByte);
      
      (* NOT WORD测试 - 按位非 *)
      TestStep := 11;
      NOTWordResult := NOT(TestWord1);
      (* NOT FF00 = NOT 1111111100000000 = 0000000011111111 = 00FF *)
      ExpectedWord := 16#00FF;
      NOTWordOK := (NOTWordResult = ExpectedWord);
      
      (* NOT DWORD测试 - 按位非 *)
      TestStep := 12;
      NOTDWordResult := NOT(TestDWord1);
      (* NOT FFFF0000 = 0000FFFF *)
      ExpectedDWord := 16#0000FFFF;
      NOTDWordOK := (NOTDWordResult = ExpectedDWord);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT ANDByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT ANDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT ANDDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT ORByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT ORWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT ORDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT XORByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT XORWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT XORDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT NOTByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT NOTWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT NOTDWordOK THEN Errors := Errors + 1; END_IF;
      
      TestsPassed := (Errors = 0);
      Complete := TRUE;
      
      IF TestsPassed THEN
          TestStep := 99;  (* 所有测试通过 *)
      ELSE
          TestStep := 88;  (* 有测试失败 *)
      END_IF;

  ELSE
      TestStep := 0;
      Complete := FALSE;
      TestsPassed := FALSE;
      Errors := 0;
  END_IF;

END_PROGRAM