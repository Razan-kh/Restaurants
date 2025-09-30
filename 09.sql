USE RestaurantDB;
GO

SELECT r.RestaurantID ,COUNT (res.RestaurantID)
FROM Restaurant.Restaurant AS r
INNER JOIN Restaurant.Reservation res
	ON r.RestaurantID = res.RestaurantID
GROUP BY r.RestaurantID
ORDER BY COUNT (res.RestaurantID) DESC;