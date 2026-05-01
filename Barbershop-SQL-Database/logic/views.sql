-- =========================
-- VIEWS
-- =========================

--Повернути інформацію про всіх синьйор-барберів
CREATE VIEW SeniorBarbers
AS 
SELECT *
FROM Barbers AS b
JOIN PositionBarbers as p
    ON b.PositionBarberId = p.PositionId
WHERE p.PositionName = 'Senior'

SELECT * 
FROM SeniorBarbers
GO
--Повернути інформацію про всіх барберів, які можуть надати послугу традиційного гоління бороди. 

SELECT *
FROM Service_Price_Time

SELECT *
FROM Barbers AS b

CREATE VIEW Bar_Ser_Shaving
AS
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
WHERE s.ServiceName = 'Shaving'


SELECT * 
FROM Bar_Ser_Shaving

GO

--Повернути кількість синьйор-барберів та кількість джуніор-барберів. 
CREATE VIEW cnt_positionBar
AS
SELECT 
    p.PositionName,
    count(*) AS cnt_barbers
FROM Barbers AS b
JOIN PositionBarbers AS p
    ON b.PositionBarberId = p.PositionId
WHERE p.PositionName IN ('Junior','Senior')
GROUP BY p.PositionName

SELECT * 
FROM cnt_positionBar
GO
