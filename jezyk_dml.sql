/*
Plik:	jezyk_dml.sql
Opis:	plik z poleceniami jezyka DML
*/

--ustawiam baze robocza
USE PraceDyplomowe
GO

-- Przygotowuje tabele tymczasowa
SELECT * 
INTO Studenci_temp 
FROM Student
GO

-- Wyswietlam cala zawartosc tabeli tymczasowej
SELECT * 
FROM Studenci_temp
GO

-- Zliczam ilosc rekordow w tabeli
SELECT Count(*) AS [Liczba studentow]
FROM Studenci_temp
GO

-- Wyswietlam imiona i nazwiska wszystkich studentow, ktorych nazwiska
-- nie zaczynaja sie na Sz	
SELECT 'Imie i nazwisko: ' + imie + ' ' + nazwisko AS Student
FROM Studenci_temp
WHERE nazwisko NOT LIKE 'Sz%'
GO

-- nowy rekord do tabeli
INSERT INTO Studenci_temp(imie, nazwisko)
VALUES ('Miroslaw', 'Dusza')
GO

-- wyswietlam rekord z podanymi danymi
SELECT imie + ' ' + nazwisko AS Student
FROM Studenci_temp
WHERE imie='Miroslaw' AND nazwisko='Dusza'
GO 

-- zmieniam istniejacy rekord
UPDATE Studenci_temp
SET imie='Przemyslaw' 
WHERE imie='Miroslaw' AND nazwisko='Dusza'
GO

-- wyswietlam wszystkich studentow z podanym nazwiskiem
SELECT imie + ' ' + nazwisko AS Student
FROM Studenci_temp
WHERE nazwisko='Dusza'
GO

-- wyswietlam wszystkich studentow, ktorzy maja sz w nazwisku
SELECT imie,nazwisko 
FROM Studenci_temp
WHERE nazwisko LIKE '%sz%'
GO

-- usuwam pojedynczy rekord
DELETE FROM Studenci_temp
WHERE nazwisko='Szydlowski'
GO

-- usuwam cala zawartosc tabeli
TRUNCATE TABLE Studenci_temp
GO

-- wyswietlam cala zawartosc tabeli
SELECT * FROM Studenci_temp
GO

-- usuwam cala tabele
DROP TABLE Studenci_temp
GO

-- wyswietlam zawartosc tabeli Pracownik
SELECT Tytul_naukowy,Imie,Nazwisko 
FROM Pracownik
GO

-- wyswietlam wszystkich pracownikow z tytulem inzyniera 
-- w kolejnosci alfabetycznej
SELECT Tytul_naukowy AS Stopien,Imie,Nazwisko
FROM Pracownik
WHERE Tytul_naukowy LIKE '%inz.%'
ORDER BY Nazwisko
GO

-- wyswietlam wszystkich pracownikow tylko z tytulem dr
SELECT 'Dr ' + Imie + ' ' + Nazwisko AS Doktorzy
FROM Pracownik
WHERE Tytul_naukowy LIKE 'dr'
GO