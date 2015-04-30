/*

	Plik:	jezyk_dcl.sql
	Opis:	polecenia jezyka DCL dla bazy PraceDyplomowe
*/

-- Ustawiam baze robocza
USE PraceDyplomowe
GO

-- tworze grupe Dziekanat
EXEC sp_addrole Dziekanat
GO

-- tworze dwoch uzytkownikow: pani_Ewa i pani_Zuzanna oraz przyznaje dostep do bazy
EXEC sp_addlogin pani_Ewa
EXEC sp_addlogin pani_Zuzanna
EXEC sp_grantdbaccess pani_Ewa
EXEC sp_grantdbaccess pani_Zuzanna
GO

-- dodaje uzytkownikow pani_Ewa i pani_Zuzanna do grupy Dziekanat
EXEC sp_addrolemember Dziekanat, pani_Ewa
EXEC sp_addrolemember Dziekanat, pani_Zuzanna
GO


-- nadaje uprawnienia do wykonywania polecania INSERT
-- na tabeli Student grupie Dziekanat
GRANT INSERT ON Student TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania UPDATE
-- na tabeli Student grupie Dziekanat
GRANT UPDATE ON Student TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania SELECT
-- na tabeli Student grupie Dziekanat
GRANT SELECT ON Student TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania DELETE
-- na tabeli Student grupie Dziekanat
GRANT DELETE ON Student TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania INSERT
-- na tabeli Pracownik grupie Dziekanat
GRANT INSERT ON Pracownik TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania UPDATE
-- na tabeli Pracownik grupie Dziekanat
GRANT UPDATE ON Pracownik TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania SELECT
-- na tabeli Pracownik grupie Dziekanat
GRANT SELECT ON Pracownik TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecania DELETE
-- na tabeli Pracownik grupie Dziekanat
GRANT DELETE ON Pracownik TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecenia INSERT
-- na tabeli PraceDyplomowe grupie Dziekanat
GRANT INSERT ON PraceDyplomowe TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecenia UPDATE
-- na tabeli PraceDyplomowe grupie Dziekanat
GRANT INSERT ON PraceDyplomowe TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecenia SELECT
-- na tabeli PraceDyplomowe grupie Dziekanat
GRANT SELECT ON PraceDyplomowe TO Dziekanat
GO

-- nadaje uprawnienia do wykonywania polecenia DELETE
-- na tabeli PraceDyplomowe grupie Dziekanat
GRANT DELETE ON PraceDyplomowe TO Dziekanat
GO


