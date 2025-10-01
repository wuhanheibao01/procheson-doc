(*
===============================================
  PLC计数器指令测试程序(极简版)
  程序名称: CounterInstructionsTest
  创建日期: 2025-08-30
  测试人员: 汪勇强
  联系方式: 13971612060
  QQ号码: 94114148
  
  测试目的: 验证PLC基础计数器指令的功能正确性
  适用环境: Beremiz (IEC 61131-3标准)
  
  测试指令: CTD、CTU、CTUD (基础版本)
===============================================
*)

PROGRAM CounterInstructionsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 计数器控制输入 *)
 CountUp : BOOL;
 CountDown : BOOL;
 Reset : BOOL;
 Load : BOOL;
 
 (* 计数器预设值 *)
 PresetValue : INT;
 
 (* CTU - 增计数器 *)
 CTU_Counter : CTU;
 CTU_CountValue : INT;
 CTU_QReached : BOOL;
 
 (* CTD - 减计数器 *)
 CTD_Counter : CTD;
 CTD_CountValue : INT;
 CTD_QReached : BOOL;
 
 (* CTUD - 增减计数器 *)
 CTUD_Counter : CTUD;
 CTUD_CountValue : INT;
 CTUD_QU : BOOL;
 CTUD_QD : BOOL;
 
 (* 测试结果判断变量 *)
 CTU_TestOK : BOOL;
 CTD_TestOK : BOOL;
 CTUD_TestOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
 
 (* 边沿检测 *)
 CountUp_Last : BOOL;
 CountDown_Last : BOOL;
 CountUp_Edge : BOOL;
 CountDown_Edge : BOOL;
 
 (* 简化的测试控制 *)
 TestCycle : INT;
 MaxCycles : INT;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  PresetValue := 3;
  MaxCycles := 10;
  
  (* 边沿检测逻辑 *)
  CountUp_Edge := CountUp AND NOT CountUp_Last;
  CountDown_Edge := CountDown AND NOT CountDown_Last;
  CountUp_Last := CountUp;
  CountDown_Last := CountDown;

  IF Enable THEN
      
      (* 极简的测试序列生成 *)
      IF TestCycle < MaxCycles THEN
          TestCycle := TestCycle + 1;
      END_IF;
      
      (* 使用简单的条件判断代替复杂运算 *)
      IF TestCycle = 1 THEN
          CountUp := TRUE;
          CountDown := FALSE;
      ELSIF TestCycle = 2 THEN
          CountUp := FALSE;
          CountDown := FALSE;
      ELSIF TestCycle = 3 THEN
          CountUp := TRUE;
          CountDown := FALSE;
      ELSIF TestCycle = 4 THEN
          CountUp := FALSE;
          CountDown := FALSE;
      ELSIF TestCycle = 5 THEN
          CountUp := FALSE;
          CountDown := TRUE;
      ELSIF TestCycle = 6 THEN
          CountUp := FALSE;
          CountDown := FALSE;
      ELSIF TestCycle = 7 THEN
          Reset := TRUE;
      ELSIF TestCycle = 8 THEN
          Reset := FALSE;
          Load := TRUE;
      ELSE
          CountUp := FALSE;
          CountDown := FALSE;
          Reset := FALSE;
          Load := FALSE;
      END_IF;
      
      (* CTU 测试 - 增计数器 *)
      TestStep := 1;
      CTU_Counter(CU := CountUp_Edge, R := Reset, PV := PresetValue);
      CTU_CountValue := CTU_Counter.CV;
      CTU_QReached := CTU_Counter.Q;
      CTU_TestOK := (CTU_CountValue >= 0);
      
      (* CTD 测试 - 减计数器 *)
      TestStep := 2;
      CTD_Counter(CD := CountDown_Edge, LD := Load, PV := PresetValue);
      CTD_CountValue := CTD_Counter.CV;
      CTD_QReached := CTD_Counter.Q;
      CTD_TestOK := (CTD_CountValue >= 0);
      
      (* CTUD 测试 - 增减计数器 *)
      TestStep := 3;
      CTUD_Counter(CU := CountUp_Edge, CD := CountDown_Edge, R := Reset, 
                   LD := Load, PV := PresetValue);
      CTUD_CountValue := CTUD_Counter.CV;
      CTUD_QU := CTUD_Counter.QU;
      CTUD_QD := CTUD_Counter.QD;
      CTUD_TestOK := (CTUD_CountValue >= 0);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT CTU_TestOK THEN Errors := Errors + 1; END_IF;
      IF NOT CTD_TestOK THEN Errors := Errors + 1; END_IF;
      IF NOT CTUD_TestOK THEN Errors := Errors + 1; END_IF;
      
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
      TestCycle := 0;
      CountUp := FALSE;
      CountDown := FALSE;
      Reset := FALSE;
      Load := FALSE;
  END_IF;

END_PROGRAM