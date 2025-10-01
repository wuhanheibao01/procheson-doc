(*
===============================================
  PLC类型转换指令测试程序
  程序名称: TypeConversionTest
  创建日期: 2025-08-30
  测试人员: 汪勇强
  联系方式: 13971612060
  QQ号码: 94114148
  
  测试目的: 验证PLC类型转换指令的功能正确性
  适用环境: Beremiz (IEC 61131-3标准)
  
  测试指令: 图片中的类型转换指令
  包括BOOL_TO_*, BYTE_TO_*, INT_TO_*, DINT_TO_*, 
  REAL_TO_*, STRING_TO_*, TIME_TO_*等转换函数
===============================================
*)

PROGRAM TypeConversionTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 - 不同数据类型 *)
 TestBool : BOOL;
 TestByte : BYTE;
 TestWord : WORD;
 TestDWord : DWORD;
 TestInt : INT;
 TestDInt : DINT;
 TestReal : REAL;
 TestString : STRING;
 TestTime : TIME;
 
 (* BOOL类型转换测试结果 *)
 BOOL_TO_BYTE_Result : BYTE;
 BOOL_TO_WORD_Result : WORD;
 BOOL_TO_DWORD_Result : DWORD;
 BOOL_TO_INT_Result : INT;
 BOOL_TO_DINT_Result : DINT;
 BOOL_TO_REAL_Result : REAL;
 
 (* BYTE类型转换测试结果 *)
 BYTE_TO_BOOL_Result : BOOL;
 BYTE_TO_WORD_Result : WORD;
 BYTE_TO_DWORD_Result : DWORD;
 BYTE_TO_INT_Result : INT;
 BYTE_TO_DINT_Result : DINT;
 BYTE_TO_REAL_Result : REAL;
 
 (* INT类型转换测试结果 *)
 INT_TO_BOOL_Result : BOOL;
 INT_TO_BYTE_Result : BYTE;
 INT_TO_WORD_Result : WORD;
 INT_TO_DWORD_Result : DWORD;
 INT_TO_DINT_Result : DINT;
 INT_TO_REAL_Result : REAL;
 INT_TO_STRING_Result : STRING;
 
 (* DINT类型转换测试结果 *)
 DINT_TO_BOOL_Result : BOOL;
 DINT_TO_BYTE_Result : BYTE;
 DINT_TO_WORD_Result : WORD;
 DINT_TO_DWORD_Result : DWORD;
 DINT_TO_INT_Result : INT;
 DINT_TO_REAL_Result : REAL;
 DINT_TO_STRING_Result : STRING;
 DINT_TO_TIME_Result : TIME;
 
 (* REAL类型转换测试结果 *)
 REAL_TO_BOOL_Result : BOOL;
 REAL_TO_BYTE_Result : BYTE;
 REAL_TO_WORD_Result : WORD;
 REAL_TO_DWORD_Result : DWORD;
 REAL_TO_INT_Result : INT;
 REAL_TO_DINT_Result : DINT;
 REAL_TO_STRING_Result : STRING;
 
 (* STRING类型转换测试结果 *)
 STRING_TO_BOOL_Result : BOOL;
 STRING_TO_BYTE_Result : BYTE;
 STRING_TO_WORD_Result : WORD;
 STRING_TO_DWORD_Result : DWORD;
 STRING_TO_INT_Result : INT;
 STRING_TO_DINT_Result : DINT;
 STRING_TO_REAL_Result : REAL;
 
 (* TIME类型转换测试结果 *)
 TIME_TO_DINT_Result : DINT;
 TIME_TO_REAL_Result : REAL;
 TIME_TO_STRING_Result : STRING;
 
 (* 测试结果判断变量 *)
 BOOL_ConversionOK : BOOL;
 BYTE_ConversionOK : BOOL;
 INT_ConversionOK : BOOL;
 DINT_ConversionOK : BOOL;
 REAL_ConversionOK : BOOL;
 STRING_ConversionOK : BOOL;
 TIME_ConversionOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  TestBool := TRUE;
  TestByte := 16#55;      (* 85 in decimal *)
  TestWord := 16#1234;    (* 4660 in decimal *)
  TestDWord := 16#12345678;
  TestInt := 1234;
  TestDInt := 123456789;
  TestReal := 123.456;
  TestString := '42';     (* 可转换为数值的字符串 *)
  TestTime := T#10s;      (* 10秒 *)

  IF Enable THEN
      
      (* BOOL类型转换测试 *)
      TestStep := 1;
      BOOL_TO_BYTE_Result := BOOL_TO_BYTE(TestBool);
      BOOL_TO_WORD_Result := BOOL_TO_WORD(TestBool);
      BOOL_TO_DWORD_Result := BOOL_TO_DWORD(TestBool);
      BOOL_TO_INT_Result := BOOL_TO_INT(TestBool);
      BOOL_TO_DINT_Result := BOOL_TO_DINT(TestBool);
      BOOL_TO_REAL_Result := BOOL_TO_REAL(TestBool);
      BOOL_ConversionOK := (BOOL_TO_BYTE_Result = 1); (* TRUE应转换为1 *)
      
      (* BYTE类型转换测试 *)
      TestStep := 2;
      BYTE_TO_BOOL_Result := BYTE_TO_BOOL(TestByte);
      BYTE_TO_WORD_Result := BYTE_TO_WORD(TestByte);
      BYTE_TO_DWORD_Result := BYTE_TO_DWORD(TestByte);
      BYTE_TO_INT_Result := BYTE_TO_INT(TestByte);
      BYTE_TO_DINT_Result := BYTE_TO_DINT(TestByte);
      BYTE_TO_REAL_Result := BYTE_TO_REAL(TestByte);
      BYTE_ConversionOK := (BYTE_TO_INT_Result = 85); (* 16#55 = 85 *)
      
      (* INT类型转换测试 *)
      TestStep := 3;
      INT_TO_BOOL_Result := INT_TO_BOOL(TestInt);
      INT_TO_BYTE_Result := INT_TO_BYTE(TestInt);
      INT_TO_WORD_Result := INT_TO_WORD(TestInt);
      INT_TO_DWORD_Result := INT_TO_DWORD(TestInt);
      INT_TO_DINT_Result := INT_TO_DINT(TestInt);
      INT_TO_REAL_Result := INT_TO_REAL(TestInt);
      INT_TO_STRING_Result := INT_TO_STRING(TestInt);
      INT_ConversionOK := (INT_TO_DINT_Result = 1234);
      
      (* DINT类型转换测试 *)
      TestStep := 4;
      DINT_TO_BOOL_Result := DINT_TO_BOOL(TestDInt);
      DINT_TO_BYTE_Result := DINT_TO_BYTE(TestDInt);
      DINT_TO_WORD_Result := DINT_TO_WORD(TestDInt);
      DINT_TO_DWORD_Result := DINT_TO_DWORD(TestDInt);
      DINT_TO_INT_Result := DINT_TO_INT(1234); (* 使用小值避免溢出 *)
      DINT_TO_REAL_Result := DINT_TO_REAL(TestDInt);
      DINT_TO_STRING_Result := DINT_TO_STRING(TestDInt);
      DINT_TO_TIME_Result := DINT_TO_TIME(10000); (* 10秒=10000毫秒 *)
      DINT_ConversionOK := (DINT_TO_INT_Result = 1234);
      
      (* REAL类型转换测试 *)
      TestStep := 5;
      REAL_TO_BOOL_Result := REAL_TO_BOOL(TestReal);
      REAL_TO_BYTE_Result := REAL_TO_BYTE(85.0); (* 使用合适范围的值 *)
      REAL_TO_WORD_Result := REAL_TO_WORD(1234.0);
      REAL_TO_DWORD_Result := REAL_TO_DWORD(TestReal);
      REAL_TO_INT_Result := REAL_TO_INT(TestReal);
      REAL_TO_DINT_Result := REAL_TO_DINT(TestReal);
      REAL_TO_STRING_Result := REAL_TO_STRING(TestReal);
      REAL_ConversionOK := (REAL_TO_INT_Result = 123); (* 小数部分截断 *)
      
      (* STRING类型转换测试 *)
      TestStep := 6;
      STRING_TO_BOOL_Result := STRING_TO_BOOL('1');
      STRING_TO_BYTE_Result := STRING_TO_BYTE('85');
      STRING_TO_WORD_Result := STRING_TO_WORD('1234');
      STRING_TO_DWORD_Result := STRING_TO_DWORD('12345');
      STRING_TO_INT_Result := STRING_TO_INT(TestString);
      STRING_TO_DINT_Result := STRING_TO_DINT('123456');
      STRING_TO_REAL_Result := STRING_TO_REAL('123.456');
      STRING_ConversionOK := (STRING_TO_INT_Result = 42);
      
      (* TIME类型转换测试 *)
      TestStep := 7;
      TIME_TO_DINT_Result := TIME_TO_DINT(TestTime);
      TIME_TO_REAL_Result := TIME_TO_REAL(TestTime);
      TIME_TO_STRING_Result := TIME_TO_STRING(TestTime);
      TIME_ConversionOK := (TIME_TO_DINT_Result = 10000); (* 10秒=10000毫秒 *)
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT BOOL_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT BYTE_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT INT_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT DINT_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT REAL_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT STRING_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT TIME_ConversionOK THEN Errors := Errors + 1; END_IF;
      
      TestsPassed := (Errors = 0);
      Complete := TRUE;
      
      IF TestsPassed THEN
          TestStep := 99;  (* 所有类型转换测试通过 *)
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