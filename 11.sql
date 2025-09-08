USE RestaurantDB;
GO

DROP FUNCTION IF EXISTS Restaurant.restaurant_revenue;
GO

CREATE FUNCTION Restaurant.restaurant_revenue (
    @RestaurantId INT 
)
RETURNS FLOAT 
AS
BEGIN
    DECLARE @revenue FLOAT;

    SELECT @revenue = SUM(o.TotalAmount)
    FROM Restaurant.Restaurant AS r
    INNER JOIN Restaurant.Employee AS e
        ON e.RestaurantID = r.RestaurantID
    INNER JOIN Restaurant.[Order] AS o
        ON o.EmployeeID = e.EmployeeID
    WHERE r.RestaurantID = @RestaurantId;

    IF @revenue IS NULL
        SET @revenue = 0;

    RETURN @revenue;
END;
GO