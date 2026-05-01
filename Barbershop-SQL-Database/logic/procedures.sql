-- =========================
-- STORED PROCEDURES
-- =========================
GO
--Повернути ПІБ всіх барберів салону. 
CREATE PROCEDURE FullName 
AS 
BEGIN 
SELECT b.FirstName + ' ' + b.LastName + ' ' + ISNULL(b.MiddleName,'Немає') AS FullName
FROM Barbers AS b
END

EXEC FullName

Go

--Повернути інформацію про всіх барберів, які можуть надати конкретну послугу. Інформація про потрібну послугу надається як параметр.

CREATE PROCEDURE BarberServis
@ServiceName nvarchar(50)
AS

BEGIN 

SET NOCOUNT ON

SELECT DISTINCT 
    b.Id,
    b.FirstName,
    b.LastName,
    ISNULL(b.MiddleName,' ' ) AS MiddleName,
    s.ServiceName
FROM Barbers b
JOIN BarberServices bs 
    ON b.Id = bs.BarberId
JOIN Service_Price_Time s
    ON bs.ServiceId = s.Id
WHERE s.ServiceName =  @ServiceName

END

EXEC BarberServis 'Fade'

GO

-- Повернути інформацію про всіх барберів, які працюють понад зазначену кількість років. Кількість років передається як параметр. 
CREATE PROCEDURE Work_year
@Years INT

AS
BEGIN

SELECT 
    b.Id,
    b.FirstName + ' ' + b.LastName + ' ' + ISNULL(b.MiddleName,' ') AS FullName,
    datediff(year,b.HireDate,getdate()) AS diff_year
FROM Barbers AS b
WHERE DATEADD(YEAR, @Years, b.HireDate) < GETDATE() 

END

EXEC Work_year 7

GO

--Повернути інформацію про постійних клієнтів. Критерій постійного клієнта: був у салоні задану кількість разів. Кількість передається як параметр. 
CREATE PROCEDURE top_CL_visits
@MinVisit INT
AS

BEGIN

SELECT 
    c.LastName  + ' ' + c.FirstName + ' ' + ISNULL(c.MiddleName,' ') AS FullName,
    COUNT(v.ClientId) AS cnt_visitiv
FROM Clients AS c
JOIN VisitArchive AS v
    ON c.Id = v.ClientId
GROUP BY c.Id, c.LastName,c.FirstName,c.MiddleName
HAVING COUNT(v.ClientId) >= @MinVisit

END

EXEC top_CL_visits 7

GO