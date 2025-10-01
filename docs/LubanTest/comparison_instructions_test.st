(*
===============================================
  PLC比较指令测试程序
  程序名称: ComparisonInstructionsTest
  创建日期: 2025-08-30
  测试人员: 汪勇强
  联系方式: 13971612060
  QQ号码: 94114148
  
  测试目的: 验证PLC比较指令的功能正确性
  适用环境: Beremiz (IEC 61131-3标准)
===============================================
*)

PROGRAM ComparisonInstructionsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 - 整数 *)
 IntA : INT;
 IntB : INT;
 IntC : INT;
 IntMin : INT;
 IntMax : INT;
 
 (* 测试输入数据 - 实数 *)
 RealA : REAL;
 RealB : REAL;
 RealC : REAL;
 RealMin : REAL;
 RealMax : REAL;
 
 (* 选择器输入 *)
 Selector : BOOL;
 
 (* EQ测试结果变量 *)
 EQIntResult : BOOL;
 EQRealResult : BOOL;
 
 (* NE测试结果变量 *)
 NEIntResult : BOOL;
 NERealResult : BOOL;
 
 (* LT测试结果变量 *)
 LTIntResult : BOOL;
 LTRealResult : BOOL;
 
 (* LE测试结果变量 *)
 LEIntResult : BOOL;
 LERealResult : BOOL;
 
 (* GT测试结果变量 *)
 GTIntResult : BOOL;
 GTRealResult : BOOL;
 
 (* GE测试结果变量 *)
 GEIntResult : BOOL;
 GERealResult : BOOL;
 
 (* LIMIT测试结果变量 *)
 LIMITIntResult : INT;
 LIMITRealResult : REAL;
 
 (* MAX测试结果变量 *)
 MAXIntResult : INT;
 MAXRealResult : REAL;
 
 (* MIN测试结果变量 *)
 MINIntResult : INT;
 MINRealResult : REAL;
 
 (* SEL测试结果变量 *)
 SELIntResult : INT;
 SELRealResult : REAL;
 
 (* 期望结果变量 *)
 ExpectedBool : BOOL;
 ExpectedInt : INT;
 ExpectedReal : REAL;
 
 (* 测试结果判断变量 *)
 EQIntOK : BOOL;
 EQRealOK : BOOL;
 NEIntOK : BOOL;
 NERealOK : BOOL;
 LTIntOK : BOOL;
 LTRealOK : BOOL;
 LEIntOK : BOOL;
 LERealOK : BOOL;
 GTIntOK : BOOL;
 GTRealOK : BOOL;
 GEIntOK : BOOL;
 GERealOK : BOOL;
 LIMITIntOK : BOOL;
 LIMITRealOK : BOOL;
 MAXIntOK : BOOL;
 MAXRealOK : BOOL;
 MINIntOK : BOOL;
 MINRealOK : BOOL;
 SELIntOK : BOOL;
 SELRealOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  IntA := 10;
  IntB := 5;
  IntC := 15;
  IntMin := 3;
  IntMax := 12;
  
  RealA := 10.5;
  RealB := 5.2;
  RealC := 15.8;
  RealMin := 3.1;
  RealMax := 12.9;
  
  Selector := TRUE;

  IF Enable THEN
      
      (* EQ测试 - 等于比较 *)
      TestStep := 1;
      EQIntResult := EQ(IntA, IntA);  (* 10 = 10 *)
      EQRealResult := EQ(RealA, RealA);  (* 10.5 = 10.5 *)
      ExpectedBool := TRUE;
      EQIntOK := (EQIntResult = ExpectedBool);
      EQRealOK := (EQRealResult = ExpectedBool);
      
      (* NE测试 - 不等于比较 *)
      TestStep := 2;
      NEIntResult := NE(IntA, IntB);  (* 10 <> 5 *)
      NERealResult := NE(RealA, RealB);  (* 10.5 <> 5.2 *)
      ExpectedBool := TRUE;
      NEIntOK := (NEIntResult = ExpectedBool);
      NERealOK := (NERealResult = ExpectedBool);
      
      (* LT测试 - 小于比较 *)
      TestStep := 3;
      LTIntResult := LT(IntB, IntA);  (* 5 < 10 *)
      LTRealResult := LT(RealB, RealA);  (* 5.2 < 10.5 *)
      ExpectedBool := TRUE;
      LTIntOK := (LTIntResult = ExpectedBool);
      LTRealOK := (LTRealResult = ExpectedBool);
      
      (* LE测试 - 小于等于比较 *)
      TestStep := 4;
      LEIntResult := LE(IntA, IntA);  (* 10 <= 10 *)
      LERealResult := LE(RealB, RealA);  (* 5.2 <= 10.5 *)
      ExpectedBool := TRUE;
      LEIntOK := (LEIntResult = ExpectedBool);
      LERealOK := (LERealResult = ExpectedBool);
      
      (* GT测试 - 大于比较 *)
      TestStep := 5;
      GTIntResult := GT(IntA, IntB);  (* 10 > 5 *)
      GTRealResult := GT(RealA, RealB);  (* 10.5 > 5.2 *)
      ExpectedBool := TRUE;
      GTIntOK := (GTIntResult = ExpectedBool);
      GTRealOK := (GTRealResult = ExpectedBool);
      
      (* GE测试 - 大于等于比较 *)
      TestStep := 6;
      GEIntResult := GE(IntA, IntA);  (* 10 >= 10 *)
      GERealResult := GE(RealA, RealB);  (* 10.5 >= 5.2 *)
      ExpectedBool := TRUE;
      GEIntOK := (GEIntResult = ExpectedBool);
      GERealOK := (GERealResult = ExpectedBool);
      
      (* LIMIT测试 - 限制在范围内 *)
      TestStep := 7;
      LIMITIntResult := LIMIT(IntMin, IntC, IntMax);  (* LIMIT(3, 15, 12) = 12 *)
      LIMITRealResult := LIMIT(RealMin, RealC, RealMax);  (* LIMIT(3.1, 15.8, 12.9) = 12.9 *)
      ExpectedInt := 12;
      ExpectedReal := 12.9;
      LIMITIntOK := (LIMITIntResult = ExpectedInt);
      LIMITRealOK := (LIMITRealResult = ExpectedReal);
      
      (* MAX测试 - 取最大值 *)
      TestStep := 8;
      MAXIntResult := MAX(IntA, IntB);  (* MAX(10, 5) = 10 *)
      MAXRealResult := MAX(RealA, RealB);  (* MAX(10.5, 5.2) = 10.5 *)
      ExpectedInt := 10;
      ExpectedReal := 10.5;
      MAXIntOK := (MAXIntResult = ExpectedInt);
      MAXRealOK := (MAXRealResult = ExpectedReal);
      
      (* MIN测试 - 取最小值 *)
      TestStep := 9;
      MINIntResult := MIN(IntA, IntB);  (* MIN(10, 5) = 5 *)
      MINRealResult := MIN(RealA, RealB);  (* MIN(10.5, 5.2) = 5.2 *)
      ExpectedInt := 5;
      ExpectedReal := 5.2;
      MINIntOK := (MINIntResult = ExpectedInt);
      MINRealOK := (MINRealResult = ExpectedReal);
      
      (* SEL测试 - 选择 *)
      TestStep := 10;
      SELIntResult := SEL(Selector, IntB, IntA);  (* SEL(TRUE, 5, 10) = 10 *)
      SELRealResult := SEL(Selector, RealB, RealA);  (* SEL(TRUE, 5.2, 10.5) = 10.5 *)
      ExpectedInt := 10;
      ExpectedReal := 10.5;
      SELIntOK := (SELIntResult = ExpectedInt);
      SELRealOK := (SELRealResult = ExpectedReal);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT EQIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT EQRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT NEIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT NERealOK THEN Errors := Errors + 1; END_IF;
      IF NOT LTIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT LTRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT LEIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT LERealOK THEN Errors := Errors + 1; END_IF;
      IF NOT GTIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT GTRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT GEIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT GERealOK THEN Errors := Errors + 1; END_IF;
      IF NOT LIMITIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT LIMITRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MAXIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MAXRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MINIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MINRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT SELIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT SELRealOK THEN Errors := Errors + 1; END_IF;
      
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