-- =========================
-- INDEXES
-- =========================
GO 

CREATE UNIQUE INDEX UX_OneChief --Додавання обмеження індекса 
ON Barbers(PositionBarberId)
WHERE PositionBarberId = 1

GO

--Створення некластеризованих індексів

CREATE NONCLUSTERED INDEX IX_Appointments_Client          
ON Appointments(ClientId)

CREATE NONCLUSTERED INDEX IX_Appointments_Barber
ON Appointments(BarberId)

--індекс з INCLUDE
CREATE NONCLUSTERED INDEX IX_VisitArchive_Client
ON VisitArchive(ClientId)
INCLUDE (TotalPrice, Rating)

CREATE NONCLUSTERED INDEX IX_VisitArchive_Barber
ON VisitArchive(BarberId)
INCLUDE (TotalPrice, Rating)

--відфільтрований індекс 
CREATE INDEX IX_Feedback_TopRating 
ON Feedback(Rating) 
WHERE Rating = 5


GO 
