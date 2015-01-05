Program Numeros_Grandes;

CONST
  MIN = 1;
  MAX = 50;
TYPE
  T_keep_numbers = array[MIN..MAX] of integer;
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
  big_number.length:=i-1;
end; {====================FIN READNUMBBER======================================}

Function numberstringTokeepNumbers(number_string:string[50]; big_number:T_numbers):t_keep_numbers;
var a:integer;
Begin

    for a:=1 to big_number.length do
    begin
     numberstringTokeepNumbers[a]:=CharToInt(number_string[a]);

    end;
End;{============================END NUMBERSTRING TO KEEPNUMBERS===================}

 Procedure ShowNumber(big_number:t_numbers);
 var a:integer;
 Begin
  if(big_number.IsPositive=false)then
      write('-');
     for a:=1 to big_number.length do
         write(big_number.keep_numbers[a]);
     writeln();
 End;{=====================END SHOWNUMBER==========================================}

Function IsEqual_without_compare_simbol(number1,number2:T_numbers):boolean;
var
a:integer;

Begin

    if(number1.length = number2.length)then
      begin  

        IsEqual_without_compare_simbol:=true;
        for a:=1 to number1.length do
          begin

              if(number1.keep_numbers[a] <> number2.keep_numbers[a])then
                  IsEqual_without_compare_simbol:=false;

          end;

      end 
    else
      IsEqual_without_compare_simbol:=FALSE;

End;

Function IsEqual(number1,number2:T_numbers):boolean;
begin

      if (number1.IsPositive = number2.Ispositive)then
          IsEqual:= IsEqual_without_compare_simbol(number1,number2)
      else
          IsEqual:=False;

end;

Function IsSameSimbol(number1,number2:T_numbers):boolean;
begin
  If(number1.Ispositive = number2.IsPositive)then
      IsSameSimbol:=True
  else
      IsSameSimbol:=False;
end;
Function When_simbol_is_equal_and_positive(number1,number2:T_numbers):boolean;
var
a:integer;
begin

    When_simbol_is_equal_and_positive:=FALSE;
    if(number1.length = number2.length)then
        begin

            for a:=1 to number1.length do
                begin

                    if(number1.keep_numbers[a] > number2.keep_numbers[a])then
                          When_simbol_is_equal_and_positive:=True;

                end;  

        end
        else if(number1.length > number2.length)then
                When_simbol_is_equal_and_positive:=TRUE;

end;
Function When_numbers_are_not_equals(number1,number2:T_numbers):boolean;
begin

      If (IsSameSimbol(number1,number2))then
            begin
                  if(number1.Ispositive=TRUE)then
                  begin

                       When_numbers_are_not_equals:=When_simbol_is_equal_and_positive(number1,number2);
                        
                  end
                  else if(number1.IsPositive=False)then
                  begin

                        When_numbers_are_not_equals:=When_simbol_is_equal_and_positive(number2,number1);

                  end;
            end
          else if(IsSameSimbol(number1,number2)=FALSE)then
            begin
              
              if(number1.IsPositive)then
                    When_numbers_are_not_equals:=TRUE;

            end;

end;
Function IsGreather(number1,number2:T_numbers):boolean;
Begin

    if( IsEqual(number1,number2) = FALSE )then
      begin
         IsGreather:=When_numbers_are_not_equals(number1,number2);
      end

    else
      IsGreather:=FALSE;

End;


Procedure Operation_Centre(operation:char;var number1: T_numbers; var number2: T_numbers);
  Begin

      case operation of
        {'+': Sum(number1,number2);
        
                '-': Begin
        
                        number2.IsPositive:= ! number2.IsPositive;
                        sum(number1, number2);
        
                     end;
        }
        '=': Begin

                writeln(IsEqual(number1,number2));
        
             end;

        '>': Begin
        
                        writeln(IsGreather(number1,number2));
        
              end; 
        
        '<': Begin
        
                        writeln(IsGreather(number2,number1));
        
              end;
        
        end;
  end;

{*********************COMIENZO DEL CUERPO***********************************}
BEGIN
 readln(operation);

 ReadNumbers(number_string, big_number1);
 big_number1.keep_numbers:=numberStringTokeepNumbers(number_string,big_number1);

 ReadNumbers(number_string, big_number2);
 big_number2.keep_numbers:=numberStringTokeepNumbers(number_string,big_number2);

 Operation_centre(operation, big_number1, big_number2);

 

readln();
END.
