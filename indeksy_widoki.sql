/*
Plik:	indeksy_widoki.sql
Opis:	a)sprawdzenie czy dotychczas utworzone widoki mozna zaindeksowac

*/

-- ustawiam robocza baze danych
USE PraceDyplomowe
GO

-- ustawiam opcje polaczenia
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

-- sprawdzam czy widok Autorstwo_dodawanie mozna zaindeksowac
PRINT '** sprawdzam czy widok Autorstwo_dodawanie mozna zaindeksowac **'
IF 
(SELECT OBJECTPROPERTY(object_id('Autorstwo_dodawanie'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	

-- sprawdzam czy widok Autorzy_prac mozna zaindeksowac
PRINT '** sprawdzam czy widok Autorzy_prac mozna zaindeksowac **'
IF 
(SELECT OBJECTPROPERTY(object_id('Autorzy_prac'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	


-- sprawdzam czy widok Praca_dodawanie mozna zaindeksowac
PRINT 'sprawdzam czy widok Praca_dodawanie mozna zaindeksowac'
IF 
(SELECT OBJECTPROPERTY(object_id('Praca_dodawanie'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	

-- sprawdzam czy widok Promotorzy_prac mozna zaindeksowac
PRINT 'sprawdzam czy widok Promotorzy_prac mozna zaindeksowac'
IF 
(SELECT OBJECTPROPERTY(object_id('Promotorzy_prac'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	

-- sprawdzam czy widok SlowaKluczoweTytulyPrac mozna zaindeksowac
PRINT 'sprawdzam czy widok SlowaKluczoweTytulyPrac mozna zaindeksowac'
IF 
(SELECT OBJECTPROPERTY(object_id('SlowaKluczoweTytulyPrac'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	

-- sprawdzam czy widok WynikiRecenzji mozna zaindeksowac
PRINT 'sprawdzam czy widok WynikiRecenzji mozna zaindeksowac'
IF 
(SELECT OBJECTPROPERTY(object_id('WynikiRecenzji'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	
	
-- sprawdzam czy widok WynikObron mozna zaindeksowac
PRINT 'sprawdzam czy widok WynikObron mozna zaindeksowac'
IF 
(SELECT OBJECTPROPERTY(object_id('WynikObron'),'IsIndexable'))
= 1 PRINT 'Mozna'
ELSE PRINT 'Nie mozna'
GO	

-- tworze widok, ktory mozna indeksowac
CREATE VIEW TytulySlowaKlucz_poindeksowane
WITH SCHEMABINDING
AS
SELECT PraceDyplomowe.Tytul,Slownik.slowo
FROM dbo.PraceDyplomowe
INNER JOIN dbo.SlowaKluczowe ON PraceDyplomowe.ID_pd = SlowaKluczowe.ID_pd
INNER JOIN dbo.Slownik ON SlowaKluczowe.ID_slowo = Slownik.ID_slowo
GO

-- sprawdzam czy widok TytulySlowaKlucz_poindeksowane mozna indeksowac
PRINT '** sprawdzam czy widok TytulySlowaKlucz_poindeksowane mozna zaindeksowac'
IF 
(SELECT OBJECTPROPERTY(object_id('TytulySlowaKlucz_poindeksowane'),'IsIndexable'))
= 1 PRINT 'Mozna!'
ELSE PRINT 'Nie mozna'
GO

-- tworze indeks w widoku TytulySlowaKlucz_poindeksowane
-- tytuly alfabetycznie po nich slowa kluczowe alfabetycznie
CREATE UNIQUE CLUSTERED INDEX ci_TytulySlowaKlucz
ON TytulySlowaKlucz_poindeksowane (Tytul,slowo)
GO
