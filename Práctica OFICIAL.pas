PROGRAM Practica;
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
  number_string: string[50];
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
     if((ord(number)<>10) and (i<=50))then {Compruebo que el number no sea enter}
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

{**********************MENOR X QUE Y**********************************}
FUNCTION Menor (big_number_1, big_number_2: t_numbers):boolean;
VAR
  i: integer;

BEGIN

IF (big_number_1.ispositive) AND (NOT big_number_2.ispositive) THEN
	Menor:= FALSE
ELSE IF (NOT big_number_1.ispositive) AND (big_number_2.ispositive) THEN
	Menor:= TRUE

ELSE IF (big_number_1.ispositive) AND (big_number_2.ispositive) THEN
 	BEGIN

    IF NumberOFDigits(big_number_1) > NumberOFDigits(big_number_2) THEN
    Menor:= FALSE

  ELSE IF NumberOFDigits(big_number_1) < NumberOFDigits(big_number_2) THEN
    Menor:= TRUE

  ELSE BEGIN
    i:= NumberOFDigits(big_number_1);

    WHILE (i >=1) AND (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) DO
      i:= i- 1;

    IF (big_number_1.keep_numbers[i] < big_number_2.keep_numbers[i]) THEN
	Menor:= TRUE
    ELSE
	Menor:= FALSE;

    END; {IF}
    END
ELSE IF (NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) THEN
	BEGIN
	IF NumberOFDigits(big_number_1) < NumberOFDigits(big_number_2) THEN
    Menor:= FALSE

  ELSE IF NumberOFDigits(big_number_1) > NumberOFDigits(big_number_2) THEN
    Menor:= TRUE

  ELSE BEGIN
    i:= NumberOFDigits(big_number_1);

    WHILE (i >=1) AND (big_number_1.keep_numbers[i] = big_number_2.keep_numbers[i]) DO
      i:= i- 1;

    IF (big_number_1.keep_numbers[i] > big_number_2.keep_numbers[i]) THEN
	Menor:= TRUE
    ELSE
	Menor:= FALSE;

    END; {IF}
    END;

END;{*********************END MENOR***********************************}

PROCEDURE SumNumbers ( var overflow: boolean; big_number_1: t_numbers; big_number_2: t_numbers; var result_total: t_numbers); FORWARD;

{***********************SUBTRACT**************************************}
PROCEDURE Subtrac (var overflow: boolean; big_number_1: t_numbers; big_number_2: t_numbers; var result_total: t_numbers);

VAR
	counter: integer;
	i: INTEGER;
	greater_number: integer;
	aux: t_numbers;

BEGIN

		IF (big_number_1.ispositive) AND (not big_number_2.ispositive) THEN
		BEGIN
			result_total.ispositive:= TRUE;
			big_number_2.ispositive:= TRUE;
			SumNumbers ( overflow, big_number1, big_number2, result);
		END
		ELSE
		IF (not big_number_1.ispositive) AND (big_number_2.ispositive) THEN
		BEGIN
			result_total.ispositive:= FALSE;
			big_number_1.ispositive:= TRUE;
			big_number_2.ispositive:= TRUE;
			SumNumbers ( overflow, big_number1, big_number2, result);
		END
		ELSE
		IF (big_number_1.ispositive) AND (big_number_2.ispositive) AND mayor (big_number_1, big_number_2) THEN
		BEGIN
			result_total.ispositive:= TRUE;

		IF big_number_1.number_lenght > big_number_2.number_lenght THEN
		BEGIN
			greater_number:= big_number_1.number_lenght;
			fill( big_number_1, big_number_2);
		end
		ELSE
		begin
			fill( big_number_2, big_number_1);
			greater_number:= big_number_2.number_lenght;
		end;
		counter:= 0;

		FOR i:= MIN TO greater_number DO
		BEGIN
			IF (big_number_1.keep_numbers[i] >= (big_number_2.keep_numbers[i] + counter) ) THEN
			BEGIN
				result_total.keep_numbers[i]:= (big_number_1.keep_numbers[i] - (big_number_2.keep_numbers[i] + counter));
				counter:=0;
			END
			ELSE BEGIN
				result_total.keep_numbers[i]:= ((big_number_1.keep_numbers[i]+10) -(big_number_2.keep_numbers[i] + counter));
				counter:= 1;
			END;
		END; {FOR}

		result_total.number_lenght:= NumberOFDigits(result_total) ;

		END

		ELSE

		IF (big_number_1.ispositive) AND (big_number_2.ispositive) AND mayor (big_number_2, big_number_1) THEN
		BEGIN
			result_total.ispositive:= FALSE;
			aux:= big_number_1;
			big_number_1:= big_number_2;
			big_number_2:= aux;

		{Resto al revés, y el resultado lo cambio de signo}
		IF big_number_1.number_lenght > big_number_2.number_lenght THEN
		BEGIN
			greater_number:= big_number_1.number_lenght;
			fill( big_number_1, big_number_2);
		end
		ELSE
		begin
			fill( big_number_2, big_number_1);
			greater_number:= big_number_2.number_lenght;
		end;
		counter:= 0;

		FOR i:= MIN TO greater_number DO
		BEGIN
			IF (big_number_1.keep_numbers[i] >= (big_number_2.keep_numbers[i] + counter) ) THEN
			BEGIN
				result_total.keep_numbers[i]:= (big_number_1.keep_numbers[i] - (big_number_2.keep_numbers[i] + counter));
				counter:=0;
			END
			ELSE BEGIN
				result_total.keep_numbers[i]:= ((big_number_1.keep_numbers[i]+10) -(big_number_2.keep_numbers[i] + counter));
				counter:= 1;
			END;
		END; {FOR}

		result_total.number_lenght:= NumberOFDigits(result_total) ;
		END;


		IF (NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) AND mayor (big_number_1, big_number_2) THEN
		BEGIN
			result_total.ispositive:= FALSE;

		IF big_number_1.number_lenght > big_number_2.number_lenght THEN
		BEGIN
			greater_number:= big_number_1.number_lenght;
			fill( big_number_1, big_number_2);
		end
		ELSE
		begin
			fill( big_number_2, big_number_1);
			greater_number:= big_number_2.number_lenght;
		end;
		counter:= 0;

		FOR i:= MIN TO greater_number DO
		BEGIN
			IF (big_number_1.keep_numbers[i] >= (big_number_2.keep_numbers[i] + counter) ) THEN
			BEGIN
				result_total.keep_numbers[i]:= (big_number_1.keep_numbers[i] - (big_number_2.keep_numbers[i] + counter));
				counter:=0;
			END
			ELSE BEGIN
				result_total.keep_numbers[i]:= ((big_number_1.keep_numbers[i]+10) -(big_number_2.keep_numbers[i] + counter));
				counter:= 1;
			END;
		END; {FOR}

		result_total.number_lenght:= NumberOFDigits(result_total) ;

		END

		ELSE

		IF (NOT big_number_1.ispositive) AND (NOT big_number_2.ispositive) AND mayor (big_number_2, big_number_1) THEN
		BEGIN
			result_total.ispositive:= TRUE;
			aux:= big_number_1;
			big_number_1:= big_number_2;
			big_number_2:= aux;

		{Resto al revés, y el resultado lo cambio de signo}
		IF big_number_1.number_lenght > big_number_2.number_lenght THEN
		BEGIN
			greater_number:= big_number_1.number_lenght;
			fill( big_number_1, big_number_2);
		end
		ELSE
		begin
			fill( big_number_2, big_number_1);
			greater_number:= big_number_2.number_lenght;
		end;
		counter:= 0;

		FOR i:= MIN TO greater_number DO
		BEGIN
			IF (big_number_1.keep_numbers[i] >= (big_number_2.keep_numbers[i] + counter) ) THEN
			BEGIN
				result_total.keep_numbers[i]:= (big_number_1.keep_numbers[i] - (big_number_2.keep_numbers[i] + counter));
				counter:=0;
			END
			ELSE BEGIN
				result_total.keep_numbers[i]:= ((big_number_1.keep_numbers[i]+10) -(big_number_2.keep_numbers[i] + counter));
				counter:= 1;
			END;
		END; {FOR}

		result_total.number_lenght:= NumberOFDigits(result_total) ;
		END;


END; {************************END SUBSTRACT*********************************}

PROCEDURE SumNumbers ( var overflow: boolean; big_number_1: t_numbers; big_number_2: t_numbers; var result_total: t_numbers);
VAR
	counter: integer;
	i: INTEGER;
	greater_number: integer;
BEGIN
		IF (big_number_1.ispositive) AND (not big_number_2.ispositive) THEN
		BEGIN
			result_total.ispositive:= FALSE;
			Subtrac( overflow, big_number1, big_number2, result);
		END;
		IF (not big_number_1.ispositive) AND (big_number_2.ispositive) THEN
		BEGIN
			result_total.ispositive:= FALSE;
			Subtrac( overflow, big_number2, big_number1, result);
		END;
		IF (big_number_1.ispositive) AND (big_number_2.ispositive) THEN
			result_total.ispositive:= TRUE;
		IF big_number_1.number_lenght > big_number_2.number_lenght THEN
		BEGIN
			greater_number:= big_number_1.number_lenght;
			fill( big_number_1, big_number_2);
		end
		ELSE
		begin
			fill( big_number_2, big_number_1);
			greater_number:= big_number_2.number_lenght;
		end;
		counter:= 0;
		FOR i:= MIN TO greater_number DO
		BEGIN
			result_total.keep_numbers[i]:= (big_number_1.keep_numbers[i] + big_number_2.keep_numbers[i] + counter) mod 10;
			counter:= ( big_number_1.keep_numbers[i] + big_number_2.keep_numbers[i] + counter ) div 10;
		END;
		IF greater_number < MAX THEN
			result_total.keep_numbers[greater_number + 1]:= counter
		ELSE
			overflow:= TRUE;
		result_total.number_lenght:= NumberOFDigits(result_total) ;
END;


{*********************COMIENZO DEL CUERPO***********************************}
BEGIN
	readln(operation);

	ReadNumbers(number_string, big_number1);
	big_number1.keep_numbers:= numberStringTokeepNumbers(number_string, big_number1);

	ReadNumbers(number_string, big_number2);
	big_number2.keep_numbers:=numberStringTokeepNumbers(number_string, big_number2);

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
		'>': BEGIN
  			result2:= Mayor (big_number1, big_number2);
			IF result2 THEN
				writeln('TRUE')
			ELSE
				writeln('FALSE');
		     END;
		'<': BEGIN
  			result2:= Menor (big_number1, big_number2);
			IF result2 THEN
				writeln('TRUE')
			ELSE
				writeln('FALSE');
		     END;
	END;
	readln();
END.
