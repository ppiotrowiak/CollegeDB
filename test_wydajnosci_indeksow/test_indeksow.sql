/*
Plik:	test_indeksow.sql
Opis:	plik testujacy wydajnosc zapytan przed i po zalozeniu przykladowych indeksow
*/

-- ustawiam robocza baze (1)
USE PraceDyplomowe
GO

-- tworze kopie tabeli Slownik do celow testowych (2)
IF EXISTS (
	SELECT name
	FROM sysobjects
	WHERE name='Slownik_tmp')
DROP TABLE Slownik_tmp
GO

SELECT * INTO Slownik_tmp
FROM Slownik
GO


-- sprawdzam jakie indeksy sa zalozone w tabeli (3)
EXEC sp_helpindex Slownik_tmp
GO

-- wlaczam pomiar ilosci skanowanych stron (4)
SET statistics io on
GO

-- dokonuje pomiaru wyszukiwania bez indeksu na kolumnie 'slowo' (5)
SELECT * FROM Slownik_tmp
WHERE slowo = 'eksploatacja'
GO

/*
Wynik powyzszego zapytania to:

(1 row(s) affected)

Table 'Slownik_tmp'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0.
*/

-- tworze indeks na kolumnie slowo (6)
CREATE INDEX slowa_a_z ON Slownik_tmp(slowo)
GO

-- wyszukuje slowa z wykorzystaniem indeksu (7)
SELECT *
FROM Slownik_tmp
WHERE slowo = 'eksploatacja'
GO

/*
wyniki pomiarow sa takie same:
(1 row(s) affected)

Table 'Slownik_tmp'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0.

i wynika to z malej ilosci danych w tabeli
*/

-- usuwam tabele testowa
DROP TABLE Slownik_tmp 
GO

-- tworze kopie tabeli PraceDyplomowe do celow testowych
IF EXISTS (
	SELECT name 
	FROM sysobjects
	WHERE name = 'PraceDyplomowe_tmp')
DROP TABLE PraceDyplomowe_tmp
GO
	
SELECT * INTO PraceDyplomowe_tmp
FROM PraceDyplomowe
GO

-- Pomiar bez indeksow na kolumnie ID_pracownik
SELECT Tytul FROM PraceDyplomowe
WHERE ID_pracownik = 6
GO

/* wynik:

(1 row(s) affected)

Table 'PraceDyplomowe'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0.
*/

-- zalozenie indeksu na kolumnie ID_pracownik
CREATE INDEX promotor ON PraceDyplomowe_tmp(ID_pracownik)
GO

-- wyszukiwanie rekordu
SELECT Tytul FROM PraceDyplomowe
WHERE ID_pracownik = 6
GO

/*
wynik:

(1 row(s) affected)

Table 'PraceDyplomowe'. Scan count 1, logical reads 2, physical reads 0, read-ahead reads 0.

z powodu malej ilosci rekordow w tabeli wyniki pomiarow takie same
przeszukiwana jest tylko jedna strona z danymi
*/
