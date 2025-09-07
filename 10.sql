USE RestaurantDB;
GO

;WITH ItemCountCTE AS
(
    SELECT 
        r.RestaurantID,
        oi.ItemID,
        COUNT(oi.ItemID) AS ItemsCount
    FROM Restaurant.Restaurant AS r
    INNER JOIN Restaurant.Employee AS e
        ON r.RestaurantID = e.RestaurantID
    INNER JOIN Restaurant.[Order] AS o
        ON o.EmployeeID = e.EmployeeID
    INNER JOIN Restaurant.OrderItem AS oi
        ON oi.OrderID = o.OrderID
    WHERE MONTH(o.OrderDate) = 9
    GROUP BY r.RestaurantID, oi.ItemID
)
SELECT 
    RestaurantID,
    ItemID,
    ItemsCount
    FROM (
    SELECT *,
        RANK() OVER(PARTITION BY RestaurantID ORDER BY ItemsCount DESC) AS RankNum
    FROM ItemCountCTE
) t
WHERE RankNum = 1