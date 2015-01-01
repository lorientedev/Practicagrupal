PROGRAM Practica; {estan declarados los dos number_string , hay que modificar eso que hemos comentado y el programa principal para 
que lea y convierta los dos string}
CONST
  MIN = 1;
  MAX = 50;
TYPE
  T_keep_numbers = array[MIN..MAX] of integer;
  T_numbers = RECORD
    keep_numbers: t_keep_numbers;
    number_lenght: integer;
    IsPositive: boolean;
  END;

VAR
  big_number:  t_numbers;
  number_string_1: string[50];
  number_string_2: string[50];
  operation: char;
  a:integer;

FUNCTION  IsANumber(character:char): boolean;
BEGIN
  case character of
          '1', '2', '3','4','5','6','7','8','9','0' : BEGIN
                                                        IsANumber:= TRUE;
                                                        END;
  else
    IsANumber:= FALSE;
    END;
END;

FUNCTION CharToInt(character:char):integer;
BEGIN
  CASE character of
        '1' : CharToInt:=1;
        '2' : CharToInt:=2;
        '3' : CharToInt:=3;
        '4' : CharToInt:=4;
        '5' : CharToInt:=5;
        '6' : CharToInt:=6;
        '7' : CharToInt:=7;
        '8' : CharToInt:=8;
        '9' : CharToInt:=9;
        '0' : CharToInt:=0;
  END;
END;


PROCEDURE ReadNumbers(var number_string: string[50]; var number_lenght: integer; var positive:boolean);
VAR
  i: integer;
  number:char;
BEGIN
  i:=1;
  positive:=true;
  repeat
     read(number);
     if((ord(number)<>10) and (i<=50))then {Compruebo que el number no sea enter}
        begin
          if(IsANumber(number))then {Compruebo si number es un numero }
            begin
              number_string:= number_string + number;
              i:= i+1;
            end
            else if(number='-')then
              positive:=false;
        end;
  until ord(number)=10;
  number_lenght:= i - 1;
END;

FUNCTION NumberStringTokeepNumbers(number_string: string[50]; number_lenght: integer): t_keep_numbers;
VAR
  a:integer;
BEGIN
    for a:=1 to number_lenght do
    BEGIN
     numberstringTokeepNumbers[a]:= CharToInt(number_string[a]);
    END;
END;

BEGIN
  read(operation);
  ReadNumbers(number_string, big_number.number_lenght, big_number.IsPositive);
  big_number.keep_numbers:=NumberStringTokeepNumbers(number_string, big_number.number_lenght);
  for a:=1 to big_number.number_lenght do
  begin
    write(big_number.keep_numbers[a]);
  end;
  readln();
END.
