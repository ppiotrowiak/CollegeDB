/* 
Plik: import.sql
Opis: skrypt importujacy dane z plikow tekstowych do tabel
*/

-- (1) ustaw PraceDyplomowe jako baze robocza 
USE PraceDyplomowe
GO

-- (2) skasuj ewentualna zawartosc tabel
DELETE Autorstwo
DELETE Obrona
DELETE Ocena
DELETE PraceDyplomowe
DELETE Pracownik
DELETE Recenzje
DELETE RodzajPracy
DELETE SlowaKluczowe
DELETE Slownik
DELETE Student
GO

-- (3) wyzeruj liczniki kluczy glownych
-- (w tabelach Autorstwo, Obrona, Recenzje, SlowaKluczowe 
--  nie zeruje, bo nie ma klucza glownego)
DBCC CHECKIDENT (RodzajPracy,RESEED,1)
GO
DBCC CHECKIDENT (Slownik,RESEED,1)
GO
DBCC CHECKIDENT (Student,RESEED,1)
GO
DBCC CHECKIDENT (PraceDyplomowe,RESEED,1)
GO
DBCC CHECKIDENT (Pracownik,RESEED,1)
GO
DBCC CHECKIDENT (Ocena,RESEED,1)
GO

-- (4) zaimportuj dane z plikow tekstowych do tabel
-- podajac separatory pojedynczych pol i wierszy
BULK INSERT PraceDyplomowe.dbo.RodzajPracy
   FROM 'C:\RodzajPracy.txt'
   WITH
     (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Student
   FROM 'C:\Student.txt'
   WITH
     (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Ocena
   FROM 'C:\Ocena.txt'
   WITH
     (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Pracownik
   FROM 'C:\Pracownik.txt'
   WITH
     (
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Slownik
   FROM 'C:\Slownik.txt'
   WITH
     (	
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.PraceDyplomowe
   FROM 'C:\PraceDyplomowe.txt'
   WITH
     (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.SlowaKluczowe
   FROM 'C:\SlowaKluczowe.txt'
   WITH 
     (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Autorstwo
   FROM 'C:\Autorstwo2.txt'
   WITH
     (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Recenzje
   FROM 'C:\Recenzje.txt'
   WITH
     (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO

BULK INSERT PraceDyplomowe.dbo.Obrona
   FROM 'C:\Obrona.txt'
   WITH
     (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	CODEPAGE = 'ACP'
      )
GO


-- (5) zobacz zawartosc tabel
SELECT * FROM RodzajPracy
SELECT * FROM Student
SELECT * FROM Ocena
SELECT * FROM Pracownik
SELECT * FROM Slownik
SELECT * FROM PraceDyplomowe
SELECT * FROM SlowaKluczowe
SELECT * FROM Autorstwo
SELECT * FROM Recenzje
SELECT * FROM Obrona
GO


