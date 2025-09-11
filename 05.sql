USE RestaurantDB;
GO

SELECT AVG(o.TotalAmount) AS TotalAmount
FROM Restaurant.[Order] AS o
INNER JOIN Restaurant.Employee AS e
ON e.EmployeeID = o.EmployeeID
WHERE e.EmployeeID = 1;