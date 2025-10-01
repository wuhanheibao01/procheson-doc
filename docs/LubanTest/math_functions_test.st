(*
===============================================
  PLC数学函数指令测试程序
  程序名称: MathFunctionsTest
  创建日期: 2025-08-30
  测试人员: 汪勇强
  联系方式: 13971612060
  QQ号码: 94114148
  
  测试目的: 验证PLC数学函数指令的功能正确性
  适用环境: Beremiz (IEC 61131-3标准)
  
  测试函数: ABS、ACOS、ASIN、ATAN、COS、EXP、LN、LOG、SIN、SQRT、TAN
===============================================
*)

PROGRAM MathFunctionsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 *)
 TestValue1 : REAL;      (* -5.5 用于ABS测试 *)
 TestValue2 : REAL;      (* 0.5 用于三角函数测试 *)
 TestValue3 : REAL;      (* 2.0 用于指数对数测试 *)
 TestValue4 : REAL;      (* 25.0 用于SQRT测试 *)
 TestAngle : REAL;       (* 0.7854 (π/4) 用于三角函数 *)
 
 (* ABS测试结果变量 *)
 ABSResult : REAL;
 
 (* 三角函数测试结果变量 *)
 ACOSResult : REAL;
 ASINResult : REAL;
 ATANResult : REAL;
 COSResult : REAL;
 SINResult : REAL;
 TANResult : REAL;
 
 (* 指数对数函数测试结果变量 *)
 EXPResult : REAL;
 LNResult : REAL;
 LOGResult : REAL;
 
 (* 平方根测试结果变量 *)
 SQRTResult : REAL;
 
 (* 期望结果变量 *)
 ExpectedReal : REAL;
 
 (* 测试结果判断变量 *)
 ABSOK : BOOL;
 ACOSOK : BOOL;
 ASINOK : BOOL;
 ATANOG : BOOL;
 COSOK : BOOL;
 SINOK : BOOL;
 TANOG : BOOL;
 EXPOK : BOOL;
 LNOK : BOOL;
 LOGOK : BOOL;
 SQRTOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
 
 (* 比较误差容差 *)
 Tolerance : REAL;
 ResultDiff : REAL;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  TestValue1 := -5.5;     (* 负数，用于ABS测试 *)
  TestValue2 := 0.5;      (* 0-1之间，用于ACOS/ASIN测试 *)
  TestValue3 := 2.0;      (* 正数，用于指数对数测试 *)
  TestValue4 := 25.0;     (* 完全平方数，用于SQRT测试 *)
  TestAngle := 0.7854;    (* π/4 ≈ 45度，用于三角函数测试 *)
  
  Tolerance := 0.01;      (* 浮点数比较容差 *)

  IF Enable THEN
      
      (* ABS测试 - 绝对值 *)
      TestStep := 1;
      ABSResult := ABS(TestValue1);
      ExpectedReal := 5.5;    (* ABS(-5.5) = 5.5 *)
      ResultDiff := ABSResult - ExpectedReal;
      ABSOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* ACOS测试 - 反余弦 *)
      TestStep := 2;
      ACOSResult := ACOS(TestValue2);
      ExpectedReal := 1.047;  (* ACOS(0.5) ≈ 1.047弧度 (60度) *)
      ResultDiff := ACOSResult - ExpectedReal;
      ACOSOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* ASIN测试 - 反正弦 *)
      TestStep := 3;
      ASINResult := ASIN(TestValue2);
      ExpectedReal := 0.524;  (* ASIN(0.5) ≈ 0.524弧度 (30度) *)
      ResultDiff := ASINResult - ExpectedReal;
      ASINOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* ATAN测试 - 反正切 *)
      TestStep := 4;
      ATANResult := ATAN(1.0);
      ExpectedReal := 0.7854; (* ATAN(1.0) ≈ 0.7854弧度 (45度) *)
      ResultDiff := ATANResult - ExpectedReal;
      ATANOG := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* COS测试 - 余弦 *)
      TestStep := 5;
      COSResult := COS(TestAngle);
      ExpectedReal := 0.707;  (* COS(π/4) ≈ 0.707 *)
      ResultDiff := COSResult - ExpectedReal;
      COSOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* SIN测试 - 正弦 *)
      TestStep := 6;
      SINResult := SIN(TestAngle);
      ExpectedReal := 0.707;  (* SIN(π/4) ≈ 0.707 *)
      ResultDiff := SINResult - ExpectedReal;
      SINOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* TAN测试 - 正切 *)
      TestStep := 7;
      TANResult := TAN(TestAngle);
      ExpectedReal := 1.0;    (* TAN(π/4) = 1.0 *)
      ResultDiff := TANResult - ExpectedReal;
      TANOG := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* EXP测试 - 自然指数 *)
      TestStep := 8;
      EXPResult := EXP(TestValue3);
      ExpectedReal := 7.389;  (* EXP(2.0) ≈ 7.389 *)
      ResultDiff := EXPResult - ExpectedReal;
      EXPOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* LN测试 - 自然对数 *)
      TestStep := 9;
      LNResult := LN(TestValue3);
      ExpectedReal := 0.693;  (* LN(2.0) ≈ 0.693 *)
      ResultDiff := LNResult - ExpectedReal;
      LNOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* LOG测试 - 常用对数(以10为底) *)
      TestStep := 10;
      LOGResult := LOG(100.0);
      ExpectedReal := 2.0;    (* LOG(100) = 2.0 *)
      ResultDiff := LOGResult - ExpectedReal;
      LOGOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* SQRT测试 - 平方根 *)
      TestStep := 11;
      SQRTResult := SQRT(TestValue4);
      ExpectedReal := 5.0;    (* SQRT(25.0) = 5.0 *)
      ResultDiff := SQRTResult - ExpectedReal;
      SQRTOK := (ResultDiff < Tolerance) AND (ResultDiff > -Tolerance);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT ABSOK THEN Errors := Errors + 1; END_IF;
      IF NOT ACOSOK THEN Errors := Errors + 1; END_IF;
      IF NOT ASINOK THEN Errors := Errors + 1; END_IF;
      IF NOT ATANOG THEN Errors := Errors + 1; END_IF;
      IF NOT COSOK THEN Errors := Errors + 1; END_IF;
      IF NOT SINOK THEN Errors := Errors + 1; END_IF;
      IF NOT TANOG THEN Errors := Errors + 1; END_IF;
      IF NOT EXPOK THEN Errors := Errors + 1; END_IF;
      IF NOT LNOK THEN Errors := Errors + 1; END_IF;
      IF NOT LOGOK THEN Errors := Errors + 1; END_IF;
      IF NOT SQRTOK THEN Errors := Errors + 1; END_IF;
      
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