/*
Plik:	widoki_mod.sql
Opis:	Plik zawierajace widoki, ktore moga sluzyc do modyfikacji danych
*/

-- ustawiam robocza baze danych
USE PraceDyplomowe
GO

-- widok Praca_dodawanie pozwalajacy  tytuly prac, przy czym nalezy
-- wybrac promotora pracy i jej rodzaj
CREATE VIEW Praca_dodawanie
AS
SELECT     PraceDyplomowe.Tytul, PraceDyplomowe.ID_pracownik, PraceDyplomowe.ID_rodzaj, 
	   Pracownik.Imie, Pracownik.Nazwisko,Pracownik.Tytul_naukowy, 
	   RodzajPracy.Rodzaj
FROM       PraceDyplomowe 
INNER JOIN RodzajPracy ON PraceDyplomowe.ID_rodzaj = RodzajPracy.ID_Rodzaj 
INNER JOIN Pracownik ON PraceDyplomowe.ID_pracownik = Pracownik.ID_pracownik
GO

-- test dodawania pracy
-- INSERT INTO Praca_dodawanie(Tytul, ID_pracownik, ID_rodzaj)
-- VALUES ('Praca testowa',2,2)
-- GO

-- widok Autorstwo_dodawanie pozwalajacy na powiazanie pracy ze studentem
CREATE VIEW Autorstwo_dodawanie
AS
SELECT     Autorstwo.ID_pd, Autorstwo.ID_student, Student.imie, 
	   Student.nazwisko, PraceDyplomowe.Tytul
FROM       Autorstwo 
INNER JOIN PraceDyplomowe ON Autorstwo.ID_pd = PraceDyplomowe.ID_pd 
INNER JOIN Student ON Autorstwo.ID_student = Student.ID_student
GO


-- przypisanie studentowi pracy
-- INSERT INTO Autorstwo_dodawanie(ID_pd,ID_student)
-- VALUES (8,2)
-- GO
