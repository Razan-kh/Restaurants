USE RestaurantDB;
GO

DECLARE @Position NVARCHAR(50);
SET @Position = 'Manager';

SELECT *
FROM Restaurant.Employee
WHERE Position = @Position;