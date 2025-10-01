PROGRAM ShiftInstructionsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 *)
 TestByte : BYTE;
 TestWord : WORD;
 TestDWord : DWORD;
 ShiftCount : INT;
 
 (* ROL测试结果变量 *)
 ROLByteResult : BYTE;
 ROLWordResult : WORD;
 ROLDWordResult : DWORD;
 
 (* ROR测试结果变量 *)
 RORByteResult : BYTE;
 RORWordResult : WORD;
 RORDWordResult : DWORD;
 
 (* SHL测试结果变量 *)
 SHLByteResult : BYTE;
 SHLWordResult : WORD;
 SHLDWordResult : DWORD;
 
 (* SHR测试结果变量 *)
 SHRByteResult : BYTE;
 SHRWordResult : WORD;
 SHRDWordResult : DWORD;
 
 (* 期望结果变量 *)
 ExpectedByte : BYTE;
 ExpectedWord : WORD;
 ExpectedDWord : DWORD;
 
 (* 测试结果判断变量 *)
 ROLByteOK : BOOL;
 ROLWordOK : BOOL;
 ROLDWordOK : BOOL;
 RORByteOK : BOOL;
 RORWordOK : BOOL;
 RORDWordOK : BOOL;
 SHLByteOK : BOOL;
 SHLWordOK : BOOL;
 SHLDWordOK : BOOL;
 SHRByteOK : BOOL;
 SHRWordOK : BOOL;
 SHRDWordOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  TestByte := 16#A5;      (* 10100101 *)
  TestWord := 16#1234;    (* 0001001000110100 *)
  TestDWord := 16#12345678; (* 00010010001101000101011001111000 *)
  ShiftCount := 2;        (* 移位数量 *)

  IF Enable THEN
      
      (* ROL BYTE测试 - 左循环移位 *)
      TestStep := 1;
      ROLByteResult := ROL(TestByte, ShiftCount);
      (* A5 = 10100101, 左循环移位2位 = 10010110 = 96 *)
      ExpectedByte := 16#96;
      ROLByteOK := (ROLByteResult = ExpectedByte);
      
      (* ROL WORD测试 - 左循环移位 *)
      TestStep := 2;
      ROLWordResult := ROL(TestWord, ShiftCount);
      (* 1234 = 0001001000110100, 左循环移位2位 = 0100100011010000 = 48D0 *)
      ExpectedWord := 16#48D0;
      ROLWordOK := (ROLWordResult = ExpectedWord);
      
      (* ROL DWORD测试 - 左循环移位 *)
      TestStep := 3;
      ROLDWordResult := ROL(TestDWord, ShiftCount);
      (* 12345678 左循环移位2位 = 48D159E0 *)
      ExpectedDWord := 16#48D159E0;
      ROLDWordOK := (ROLDWordResult = ExpectedDWord);
      
      (* ROR BYTE测试 - 右循环移位 *)
      TestStep := 4;
      RORByteResult := ROR(TestByte, ShiftCount);
      (* A5 = 10100101, 右循环移位2位 = 01101001 = 69 *)
      ExpectedByte := 16#69;
      RORByteOK := (RORByteResult = ExpectedByte);
      
      (* ROR WORD测试 - 右循环移位 *)
      TestStep := 5;
      RORWordResult := ROR(TestWord, ShiftCount);
      (* 1234 = 0001001000110100, 右循环移位2位 = 0000010010001101 = 048D *)
      ExpectedWord := 16#048D;
      RORWordOK := (RORWordResult = ExpectedWord);
      
      (* ROR DWORD测试 - 右循环移位 *)
      TestStep := 6;
      RORDWordResult := ROR(TestDWord, ShiftCount);
      (* 12345678 右循环移位2位 = 048D159E *)
      ExpectedDWord := 16#048D159E;
      RORDWordOK := (RORDWordResult = ExpectedDWord);
      
      (* SHL BYTE测试 - 左移位 *)
      TestStep := 7;
      SHLByteResult := SHL(TestByte, ShiftCount);
      (* A5 = 10100101, 左移位2位 = 10010100 = 94 *)
      ExpectedByte := 16#94;
      SHLByteOK := (SHLByteResult = ExpectedByte);
      
      (* SHL WORD测试 - 左移位 *)
      TestStep := 8;
      SHLWordResult := SHL(TestWord, ShiftCount);
      (* 1234 = 0001001000110100, 左移位2位 = 0100100011010000 = 48D0 *)
      ExpectedWord := 16#48D0;
      SHLWordOK := (SHLWordResult = ExpectedWord);
      
      (* SHL DWORD测试 - 左移位 *)
      TestStep := 9;
      SHLDWordResult := SHL(TestDWord, ShiftCount);
      (* 12345678 左移位2位 = 48D159E0 *)
      ExpectedDWord := 16#48D159E0;
      SHLDWordOK := (SHLDWordResult = ExpectedDWord);
      
      (* SHR BYTE测试 - 右移位 *)
      TestStep := 10;
      SHRByteResult := SHR(TestByte, ShiftCount);
      (* A5 = 10100101, 右移位2位 = 00101001 = 29 *)
      ExpectedByte := 16#29;
      SHRByteOK := (SHRByteResult = ExpectedByte);
      
      (* SHR WORD测试 - 右移位 *)
      TestStep := 11;
      SHRWordResult := SHR(TestWord, ShiftCount);
      (* 1234 = 0001001000110100, 右移位2位 = 0000010010001101 = 048D *)
      ExpectedWord := 16#048D;
      SHRWordOK := (SHRWordResult = ExpectedWord);
      
      (* SHR DWORD测试 - 右移位 *)
      TestStep := 12;
      SHRDWordResult := SHR(TestDWord, ShiftCount);
      (* 12345678 右移位2位 = 048D159E *)
      ExpectedDWord := 16#048D159E;
      SHRDWordOK := (SHRDWordResult = ExpectedDWord);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT ROLByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT ROLWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT ROLDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT RORByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT RORWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT RORDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT SHLByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT SHLWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT SHLDWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT SHRByteOK THEN Errors := Errors + 1; END_IF;
      IF NOT SHRWordOK THEN Errors := Errors + 1; END_IF;
      IF NOT SHRDWordOK THEN Errors := Errors + 1; END_IF;
      
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