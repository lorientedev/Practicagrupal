PROGRAM Practica;
CONST
  MIN = 1;
  MAX = 50;
TYPE
  T_keep_numbers = array[MIN..50] of integer;
  T_numbers = RECORD
    keep_numbers: t_keep_numbers;
    number_lenght: integer;
    IsPositive: boolean;
  END;

VAR
  number_string: string;
  big_number1: T_numbers;
  big_number2: T_numbers;
  result: T_numbers;
  operation: char;
  overflow: boolean;
  result2: boolean;


FUNCTION IsANumber(character:char):boolean;
BEGIN
     case character of
          '1', '2', '3','4','5','6','7','8','9','0' : BEGIN
                                                               IsANumber:=true;
                                                              end;
     else IsANumber:=False;
    end;
END;{==================FIN ISANUMBER=======================================}

FUNCTION CharToInt(character:char):integer;
BEGIN
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
END;{===================END CHARTOINT=======================================}


PROCEDURE ReadNumbers(var number_string: string[50]; var big_number: T_numbers);{=======================}
var
  i:integer;
  number:char;
BEGIN
  number_string:='';
  i:=1;
  big_number.Ispositive:=true;
  repeat
     read(number);
     if (ord(number)<>10) and (i<=50) then {Compruebo que el number no sea enter}
        begin
          if(IsANumber(number))then {Compruebo si number es un numero }
            begin
              number_string:= number_string+number;
              i:=i+1;
            end
            else if(number='-')then
              big_number.Ispositive:=false;
        end;
  until ord(number)=10;
  big_number.number_lenght:=i-1;
END; {====================FIN READNUMBBER======================================}

FUNCTION NumberStringTokeepNumbers(number_string: string[50]; big_number: T_numbers): t_keep_numbers;
VAR
	a:integer;
	n:integer;
BEGIN
	n:= big_number.number_lenght;
    for a:=1 to big_number.number_lenght do { rellenar el array alreves del string para operar}
    begin
     numberstringTokeepNumbers[a]:=CharToInt(number_string[n]);
     n:= n -1;
    end;
END;{============================END NUMBERSTRING TO KEEPNUMBERS===================}

PROCEDURE ShowNumber(big_number:t_numbers);
var
  a:integer;
BEGIN
  if( big_number.IsPositive = false) then
      write('-');
     for a:=big_number.number_lenght downto MIN do
         write(big_number.keep_numbers[a]);
     writeln();
END;{=====================END SHOWNUMBER==========================================}

PROCEDURE fill (VAR  big_number_1 :t_numbers; VAR  big_number_2: t_numbers);
var
	i: integer;
BEGIN
	FOR i:= big_number_2.number_lenght + 1  TO  big_number_1.number_lenght DO
		 big_number_2.keep_numbers[i]:= 0;

END;{=====================END FILL==========================================}

FUNCTION NumberOFDigits ( big_number : T_numbers): integer;
VAR
	counter: integer;
BEGIN
	counter:= MAX;
	WHILE (big_number.keep_numbers[counter] = 0) AND (counter >= 1) DO
	BEGIN
		 counter:= counter - 1;
	END;
	NumberOfDigits:= counter;

END;{=====================END NumberOFDigits=========================================}

{*******************FUNCIÓN IGUAL******************************************}

FUNCTION Igual (big_number_1, big_number_2: t_numbers):boolean;
VAR
  i: integer;

BEGIN

  i:=1;
  IF (big_number_1.ispositive) AND (big_number_2.ispositive) AND (NumberOFDigits (big_number_1) = NumberOFDigits (big_number_2)) THEN

    BEGIN
      WHILE (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) AND (i< NumberOFDigits (big_number_1)) DO
        i:= i+1;

      IF (i= NumberOFDigits (big_number_1)) AND (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) THEN
         Igual:= TRUE;

    END
  ELSE IF ( NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) AND (NumberOFDigits (big_number_1) = NumberOFDigits (big_number_2)) THEN

    BEGIN
      WHILE (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) AND (i< NumberOFDigits (big_number_1)) DO
        i:= i+1;

      IF (i= NumberOFDigits (big_number_1)) AND (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) THEN
         Igual:= TRUE;

    END
  ELSE
    Igual:= FALSE;

END;{*********************END IGUAL***********************************}

{**********************MAYOR X QUE Y**********************************}
FUNCTION Mayor (big_number_1, big_number_2: t_numbers):boolean;
VAR
  i: integer;

BEGIN
IF (big_number_1.ispositive) AND (NOT big_number_2.ispositive) THEN
	Mayor:= TRUE
ELSE IF (NOT big_number_1.ispositive) AND (big_number_2.ispositive) THEN
	Mayor:= FALSE
ELSE IF ( big_number_1.ispositive) AND (big_number_2.ispositive) THEN
BEGIN
IF NumberOFDigits(big_number_1) > NumberOFDigits(big_number_2) THEN
    Mayor:= TRUE

  ELSE IF NumberOFDigits(big_number_1) < NumberOFDigits(big_number_2) THEN
    Mayor:= FALSE

  ELSE BEGIN
    i:= NumberOFDigits(big_number_1);

    WHILE (i >=1) AND (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) DO
      i:= i- 1;

    IF (big_number_1.keep_numbers[i] > big_number_2.keep_numbers[i]) THEN
	Mayor:= TRUE
    ELSE
	Mayor:= FALSE;

    END;
    END {IF}
ELSE IF (NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) THEN
BEGIN
IF NumberOFDigits(big_number_1) < NumberOFDigits(big_number_2) THEN
    Mayor:= TRUE

  ELSE IF NumberOFDigits(big_number_1) > NumberOFDigits(big_number_2) THEN
    Mayor:= FALSE

  ELSE BEGIN
    i:= NumberOFDigits(big_number_1);

    WHILE (i >=1) AND (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) DO
      i:= i- 1;

    IF (big_number_1.keep_numbers[i] < big_number_2.keep_numbers[i]) THEN
	Mayor:= TRUE
    ELSE
	Mayor:= FALSE;

    END;
END;

END;{*********************END MAYOR***********************************}


PROCEDURE SumNumbers ( var overflow: boolean; VAR big_number_1: t_numbers; VAR big_number_2: t_numbers; var result_total: t_numbers); FORWARD;

{*****************RESTA**********************}

PROCEDURE Resta (VAR overflow1: boolean; bignumber_1,bignumber_2: t_numbers; VAR resulttotal:t_numbers);
VAR
 	counter: integer;
 	i: integer;
 	greater_number: integer;

BEGIN

IF bignumber_1.number_lenght > bignumber_2.number_lenght THEN
		BEGIN
			greater_number:= bignumber_1.number_lenght;
			fill( bignumber_1, bignumber_2);
		end
		ELSE
		begin
			fill( bignumber_2, bignumber_1);
			greater_number:= bignumber_2.number_lenght;
		end;
		counter:= 0;

		FOR i:= MIN TO greater_number DO
		BEGIN
			IF (bignumber_1.keep_numbers[i] >= (bignumber_2.keep_numbers[i] + counter) ) THEN
			BEGIN
				resulttotal.keep_numbers[i]:= (bignumber_1.keep_numbers[i] - (bignumber_2.keep_numbers[i] + counter));
				counter:=0;
			END
			ELSE BEGIN
				resulttotal.keep_numbers[i]:= ((bignumber_1.keep_numbers[i]+10) -(bignumber_2.keep_numbers[i] + counter));
				counter:= 1;
			END;
		END;

		resulttotal.number_lenght:= NumberOFDigits(resulttotal) ;
END;

{**********************END RESTA*********************************}

{***********************SUBTRAC**************************************}

PROCEDURE Subtrac (var overflow: boolean; big_number_1: t_numbers; big_number_2: t_numbers; var result_total: t_numbers);

BEGIN
IF (big_number_1.ispositive) AND (big_number_2.ispositive) AND mayor (big_number_1, big_number_2) THEN
	BEGIN
	Resta (overflow, big_number_1, big_number_2, result_total);
	result_total.ispositive:=TRUE;
	END

ELSE IF (big_number_1.ispositive) AND (big_number_2.ispositive) AND mayor (big_number_2, big_number_1) THEN
	BEGIN
	Resta (overflow, big_number_2, big_number_1, result_total);
	result_total.ispositive:=FALSE;
	END

ELSE IF (NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) AND mayor (big_number_1, big_number_2) THEN
	BEGIN
	big_number_1.ispositive:= TRUE;
	big_number_2.ispositive:= TRUE;
	Resta (overflow, big_number_2, big_number_1, result_total);
	result_total.ispositive:=TRUE;
	END

ELSE IF (NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) AND mayor (big_number_2, big_number_1) THEN
	BEGIN

	Resta (overflow, big_number_1, big_number_2, result_total);
	result_total.ispositive:=FALSE;
	END

ELSE IF (big_number_1.ispositive) AND (NOT big_number_2.ispositive) THEN
	BEGIN
	big_number_2.ispositive:=TRUE;
	SumNumbers ( overflow, big_number_1, big_number_2, result_total);
	END

ELSE IF (NOT big_number_1.ispositive) AND (big_number_2.ispositive) THEN
	BEGIN
	big_number_1.ispositive:=TRUE;
	SumNumbers ( overflow, big_number_1, big_number_2, result_total);
	result_total.ispositive:= FALSE;
	END

ELSE IF Igual(big_number_1, big_number_2) THEN
	result_total.keep_numbers[MIN]:=0;


IF (result_total.number_lenght > MAX) THEN
  overflow:= TRUE;

END; {************************END SUBTRAC*********************************}

PROCEDURE Suma (overflow:boolean; bignumber1, bignumber2: t_numbers; VAR resulttotal: t_numbers);
VAR
greaternumber,i, counter: integer;

BEGIN

	IF bignumber1.number_lenght > bignumber2.number_lenght THEN
		BEGIN
			greaternumber:= bignumber1.number_lenght;
			fill( bignumber1, bignumber2);
		end
		ELSE
		begin
			fill( bignumber2, bignumber1);
			greaternumber:= bignumber2.number_lenght;
		end;
		counter:= 0;
		FOR i:= MIN TO greaternumber DO
		BEGIN
			resulttotal.keep_numbers[i]:= (bignumber1.keep_numbers[i] + bignumber2.keep_numbers[i] + counter) mod 10;
			counter:= ( bignumber1.keep_numbers[i] + bignumber2.keep_numbers[i] + counter ) div 10;
		END;

IF greaternumber < MAX THEN
			resulttotal.keep_numbers[greaternumber + 1]:= counter
		ELSE
			overflow:= TRUE;

resulttotal.number_lenght:= NumberOFDigits(resulttotal) ;

END; {********************END SUMA*****************}

PROCEDURE SumNumbers ( var overflow: boolean; var big_number_1: t_numbers; var big_number_2: t_numbers; var result_total: t_numbers);

BEGIN

IF (big_number_1.ispositive = big_number_2.ispositive) THEN
	BEGIN
	Suma (overflow, big_number_1, big_number_2, result_total);
	result_total.ispositive:= big_number_1.ispositive;
	END

ELSE IF (big_number_1.ispositive) AND (NOT big_number_2.ispositive) THEN
	 BEGIN
	 big_number_2.ispositive:=TRUE;
	 IF mayor(big_number_1, big_number_2) THEN
	 	BEGIN
	 	Subtrac (overflow, big_number_1, big_number_2, result_total);
	 	result_total.ispositive:= TRUE;
		END
	 ELSE IF mayor (big_number_2, big_number_1) THEN
	 	BEGIN
	 	Subtrac (overflow, big_number_2, big_number_1, result_total);
	 	result_total.ispositive:= FALSE;
	 	END
	 ELSE IF igual (big_number_1, big_number_2) THEN
	 	BEGIN
	 	result_total.number_lenght:= 1;
	 	result_total.keep_numbers[1]:=0;
	 	result_total.ispositive:=TRUE;
	 	END;
	 END

ELSE IF (NOT big_number_1.ispositive) AND (big_number_2.ispositive) THEN
	BEGIN
	big_number_1.ispositive:=TRUE;
	IF mayor(big_number_1, big_number_2) THEN
		BEGIN
	 	Subtrac (overflow, big_number_1, big_number_2, result_total);
	 	result_total.ispositive:= FALSE;
		END
	 ELSE IF mayor (big_number_2, big_number_1) THEN
	 	BEGIN
	 	Subtrac (overflow, big_number_2, big_number_1, result_total);
	 	result_total.ispositive:= TRUE;
	 	END
	 ELSE IF igual (big_number_1, big_number_2) THEN
	 	BEGIN
	 	result_total.number_lenght:= 1;
	 	result_total.keep_numbers[1]:=0;
	 	result_total.ispositive:=TRUE;
	 	END;
	 END;

END;
 {------------------------- MULTIPLICACION------------------------------}
PROCEDURE inicializa(VAR big_number1:T_Numbers);
VAR
	i:integer;
BEGIN
	FOR i:= 1 TO MAX DO
		big_number1.keep_numbers[i]:=0;
	big_number1.number_lenght:=0;
	big_number1.IsPositive:=FALSE;
END;

PROCEDURE multiplica_por_10(big_number1:T_Numbers; VAR result:T_Numbers; VAR overflow:Boolean);
VAR
	i: integer;
BEGIN
	IF big_number1.number_lenght<>0 THEN
	BEGIN
		IF big_number1.number_lenght<MAX THEN
		BEGIN
			FOR i:= big_number1.number_lenght DOWNTO 1 DO
				result.keep_numbers[i+1]:=big_number1.keep_numbers[i];
		END
		ELSE
			overflow:=TRUE;

		result.keep_numbers[1]:=0;
		result.number_lenght := big_number1.number_lenght+1
	END
	ELSE
		inicializa(result);
END;

PROCEDURE multiplica_por_digito(big_number1:T_Numbers; d:integer; VAR result:T_Numbers; VAR overflow: Boolean);
VAR
	i,j: integer;
BEGIN
	result.IsPositive:=FALSE;

	IF (big_number1.number_lenght<>0) AND (d<>0) THEN
	BEGIN
		j:=0;
		FOR i:=1 TO big_number1.number_lenght DO
		BEGIN
			result.keep_numbers[i] := (big_number1.keep_numbers[i]*d+j) mod 10;
			j := (big_number1.keep_numbers[i]*d+j) div 10;
		END;
		result.number_lenght:=big_number1.number_lenght;
		IF j>0 THEN
		BEGIN
			IF result.number_lenght<MAX THEN
				result.keep_numbers[i+1]:=j
			ELSE
				overflow:=TRUE;
			result.number_lenght:=result.number_lenght+1;
		END
	END
	ELSE
		inicializa(result);
END;
PROCEDURE Check_sign(number1,number2:T_numbers; VAR result:T_numbers);
BEGIN
    if(big_number1.Ispositive)then
            begin
                 if(big_number2.Ispositive)then
                      result.IsPositive:=true
                 else
                      result.IsPositive:=False;
            end
    else
            begin
                 if(big_number2.Ispositive)then
                      result.IsPositive:=False
                 else
                      result.IsPositive:=True;

            end;
END;
PROCEDURE multiplica(big_number1,big_number2:T_Numbers; VAR result:T_Numbers; VAR overflow: Boolean);
VAR
	i:integer;
	s,t:T_Numbers;
BEGIN
	inicializa(result);
	FOR i:=big_number2.number_lenght DOWNTO 1 DO
	BEGIN
		inicializa(s);
		multiplica_por_10(result,s, overflow);
		inicializa(t);
		multiplica_por_digito(big_number1,big_number2.keep_numbers[i],t, overflow);
		inicializa(result);
        write('s= ');
        ShowNumber(s);
        writeln();
        write('t= ');
        ShowNumber(t);
        writeln();
        write('result= ');
        ShowNumber(result);

		SumNumbers(overflow,s,t,result);
        write('result2= ');
        ShowNumber(result);
        Check_sign(big_number1,big_number2,result);

	END;
END;

{----------------END--MULTIPLICACION---------------------}


PROCEDURE Operation_Centre(operation:char;VAR number1: T_numbers; VAR number2: T_numbers);

BEGIN
CASE operation OF
		'-': BEGIN
			overflow:= FALSE;
			Subtrac ( overflow , big_number1, big_number2, result);
			IF overflow THEN
				writeln('DESBORDAMIENTO')
			ELSE
				ShowNumber(result);
		END;

		'+': BEGIN
			overflow:= FALSE;
			SumNumbers ( overflow, big_number1, big_number2, result);
			IF overflow THEN
				writeln('DESBORDAMIENTO')
			ELSE
				ShowNumber(result);
		     END;
		'=': BEGIN
  			result2:= Igual (big_number1, big_number2);
			IF result2 THEN
				writeln('TRUE')
			ELSE
				writeln('FALSE');
		     END;
		 '*': BEGIN
			overflow:=FALSE;
			Multiplica (big_number1,big_number2,result,overflow);

			IF overflow THEN
				writeln ('DESBORDAMIENTO')
			ELSE
				ShowNumber (result);
			END;
		'>': BEGIN
  			result2:= Mayor (big_number1, big_number2);
			IF result2 THEN
				writeln('TRUE')
			ELSE
				writeln('FALSE');
		     END;
		'<': BEGIN
  			result2:= Mayor(big_number2, big_number1);
			IF result2 THEN
				writeln('TRUE')
			ELSE
				writeln('FALSE');
		     END;
END;

END;

{*********************COMIENZO DEL CUERPO***********************************}
BEGIN
	readln(operation);

	ReadNumbers(number_string, big_number1);
	big_number1.keep_numbers:= numberStringTokeepNumbers(number_string, big_number1);

	ReadNumbers(number_string, big_number2);
	big_number2.keep_numbers:=numberStringTokeepNumbers(number_string, big_number2);

	Operation_centre(operation, big_number1, big_number2);


	readln();
END.
