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

VAR
  number_string:string[50];
  big_number1:T_numbers;
  big_number2:T_numbers;
  operation:char;


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
end;{===================END CHARTOINT=======================================}


Procedure ReadNumbers(var number_string:string[50]; var big_number: T_numbers);{=======================}
var
  i:integer;
  number:char;
Begin
  number_string:='';
  i:=1;
  big_number.Ispositive:=true;
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
              big_number.Ispositive:=false;
        end;
  until ord(number)=10;
  big_number.number_lenght:=i-1;
end; {====================FIN READNUMBBER======================================}

Function numberstringTokeepNumbers(number_string:string[50]; big_number:T_numbers):t_keep_numbers;
var a:integer;
Begin

    for a:=1 to big_number.number_lenght do
    begin
     numberstringTokeepNumbers[a]:=CharToInt(number_string[a]);

    end;
End;{============================END NUMBERSTRING TO KEEPNUMBERS===================}

 Procedure ShowNumber(big_number:t_numbers);
 var a:integer;
 Begin
  if(big_number.IsPositive=false)then
      write('-');
     for a:=1 to big_number.number_lenght do
         write(big_number.keep_numbers[a]);
     writeln();
 End;{=====================END SHOWNUMBER==========================================}


{*********************COMIENZO DEL CUERPO***********************************}
BEGIN
 readln(operation);

 ReadNumbers(number_string, big_number1);
 big_number1.keep_numbers:=numberStringTokeepNumbers(number_string,big_number1);

 ReadNumbers(number_string, big_number2);
 big_number2.keep_numbers:=numberStringTokeepNumbers(number_string,big_number2);


 ShowNumber(big_number1);
 ShowNumber(big_number2);

readln();
END.
