/*
Plik:	proc.sql
Opis:	plik zawiera dwie przykladowe procedury skladowane
*/

--ustawiam robocza baze danych (1)
USE PraceDyplomowe
GO

--tworze procedure zwracajaca tytuly i autorow prac dyplomowych (2)
--obronionych lub zaplanowanych w okreslonym przedziale dat
CREATE PROCEDURE prace_zakres_dat
	@granica_dolna smalldatetime = '2000-01-01',
	@granica_gorna smalldatetime = '2010-06-09',
	@znalezionych int OUTPUT
AS

DECLARE @komunikat varchar(100)

--sprawdzenie, czy podane daty sa w poprawnym formacie
IF (ISDATE(@granica_dolna)=1 AND ISDATE(@granica_gorna)=1)
	--sprawdzenie czy dolny zakres jest mniejszy od gornego
	IF @granica_dolna<=@granica_gorna
	BEGIN
	  SELECT imie,nazwisko,Tytul,Data,Ocena
	  FROM WynikObron
	  WHERE Data >= @granica_dolna AND Data <= @granica_gorna

	  SET @znalezionych = @@ROWCOUNT
	  IF @znalezionych = 0
	    BEGIN
		SET @komunikat = 'Nie znaleziono prac bronionych w podanym okresie czasu'
	  	PRINT @komunikat
	    END
	  ELSE 
	    BEGIN
		SET @komunikat = 'Znaleziono pewna liczbe prac'
		PRINT @komunikat
	    END
	END

	ELSE 
	  BEGIN
	  SET @komunikat = 'Blad. Data poczatkowa wieksza od daty koncowej'  	
	  PRINT @komunikat
	  END
ELSE
  BEGIN
	SET @komunikat = 'Blad. Podano nieprawidlowy format daty'
	PRINT @komunikat
  END

RETURN
GO

-- uzywam utworzonej procedury skladowanej (3)
DECLARE @poczatkowa smalldatetime, @koncowa smalldatetime
DECLARE @ile_prac int
SET @poczatkowa = '2003-01-01'
SET @koncowa = '2006-01-01'

EXECUTE prace_zakres_dat
@granica_dolna = @poczatkowa,
@granica_gorna = @koncowa,
@znalezionych = @ile_prac OUTPUT

PRINT CAST(@ile_prac  AS varchar(3))


-- uzywam utworzonej procedury skladowanej (3,5)
-- wywolanie z rekompilacja
DECLARE @poczatkowa smalldatetime, @koncowa smalldatetime
DECLARE @ile_prac int
SET @poczatkowa = '2003-01-01'
SET @koncowa = '2006-01-01'

EXECUTE prace_zakres_dat
@granica_dolna = @poczatkowa,
@granica_gorna = @koncowa,
@znalezionych = @ile_prac OUTPUT WITH RECOMPILE

PRINT CAST(@ile_prac  AS varchar(3))

-- procedura wyswietlajace liste recenzji, ktorych wyniki (4)
-- znajduja sie w wybranym przedziale od 20 do 50
CREATE PROCEDURE recenzje_zakres_ocen
	@ocena_dolna int = 20,
	@ocena_gorna int = 50,	
	@znalezionych_prac int OUTPUT
AS

DECLARE @komunikat varchar(100)

IF ((@ocena_dolna >= 20) AND (@ocena_gorna <=50))
 IF @ocena_dolna <= @ocena_gorna
  BEGIN
    SELECT Tytul,Data,Ocena
    FROM WynikiRecenzji
    WHERE Ocena >= @ocena_dolna AND Ocena <= @ocena_gorna
    ORDER BY Ocena DESC

    SET @znalezionych_prac = @@ROWCOUNT
    IF @znalezionych_prac = 0
     BEGIN 
	SET @komunikat = 'Nie znaleziono prac'
	PRINT @komunikat
     END
    ELSE 
     BEGIN
	SET @komunikat = 'Znaleziono pewna ilosc prac'
	PRINT @komunikat
     END 	
  END

  ELSE
  BEGIN
	SET @komunikat = 'Blad. Ocena dolna musi byc mniejsza badz rowna dolnej'
	PRINT @komunikat	
  END
ELSE
 BEGIN
  SET @komunikat = 'Blad. Ocena musi zawierac sie w przedziale 20-50)'
  PRINT @komunikat	
 END
RETURN
GO

-- wywolanie procedury recenzje_zakres_ocen
DECLARE @ile int
EXECUTE recenzje_zakres_ocen
@ocena_dolna = 40,
@ocena_gorna = 50,
@znalezionych_prac = @ile OUTPUT
GO
