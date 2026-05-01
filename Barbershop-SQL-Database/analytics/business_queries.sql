-- =========================
-- BUSINESS ANALYTICS
-- =========================


--Топ барбери по доходу
SELECT 
    BarberId,
    SUM(TotalPrice) AS TotalRevenue
FROM VisitArchive
GROUP BY BarberId
ORDER BY TotalRevenue DESC

--Найпопулярніші послуги
SELECT 
    s.ServiceName,
    COUNT(*) AS UsageCount
FROM VisitServices vs
JOIN Service_Price_Time s 
    ON vs.ServiceId = s.Id
GROUP BY s.ServiceName
ORDER BY UsageCount DESC

--Середній чек
SELECT 
    AVG(TotalPrice) AS AvgCheck
FROM VisitArchive

--Активні клієнти (топ)
SELECT TOP 10
    ClientId,
    COUNT(*) AS Visits
FROM VisitArchive
GROUP BY ClientId
ORDER BY Visits DESC

--Завантаженість барберів
SELECT 
    BarberId,
    COUNT(*) AS AppointmentsCount
FROM Appointments
GROUP BY BarberId
ORDER BY AppointmentsCount DESC

--Дохід по днях
SELECT 
    VisitDate,
    SUM(TotalPrice) AS DailyRevenue
FROM VisitArchive
GROUP BY VisitDate
ORDER BY VisitDate

--Retention (повернення клієнтів)
SELECT 
    COUNT(DISTINCT ClientId) AS ReturningClients
FROM VisitArchive
WHERE ClientId IN (
    SELECT ClientId
    FROM VisitArchive
    GROUP BY ClientId
    HAVING COUNT(*) > 1)

