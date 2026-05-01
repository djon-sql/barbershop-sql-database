-- =========================
-- DATA INSERTION
-- =========================
GO

BEGIN TRAN

INSERT INTO PositionBarbers (PositionName)
VALUES ('Chief'), ('Senior'), ('Junior')

SELECT *
FROM PositionBarbers

--ROLLBACK

--COMMIT 
	
SELECT *
FROM PositionBarbers

GO

--Генерація даних 
BEGIN TRAN

INSERT INTO Service_Price_Time (ServiceName, Price, DurationMinutes)
VALUES
('Haircut', 300, 30),
('Beard Trim', 200, 20),
('Haircut + Beard', 450, 50),
('Fade', 350, 40),
('Kids Haircut', 250, 25),
('Styling', 150, 15),
('Shaving', 200, 20),
('Premium Package', 600, 60)

SELECT *
FROM Service_Price_Time
ROLLBACK
--COMMIT

SELECT *
FROM Service_Price_Time

Go

INSERT INTO Barbers 
(FirstName, LastName, MiddleName, Gender, PhoneNumber, Email, BirthDate, HireDate, PositionBarberId)
SELECT TOP 50
    n.FirstName,
    s.LastName,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN NULL ELSE m.MiddleName END,
    'Male',
    '+380' + RIGHT('000000000' + CAST(ABS(CHECKSUM(NEWID()) % 1000000000) AS NVARCHAR), 9),
    LOWER(n.FirstName) + '.' + LOWER(s.LastName) + '@barber.com',
    DATEADD(YEAR, -20 - ABS(CHECKSUM(NEWID()) % 20), GETDATE()),
    DATEADD(YEAR, -ABS(CHECKSUM(NEWID()) % 10), GETDATE()),
    CASE 
        WHEN ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) = 1 THEN 1
        WHEN ABS(CHECKSUM(NEWID()) % 2) = 0 THEN 2
        ELSE 3
    END
FROM sys.objects t
CROSS JOIN (VALUES 
('Ivan'), ('Oleg'), ('Dmytro'), ('Maxim'), ('Serhii'), ('Roman'), ('Denys'), ('Artem')
) n(FirstName)
CROSS JOIN (VALUES 
('Shevchenko'), ('Koval'), ('Bondarenko'), ('Tkachenko')
) s(LastName)
CROSS JOIN (VALUES 
('Ivanovych'), ('Petrovych'), ('Serhiyovych')
) m(MiddleName)


SELECT * 
FROM Barbers

GO

INSERT INTO Clients (FirstName, LastName, MiddleName, PhoneNumber, Email)
SELECT TOP 200000
    n.FirstName,
    s.LastName,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 4 = 0 THEN NULL ELSE m.MiddleName END,
    '+380' + RIGHT('000000000' + CAST(ABS(CHECKSUM(NEWID()) % 1000000000) AS NVARCHAR), 9),
    LOWER(n.FirstName) + '.' + LOWER(s.LastName) 
        + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR) + '@gmail.com'
FROM sys.objects s1
CROSS JOIN sys.objects s2
CROSS JOIN (VALUES 
('Ivan'), ('Oleg'), ('Andrii'), ('Dmytro'), ('Maxim'),
('Serhii'), ('Roman'), ('Denys'), ('Artem'), ('Vlad')
) n(FirstName)
CROSS JOIN (VALUES 
('Shevchenko'), ('Koval'), ('Bondarenko'), ('Tkachenko'),
('Melnyk'), ('Boyko'), ('Savchenko')
) s(LastName)
CROSS JOIN (VALUES 
('Ivanovych'), ('Petrovych'), ('Mykolayovych')
) m(MiddleName)


SELECT *
FROM Clients

GO

INSERT INTO BarberServices (BarberId, ServiceId)
SELECT 
    b.Id,
    s.Id
FROM Barbers b
CROSS JOIN Service_Price_Time s
WHERE ABS(CHECKSUM(NEWID())) % 2 = 0

SELECT *
FROM BarberServices

GO

INSERT INTO Appointments (BarberId, ClientId, AppointmentDate, AppointmentTime)
SELECT TOP 400000
    (ABS(CHECKSUM(NEWID())) % 50) + 1,
    (ABS(CHECKSUM(NEWID())) % 200000) + 1,
    DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30), GETDATE()),
    DATEADD(MINUTE, ABS(CHECKSUM(NEWID()) % 600), '09:00')
FROM sys.objects s1
CROSS JOIN sys.objects s2
CROSS JOIN sys.objects s3

SELECT * 
FROM Appointments

GO

INSERT INTO AppointmentServices (AppointmentId, ServiceId)
SELECT 
    a.Id,
    (ABS(CHECKSUM(NEWID())) % 8) + 1
FROM Appointments a

SELECT * 
FROM AppointmentServices

GO

INSERT INTO VisitArchive (ClientId, BarberId, VisitDate, TotalPrice, Rating, Feedback)
SELECT TOP 400000
    (ABS(CHECKSUM(NEWID()) % 200000) + 1),
    (ABS(CHECKSUM(NEWID()) % 50) + 1),
    DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 30), GETDATE()),
    200 + ABS(CHECKSUM(NEWID()) % 800),
    (ABS(CHECKSUM(NEWID()) % 5) + 1),
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 'Excellent service'
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 1 THEN 'Good job'
        ELSE 'Average'
    END
FROM sys.objects s1
CROSS JOIN sys.objects s2
CROSS JOIN sys.objects s3

SELECT * 
FROM VisitArchive

GO

INSERT INTO VisitServices (VisitId, ServiceId)
SELECT 
    v.Id,
    (ABS(CHECKSUM(NEWID())) % 8) + 1
FROM VisitArchive v

SELECT * 
FROM VisitServices

GO

INSERT INTO Barber_layouts (BarberId, AvailableDate, StartTime, EndTime)
SELECT TOP 5000
    (ABS(CHECKSUM(NEWID())) % 50) + 1,
    DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 30), GETDATE()),
    '09:00',
    '18:00'
FROM sys.objects s1
CROSS JOIN sys.objects s2

SELECT * 
FROM Barber_layouts

GO

INSERT INTO Feedback (ClientId, BarberId, FeedbackText, Rating)
SELECT TOP 50000
    (ABS(CHECKSUM(NEWID()) % 200000) + 1),
    (ABS(CHECKSUM(NEWID()) % 50) + 1),
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 0 THEN 'Excellent barber'
        WHEN ABS(CHECKSUM(NEWID())) % 3 = 1 THEN 'Good service'
        ELSE 'Could be better'
    END,
    (ABS(CHECKSUM(NEWID()) % 5) + 1)
FROM sys.objects s1
CROSS JOIN sys.objects s2

SELECT * 
FROM Feedback

GO