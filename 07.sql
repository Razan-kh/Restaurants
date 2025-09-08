USE RestaurantDB;
GO

DROP VIEW IF EXISTS vw_Employees;
GO

CREATE VIEW vw_Employees AS
SELECT 
	e.EmployeeID,
	e.FirstName,
	e.LastName,
	e.Position,
	r.Address,
	r.Name,
	r.OpeningHours,
	r.PhoneNumber,
	r.RestaurantID
FROM Restaurant.Restaurant AS r
LEFT JOIN Restaurant.Employee AS e
	ON e.RestaurantID = r.RestaurantID;
GO

SELECT * FROM vw_Employees;