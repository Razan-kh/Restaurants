USE RestaurantDB;
GO

CREATE NONCLUSTERED INDEX IX_Order_Employee
ON Restaurant.[Order] (EmployeeID)
INCLUDE (TotalAmount);