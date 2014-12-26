Program Numeros_Grandes;

type
t_keep_numbers = array[1..50] of char;
t_keep_binary = array[1..200] of integer;
var 
keep_numbers:t_keep_numbers;
keep_binary: t_keep_binary;
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


Procedure ReadNumbers(var keep_numbers:t_keep_numbers);{=======================}
var
i,a:integer;
number:char;
Begin
  i:=0;
  repeat
     read(number);
     if((ord(number)<>10) and (i<50))then {Compruebo que el number no sea enter}
        begin
          if(IsANumber(number))then {Compruebo si number es un numero }
            begin
              keep_numbers[i]:=number;
              i:=i+1;
            end;
        end;

  until ord(number)=10;
end; {====================FIN READNUMBBER======================================}

BEGIN
 ReadNumbers(keep_numbers);
 readln();
END.
