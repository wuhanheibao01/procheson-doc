PROGRAM TimeArithmeticTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 时间变量 *)
 TestTime1 : TIME;
 TestTime2 : TIME;
 AddTimeResult : TIME;
 MulTimeResult : TIME;
 DivTimeResult : TIME;
 SubTimeResult : TIME;
 SubDTDTResult : TIME;
 SubDateDateResult : TIME;
 SubTODTODResult : TIME;
 
 (* 日期时间变量 *)
 TestDT1 : DATE_AND_TIME;
 TestDT2 : DATE_AND_TIME;
 AddDTTimeResult : DATE_AND_TIME;
 SubDTTimeResult : DATE_AND_TIME;
 
 (* 日期变量 *)
 TestDate1 : DATE;
 TestDate2 : DATE;
 DateResult : DATE;
 
 (* 时刻变量 *)
 TestTOD1 : TIME_OF_DAY;
 TestTOD2 : TIME_OF_DAY;
 AddTODTimeResult : TIME_OF_DAY;
 SubTODTimeResult : TIME_OF_DAY;
 
 (* 测试结果判断变量 *)
 AddTimeOK : BOOL;
 AddDTTimeOK : BOOL;
 AddTODTimeOK : BOOL;
 MulTimeOK : BOOL;
 DivTimeOK : BOOL;
 SubTimeOK : BOOL;
 SubDTDTOK : BOOL;
 SubDTTimeOK : BOOL;
 SubDateDateOK : BOOL;
 SubTODTimeOK : BOOL;
 SubTODTODOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
 
 (* 期望值比较用的临时变量 *)
 ExpectedTime : TIME;
 ExpectedDT : DATE_AND_TIME;
 ExpectedDate : DATE;
 ExpectedTOD : TIME_OF_DAY;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  TestTime1 := T#10s;          (* 10秒 *)
  TestTime2 := T#5s;           (* 5秒 *)
  
  TestDT1 := DT#2024-01-15-10:30:00;
  TestDT2 := DT#2024-01-10-08:15:00;
  
  TestDate1 := D#2024-01-15;
  TestDate2 := D#2024-01-10;
  
  TestTOD1 := TOD#10:30:00;
  TestTOD2 := TOD#08:15:00;

  IF Enable THEN
      
      (* ADD_TIME 测试 *)
      TestStep := 1;
      AddTimeResult := ADD_TIME(TestTime1, TestTime2);
      ExpectedTime := T#15s;
      AddTimeOK := (AddTimeResult = ExpectedTime);
      
      (* ADD_DT_TIME 测试 - 日期时间加时间 *)
      TestStep := 2;
      AddDTTimeResult := ADD_DT_TIME(TestDT1, TestTime1);
      (* 期望结果：2024-01-15-10:30:10 *)
      ExpectedDT := DT#2024-01-15-10:30:10;
      AddDTTimeOK := (AddDTTimeResult = ExpectedDT);
      
      (* ADD_TOD_TIME 测试 - 时刻加时间 *)
      TestStep := 3;
      AddTODTimeResult := ADD_TOD_TIME(TestTOD1, TestTime1);
      (* 期望结果：10:30:10 *)
      ExpectedTOD := TOD#10:30:10;
      AddTODTimeOK := (AddTODTimeResult = ExpectedTOD);
      
      (* MULTIME 测试 - 时间乘以数值 *)
      TestStep := 4;
      MulTimeResult := MULTIME(TestTime2, 3);
      ExpectedTime := T#15s;  (* 5s * 3 = 15s *)
      MulTimeOK := (MulTimeResult = ExpectedTime);
      
      (* DIVTIME 测试 - 时间除以数值 *)
      TestStep := 5;
      DivTimeResult := DIVTIME(TestTime1, 2);
      ExpectedTime := T#5s;   (* 10s / 2 = 5s *)
      DivTimeOK := (DivTimeResult = ExpectedTime);
      
      (* SUB_TIME 测试 - 时间减时间 *)
      TestStep := 6;
      SubTimeResult := SUB_TIME(TestTime1, TestTime2);
      ExpectedTime := T#5s;   (* 10s - 5s = 5s *)
      SubTimeOK := (SubTimeResult = ExpectedTime);
      
      (* SUB_DT_DT 测试 - 日期时间减日期时间 *)
      TestStep := 7;
      SubDTDTResult := SUB_DT_DT(TestDT1, TestDT2);
      (* 2024-01-15-10:30:00 - 2024-01-10-08:15:00 = 5天2小时15分钟 *)
      ExpectedTime := T#5d2h15m;
      SubDTDTOK := (SubDTDTResult = ExpectedTime);
      
      (* SUB_DT_TIME 测试 - 日期时间减时间 *)
      TestStep := 8;
      SubDTTimeResult := SUB_DT_TIME(TestDT1, TestTime1);
      (* 2024-01-15-10:30:00 - 10s = 2024-01-15-10:29:50 *)
      ExpectedDT := DT#2024-01-15-10:29:50;
      SubDTTimeOK := (SubDTTimeResult = ExpectedDT);
      
      (* SUB_DATE_DATE 测试 - 日期减日期 *)
      TestStep := 9;
      SubDateDateResult := SUB_DATE_DATE(TestDate1, TestDate2);
      ExpectedTime := T#5d;   (* 5天 *)
      SubDateDateOK := (SubDateDateResult = ExpectedTime);
      
      (* SUB_TOD_TIME 测试 - 时刻减时间 *)
      TestStep := 10;
      SubTODTimeResult := SUB_TOD_TIME(TestTOD1, TestTime1);
      (* 10:30:00 - 10s = 10:29:50 *)
      ExpectedTOD := TOD#10:29:50;
      SubTODTimeOK := (SubTODTimeResult = ExpectedTOD);
      
      (* SUB_TOD_TOD 测试 - 时刻减时刻 *)
      TestStep := 11;
      SubTODTODResult := SUB_TOD_TOD(TestTOD1, TestTOD2);
      (* 10:30:00 - 08:15:00 = 2:15:00 *)
      ExpectedTime := T#2h15m;
      SubTODTODOK := (SubTODTODResult = ExpectedTime);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT AddTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT AddDTTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT AddTODTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT MulTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT DivTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubDTDTOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubDTTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubDateDateOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubTODTimeOK THEN Errors := Errors + 1; END_IF;
      IF NOT SubTODTODOK THEN Errors := Errors + 1; END_IF;
      
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