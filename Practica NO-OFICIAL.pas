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
  number_string:string;
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


Procedure ReadNumbers(VAR number_string:string; VAR big_number: T_numbers);{=======================}
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

Function numberstringTOkeepNumbers(number_string:string; big_number:T_numbers):t_keep_numbers;
VAR a:integer;
BEGIN

    FOR a:=1 TO big_number.length DO
    BEGIN
     numberstringTOkeepNumbers[a]:=CharTOInt(number_string[a]);

    END;
END;{============================END NUMBERSTRING TO KEEPNUMBERS===================}

FUNCTION NumberStringTokeepNumbers_reverse(number_string: string; big_number: T_numbers): t_keep_numbers;
VAR
  a:integer;
  n:integer;
BEGIN
  n:= big_number.length;
    for a:=1 to big_number.length do { rellenar el array alreves del string para operar}
    begin
     numberstringTokeepNumbers_reverse[a]:=CharToInt(number_string[n]);
     n:= n -1;
    end;
END;{============================END NUMBERSTRING TO KEEPNUMBERS REVERSE===================}

 Procedure ShowNumber(big_number:t_numbers);
 VAR a:integer;
 BEGIN
  IF(big_number.IsPositive=false)THEN
      write('-');
     FOR a:=1 TO big_number.length DO
         write(big_number.keep_numbers[a]);
     writeln();
 END;{=====================END SHOWNUMBER==========================================}

Procedure ShowNumber_reverse(big_number:t_numbers);
 VAR a:integer;
 BEGIN
  IF(big_number.length>50)then
      BEGIN
      
      writeln('DESBORDAMIENTO');

      END
  
  else
    BEGIN  
      IF(big_number.IsPositive=false)THEN
          write('-');
         FOR a:=big_number.length  DOWNTO 1 DO
             write(big_number.keep_numbers[a]);
         writeln();
    END;
 END;

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

END;{==================FIN DE COMPARACIONES=====================================}

Procedure Fill_With_Zeroes(var number:T_numbers);{===================INICIO SUMA============================}
VAR
a:integer;
BEGIN

    for a:=1 to 50 DO
        number.keep_numbers[a]:=0; 

END;

Procedure Sum_with_same_simbol(number1,number2:T_numbers; var sum:T_numbers);
VAR 
a,len1,len2:integer;

BEGIN

            len1:=number1.length;
            len2:=number2.length;
            a:=1;

             repeat
                if(len1=0)then
                   BEGIN
                      Sum.keep_numbers[a]:= number2.keep_numbers[len2] + Sum.keep_numbers[a];
                      len2:=len2-1;
                   END
                else if(len2=0)then
                   BEGIN
                     Sum.keep_numbers[a]:= number1.keep_numbers[len1] + Sum.keep_numbers[a];
                      len1:=len1-1;
                   END   
                else
                    BEGIN
                        Sum.keep_numbers[a]:= number1.keep_numbers[len1] + number2.keep_numbers[len2] + Sum.keep_numbers[a];
                        len1:=len1-1;
                        len2:=len2-1;
                    END;

                if(Sum.keep_numbers[a] >= 10)THEN
                    BEGIN

                        Sum.keep_numbers[a+1]:= Sum.keep_numbers[a] div 10;
                        Sum.keep_numbers[a]:=   Sum.keep_numbers[a] mod 10;

                    END;

                a:=a+1;

            until ((len1=0) and (len2=0));

            IF (Sum.keep_numbers[a]=0)  THEN
               Sum.length:=a-1
            ELSE
               Sum.length:=a;
            Sum.IsPositive:= number1.IsPositive;

END;

Procedure Sum_with_diferent_simbol(number1,number2:T_numbers; VAR sum:T_numbers);
VAR
len1, len2:integer;
a:integer;
b:integer;
ceros:boolean;
BEGIN
    
    len1:=number1.length;
    len2:=number2.length;
    a:=1;


    repeat
            
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

                
    
    until ( (len1=0) and (len2=0) );
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
            


END;

Procedure Number_position(number1,number2:T_numbers; var Sum:T_numbers);
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
  END;

Function Sum(number1,number2:T_numbers):T_numbers;

BEGIN
    
    Fill_with_Zeroes(Sum);
   

    IF IsSameSimbol(number1,number2) THEN
                  
           Sum_with_same_simbol(number1,number2,Sum)

    ELSE IF( NOT IsSameSimbol(number1,number2))THEN

        Number_position(number1,number2,Sum);
        

END;{============================================================FIN SUMA=======================================}

 {------------------------- MULTIPLICACION------------------------------}
PROCEDURE inicializa(VAR big_number1:T_Numbers);
VAR
  i:integer;
BEGIN
  FOR i:= 1 TO MAX DO
    big_number1.keep_numbers[i]:=0;
  big_number1.length:=0;
  big_number1.IsPositive:=FALSE;
END;

PROCEDURE multiplica_por_10(big_number1:T_Numbers; VAR result:T_Numbers; VAR overflow:Boolean);
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
    inicializa(result);
END;

PROCEDURE multiplica_por_digito(big_number1:T_Numbers; d:integer; VAR result:T_Numbers; VAR overflow: Boolean);
VAR
  i,j: integer;
BEGIN
  result.IsPositive:=FALSE;

  IF (big_number1.length<>0) AND (d<>0) THEN
  BEGIN
    j:=0;
    FOR i:=1 TO big_number1.length DO
    BEGIN
      result.keep_numbers[i] := (big_number1.keep_numbers[i]*d+j) mod 10;
      j := (big_number1.keep_numbers[i]*d+j) div 10;
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
    inicializa(result);
END;
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
END;

 Function Reverse(big_number:t_numbers):T_numbers;
 VAR a,b:integer;
 BEGIN
     reverse.Ispositive:=big_number.Ispositive;
     b:=1;
     FOR a:=big_number.length DOWNTO 1 DO
        BEGIN
         reverse.keep_numbers[b]:=(big_number.keep_numbers[a]);
         b:=b+1;
        END;
     reverse.length:=big_number.length;
 END;{=====================END SHOWNUMBER==========================================}

Function IsZero(number:T_numbers):Boolean;
BEGIN
  IsZero:=FALSE;
  if(number.length=1)then
    BEGIN
      if(number.keep_numbers[1]=0)then
          IsZero:=TRUE;
    END;

END;  

Function IsOne(number:T_numbers):Boolean;
BEGIN
  IsOne:=False;
  if(number.length=1)then
    BEGIN
      if(number.keep_numbers[1]=1)then
          IsOne:=TRUE;
    END;
END;

Function Sum_reverse(number1,number2:T_Numbers):T_Numbers;
VAR
a:integer;
BEGIN
  a:=1;
  Fill_with_Zeroes(Sum_reverse);
  repeat

        IF(a>number1.length)THEN
          BEGIN
            Sum_reverse.keep_numbers[a]:= number2.keep_numbers[a] + Sum_reverse.keep_numbers[a];
          END
        ELSE IF(a>number2.length)THEN
          BEGIN  
           
            Sum_reverse.keep_numbers[a]:= number1.keep_numbers[a] + Sum_reverse.keep_numbers[a];
          END
        ELSE
          BEGIN
            Sum_reverse.keep_numbers[a]:= number1.keep_numbers[a] + number2.keep_numbers[a] + Sum_reverse.keep_numbers[a];
          END;
       

        IF(Sum_reverse.keep_numbers[a]>10)THEN
          BEGIN
            
            Sum_reverse.keep_numbers[a+1]:= Sum_reverse.keep_numbers[a] DIV 10;
            Sum_reverse.keep_numbers[a]:=   Sum_reverse.keep_numbers[a] mod 10;

          END;
          a:=a+1;
       
  until( (a>number1.length) and (a>number2.length));
  Sum_reverse.Ispositive:=TRUE;
  IF (Sum_reverse.keep_numbers[a]=0)  THEN
               Sum_reverse.length:=a-1
            ELSE
               Sum_reverse.length:=a;
END; 



PROCEDURE multiplica(big_number1,big_number2:T_Numbers; VAR result:T_Numbers; VAR overflow: Boolean);
VAR
  i:integer;
  s,t:T_Numbers;
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
      inicializa(result);
      FOR i:=big_number2.length DOWNTO 1 DO
      BEGIN
        inicializa(s);
        multiplica_por_10(result,s, overflow);
        inicializa(t);
        multiplica_por_digito(big_number1,big_number2.keep_numbers[i],t, overflow);
        inicializa(result);
            s.IsPositive:=true;
            t.IsPositive:=true;
            result:=Sum(reverse(s),reverse(t));
      END;
       Check_sign(s,t,result);
  END;
END;

{----------------END--MULTIPLICACION---------------------}

Procedure Operation_Centre(operation:char;VAR number1: T_numbers; VAR number2: T_numbers);
var
overflow:boolean;
result:T_numbers;
  BEGIN

      CASE operation OF
        '*': BEGIN
              overflow:=FALSE;
                                          Multiplica (big_number1,big_number2,result,overflow);
                            
                                          IF overflow THEN
                                            writeln ('DESBORDAMIENTO')
                                          ELSE
                                            ShowNumber_reverse(result);
             END;
        '+': BEGIN
                  
                  ShowNumber_reverse(Sum(number1,number2));

        
             END; 
              
        '-': BEGIN
         
                  number2.IsPositive:= not number2.IsPositive;
                                    ShowNumber_reverse(sum(number1, number2));
        
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
  big_number1.keep_numbers:=NumberStringTokeepNumbers_reverse(number_string,big_number1)
 else
  big_number1.keep_numbers:=numberStringTOkeepNumbers(number_string,big_number1);

 ReadNumbers(number_string, big_number2);
 if(operation='*')then
    big_number2.keep_numbers:=NumberStringTokeepNumbers_reverse(number_string,big_number2)
  else
    big_number2.keep_numbers:=numberStringTOkeepNumbers(number_string,big_number2);

 Operation_centre(operation, big_number1, big_number2);
 


readln();
END.
