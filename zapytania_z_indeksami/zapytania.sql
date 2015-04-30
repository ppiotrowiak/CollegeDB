/*
Plik:	zapytania.sql
Opis:	wykonanie kilku zapytan wykorzystujacych indeksy

*/

-- ustawiam robocza baze danych (1)
USE PraceDyplomowe
GO

-- wyszukuje tytul pracy wg id promotora (2)
-- plan wykonania w pliku rys_1.bmp
SELECT Tytul
FROM PraceDyplomowe
WHERE ID_pracownik = 6
GO

-- wyszukuje pracownikow wedlug pierwszej litery nazwiska (3)
-- plan wykonania zapytania w pliku rys_2.bmp
SELECT Tytul_naukowy,Imie,Nazwisko
FROM Pracownik
WHERE Nazwisko LIKE 'P%'
GO

-- wyszukuje tytuly prac wedlug nazwiska promotora z wykorzystaniem
-- INNER JOIN (4)
-- plan wykonania zapytania w pliku rys_3.bmp
SELECT PraceDyplomowe.Tytul,Pracownik.Tytul_naukowy,
	Pracownik.Imie,Pracownik.Nazwisko
FROM Pracownik
INNER JOIN PraceDyplomowe
ON Pracownik.ID_pracownik = PraceDyplomowe.ID_pracownik
WHERE Pracownik.Nazwisko = 'Ziolkowski'
GO
