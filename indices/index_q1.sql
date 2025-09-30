USE RestaurantDB;
GO

CREATE NONCLUSTERED INDEX IX_Reservation_Customer
ON Restaurant.Reservation (CustomerID);