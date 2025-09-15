USE RestaurantDB;
GO

DECLARE @EmployeeID INT;
SET @EmployeeID = 1;

SELECT AVG(o.TotalAmount) AS TotalAmount
FROM Restaurant.[Order] AS o
INNER JOIN Restaurant.Employee AS e
ON e.EmployeeID = o.EmployeeID
WHERE e.EmployeeID = @EmployeeID;