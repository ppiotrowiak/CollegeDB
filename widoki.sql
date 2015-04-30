/*
Plik:	widoki.sql
Opis:	plik tworzacy kilka widokow w bazie PraceDyplomowe
*/

-- ustawiam robocza baze danych (1)
USE PraceDyplomowe
GO

-- Tworze widok autorzy_prac, przedstawiajacy autorow prac i tytuly prac, 
-- oraz rodzaj pracy.
-- Widok pozwala na wyswietlenie imion i nazwisk studentow, ktorzy
-- napisali (lub zobowiazali sie napisac, badz sa w trakcie)
-- jakies prace
CREATE VIEW autorzy_prac
AS
SELECT     Student.imie, Student.nazwisko, 
	   PraceDyplomowe.Tytul,RodzajPracy.Rodzaj
FROM       Autorstwo 
INNER JOIN PraceDyplomowe ON Autorstwo.ID_pd = PraceDyplomowe.ID_pd
INNER JOIN Student ON Autorstwo.ID_student = Student.ID_student
INNER JOIN RodzajPracy ON PraceDyplomowe.ID_rodzaj = RodzajPracy.ID_Rodzaj
GO

-- Tworze widok promotorzy_prac
-- Widok pozwala na wyciagniecie z bazy promotor prac wedlug tytulow prac
-- i ich rodzajow
CREATE VIEW promotorzy_prac
AS
SELECT	   Pracownik.Tytul_naukowy, Pracownik.Imie, Pracownik.Nazwisko,
	   PraceDyplomowe.Tytul, RodzajPracy.Rodzaj
FROM       PraceDyplomowe 
INNER JOIN Pracownik ON PraceDyplomowe.ID_pracownik = Pracownik.ID_pracownik 
INNER JOIN RodzajPracy ON PraceDyplomowe.ID_rodzaj = dbo.RodzajPracy.ID_Rodzaj
GO

-- Tworze widok WynikiObron
-- dzieki ktoremu mozna sprawdzic, ktorzy studenci, kiedy i na jaka ocene
-- obronili prace
CREATE VIEW WynikObron
AS
SELECT     Student.imie, Student.nazwisko, PraceDyplomowe.Tytul, Obrona.Data,
	   Ocena.Ocena
	   
FROM       Obrona 
INNER JOIN PraceDyplomowe ON Obrona.ID_pd = PraceDyplomowe.ID_pd 
INNER JOIN Student ON Obrona.ID_student = Student.ID_student 
INNER JOIN Ocena ON Obrona.ID_ocena = Ocena.ID_ocena
GO

-- Widok WynikiRecenzji
-- dzieki widokowi mozna sprawdzic na jakie oceny prace zostaly ocenione przez 
-- recenzentow i kto byl recenzentem
CREATE VIEW WynikiRecenzji
AS
SELECT     PraceDyplomowe.Tytul, Recenzje.Data, Ocena.Ocena, 
	   Pracownik.Tytul_naukowy, Pracownik.Imie, Pracownik.Nazwisko
FROM       Ocena 
INNER JOIN Recenzje ON Ocena.ID_ocena = Recenzje.ID_ocena 
INNER JOIN PraceDyplomowe ON Recenzje.ID_pd = PraceDyplomowe.ID_pd 
INNER JOIN Pracownik ON Recenzje.ID_pracownik = Pracownik.ID_pracownik
GO

-- Widok SlowaKluczoweTytulyPrac
-- dzieki widokowi mozna sprawdzic jakie slowa kluczowe wystepuja w 
-- poszczegolnych pracach
CREATE VIEW SlowaKluczoweTytulyPrac
AS
SELECT     Slownik.slowo,PraceDyplomowe.Tytul
FROM       PraceDyplomowe 
INNER JOIN SlowaKluczowe ON PraceDyplomowe.ID_pd = SlowaKluczowe.ID_pd 
INNER JOIN Slownik ON SlowaKluczowe.ID_slowo = Slownik.ID_slowo
GO

