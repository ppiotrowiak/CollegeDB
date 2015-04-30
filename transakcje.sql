/*
Plik:	transakcje.sql
Opis:	przyklad wykorzystania transakcji do usuwania rekordow
	z tabeli PraceDyplomowe oraz powiazanych rekordow z innych tabel
	dla zachowania spojnosci
*/


-- ustawiam robocza baze danych
USE PraceDyplomowe
GO

-- deklaracje zmiennych
DECLARE @ID_pd int, @ID_slowo int
SET @ID_pd = 7 -- usuwam prace o ID_pd =

-- rozpoczecie transakcji
BEGIN TRAN  

-- usuniecie rekordow z tabeli Recenzje
DELETE FROM Recenzje 
WHERE ID_pd = @ID_pd
-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN

-- usuniecie rekordow z tabeli Obrona
DELETE FROM Obrona
WHERE ID_pd = @ID_pd
-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN

-- usuniecie rekordow z tabeli SlowaKluczowe
DELETE FROM SlowaKluczowe
WHERE ID_pd = @ID_pd
-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN

-- usuniecie rekordow z tabeli Autorstwo
DELETE FROM Autorstwo
WHERE ID_pd = @ID_pd
-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN

-- usuniecie rekordu z tabeli PraceDyplomowe
DELETE FROM PraceDyplomowe
WHERE ID_pd = @ID_pd
-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN

-- usuniecie z tabeli Slownik niepotrzebnych juz slow kluczowych
DECLARE kursor_slownik CURSOR FOR
SELECT ID_slowo
FROM Slownik
-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN

-- otwarcie kursora
OPEN kursor_slownik

-- pobranie pierwszej wartosci kursora do zmiennej
FETCH NEXT FROM kursor_slownik
INTO @ID_slowo

-- przeszukuje tabele SlowaKluczowe pod katem wystepowania slow
-- z tabeli Slownik, jesli slowo nie jest przypisane zadnej pracy
-- jest usuwane
WHILE @@FETCH_STATUS = 0
BEGIN
	IF (SELECT COUNT(*) FROM SlowaKluczowe
	WHERE ID_Slowo = @ID_slowo)
	= 0
	DELETE FROM Slownik WHERE ID_slowo = @ID_slowo
	
	-- w przypadku problemow cofnij cala transakcje
	IF @@ERROR <> 0 ROLLBACK TRAN
	
	-- sprawdz nastepne slowo
	FETCH NEXT FROM kursor_slownik INTO @ID_slowo
END


-- w przypadku problemow cofnij cala transakcje
IF @@ERROR <> 0 ROLLBACK TRAN


-- wyslanie transakcji
COMMIT TRAN

CLOSE kursor_slownik
DEALLOCATE kursor_slownik

GO
