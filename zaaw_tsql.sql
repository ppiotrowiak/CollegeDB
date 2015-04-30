/*
Plik:	zaaw_tsql.sql
Opis:	przyklad uzycia agregacji i kursorow
*/

--ustawiam robocza baze (1)
USE PraceDyplomowe
GO

-- wyciagam z bazy prace obronione w roku 2005 (2)
-- stosuje zlaczenie wewnetrzne
SELECT PraceDyplomowe.Tytul AS 'Tytul pracy', Obrona.Data AS 'Data obrony'
FROM PraceDyplomowe
INNER JOIN Obrona
ON PraceDyplomowe.ID_pd = Obrona.ID_pd
WHERE DATEPART(year, Obrona.Data) = 2005
GO

-- zestawienie prac wg promotorow (3)
-- zastosowanie kursorow

-- deklaruje zmienne
DECLARE
@ID_pracownik int,
@pracownik_tytul varchar(20),
@pracownik_imie varchar(20),
@pracownik_nazwisko varchar(50),
@komunikat varchar(150),
@tytul varchar(100)

-- wyswietlam naglowek raportu
PRINT '------ Prace dyplomowe wedlug promotorow ------'

-- deklaruje kursor do przegladania pracownikow
DECLARE kursor_pracownik CURSOR FOR
SELECT ID_pracownik,Tytul_naukowy,Imie,Nazwisko
FROM Pracownik
ORDER BY Nazwisko

-- otwieram zadeklarowany kursor
OPEN kursor_pracownik

-- pobieram pierwszy rekord i wstawiam wartosci z pol do zmiennych
FETCH NEXT FROM kursor_pracownik
INTO @ID_pracownik, @pracownik_tytul, @pracownik_imie, @pracownik_nazwisko


-- w petli wyswietlam prace wedlug promotorow
-- przy uzyciu drugiego kursora
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT ' '
	SELECT @komunikat = '*** ' + @pracownik_tytul + ' ' 
		+ @pracownik_imie + ' ' + @pracownik_nazwisko + ' ***'
	PRINT @komunikat

	DECLARE kursor_prace CURSOR FOR
	SELECT Tytul
	FROM PraceDyplomowe
	WHERE ID_pracownik = @id_pracownik

	OPEN kursor_prace

	FETCH NEXT FROM kursor_prace INTO @tytul

	IF @@FETCH_STATUS <> 0
		PRINT '        Nie jest promotorem zadnej pracy'

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @komunikat = '	' + @tytul
		PRINT @komunikat
		FETCH NEXT FROM kursor_prace INTO @tytul
	END
	
	-- zamykam niepotrzebny kursor i zwalniam pamiec
	CLOSE kursor_prace
	DEALLOCATE kursor_prace

	FETCH NEXT FROM kursor_pracownik
	INTO @ID_pracownik, @pracownik_tytul, @pracownik_imie, 
		@pracownik_nazwisko
END

-- zamykam kursor i zwalniam pamiec
CLOSE kursor_pracownik
DEALLOCATE kursor_pracownik
GO
	

