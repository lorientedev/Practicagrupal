Program Numeros_Grandes;

type
t_keep_numbers = array[1..50] of char;
var 
keep_numbers:t_keep_numbers;
operation,number:char;

Procedure ReadNumbers(var keep_numbers:t_keep_numbers);
var i,a:integer;
Begin
  i:=0;
  repeat
     i:=i+1;
     read(numeros);
     if((ord(numeros)<>10) and (i<=50))then
        t_numeros[i]:=numeros;
  until ord(numeros)=10;
  i:=i-1;
  if i>50 then
   i:=50;
end;

BEGIN
END.
