Program Numeros_Grandes;

type
t_keep_character_number = array[1..50] of char;
t_keep_numbers = array[1..50]of integer;
t_keep_binary = array[1..200] of integer;
var 
keep_character_number:t_keep_character_number;
keep_numbers:t_keep_numbers;
keep_binary: t_keep_binary;
operation:char;
binary_lenght:integer;
number_lenght,a:integer;


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


Procedure ReadNumbers(var keep_character_number:t_keep_character_number; var number_lenght:integer);{=======================}
var
i,a:integer;
number:char;
Begin
  i:=1;
  repeat
     read(number);
     if((ord(number)<>10) and (i<=50))then {Compruebo que el number no sea enter}
        begin
          if(IsANumber(number))then {Compruebo si number es un numero }
            begin
              keep_character_number[i]:=number;
              i:=i+1;
            end;
        end;
  until ord(number)=10;
  number_lenght:=i-1;
end; {====================FIN READNUMBBER======================================}

Function keepCharacterTokeepNumbers(keep_character_number:t_keep_character_number; number_lenght:integer):t_keep_numbers;
var a:integer;
Begin
    writeln('prue ',keep_character_number[1]);
    for a:=1 to number_lenght do
    begin
     keepCharacterTokeepNumbers[a]:=CharToInt(keep_character_number[a]);

    end;
End;


Procedure IntegerToBinary(var keep_numbers:t_keep_numbers; number_lenght:integer; var binary_lenght:integer; var keep_binary:t_keep_binary);
 var
 rest:integer;
 a,b:integer;
 binary_aux:integer;
 Begin
 rest:=0;
    for a:=1 to number_lenght do
      begin
        if a=1 then
          begin
            rest:=keep_numbers[a] mod 2;
            keep_numbers[a]:=keep_numbers[a] div 2;
          end
        else
        begin
          rest:=rest*10+keep_numbers[a];
          keep_numbers[a]:=rest div 2;
          rest:=rest mod 2;
        end;
      end;
      writeln('RESTO: ',rest);
      keep_binary[binary_lenght]:=rest;
      binary_lenght:=binary_lenght+1;
      if(binary_lenght<=170)then

          IntegerToBinary(keep_numbers,number_lenght,binary_lenght,keep_binary)
      else
      begin
      for a:=1 to 85 do
      begin
      binary_aux:=keep_binary[171-a];
      keep_binary[171-a]:=keep_binary[a];
      keep_binary[a]:=binary_aux;
      end;

      writeln('Inttobin2 ');
      for a:=1 to 170 do
       write(Keep_binary[a]);
       writeln('resto ',rest);
       end;
 End;


BEGIN
 ReadNumbers(keep_character_number, number_lenght);
 number_lenght:=number_lenght;

 writeln('Number lenght', number_lenght);

 keep_numbers:=keepCharacterTokeepNumbers(keep_character_number,number_lenght);
 binary_lenght:=1;
 IntegerToBinary(keep_numbers, number_lenght,binary_lenght,keep_binary);
 writeln();

 readln();
END.
