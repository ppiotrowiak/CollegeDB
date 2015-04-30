/*
	Plik:	jezyk_ddl.sql
	Opis: 	skrypt do modyfikacji i usuwania tabel bazy danych
*/

-- ustawiam PraceDyplomowe jako robocza baze
USE PraceDyplomowe
GO

-- dodaje kolumne numer_indeksu do tabeli Student
ALTER TABLE Student
	ADD numer_indeksu int
GO

-- dodaje ograniczenie, numer_indeksu >= 10000 i <= 99999
ALTER TABLE Student
	ADD CONSTRAINT CK_numer_indeksu CHECK 
		((numer_indeksu >= 10000) AND (numer_indeksu <= 99999))
GO

-- pozwalam na wartosci zerowe w kolumnie numer_indeksu
ALTER TABLE Student
	ALTER COLUMN numer_indeksu
		int NULL
GO

-- usuwam ograniczenie numerow indeksu
ALTER TABLE Student
	DROP CONSTRAINT CK_numer_indeksu 
GO

-- usuwam kolumne numer_indeksu
ALTER TABLE Student
	DROP COLUMN numer_indeksu
GO

-- tworze tabele Brudnopis
CREATE TABLE Brudnopis  (
	ID_Brudnopis int IDENTITY(1,1) PRIMARY KEY,
	kol1 nvarchar(20),
	kol2 nvarchar(30)
)
GO

-- usuwam tabele Brudnopis
DROP TABLE Brudnopis
GO
	

-- koniec skryptu