-- =========================
-- TABLES (SCHEMA)
-- =========================
Go
CREATE DATABASE BarbershopDmytro 
GO
USE BarbershopDmytro
Go 

--Позиція барбера 
CREATE TABLE PositionBarbers

(	
    PositionId	 INT PRIMARY KEY IDENTITY,
	PositionName NVARCHAR(50) NOT NULL UNIQUE
	
												)
 GO

--Послуги та ціни 
CREATE TABLE Service_Price_Time

(
	Id				INT PRIMARY KEY IDENTITY,
	ServiceName		NVARCHAR(100) NOT NULL,
	Price			money NOT NULL,
	DurationMinutes INT NOT NULL
									)
GO

--Барбери 
CREATE TABLE Barbers

( 
	Id				 INT PRIMARY KEY IDENTITY,
	FirstName		 NVARCHAR(50) NOT NULL,
	LastName		 NVARCHAR(50) NOT NULL,
	MiddleName		 NVARCHAR(50) NULL,
	Gender			 NVARCHAR(20) NOT NULL,
	PhoneNumber		 NVARCHAR(30) NOT NULL,
	Email			 NVARCHAR(50) NULL,
	BirthDate		 date NOT NULL,
	HireDate		 date NOT NULL,
	PositionBarberId INT NOT NULL,
 
 CONSTRAINT FK_Position_Barber FOREIGN KEY (PositionBarberId) REFERENCES PositionBarbers(PositionId)
	                                                                                                     )
GO

--Проміжна табл. 
CREATE TABLE BarberServices
(
    BarberId  INT NOT NULL,
    ServiceId INT NOT NULL,

    PRIMARY KEY (BarberId, ServiceId),

 CONSTRAINT FK_Barber		 FOREIGN KEY (BarberId)  REFERENCES Barbers(Id),
 CONSTRAINT FK_BarberService FOREIGN KEY (ServiceId) REFERENCES Service_Price_Time(Id)
																						)
GO

--Розкладбарберів
CREATE TABLE Barber_layouts
(	
	Id			  INT PRIMARY KEY IDENTITY,
	BarberId      INT NOT NULL,
	AvailableDate DATE NOT NULL,
	StartTime	  TIME NOT NULL,
	EndTime		  TIME NOT NULL,
	
 CONSTRAINT FK_Barber_layout FOREIGN KEY (BarberId) REFERENCES Barbers(Id)
											                                    )
GO

--Клієнти 
CREATE TABLE Clients
(
	Id		    INT PRIMARY KEY IDENTITY,
	FirstName   NVARCHAR(50) NOT NULL,
	LastName    NVARCHAR(50) NOT NULL,
	MiddleName  NVARCHAR(50) NULL,
	PhoneNumber NVARCHAR(30) NOT NULL,
	Email		NVARCHAR(50) NULL
	                                     ) 
GO

--Відгуки кл. про барберів та фітбек
CREATE TABLE Feedback

(
	Id			 INT PRIMARY KEY IDENTITY,
	ClientId	 INT NOT NULL,
	BarberId	 INT NOT NULL,
	FeedbackText NVARCHAR(1000) NOT NULL,
	Rating		 INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
	
 CONSTRAINT FK_Cl_Feedback  FOREIGN KEY (ClientId) REFERENCES Clients(Id),
 CONSTRAINT FK_Bar_Feedback FOREIGN KEY (BarberId) REFERENCES Barbers(Id)
																				)
GO

--Записи клієнтів
CREATE TABLE Appointments
(
    Id INT PRIMARY KEY IDENTITY,
    BarberId	    INT NOT NULL,
    ClientId	    INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    
CONSTRAINT FK_Appointments_Bar FOREIGN KEY (BarberId)  REFERENCES Barbers(Id),
CONSTRAINT FK_Appointments_CL  FOREIGN KEY (ClientId)  REFERENCES Clients(Id)

																							)
GO

CREATE TABLE AppointmentServices
(
    AppointmentId INT NOT NULL,
    ServiceId	  INT NOT NULL,

    PRIMARY KEY (AppointmentId, ServiceId),

 CONSTRAINT FK_Appointments_app	FOREIGN KEY (AppointmentId) REFERENCES Appointments(Id),
 CONSTRAINT FK_Appointments_ser FOREIGN KEY (ServiceId)		REFERENCES Service_Price_Time(Id)
																								)
GO
	
--Архів відвідувань
CREATE TABLE VisitArchive 
(
    Id           INT PRIMARY KEY IDENTITY,
    ClientId     INT NOT NULL,
    BarberId     INT NOT NULL,
    VisitDate	 DATE NOT NULL,
    TotalPrice   MONEY NOT NULL,
    Rating		 INT NULL CHECK (Rating BETWEEN 1 AND 5),
    Feedback     NVARCHAR(1000) NULL,
 
 CONSTRAINT FK_VisitArchive_Cl   FOREIGN KEY (ClientId)  REFERENCES Clients(Id),
 CONSTRAINT FK_VisitArchive_Bar  FOREIGN KEY (BarberId)  REFERENCES Barbers(Id)
 
																					)
GO

--Послуги в архіві 
CREATE TABLE VisitServices 
(
    VisitId   INT NOT NULL,
    ServiceId INT NOT NULL,
    PRIMARY KEY (VisitId, ServiceId),
 
 CONSTRAINT FK_VisitArchive_Vis FOREIGN KEY (VisitId)   REFERENCES VisitArchive(Id),
 CONSTRAINT FK_VisitArchive_Ser FOREIGN KEY (ServiceId) REFERENCES Service_Price_Time(Id)
																							)