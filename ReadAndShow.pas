Program Numeros_Grandes;

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

var 
number_string:string[50];
big_number1:T_numbers;
big_number2:T_numbers;
operation:char;
number1_lenght:integer;
number2_lenght:integer;


Function IsANumber(character:char):boolean;
  Begin
     case character of
          '1', '2', '3','4','5','6','7','8','9','0' : Begin
                                                               IsANumber:=true;
                                                              end;
     else IsANumber:=False;
    end;
  end;{==================FIN ISANUMBER=======================================}

Function CharToInt(character:char):integer;
Begin
  case character of
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
  end;
end;


Procedure ReadNumbers(var number_string:string[50]; var number_lenght:integer; var positive:boolean);{=======================}
var
i:integer;
number:char;
Begin
  number_string:='';
  i:=1;
  repeat
     read(number);
     if((ord(number)<>10) and (i<=50))then {Compruebo que el number no sea enter}
        begin
          if(IsANumber(number))then {Compruebo si number es un numero }
            begin
              number_string:=number_string+number;
              i:=i+1;
            end
            else if(number='-')then
              positive:=false;
        end;
  until ord(number)=10;
  number_lenght:=i-1;
end; {====================FIN READNUMBBER======================================}

Function numberstringTokeepNumbers(number_string:string[50]; number_lenght:integer):t_keep_numbers;
var a:integer;
Begin

    for a:=1 to number_lenght do
    begin
     numberstringTokeepNumbers[a]:=CharToInt(number_string[a]);

    end;
End;

 Procedure ShowNumber(big_number:t_keep_numbers; number_lenght:integer);
 var a:integer;
 Begin
     for a:=1 to number_lenght do
         write(big_number[a]);
     writeln();
 End;

BEGIN
 readln(operation);
 ReadNumbers(number_string, big_number1.number_lenght,big_number1.Ispositive);
 big_number1.keep_numbers:=numberStringTokeepNumbers(number_string,big_number1.number_lenght);
 ReadNumbers(number_string, big_number2.number_lenght, big_number2.Ispositive);
 big_number2.keep_numbers:=numberStringTokeepNumbers(number_string,big_number2.number_lenght);

 ShowNumber(big_number1.keep_numbers, big_number1.number_lenght);
 ShowNumber(big_number2.keep_numbers, big_number2.number_lenght);

readln();
END.
