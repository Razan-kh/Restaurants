USE RestaurantDB;
GO
SELECT RestaurantID, ItemID, ItemsCount
FROM (
    SELECT 
        r.RestaurantID,
        oi.ItemID,
        COUNT(oi.ItemID) AS ItemsCount,
        RANK() OVER(PARTITION BY r.RestaurantID ORDER BY COUNT(oi.ItemID) DESC) AS RankNum
    FROM Restaurant.Restaurant AS r
    INNER JOIN Restaurant.Employee AS e
        ON r.RestaurantID = e.RestaurantID
    INNER JOIN Restaurant.[Order] AS o
        ON o.EmployeeID = e.EmployeeID
    INNER JOIN Restaurant.OrderItem AS oi
        ON oi.OrderID = o.OrderID
    WHERE MONTH(o.OrderDate) = 9
    GROUP BY r.RestaurantID, oi.ItemID
) t
WHERE RankNum = 1;