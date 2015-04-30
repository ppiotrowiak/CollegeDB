/*
	Plik: 	baza.sql
	Opis: 	Skrypt tworzacy baze danych
		Prace Dyplomowe
	
	Autor: Przemyslaw Piotrowiak
*/

--Sprawdzam, czy baza juz istnieje
--jesli tak, to usuwam ja

IF EXISTS (SELECT *
		FROM	master..sysdatabases
		WHERE	name = 'PraceDyplomowe')
	DROP DATABASE PraceDyplomowe
GO

--ustawiam baze master jako robocza
USE master
GO

--tworze baze danych wraz z jej plikami
CREATE DATABASE PraceDyplomowe
ON
	(NAME = PraceDyplomowe_data,
	 FILENAME = 'F:\program files\microsoft sql server\mssql\data\PraceDyplomowe_data.mdf',
	 SIZE = 1,
	 MAXSIZE = 10,
	 FILEGROWTH = 1)
LOG ON
	(NAME = PraceDyplomowe_log,
	 FILENAME = 'F:\program files\microsoft sql server\mssql\data\PraceDyplomowe_log.ldf',
	 SIZE = 512KB,
	 MAXSIZE = 5,	
	 FILEGROWTH = 512KB )
GO