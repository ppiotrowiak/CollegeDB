/*
Plik:	elementy_tsql.sql
Opis:	Wykorzystanie dodatkowych elementow T-SQL
*/

-- ustawiam baze robocza (1)
USE PraceDyplomowe
GO

-- deklaruje zmienna i przypisuje jej wartosc (2)
DECLARE @plyta bit
SET @plyta = 1
-- wyszukuje rekordy w tabeli wg wartosci zmiennej
SELECT Tytul
FROM PraceDyplomowe
WHERE Plyta_dolaczona = @plyta
GO

-- uzycie CASE (3)
SELECT Tytul, 'CD' = CASE
WHEN Plyta_dolaczona = 1 THEN 'Dolaczona plyta CD'
ELSE 'Brak plyty CD'
END
FROM PraceDyplomowe
GO

-- uzycie funkcji systemowej @@ROWCOUNT (4)
-- do sprawdzenia ilosci zmienionych rekordow
SELECT * INTO Studenci_tmp -- najpierw tworze tabele tymczasowa
FROM Student

UPDATE Studenci_tmp SET Imie = 'Marian'
WHERE Imie = 'Przemyslaw' -- @@ROWCOUNT ustawiona

SELECT @@ROWCOUNT AS 'Ilosc zmienionych rekordow'
GO	

-- przyklad uzycia IF..ELSE oraz PRINT (5)
DECLARE @do_usuniecia varchar(50)
SET @do_usuniecia = 'Malarz'

DELETE FROM Studenci_tmp
WHERE nazwisko = @do_usuniecia

IF @@ROWCOUNT = 0 PRINT 'Nie usunieto zadnych rekordow'
ELSE PRINT 'Rekordy usunieto'
GO

-- Uzycie SELECT i IF..ELSE oraz zmiennych(6)
DECLARE @imie_czy_nazwisko varchar(50)
SET @imie_czy_nazwisko = 'nazwisko'

IF @imie_czy_nazwisko = 'imie'
	SELECT Imie 
	FROM Pracownik
ELSE IF @imie_czy_nazwisko = 'nazwisko' 
		SELECT Nazwisko
		FROM Pracownik

ELSE PRINT 'Kolumna o podanej nazwie nie wystepuje w tabeli'
GO


