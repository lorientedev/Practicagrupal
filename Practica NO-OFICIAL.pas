Program Numeros_Grandes;

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

VAR
  number_string:string[50];
  big_number1:T_numbers;
  big_number2:T_numbers;
  operation:char;


Function IsANumber(character:char):boolean;
  BEGIN
     CASE character OF
          '1', '2', '3','4','5','6','7','8','9','0' : BEGIN
                                                               IsANumber:=true;
                                                              END;
     ELSE IsANumber:=False;
    END;
  END;{==================FIN ISANUMBER=======================================}

Function CharTOInt(character:char):integer;
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


Procedure ReadNumbers(VAR number_string:string[50]; VAR big_number: T_numbers);{=======================}
VAR
  i:integer;
  number:char;
BEGIN
  number_string:='';
  i:=1;
  big_number.Ispositive:=true;
  repeat
     read(number);
     IF((ord(number)<>10) and (i<=50))THEN {Compruebo que el number no sea enter}
        BEGIN
          IF(IsANumber(number))THEN {Compruebo si number es un numero }
            BEGIN
              number_string:=number_string+number;
              i:=i+1;
            END
            ELSE IF(number='-')THEN
              big_number.Ispositive:=false;
        END;
  until ord(number)=10;
  big_number.length:=i-1;
END; {====================FIN READNUMBBER======================================}

Function numberstringTOkeepNumbers(number_string:string[50]; big_number:T_numbers):t_keep_numbers;
VAR a:integer;
BEGIN

    FOR a:=1 TO big_number.length DO
    BEGIN
     numberstringTOkeepNumbers[a]:=CharTOInt(number_string[a]);

    END;
END;{============================END NUMBERSTRING TO KEEPNUMBERS===================}

 Procedure ShowNumber(big_number:t_numbers);
 VAR a:integer;
 BEGIN
  IF(big_number.IsPositive=false)THEN
      write('-');
     FOR a:=1 TO big_number.length DO
         write(big_number.keep_numbers[a]);
     writeln();
 END;{=====================END SHOWNUMBER==========================================}

Function IsEqual_without_compare_simbol(number1,number2:T_numbers):boolean;
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

END;

Function IsEqual(number1,number2:T_numbers):boolean;
BEGIN

      IF (number1.IsPositive = number2.Ispositive)THEN
          IsEqual:= IsEqual_without_compare_simbol(number1,number2)
      ELSE
          IsEqual:=False;

END;

Function IsSameSimbol(number1,number2:T_numbers):boolean;
BEGIN
  IF(number1.Ispositive = number2.IsPositive)THEN
      IsSameSimbol:=True
  ELSE
      IsSameSimbol:=False;
END;

Function When_simbol_is_equal_and_positive(number1,number2:T_numbers):boolean;
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

END;
Function When_numbers_are_not_equals(number1,number2:T_numbers):boolean;
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

END;
Function IsGreather(number1,number2:T_numbers):boolean;
BEGIN

    IF( IsEqual(number1,number2) = FALSE )THEN
      BEGIN
         IsGreather:=When_numbers_are_not_equals(number1,number2);
      END

    ELSE
      IsGreather:=FALSE;

END;


Procedure Operation_Centre(operation:char;VAR number1: T_numbers; VAR number2: T_numbers);
  BEGIN

      CASE operation OF
        {'+': Sum(number1,number2); 
              
          '-': BEGIN
        
                  number2.IsPositive:= ! number2.IsPositive;
                  sum(number1, number2);
        
               END;
        }
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
 big_number1.keep_numbers:=numberStringTOkeepNumbers(number_string,big_number1);

 ReadNumbers(number_string, big_number2);
 big_number2.keep_numbers:=numberStringTOkeepNumbers(number_string,big_number2);

 Operation_centre(operation, big_number1, big_number2);

 

readln();
END.
