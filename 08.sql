USE RestaurantDB;
GO 

;WITH reservationsCTE (ReservationID, OrderCount)
AS
(
    SELECT r.ReservationID, COUNT(o.OrderID) AS OrderCount
    FROM Restaurant.Reservation AS r
    INNER JOIN Restaurant.[Order] AS o
        ON o.ReservationID = r.ReservationID
    GROUP BY r.ReservationID
    HAVING COUNT(o.OrderID) > 2
)

SELECT * 
FROM reservationsCTE;