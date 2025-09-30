USE RestaurantDB;
GO

CREATE NONCLUSTERED INDEX IX_Order_Reservation
ON Restaurant.[Order] (ReservationID)
INCLUDE (OrderID);