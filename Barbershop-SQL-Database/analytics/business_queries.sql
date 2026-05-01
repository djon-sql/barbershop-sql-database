-- =========================
-- BUSINESS ANALYTICS
-- =========================


--Топ барбери по доходу
SELECT 
    b.Id,
    b.FirstName + ' ' + b.LastName AS BarberName,
    COUNT(va.Id) AS TotalVisits,
    SUM(va.TotalPrice) AS TotalRevenue,
    AVG(va.TotalPrice) AS AvgCheck
FROM VisitArchive va
JOIN Barbers b ON va.BarberId = b.Id
GROUP BY 
    b.Id,
    b.FirstName,
    b.LastName
ORDER BY TotalRevenue DESC

--Найпопулярніші послуги
SELECT 
    s.ServiceName,
    COUNT(*) AS UsageCount,
    SUM(va.TotalPrice) AS RevenueGenerated
FROM VisitServices vs
JOIN Service_Price_Time s ON vs.ServiceId = s.Id
JOIN VisitArchive va ON vs.VisitId = va.Id
GROUP BY s.ServiceName
ORDER BY UsageCount DESC

--Середній чек
SELECT 
    ROUND(AVG(TotalPrice), 2) AS AvgCheck
FROM VisitArchive

--Активні клієнти (топ)
SELECT TOP 10
    c.Id,
    c.FirstName + ' ' + c.LastName AS ClientName,
    COUNT(va.Id) AS TotalVisits,
    SUM(va.TotalPrice) AS TotalSpent
FROM VisitArchive va
JOIN Clients c ON va.ClientId = c.Id
GROUP BY 
    c.Id,
    c.FirstName,
    c.LastName
ORDER BY TotalVisits DESC

--Завантаженість барберів
SELECT 
    b.Id,
    b.FirstName + ' ' + b.LastName AS BarberName,
    COUNT(a.Id) AS AppointmentsCount
FROM Appointments a
JOIN Barbers b ON a.BarberId = b.Id
GROUP BY 
    b.Id,
    b.FirstName,
    b.LastName
ORDER BY AppointmentsCount DESC

--Дохід по днях
SELECT 
    CAST(VisitDate AS DATE) AS VisitDate,
    SUM(TotalPrice) AS DailyRevenue,
    COUNT(*) AS TotalVisits
FROM VisitArchive
GROUP BY CAST(VisitDate AS DATE)
ORDER BY VisitDate

--Retention (повернення клієнтів)
SELECT 
    COUNT(*) AS ReturningClients
FROM (
    SELECT ClientId
    FROM VisitArchive
    GROUP BY ClientId
    HAVING COUNT(*) > 1) t


