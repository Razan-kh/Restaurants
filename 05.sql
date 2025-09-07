USE RestaurantDB;
GO

SELECT  e.EmployeeID AS emp, AVG(o.TotalAmount) FROM Restaurant.[Order] AS o
INNER JOIN Restaurant.Employee AS e
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID;