/* 
Plik: tabele.sql
Opis: skrypt tworzacy tabele bazy danych PraceDyplomowe 
*/

-- ustawiamy baze danych PraceDyplomowe jako robocza
USE PraceDyplomowe
GO


-- tworzymy tabele RodzajPracy
CREATE TABLE RodzajPracy (
	ID_Rodzaj 	tinyint IDENTITY(1,1)
		CONSTRAINT PK_Rodzaj
		PRIMARY KEY CLUSTERED,
	Rodzaj	char(11) NOT NULL )
GO


-- tworzymy tabele Slownik
CREATE TABLE Slownik (
	ID_slowo 	int IDENTITY(1,1)
		CONSTRAINT PK_slowo
		PRIMARY KEY CLUSTERED,
	slowo 	varchar(20) NOT NULL )
GO

-- tworzymy tabele Student
CREATE TABLE Student (
	ID_student 	int IDENTITY(1,1)
		CONSTRAINT PK_student
		PRIMARY KEY CLUSTERED,
	imie 		varchar(20) NOT NULL,
	nazwisko 	varchar(50) NOT NULL )
GO

-- tworzymy tabele Ocena
CREATE TABLE Ocena (
	ID_ocena	tinyint IDENTITY(1,1)
		CONSTRAINT PK_ocena
		PRIMARY KEY CLUSTERED,
	Ocena	tinyint NOT NULL )
GO

-- tworzymy tabele Pracownik
CREATE TABLE Pracownik	(
	ID_pracownik	int IDENTITY(1,1)
		CONSTRAINT PK_pracownik
		PRIMARY KEY CLUSTERED,
	Tytul_naukowy	varchar(20) NULL,
	Imie		varchar(20) NOT NULL,
	Nazwisko	varchar(50) NOT NULL )
GO

-- tworzymy tabele PraceDyplomowe
CREATE TABLE PraceDyplomowe (
	ID_pd	int IDENTITY(1,1)
		CONSTRAINT PK_pd
		PRIMARY KEY CLUSTERED,
	Tytul	varchar(100) NOT NULL,
	Plyta_dolaczona	bit NULL,
	ID_pracownik	int NOT NULL,
	ID_rodzaj	tinyint NOT NULL,
	CONSTRAINT FK_promotor
	FOREIGN KEY (ID_pracownik)
	REFERENCES Pracownik(ID_pracownik),
	CONSTRAINT FK_rodzaj
	FOREIGN KEY (ID_rodzaj)
	REFERENCES RodzajPracy(ID_rodzaj) )
GO

-- tworzymy tabele SlowaKluczowe
CREATE TABLE SlowaKluczowe (
	ID_pd		int NOT NULL,
	ID_slowo	int NOT NULL,
	
	CONSTRAINT PK_SlowaKluczowe	
	PRIMARY KEY CLUSTERED (ID_pd,ID_slowo),
	CONSTRAINT FK_PraceDyplomowe
	FOREIGN KEY (ID_pd)
	REFERENCES PraceDyplomowe(ID_pd),
	CONSTRAINT FK_Slownik
	FOREIGN KEY (ID_slowo)
	REFERENCES Slownik(ID_slowo) )
GO

-- tworzymy tabele Autorstwo
CREATE TABLE Autorstwo (
	ID_pd		int NOT NULL,
	ID_student	int NOT NULL,
	
	CONSTRAINT PK_Autorstwo
	PRIMARY KEY CLUSTERED (ID_pd, ID_student),
	CONSTRAINT FK_AutorstwoPracy
	FOREIGN KEY (ID_pd)
	REFERENCES PraceDyplomowe (ID_pd),
	CONSTRAINT FK_Autor
	FOREIGN KEY (ID_student)
	REFERENCES Student(ID_student)	)
GO

-- tworzymy tabele Obrona
CREATE TABLE Obrona (
	ID_pd		int NOT NULL,
	ID_student	int NOT NULL,
	ID_ocena	tinyint NULL,
	Data		smalldatetime NOT NULL, 

	CONSTRAINT PK_Obrona
	PRIMARY KEY CLUSTERED (ID_pd, ID_student),
	CONSTRAINT FK_Praca
	FOREIGN KEY (ID_pd)
	REFERENCES PraceDyplomowe (ID_pd),
	CONSTRAINT FK_Student
	FOREIGN KEY (ID_student)
	REFERENCES Student(ID_student),
	CONSTRAINT FK_Ocena
	FOREIGN KEY (ID_ocena)
	REFERENCES Ocena(ID_ocena)
	)
GO

-- tworzymy tabele Recenzje
CREATE TABLE Recenzje (
	ID_pd		int NOT NULL,
	ID_pracownik	int NOT NULL,
	Data		smalldatetime NULL,
	ID_ocena	tinyint NULL,

	CONSTRAINT PK_Recenzje
	PRIMARY KEY CLUSTERED (ID_pd, ID_pracownik),
	
	CONSTRAINT FK_RecenzjeDoPrac
	FOREIGN KEY (ID_pd)
	REFERENCES PraceDyplomowe(ID_pd),
	
	CONSTRAINT FK_Recenzent
	FOREIGN KEY (ID_pracownik)
	REFERENCES Pracownik(ID_pracownik),
	
	CONSTRAINT FK_OcenaRecenzenta
	FOREIGN KEY (ID_ocena)
	REFERENCES Ocena(ID_ocena),
	)
GO	

	


