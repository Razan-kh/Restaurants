USE RestaurantDB;
GO

DECLARE @CustomerId INT;
SET @CustomerId = 1;

Select * FROM Restaurant.Reservation
WHERE CustomerID = @CustomerId;