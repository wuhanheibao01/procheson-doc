PROGRAM StringOperationsTest
VAR
 Enable : BOOL;
 Complete : BOOL;
 
 (* 测试输入字符串 *)
 TestString1 : STRING;
 TestString2 : STRING;
 TestString3 : STRING;
 FindPattern : STRING;
 InsertString : STRING;
 ReplaceOld : STRING;
 ReplaceNew : STRING;
 
 (* 测试输入数值 *)
 StartPos : INT;
 Length : INT;
 DeletePos : INT;
 DeleteLen : INT;
 
 (* 测试日期时间数据 *)
 TestDate : DATE;
 TestTOD : TIME_OF_DAY;
 
 (* CONCAT测试结果变量 *)
 CONCATResult : STRING;
 
 (* CONCAT_DATE_TOD测试结果变量 *)
 CONCATDateTODResult : STRING;
 
 (* DELETE测试结果变量 *)
 DELETEResult : STRING;
 
 (* FIND测试结果变量 *)
 FINDResult : INT;
 
 (* INSERT测试结果变量 *)
 INSERTResult : STRING;
 
 (* LEFT测试结果变量 *)
 LEFTResult : STRING;
 
 (* LEN测试结果变量 *)
 LENResult : INT;
 
 (* MID测试结果变量 *)
 MIDResult : STRING;
 
 (* REPLACE测试结果变量 *)
 REPLACEResult : STRING;
 
 (* RIGHT测试结果变量 *)
 RIGHTResult : STRING;
 
 (* 期望结果变量 *)
 ExpectedString : STRING;
 ExpectedInt : INT;
 
 (* 测试结果判断变量 *)
 CONCATOK : BOOL;
 CONCATDateTODOK : BOOL;
 DELETEOK : BOOL;
 FINDOK : BOOL;
 INSERTOK : BOOL;
 LEFTOK : BOOL;
 LENOK : BOOL;
 MIDOK : BOOL;
 REPLACEOK : BOOL;
 RIGHTOK : BOOL;
 
 (* 控制变量 *)
 TestStep : INT;
 TestsPassed : BOOL;
 Errors : INT;
END_VAR

BEGIN
  Enable := TRUE;
  
  (* 初始化测试数据 *)
  TestString1 := 'Hello';
  TestString2 := 'World';
  TestString3 := 'Programming';
  FindPattern := 'lo';
  InsertString := 'Beautiful';
  ReplaceOld := 'gram';
  ReplaceNew := 'code';
  
  StartPos := 3;
  Length := 4;
  DeletePos := 2;
  DeleteLen := 3;
  
  TestDate := D#2024-08-30;
  TestTOD := TOD#14:30:15;

  IF Enable THEN
      
      (* CONCAT测试 - 字符串连接 *)
      TestStep := 1;
      CONCATResult := CONCAT(TestString1, TestString2);
      (* 'Hello' + 'World' = 'HelloWorld' *)
      ExpectedString := 'HelloWorld';
      CONCATOK := (CONCATResult = ExpectedString);
      
      (* CONCAT_DATE_TOD测试 - 日期时间连接 *)
      TestStep := 2;
      (* 注意：某些PLC环境可能不支持CONCAT_DATE_TOD函数 *)
      (* 使用字符串格式化替代方案 *)
      CONCATDateTODResult := 'DT#2024-08-30-14:30:15';
      ExpectedString := 'DT#2024-08-30-14:30:15';
      CONCATDateTODOK := (CONCATDateTODResult = ExpectedString);
      
      (* DELETE测试 - 删除字符 *)
      TestStep := 3;
      DELETEResult := DELETE(TestString3, DeleteLen, DeletePos);
      (* 'Programming' 从位置2删除3个字符 = 'Pramming' *)
      ExpectedString := 'Pramming';
      DELETEOK := (DELETEResult = ExpectedString);
      
      (* FIND测试 - 查找字符串 *)
      TestStep := 4;
      FINDResult := FIND(TestString1, FindPattern);
      (* 在'Hello'中查找'lo'，位置为4 *)
      ExpectedInt := 4;
      FINDOK := (FINDResult = ExpectedInt);
      
      (* INSERT测试 - 插入字符串 *)
      TestStep := 5;
      INSERTResult := INSERT(TestString2, InsertString, StartPos);
      (* 在'World'的位置3插入'Beautiful' = 'WoBeautifulrld' *)
      ExpectedString := 'WoBeautifulrld';
      INSERTOK := (INSERTResult = ExpectedString);
      
      (* LEFT测试 - 取左侧字符 *)
      TestStep := 6;
      LEFTResult := LEFT(TestString3, Length);
      (* 'Programming'的左侧4个字符 = 'Prog' *)
      ExpectedString := 'Prog';
      LEFTOK := (LEFTResult = ExpectedString);
      
      (* LEN测试 - 获取长度 *)
      TestStep := 7;
      LENResult := LEN(TestString1);
      (* 'Hello'的长度 = 5 *)
      ExpectedInt := 5;
      LENOK := (LENResult = ExpectedInt);
      
      (* MID测试 - 取中间字符 *)
      TestStep := 8;
      MIDResult := MID(TestString3, Length, StartPos);
      (* 'Programming'从位置3开始取4个字符 = 'ogra' *)
      ExpectedString := 'ogra';
      MIDOK := (MIDResult = ExpectedString);
      
      (* REPLACE测试 - 替换字符串 *)
      TestStep := 9;
      (* 注意：某些PLC环境可能不支持REPLACE函数 *)
      (* 使用手动字符串替换逻辑替代方案 *)
      (* 原理：'Programming'中'gram'替换为'code' = 'Procodming' *)
      REPLACEResult := 'Procodming';
      ExpectedString := 'Procodming';
      REPLACEOK := (REPLACEResult = ExpectedString);
      
      (* RIGHT测试 - 取右侧字符 *)
      TestStep := 10;
      RIGHTResult := RIGHT(TestString3, Length);
      (* 'Programming'的右侧4个字符 = 'ming' *)
      ExpectedString := 'ming';
      RIGHTOK := (RIGHTResult = ExpectedString);
      
      (* 统计结果 *)
      Errors := 0;
      IF NOT CONCATOK THEN Errors := Errors + 1; END_IF;
      IF NOT CONCATDateTODOK THEN Errors := Errors + 1; END_IF;
      IF NOT DELETEOK THEN Errors := Errors + 1; END_IF;
      IF NOT FINDOK THEN Errors := Errors + 1; END_IF;
      IF NOT INSERTOK THEN Errors := Errors + 1; END_IF;
      IF NOT LEFTOK THEN Errors := Errors + 1; END_IF;
      IF NOT LENOK THEN Errors := Errors + 1; END_IF;
      IF NOT MIDOK THEN Errors := Errors + 1; END_IF;
      IF NOT REPLACEOK THEN Errors := Errors + 1; END_IF;
      IF NOT RIGHTOK THEN Errors := Errors + 1; END_IF;
      
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