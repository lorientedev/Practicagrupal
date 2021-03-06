PROGRAM Practica_V;

CONST
  MIN = 1;
  MAX = 50;

TYPE
  T_keep_numbers = array[MIN..MAX] OF integer;
  T_numbers = RECORD
    keep_numbers: t_keep_numbers;
    length: integer;
    IsPositive: boolean;
  END;
  T_string = string [50];
VAR
  number_string: T_string;
  big_number1: T_numbers;
  big_number2: T_numbers;
  operation: char;

FUNCTION IsANumber(character: char): boolean;
BEGIN
  CASE character OF
    '1', '2', '3','4','5','6','7','8','9','0' : BEGIN
                                                               IsANumber:=true;
                                                              END;
  ELSE IsANumber:=False;
    END;
END;{==================FIN IS A NUMBER=======================================}

FUNCTION CharTOInt(character: char): integer;
BEGIN
  CASE character OF
        '1' : CharTOInt:=1;
        '2' : CharTOInt:=2;
        '3' : CharTOInt:=3;
        '4' : CharTOInt:=4;
        '5' : CharTOInt:=5;
        '6' : CharTOInt:=6;
        '7' : CharTOInt:=7;
        '8' : CharTOInt:=8;
        '9' : CharTOInt:=9;
        '0' : CharTOInt:=0;
  END;
END;{===================END CHARTOINT=======================================}

PROCEDURE ReadNumbers(VAR number_string: T_string; VAR big_number: T_numbers);{=======================}
VAR
  i:integer;
  number:char;
BEGIN
  number_string:= '';
  i:= 1;
  big_number.Ispositive:= true;
  REPEAT
     read(number);
     IF((ord(number) <> 10) and (i<= 50))THEN {Compruebo que el number no sea enter}
        BEGIN
          IF(IsANumber(number))THEN {Compruebo si number es un numero }
            BEGIN
              number_string:= number_string+number;
              i:=i+1;
            END
            ELSE IF(number= '-')THEN
              big_number.Ispositive:= false;
        END;
  UNTIL ord(number)= 10;
  big_number.length:= i-1;
END; {====================FIN READNUMBBER======================================}

PROCEDURE numberstringTOkeepNumbers(number_string: T_string; big_number: T_numbers; VAR numberstringTOkeepNumbers: t_keep_numbers);
VAR
  a:integer;
BEGIN
    FOR a:=1 TO big_number.length DO
    BEGIN
    numberstringTOkeepNumbers[a]:=CharTOInt(number_string[a]);
    END;
END;{============================END NUMBERSTRING TO KEEPNUMBERS===================}

PROCEDURE NumberStringTokeepNumbers_reverse(number_string: T_string; big_number: T_numbers; var numberstringTokeepNumbers_reverse: t_keep_numbers);
VAR
  a:integer;
  n:integer;
BEGIN
  n:= big_number.length;
    FOR a:=1 TO big_number.length DO { rellenar el array alreves del string para operar}
    BEGIN
    numberstringTokeepNumbers_reverse[a]:= CharToInt(number_string[n]);
    n:= n -1;
    end;
END;{============================END NUMBERSTRING TO KEEPNUMBERS REVERSE===================}

PROCEDURE ShowNumber(big_number:t_numbers);
VAR
  a:integer;
BEGIN
  IF(big_number.IsPositive=false)THEN
    write('-');
  FOR a:=1 TO big_number.length DO
      write(big_number.keep_numbers[a]);
     writeln();
 END;{=====================END SHOWNUMBER==========================================}

PROCEDURE ShowNumber_reverse(big_number:t_numbers);
VAR
  a:integer;
BEGIN
  IF(big_number.length>50)then
  BEGIN
    writeln('DESBORDAMIENTO');
  END
  ELSE
    BEGIN
    IF(big_number.IsPositive=false)THEN
      write('-');
    FOR a:=big_number.length  DOWNTO 1 DO
      write(big_number.keep_numbers[a]);
         writeln();
    END;
 END;{===================ShowNumber Reverse==================================}

FUNCTION IsEqual_without_compare_simbol(number1,number2:T_numbers):boolean;
VAR
  a:integer;
BEGIN
  IF(number1.length = number2.length)THEN
  BEGIN
    IsEqual_without_compare_simbol:=true;
    FOR a:=1 TO number1.length DO
    BEGIN
      IF(number1.keep_numbers[a] <> number2.keep_numbers[a])THEN
              IsEqual_without_compare_simbol:=false;
    END;
  END
    ELSE
    IsEqual_without_compare_simbol:=FALSE;
END;{===========IsEqual without compare_simbol===================================}

FUNCTION IsEqual(number1,number2:T_numbers):boolean;
BEGIN
  IF (number1.IsPositive = number2.Ispositive)THEN
      IsEqual:= IsEqual_without_compare_simbol(number1,number2)
  ELSE
      IsEqual:=False;
END;{================Is Equal===============================}

FUNCTION IsSameSimbol(number1,number2:T_numbers):boolean;
BEGIN
  IF(number1.Ispositive = number2.IsPositive)THEN
    IsSameSimbol:=True
  ELSE
    IsSameSimbol:=False;
END;{================Is Same Simbol===============================}

FUNCTION When_simbol_is_equal_and_positive(number1,number2:T_numbers):boolean;
VAR
  a:integer;
BEGIN
  When_simbol_is_equal_and_positive:=FALSE;
    IF(number1.length = number2.length)THEN
    BEGIN
    FOR a:=1 TO number1.length DO
        BEGIN
      IF(number1.keep_numbers[a] > number2.keep_numbers[a])THEN
              When_simbol_is_equal_and_positive:=True;
    END;
  END
    ELSE IF(number1.length > number2.length)THEN
      When_simbol_is_equal_and_positive:=TRUE;
END;{===========When simbol is equal and positive==========================================}

FUNCTION When_numbers_are_not_equals(number1,number2:T_numbers):boolean;
BEGIN
  IF (IsSameSimbol(number1,number2))THEN
    BEGIN
      IF(number1.Ispositive=TRUE)THEN
        BEGIN
          When_numbers_are_not_equals:=When_simbol_is_equal_and_positive(number1,number2);
    END
        ELSE IF(number1.IsPositive=False)THEN
        BEGIN
          When_numbers_are_not_equals:=When_simbol_is_equal_and_positive(number2,number1);
    END;
  END
    ELSE IF(IsSameSimbol(number1,number2)=FALSE)THEN
    BEGIN
    IF(number1.IsPositive)THEN
        When_numbers_are_not_equals:=TRUE;
  END;
END;{=============When numbers are not equals======================================}

{===================INICIO SUMA============================}
FUNCTION IsGreather(number1,number2:T_numbers):boolean;
BEGIN
  IF( IsEqual(number1,number2) = FALSE )THEN
    BEGIN
    IsGreather:=When_numbers_are_not_equals(number1,number2);
  END
    ELSE
    IsGreather:=FALSE;
END;{===========Is Greather==========================}

PROCEDURE Fill_With_Zeroes(var number:T_numbers);
VAR
  a:integer;
BEGIN
    FOR a:=1 TO 50 DO
        number.keep_numbers[a]:=0;
END;{============Fill With Zeroes=========================}

PROCEDURE Sum_with_same_simbol(number1,number2:T_numbers; var sum:T_numbers);
VAR
  a,len1,len2:integer;
BEGIN
  len1:=number1.length;
    len2:=number2.length;
    a:=1;
  REPEAT
      IF(len1=0)THEN
      BEGIN
        Sum.keep_numbers[a]:= number2.keep_numbers[len2] + Sum.keep_numbers[a];
          len2:=len2-1;
    END
      ELSE IF(len2=0)THEN
      BEGIN
        Sum.keep_numbers[a]:= number1.keep_numbers[len1] + Sum.keep_numbers[a];
          len1:=len1-1;
    END
      ELSE
      BEGIN
        Sum.keep_numbers[a]:= number1.keep_numbers[len1] + number2.keep_numbers[len2] + Sum.keep_numbers[a];
          len1:=len1-1;
          len2:=len2-1;
    END;
    IF(Sum.keep_numbers[a] >= 10)THEN
      BEGIN
      Sum.keep_numbers[a+1]:= Sum.keep_numbers[a] div 10;
          Sum.keep_numbers[a]:=   Sum.keep_numbers[a] mod 10;
    END;
    a:=a+1;
  UNTIL ((len1=0) AND (len2=0));
  IF (Sum.keep_numbers[a]=0)  THEN
    Sum.length:=a-1
  ELSE
      Sum.length:=a;
  Sum.IsPositive:= number1.IsPositive;
END;{===========Sum with same simbol=========================}

PROCEDURE Sum_with_diferent_simbol(number1,number2:T_numbers; VAR sum:T_numbers);
VAR
  len1, len2:integer;
  a:integer;
  b:integer;
  ceros:boolean;
BEGIN
    len1:=number1.length;
    len2:=number2.length;
    a:=1;
  REPEAT
    IF( (len2 > 0) and ((number2.keep_numbers[len2]+sum.keep_numbers[a]) > number1.keep_numbers[len1]) )THEN
        BEGIN
          number1.keep_numbers[len1]:=number1.keep_numbers[len1]+10;
            Sum.keep_numbers[a+1]:=Sum.keep_numbers[a+1]+1;
    END
        ELSE
        BEGIN
      if(len1=0)then
            BEGIN
              Sum.keep_numbers[a]:= number2.keep_numbers[len2] - Sum.keep_numbers[a];
                len2:=len2-1;
      END
            else if(len2=0)then
      BEGIN
              Sum.keep_numbers[a]:= number1.keep_numbers[len1] - Sum.keep_numbers[a];
                len1:=len1-1;
      END
            else
            BEGIN
        Sum.keep_numbers[a]:= number1.keep_numbers[len1] - number2.keep_numbers[len2] - Sum.keep_numbers[a];
        len1:=len1-1;
              len2:=len2-1;
            END;
              a:=a+1;
    END;
  UNTIL ( (len1=0) and (len2=0) );
    ceros:=true;
  for b:=1 to 50 DO
    BEGIN
    if(sum.keep_numbers[b]<>0)then
    BEGIN
        a:=b;
        ceros:=false;
    END;
  END;
  if(ceros)then
    a:=1;
  Sum.length:=a;
    Sum.IsPositive:=number1.IsPositive;
END;{==========Sum with diferent simbol==========================}

PROCEDURE Number_position(number1,number2:T_numbers; var Sum:T_numbers);
BEGIN
  if(number1.IsPositive)then
  BEGIN
      number2.IsPositive:=TRUE;
    if (IsGreather(number2,number1))then
      BEGIN
        number2.Ispositive:=False;
          Sum_with_diferent_simbol(number2,number1,sum);
    END
      else
      BEGIN
        number2.IsPositive:=False;
          Sum_with_diferent_simbol(number1,number2,sum);
    END;
  END
    else
    BEGIN
    number1.IsPositive:=TRUE;
        IF(IsGreather(number2,number1))then
    BEGIN
          number1.IsPositive:=false;
            Sum_with_diferent_simbol(number2,number1,sum)
    END
    else
    BEGIN
        number1.IsPositive:=false;
          Sum_with_diferent_simbol(number1,number2,sum);
    END;
    END;
END;{=============Number position=======================}

PROCEDURE Sum(number1,number2:T_numbers; VAR result:T_numbers);
BEGIN
  Fill_with_Zeroes(result);
    IF IsSameSimbol(number1,number2) THEN
      Sum_with_same_simbol(number1,number2,result)
    ELSE IF( NOT IsSameSimbol(number1,number2))THEN
        Number_position(number1,number2,result);
END;{============== Sum ==================================}

PROCEDURE Activate (VAR big_number1:T_Numbers);
VAR
  i:integer;
BEGIN
  FOR i:= 1 TO MAX DO
    big_number1.keep_numbers[i]:=0;
  big_number1.length:=0;
  big_number1.IsPositive:=FALSE;
END;{============== Activate==================================}

PROCEDURE MovePosition(big_number1:T_Numbers; VAR result:T_Numbers; VAR overflow:Boolean);
VAR
  i: integer;
BEGIN
  IF big_number1.length<>0 THEN
  BEGIN
    IF big_number1.length<MAX THEN
    BEGIN
      FOR i:= big_number1.length DOWNTO 1 DO
        result.keep_numbers[i+1]:=big_number1.keep_numbers[i];
    END
    ELSE
      overflow:=TRUE;

    result.keep_numbers[1]:=0;
    result.length := big_number1.length+1
  END
  ELSE
    activate(result);
END;{==============MovePosition==================================}

PROCEDURE Digit_Multiplication(big_number1:T_Numbers; digit_operation:integer; VAR result:T_Numbers; VAR overflow: Boolean);
VAR
  i,j: integer;
BEGIN
  result.IsPositive:=FALSE;
  IF (big_number1.length<>0) AND (digit_operation<>0) THEN
  BEGIN
    j:=0;
    FOR i:=1 TO big_number1.length DO
    BEGIN
      result.keep_numbers[i] := (big_number1.keep_numbers[i]*digit_operation+j) mod 10;
      j := (big_number1.keep_numbers[i]*digit_operation+j) div 10;
    END;
    result.length:=big_number1.length;
    IF j>0 THEN
    BEGIN
      IF result.length<MAX THEN
        result.keep_numbers[i+1]:=j
      ELSE
        overflow:=TRUE;
      result.length:=result.length+1;
    END
  END
  ELSE
    activate(result);
END;{===============Digit Multiplication=================================}

PROCEDURE Check_sign(number1,number2:T_numbers; VAR result:T_numbers);
BEGIN
  if(number1.Ispositive)then
    begin
      if(number2.Ispositive)then
      result.IsPositive:=true
    else
          result.IsPositive:=False;
  end
    else
    begin
      if(number2.Ispositive)then
          result.IsPositive:=False
    else
        result.IsPositive:=True;
  end;
END;{===============Check sign=================================}

PROCEDURE Reverse(big_number:t_numbers; VAR Reverse:T_numbers);
VAR
  a,b:integer;
BEGIN
  reverse.Ispositive:=big_number.Ispositive;
  b:=1;
  FOR a:=big_number.length DOWNTO 1 DO
    BEGIN
      reverse.keep_numbers[b]:=(big_number.keep_numbers[a]);
        b:=b+1;
  END;
    reverse.length:=big_number.length;
 END;{================Reverse=============================================}

FUNCTION IsZero(number:T_numbers):Boolean;
BEGIN
  IsZero:=FALSE;
  if(number.length=1)then
  BEGIN
    if(number.keep_numbers[1]=0)then
      IsZero:=TRUE;
    END;
END;{===============IsZero=============================================}

FUNCTION IsOne(number:T_numbers):Boolean;
BEGIN
  IsOne:=False;
  if(number.length=1)then
    BEGIN
    if(number.keep_numbers[1]=1)then
      IsOne:=TRUE;
    END;
END;{=========IsOne===============================================}


PROCEDURE Multiplication (big_number1,big_number2:T_Numbers; VAR result:T_Numbers; VAR overflow: Boolean);
VAR
  auxiliary_element_1: T_Numbers;
  auxiliary_element_2: T_Numbers;
    auxiliary_element_3: T_Numbers;
    auxiliary_element_4: T_Numbers;
  i:integer;
 BEGIN
  if((IsZero(big_number1)) or (IsZero(big_number2)))then
    BEGIN
      result.length:=1;
      result.keep_numbers[1]:=0;
      result.Ispositive:=TRUE;
    END
    ELSE IF((IsOne(big_number1)) or (IsOne(big_number2)))THEN
    BEGIN
      IF(IsOne(big_number1))THEN
          result:=big_number2
    ELSE
        result:=big_number1;
  END
    ELSE
    BEGIN
    activate(result);
    FOR i:=big_number2.length DOWNTO 1 DO
      BEGIN
        activate(auxiliary_element_1);
          MovePosition(result,auxiliary_element_1, overflow);
          activate(auxiliary_element_2);
          Digit_Multiplication(big_number1,big_number2.keep_numbers[i],auxiliary_element_2, overflow);
          activate(result);
            auxiliary_element_1.IsPositive:=true;
            auxiliary_element_2.IsPositive:=true;
            reverse(auxiliary_element_1, auxiliary_element_3);
            reverse(auxiliary_element_2,auxiliary_element_4);
            Sum(auxiliary_element_3,auxiliary_element_4, result);
    END;
    Check_sign(auxiliary_element_1,auxiliary_element_2,result);
  END;
END;

{----------------END--MULTIPLICACION---------------------}

PROCEDURE Operation_Centre(operation:char;VAR number1: T_numbers; VAR number2: T_numbers);
VAR
  overflow:boolean;
  result:T_numbers;
BEGIN
  CASE operation OF
      '*': BEGIN
          overflow:=FALSE;
            Multiplication (big_number1,big_number2,result,overflow);
        IF overflow THEN
              writeln ('DESBORDAMIENTO')
        ELSE
              ShowNumber_reverse(result);
      END;
        '+': BEGIN
        Sum(number1,number2,result);
        ShowNumber_reverse(result);
      END;
      '-': BEGIN
        number2.IsPositive:= not number2.IsPositive;
            Sum(number1,number2,result);
            ShowNumber_reverse(result);
      END;
      '=': BEGIN
        writeln(IsEqual(number1,number2));
      END;
      '>': BEGIN
          writeln(IsGreather(number1,number2));
      END;
      '<': BEGIN
          writeln(IsGreather(number2,number1));
      END;
    END;
END;

{*********************COMIENZO DEL CUERPO***********************************}
BEGIN
  readln(operation);
  ReadNumbers(number_string, big_number1);
  if(operation='*')then
    NumberStringTokeepNumbers_reverse(number_string,big_number1,big_number1.keep_numbers)
  else
    numberStringTOkeepNumbers(number_string,big_number1,big_number1.keep_numbers);
  ReadNumbers(number_string, big_number2);
  if(operation='*')then
    NumberStringTokeepNumbers_reverse(number_string,big_number2,big_number2.keep_numbers)
  else
    numberStringTOkeepNumbers(number_string,big_number2,big_number2.keep_numbers);
  Operation_centre(operation, big_number1, big_number2);
readln();
END.
