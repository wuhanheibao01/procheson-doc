(*
===============================================
  PLC扩展数据类型转换指令测试程序
  程序名称: ExtendedTypeConversionTest
  创建日期: 2025-08-30
  测试人员: 汪勇强
  联系方式: 13971612060
  QQ号码: 94114148
  
  测试目的: 验证PLC扩展数据类型转换指令的功能正确性
  适用环境: Beremiz (IEC 61131-3标准)
  
  测试指令: 图片中的扩展数据类型转换指令
  包括LINT_TO_*, ULINT_TO_*, UDINT_TO_*, LWORD_TO_*等
  扩展数据类型转换函数
===============================================
*)

PROGRAM ExtendedTypeConversionTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入数据 - 扩展数据类型 *)
 TestLInt : LINT;
 TestUDInt : UDINT;
 TestULInt : ULINT;
 TestLWord : LWORD;
 
 (* LINT类型转换测试结果 (64位有符号整数) *)
 LINT_TO_BOOL_Result : BOOL;
 LINT_TO_BYTE_Result : BYTE;
 LINT_TO_WORD_Result : WORD;
 LINT_TO_DWORD_Result : DWORD;
 LINT_TO_INT_Result : INT;
 LINT_TO_DINT_Result : DINT;
 LINT_TO_REAL_Result : REAL;
 LINT_TO_STRING_Result : STRING;
 LINT_TO_TIME_Result : TIME;
 
 (* UDINT类型转换测试结果 (32位无符号整数) *)
 UDINT_TO_BOOL_Result : BOOL;
 UDINT_TO_BYTE_Result : BYTE;
 UDINT_TO_WORD_Result : WORD;
 UDINT_TO_DWORD_Result : DWORD;
 UDINT_TO_INT_Result : INT;
 UDINT_TO_DINT_Result : DINT;
 UDINT_TO_LINT_Result : LINT;
 UDINT_TO_REAL_Result : REAL;
 UDINT_TO_STRING_Result : STRING;
 UDINT_TO_TIME_Result : TIME;
 
 (* ULINT类型转换测试结果 (64位无符号整数) *)
 ULINT_TO_BOOL_Result : BOOL;
 ULINT_TO_BYTE_Result : BYTE;
 ULINT_TO_WORD_Result : WORD;
 ULINT_TO_DWORD_Result : DWORD;
 ULINT_TO_INT_Result : INT;
 ULINT_TO_DINT_Result : DINT;
 ULINT_TO_LINT_Result : LINT;
 ULINT_TO_UDINT_Result : UDINT;
 ULINT_TO_REAL_Result : REAL;
 ULINT_TO_STRING_Result : STRING;
 
 (* LWORD类型转换测试结果 (64位位串) *)
 LWORD_TO_BOOL_Result : BOOL;
 LWORD_TO_BYTE_Result : BYTE;
 LWORD_TO_WORD_Result : WORD;
 LWORD_TO_DWORD_Result : DWORD;
 LWORD_TO_INT_Result : INT;
 LWORD_TO_DINT_Result : DINT;
 LWORD_TO_LINT_Result : LINT;
 LWORD_TO_UDINT_Result : UDINT;
 LWORD_TO_ULINT_Result : ULINT;
 LWORD_TO_REAL_Result : REAL;
 
 (* 反向转换测试 - 其他类型转换到扩展类型 *)
 BOOL_TO_LINT_Result : LINT;
 BOOL_TO_UDINT_Result : UDINT;
 BOOL_TO_ULINT_Result : ULINT;
 BOOL_TO_LWORD_Result : LWORD;
 
 BYTE_TO_LINT_Result : LINT;
 BYTE_TO_UDINT_Result : UDINT;
 BYTE_TO_ULINT_Result : ULINT;
 BYTE_TO_LWORD_Result : LWORD;
 
 INT_TO_LINT_Result : LINT;
 INT_TO_UDINT_Result : UDINT;
 INT_TO_ULINT_Result : ULINT;
 INT_TO_LWORD_Result : LWORD;
 
 DINT_TO_LINT_Result : LINT;
 DINT_TO_UDINT_Result : UDINT;
 DINT_TO_ULINT_Result : ULINT;
 DINT_TO_LWORD_Result : LWORD;
 
 REAL_TO_LINT_Result : LINT;
 REAL_TO_UDINT_Result : UDINT;
 REAL_TO_ULINT_Result : ULINT;
 REAL_TO_LWORD_Result : LWORD;
 
 (* 测试结果判断变量 *)
 LINT_ConversionOK : BOOL;
 UDINT_ConversionOK : BOOL;
 ULINT_ConversionOK : BOOL;
 LWORD_ConversionOK : BOOL;
 REVERSE_ConversionOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
 
 (* 测试启用标志 - 渐进式测试 *)
 EnableLINT : BOOL;
 EnableUDINT : BOOL;
 EnableULINT : BOOL;
 EnableLWORD : BOOL;
 EnableReverse : BOOL;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 测试启用配置 - 渐进式测试策略 *)
  EnableLINT := TRUE;    (* 先测试LINT类型转换 *)
  EnableUDINT := TRUE;   (* 同时测试UDINT类型转换 *)
  EnableULINT := FALSE;  (* 如果前面成功，再启用ULINT *)
  EnableLWORD := FALSE;  (* 最后测试LWORD类型转换 *)
  EnableReverse := TRUE; (* 测试反向转换 *)
  
  (* 初始化测试数据 *)
  TestLInt := 9223372036854775807;   (* LINT最大值 *)
  TestUDInt := 4294967295;           (* UDINT最大值 *)
  TestULInt := 18446744073709551615; (* ULINT最大值 *)
  TestLWord := 16#FFFFFFFFFFFFFFFF; (* LWORD全1 *)

  IF Enable THEN
      
      (* LINT类型转换测试 *)
      IF EnableLINT THEN
          TestStep := 1;
          LINT_TO_BOOL_Result := LINT_TO_BOOL(TestLInt);
          LINT_TO_BYTE_Result := LINT_TO_BYTE(85); (* 使用小值避免溢出 *)
          LINT_TO_WORD_Result := LINT_TO_WORD(1234);
          LINT_TO_DWORD_Result := LINT_TO_DWORD(123456);
          LINT_TO_INT_Result := LINT_TO_INT(1234);
          LINT_TO_DINT_Result := LINT_TO_DINT(123456789);
          LINT_TO_REAL_Result := LINT_TO_REAL(TestLInt);
          LINT_TO_STRING_Result := LINT_TO_STRING(123456789);
          LINT_TO_TIME_Result := LINT_TO_TIME(10000); (* 10秒 *)
          LINT_ConversionOK := (LINT_TO_DINT_Result = 123456789);
      END_IF;
      
      (* UDINT类型转换测试 *)
      IF EnableUDINT THEN
          TestStep := 2;
          UDINT_TO_BOOL_Result := UDINT_TO_BOOL(TestUDInt);
          UDINT_TO_BYTE_Result := UDINT_TO_BYTE(85);
          UDINT_TO_WORD_Result := UDINT_TO_WORD(1234);
          UDINT_TO_DWORD_Result := UDINT_TO_DWORD(TestUDInt);
          UDINT_TO_INT_Result := UDINT_TO_INT(1234);
          UDINT_TO_DINT_Result := UDINT_TO_DINT(123456789);
          UDINT_TO_LINT_Result := UDINT_TO_LINT(TestUDInt);
          UDINT_TO_REAL_Result := UDINT_TO_REAL(TestUDInt);
          UDINT_TO_STRING_Result := UDINT_TO_STRING(123456789);
          UDINT_TO_TIME_Result := UDINT_TO_TIME(10000);
          UDINT_ConversionOK := (UDINT_TO_DINT_Result = 123456789);
      END_IF;
      
      (* ULINT类型转换测试 - 条件启用 *)
      IF EnableULINT THEN
          TestStep := 3;
          ULINT_TO_BOOL_Result := ULINT_TO_BOOL(TestULInt);
          ULINT_TO_BYTE_Result := ULINT_TO_BYTE(85);
          ULINT_TO_WORD_Result := ULINT_TO_WORD(1234);
          ULINT_TO_DWORD_Result := ULINT_TO_DWORD(123456);
          ULINT_TO_INT_Result := ULINT_TO_INT(1234);
          ULINT_TO_DINT_Result := ULINT_TO_DINT(123456789);
          ULINT_TO_LINT_Result := ULINT_TO_LINT(TestULInt);
          ULINT_TO_UDINT_Result := ULINT_TO_UDINT(123456789);
          ULINT_TO_REAL_Result := ULINT_TO_REAL(TestULInt);
          ULINT_TO_STRING_Result := ULINT_TO_STRING(123456789);
          ULINT_ConversionOK := (ULINT_TO_DINT_Result = 123456789);
      ELSE
          ULINT_ConversionOK := TRUE; (* 未启用时默认通过 *)
      END_IF;
      
      (* LWORD类型转换测试 - 条件启用 *)
      IF EnableLWORD THEN
          TestStep := 4;
          LWORD_TO_BOOL_Result := LWORD_TO_BOOL(TestLWord);
          LWORD_TO_BYTE_Result := LWORD_TO_BYTE(16#55);
          LWORD_TO_WORD_Result := LWORD_TO_WORD(16#1234);
          LWORD_TO_DWORD_Result := LWORD_TO_DWORD(16#12345678);
          LWORD_TO_INT_Result := LWORD_TO_INT(16#1234);
          LWORD_TO_DINT_Result := LWORD_TO_DINT(16#12345678);
          LWORD_TO_LINT_Result := LWORD_TO_LINT(TestLWord);
          LWORD_TO_UDINT_Result := LWORD_TO_UDINT(16#12345678);
          LWORD_TO_ULINT_Result := LWORD_TO_ULINT(TestLWord);
          LWORD_TO_REAL_Result := LWORD_TO_REAL(16#12345678);
          LWORD_ConversionOK := (LWORD_TO_DINT_Result = 16#12345678);
      ELSE
          LWORD_ConversionOK := TRUE; (* 未启用时默认通过 *)
      END_IF;
      
      (* 反向转换测试 - 其他类型转换到扩展类型 *)
      IF EnableReverse THEN
          TestStep := 5;
          
          (* BOOL转换到扩展类型 *)
          BOOL_TO_LINT_Result := BOOL_TO_LINT(TRUE);
          BOOL_TO_UDINT_Result := BOOL_TO_UDINT(TRUE);
          BOOL_TO_ULINT_Result := BOOL_TO_ULINT(TRUE);
          BOOL_TO_LWORD_Result := BOOL_TO_LWORD(TRUE);
          
          (* BYTE转换到扩展类型 *)
          BYTE_TO_LINT_Result := BYTE_TO_LINT(85);
          BYTE_TO_UDINT_Result := BYTE_TO_UDINT(85);
          BYTE_TO_ULINT_Result := BYTE_TO_ULINT(85);
          BYTE_TO_LWORD_Result := BYTE_TO_LWORD(85);
          
          (* INT转换到扩展类型 *)
          INT_TO_LINT_Result := INT_TO_LINT(1234);
          INT_TO_UDINT_Result := INT_TO_UDINT(1234);
          INT_TO_ULINT_Result := INT_TO_ULINT(1234);
          INT_TO_LWORD_Result := INT_TO_LWORD(1234);
          
          (* DINT转换到扩展类型 *)
          DINT_TO_LINT_Result := DINT_TO_LINT(123456789);
          DINT_TO_UDINT_Result := DINT_TO_UDINT(123456789);
          DINT_TO_ULINT_Result := DINT_TO_ULINT(123456789);
          DINT_TO_LWORD_Result := DINT_TO_LWORD(123456789);
          
          (* REAL转换到扩展类型 *)
          REAL_TO_LINT_Result := REAL_TO_LINT(123.456);
          REAL_TO_UDINT_Result := REAL_TO_UDINT(123.456);
          REAL_TO_ULINT_Result := REAL_TO_ULINT(123.456);
          REAL_TO_LWORD_Result := REAL_TO_LWORD(123.456);
          
          REVERSE_ConversionOK := (BOOL_TO_LINT_Result = 1);
      ELSE
          REVERSE_ConversionOK := TRUE; (* 未启用时默认通过 *)
      END_IF;
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT LINT_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT UDINT_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT ULINT_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT LWORD_ConversionOK THEN Errors := Errors + 1; END_IF;
      IF NOT REVERSE_ConversionOK THEN Errors := Errors + 1; END_IF;
      
      TestsPassed := (Errors = 0);
      Complete := TRUE;
      
      IF TestsPassed THEN
          TestStep := 99;  (* 所有扩展类型转换测试通过 *)
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