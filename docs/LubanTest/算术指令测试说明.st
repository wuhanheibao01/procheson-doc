PROGRAM SimpleArithmeticTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 IntA : INT;
 IntB : INT;
 IntResult : INT;
 RealA : REAL;
 RealB : REAL;
 RealResult : REAL;
 RealDiff : REAL;
 SubDiff : REAL;
 MulDiff : REAL;
 DivDiff : REAL;
 ExptDiff : REAL;
 AddOK : BOOL;
 SubOK : BOOL;
 MulOK : BOOL;
 DivOK : BOOL;
 ModOK : BOOL;
 MoveOK : BOOL;
 ExptOK : BOOL;
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
END_VAR

(* 主程序开始 *)
BEGIN
  Enable := TRUE;
  IntA := 100;
  IntB := 25;
  RealA := 10.5;
  RealB := 3.2;

  IF Enable THEN
      
      (* ADD 测试 *)
      TestStep := 1;
      IntResult := ADD(IntA, IntB);
      RealResult := ADD(RealA, RealB);
      RealDiff := RealResult - 13.7;
      AddOK := (IntResult = 125) AND (RealDiff < 0.1) AND (RealDiff > -0.1);
      
      (* SUB 测试 *)
      TestStep := 2;
      IntResult := SUB(IntA, IntB);
      RealResult := SUB(RealA, RealB);
      SubDiff := RealResult - 7.3;
      SubOK := (IntResult = 75) AND (SubDiff < 0.1) AND (SubDiff > -0.1);
      
      (* MUL 测试 *)
      TestStep := 3;
      IntResult := MUL(IntB, 4);
      RealResult := MUL(RealA, RealB);
      MulDiff := RealResult - 33.6;
      MulOK := (IntResult = 100) AND (MulDiff < 0.1) AND (MulDiff > -0.1);
      
      (* DIV 测试 *)
      TestStep := 4;
      IntResult := DIV(IntA, IntB);
      RealResult := DIV(RealA, RealB);
      DivDiff := RealResult - 3.28125;
      DivOK := (IntResult = 4) AND (DivDiff < 0.1) AND (DivDiff > -0.1);
      
      (* MOD 测试 *)
      TestStep := 5;
      IntResult := MOD(IntA, 30);
      ModOK := (IntResult = 10);
      
      (* MOVE 测试 *)
      TestStep := 6;
      IntResult := MOVE(IntA);
      RealResult := MOVE(RealA);
      MoveOK := (IntResult = IntA) AND (RealResult = RealA);
      
      (* EXPT 测试 *)
      TestStep := 7;
      RealResult := EXPT(2.0, 3.0);
      ExptDiff := RealResult - 8.0;
      ExptOK := (ExptDiff < 0.1) AND (ExptDiff > -0.1);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT AddOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubOK THEN Errors := Errors + 1; END_IF;
      IF NOT MulOK THEN Errors := Errors + 1; END_IF;
      IF NOT DivOK THEN Errors := Errors + 1; END_IF;
      IF NOT ModOK THEN Errors := Errors + 1; END_IF;
      IF NOT MoveOK THEN Errors := Errors + 1; END_IF;
      IF NOT ExptOK THEN Errors := Errors + 1; END_IF;
      
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