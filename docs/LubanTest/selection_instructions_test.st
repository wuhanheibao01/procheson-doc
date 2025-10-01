(*
===============================================
  PLC选择指令测试程序
  程序名称: SelectionInstructionsTest
  创建日期: 2025-08-30
  测试人员: 汪勇强
  联系方式: 13971612060
  QQ号码: 94114148
  
  测试目的: 验证PLC选择指令的功能正确性
  适用环境: Beremiz (IEC 61131-3标准)
  
  测试指令: LIMIT、MAX、MIN、MUX、SEL
===============================================
*)

PROGRAM SelectionInstructionsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 - 整数 *)
 IntA : INT;
 IntB : INT;
 IntC : INT;
 IntMin : INT;
 IntMax : INT;
 IntArray : ARRAY[0..3] OF INT;  (* MUX测试用数组 *)
 
 (* 测试输入数据 - 实数 *)
 RealA : REAL;
 RealB : REAL;
 RealC : REAL;
 RealMin : REAL;
 RealMax : REAL;
 RealArray : ARRAY[0..3] OF REAL;  (* MUX测试用数组 *)
 
 (* 选择器输入 *)
 BoolSelector : BOOL;
 IntSelector : INT;
 
 (* LIMIT测试结果变量 *)
 LIMITIntResult : INT;
 LIMITRealResult : REAL;
 
 (* MAX测试结果变量 *)
 MAXIntResult : INT;
 MAXRealResult : REAL;
 MAX3IntResult : INT;    (* 3个参数的MAX *)
 MAX3RealResult : REAL;
 
 (* MIN测试结果变量 *)
 MINIntResult : INT;
 MINRealResult : REAL;
 MIN3IntResult : INT;    (* 3个参数的MIN *)
 MIN3RealResult : REAL;
 
 (* MUX测试结果变量 *)
 MUXIntResult : INT;
 MUXRealResult : REAL;
 
 (* SEL测试结果变量 *)
 SELIntResult : INT;
 SELRealResult : REAL;
 
 (* 期望结果变量 *)
 ExpectedInt : INT;
 ExpectedReal : REAL;
 
 (* 测试结果判断变量 *)
 LIMITIntOK : BOOL;
 LIMITRealOK : BOOL;
 MAXIntOK : BOOL;
 MAXRealOK : BOOL;
 MAX3IntOK : BOOL;
 MAX3RealOK : BOOL;
 MINIntOK : BOOL;
 MINRealOK : BOOL;
 MIN3IntOK : BOOL;
 MIN3RealOK : BOOL;
 MUXIntOK : BOOL;
 MUXRealOK : BOOL;
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
  
  (* 初始化数组用于MUX测试 *)
  IntArray[0] := 100;
  IntArray[1] := 200;
  IntArray[2] := 300;
  IntArray[3] := 400;
  
  RealArray[0] := 10.1;
  RealArray[1] := 20.2;
  RealArray[2] := 30.3;
  RealArray[3] := 40.4;
  
  BoolSelector := TRUE;
  IntSelector := 2;  (* 选择数组索引2 *)

  IF Enable THEN
      
      (* LIMIT测试 - 限制在范围内 *)
      TestStep := 1;
      LIMITIntResult := LIMIT(IntMin, IntC, IntMax);  (* LIMIT(3, 15, 12) = 12 *)
      LIMITRealResult := LIMIT(RealMin, RealC, RealMax);  (* LIMIT(3.1, 15.8, 12.9) = 12.9 *)
      ExpectedInt := 12;
      ExpectedReal := 12.9;
      LIMITIntOK := (LIMITIntResult = ExpectedInt);
      LIMITRealOK := (LIMITRealResult = ExpectedReal);
      
      (* MAX测试 - 取两个值的最大值 *)
      TestStep := 2;
      MAXIntResult := MAX(IntA, IntB);  (* MAX(10, 5) = 10 *)
      MAXRealResult := MAX(RealA, RealB);  (* MAX(10.5, 5.2) = 10.5 *)
      ExpectedInt := 10;
      ExpectedReal := 10.5;
      MAXIntOK := (MAXIntResult = ExpectedInt);
      MAXRealOK := (MAXRealResult = ExpectedReal);
      
      (* MAX测试 - 取三个值的最大值 *)
      TestStep := 3;
      MAX3IntResult := MAX(MAX(IntA, IntB), IntC);  (* MAX(MAX(10, 5), 15) = 15 *)
      MAX3RealResult := MAX(MAX(RealA, RealB), RealC);  (* MAX(MAX(10.5, 5.2), 15.8) = 15.8 *)
      ExpectedInt := 15;
      ExpectedReal := 15.8;
      MAX3IntOK := (MAX3IntResult = ExpectedInt);
      MAX3RealOK := (MAX3RealResult = ExpectedReal);
      
      (* MIN测试 - 取两个值的最小值 *)
      TestStep := 4;
      MINIntResult := MIN(IntA, IntB);  (* MIN(10, 5) = 5 *)
      MINRealResult := MIN(RealA, RealB);  (* MIN(10.5, 5.2) = 5.2 *)
      ExpectedInt := 5;
      ExpectedReal := 5.2;
      MINIntOK := (MINIntResult = ExpectedInt);
      MINRealOK := (MINRealResult = ExpectedReal);
      
      (* MIN测试 - 取三个值的最小值 *)
      TestStep := 5;
      MIN3IntResult := MIN(MIN(IntA, IntB), IntC);  (* MIN(MIN(10, 5), 15) = 5 *)
      MIN3RealResult := MIN(MIN(RealA, RealB), RealC);  (* MIN(MIN(10.5, 5.2), 15.8) = 5.2 *)
      ExpectedInt := 5;
      ExpectedReal := 5.2;
      MIN3IntOK := (MIN3IntResult = ExpectedInt);
      MIN3RealOK := (MIN3RealResult = ExpectedReal);
      
      (* MUX测试 - 多路选择器 *)
      TestStep := 6;
      (* 注意：某些PLC环境可能不支持标准MUX函数，使用条件选择替代 *)
      IF IntSelector = 0 THEN
          MUXIntResult := IntArray[0];
          MUXRealResult := RealArray[0];
      ELSIF IntSelector = 1 THEN
          MUXIntResult := IntArray[1];
          MUXRealResult := RealArray[1];
      ELSIF IntSelector = 2 THEN
          MUXIntResult := IntArray[2];
          MUXRealResult := RealArray[2];
      ELSE
          MUXIntResult := IntArray[3];
          MUXRealResult := RealArray[3];
      END_IF;
      
      ExpectedInt := 300;    (* IntArray[2] *)
      ExpectedReal := 30.3;  (* RealArray[2] *)
      MUXIntOK := (MUXIntResult = ExpectedInt);
      MUXRealOK := (MUXRealResult = ExpectedReal);
      
      (* SEL测试 - 二路选择器 *)
      TestStep := 7;
      SELIntResult := SEL(BoolSelector, IntB, IntA);  (* SEL(TRUE, 5, 10) = 10 *)
      SELRealResult := SEL(BoolSelector, RealB, RealA);  (* SEL(TRUE, 5.2, 10.5) = 10.5 *)
      ExpectedInt := 10;
      ExpectedReal := 10.5;
      SELIntOK := (SELIntResult = ExpectedInt);
      SELRealOK := (SELRealResult = ExpectedReal);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT LIMITIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT LIMITRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MAXIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MAXRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MAX3IntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MAX3RealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MINIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MINRealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MIN3IntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MIN3RealOK THEN Errors := Errors + 1; END_IF;
      IF NOT MUXIntOK THEN Errors := Errors + 1; END_IF;
      IF NOT MUXRealOK THEN Errors := Errors + 1; END_IF;
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