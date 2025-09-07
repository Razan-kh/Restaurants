USE RestaurantDB;
GO

CREATE OR ALTER VIEW Restaurant.ReservationItems AS
SELECT 
    oi.OrderItemID,
    oi.Quantity,
    oi.ItemID,
    oi.OrderID AS OrderItem_OrderID,
    mi.Name AS ItemName,
    mi.Price,
    mi.Description
FROM Restaurant.MenuItem AS mi
INNER JOIN Restaurant.OrderItem AS oi
    ON mi.ItemID = oi.ItemID
INNER JOIN Restaurant.[Order] AS o
    ON oi.OrderID = o.OrderID
WHERE o.ReservationID = 1;
GO

SELECT * FROM Restaurant.ReservationItems;