USE RestaurantDB;
GO

CREATE NONCLUSTERED INDEX IX_Reservation_Report
ON Restaurant.Reservation (CustomerID)
INCLUDE (ReservationID, ReservationDate, TableID, PartySize, RestaurantID);
