USE RestaurantDB;
GO

CREATE NONCLUSTERED INDEX IX_Employee_Restaurant
ON Restaurant.Employee (RestaurantID)
INCLUDE (EmployeeID, FirstName, LastName, Position);