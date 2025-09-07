USE RestaurantDB;
GO

DROP TABLE IF EXISTS Restaurant.AuditLog;
DROP TRIGGER IF EXISTS Restaurant.trg_AuditLog;

CREATE TABLE Restaurant.AuditLog(
ReservationID INT,
CustomerID INT,
ResturantID INT,
TableID INT,
PartySize INT,
ReservationDate DATE,
);
GO

CREATE TRIGGER Restaurant.trg_AuditLog
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
ReservationDate
)
SELECT *
FROM INSERTED;
END;