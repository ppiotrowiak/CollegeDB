/*
Plik:	indeksy.sql
Opis:	plik tworzacy indeksy na tabelach bazy PraceDyplomowe
*/

-- ustawiam robocza baze danych
USE PraceDyplomowe
GO

-- tabela Pracownik:
CREATE INDEX ix_pracownik_tytul
ON Pracownik(Tytul_naukowy)
GO

CREATE INDEX ix_pracownik_nazwisko_imie
ON Pracownik(Nazwisko,Imie)
GO

--tabela Student:
CREATE INDEX ix_student_nazwisko_imie
ON Student(nazwisko,imie)
GO

-- tabela PraceDyplomowe
CREATE INDEX ix_pd_tytul
ON PraceDyplomowe(Tytul)
GO

CREATE INDEX ix_pd_rodzaj
ON PraceDyplomowe(ID_rodzaj)
GO

CREATE INDEX ix_pd_pracownik
ON PraceDyplomowe(ID_pracownik)
GO

-- tabela Slownik
CREATE INDEX ix_slownik_slowo
ON Slownik(slowo)
GO

-- tabela autorstwo
CREATE INDEX ix_autorstwo_pd_student
ON Autorstwo(ID_pd,ID_student)
GO

CREATE INDEX ix_autorstwo_student_pd
ON Autorstwo(ID_student,ID_pd)
GO

-- tabela Obrona
CREATE INDEX ix_obrona_data
ON Obrona(Data)
GO

CREATE INDEX ix_obrona_pd
ON Obrona(ID_pd)
GO

CREATE INDEX ix_obrona_student
ON Obrona(ID_student)
GO

CREATE INDEX ix_obrona_data_ocena
ON Obrona(Data,ID_ocena)
GO

-- tabela Recenzje
CREATE INDEX ix_recenzje_data
ON Recenzje(Data)
GO

CREATE INDEX ix_recenzje_pd
ON Recenzje(ID_pd)
GO

CREATE INDEX ix_recenzje_pracownik_pd
ON Recenzje(ID_pracownik,ID_pd)
GO

-- tabela SlowaKluczowe
CREATE INDEX ix_slowakluczowe_pd_slowo
ON SlowaKluczowe(ID_pd, ID_slowo)
GO

CREATE INDEX ix_slowakluczowe_slowo_pd
ON SlowaKluczowe(ID_slowo,ID_pd)
GO