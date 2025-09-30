USE RestaurantDB;
GO

DROP TABLE IF EXISTS Restaurant.AuditLog;
GO

CREATE TABLE Restaurant.AuditLog(
ReservationID INT,
CustomerID INT,
ResturantID INT,
TableID INT,
PartySize INT,
ReservationDate DATE,
ChangeDate DATE
);
GO

CREATE OR ALTER TRIGGER Restaurant.trg_AuditLog
ON Restaurant.Reservation
AFTER INSERT
AS
BEGIN
INSERT INTO Restaurant.AuditLog (
ReservationID,
CustomerID,
ResturantID,
TableID,
PartySize,
ReservationDate,
ChangeDate
)
SELECT ReservationID,
CustomerID,
RestaurantID,
TableID,
PartySize,
ReservationDate,
GETDATE()
FROM INSERTED;
END;
GO