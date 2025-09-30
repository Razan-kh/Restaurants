USE RestaurantDB;
GO

DROP PROCEDURE IF EXISTS sp_ResrvedTablesReport;
GO
CREATE PROCEDURE sp_ResrvedTablesReport
(@StartDate DATE, @EndDate DATE)
AS BEGIN
  SELECT *
  FROM Restaurant.Reservation AS reserv
  INNER JOIN Restaurant.[Table] AS t
	ON t.TableID = reserv.TableID
  INNER JOIN Restaurant.Restaurant res
	ON t.RestaurantID = res.RestaurantID
  WHERE reserv.ReservationDate > @StartDate
  AND
  reserv.ReservationDate < @EndDate
END;

EXEC sp_ResrvedTablesReport '2025-09-05','2025-09-07' ;