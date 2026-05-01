-- =========================
-- TRIGGERS
-- =========================


--Заборонити можливість видалення інформації про чиф-барбер, якщо не додано другий чиф-барбер. 
GO
CREATE TRIGGER TR_DeleteChief
ON Barbers
INSTEAD OF DELETE
AS
BEGIN

SET NOCOUNT ON

    IF (SELECT COUNT(*) FROM Barbers WHERE PositionBarberId = 1) = 1
       AND EXISTS (SELECT 1 FROM deleted WHERE PositionBarberId = 1)
    BEGIN
        RETURN
    END

    DELETE FROM Barbers
    WHERE Id IN (SELECT Id FROM deleted)
END
GO

--Заборонити додавати барберів молодше 21 року
CREATE TRIGGER TR_BarberAge
ON Barbers
INSTEAD OF INSERT
AS
BEGIN

SET NOCOUNT ON
  
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) < 21
    )
    BEGIN
        PRINT 'Ще молод'
        RETURN
    END
    
    --Перевірка 
    INSERT INTO Barbers (FirstName,LastName,MiddleName,Gender,PhoneNumber,Email,BirthDate,HireDate,PositionBarberId)
    SELECT FirstName,LastName,MiddleName,Gender,PhoneNumber,Email,BirthDate,HireDate,PositionBarberId
    FROM inserted
END

GO