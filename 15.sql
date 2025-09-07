USE RestaurantDB;
GO

DROP PROCEDURE IF EXISTS  Restaurant.sp_TablesAndRestuarnts;
GO

CREATE PROCEDURE Restaurant.sp_TablesAndRestuarnts
AS
BEGIN
    CREATE TABLE #TempTables (
        TableID INT,
        Capacity INT,
        RestaurantID INT
    );

    INSERT INTO #TempTables (TableID, Capacity,RestaurantID)
    SELECT t.TableID, t.Capacity, t.RestaurantID
    FROM Restaurant.[Table] AS t
    INNER JOIN Restaurant.Reservation AS res
        ON res.TableID = t.TableID
    WHERE res.ReservationDate > SYSDATETIME();

    SELECT * FROM #TempTables
    INNER JOIN Restaurant.Restaurant AS res
        ON res.RestaurantID = #TempTables.RestaurantID
    INNER JOIN Restaurant.Reservation AS reserv
        ON #TempTables.TableID = reserv.TableID
     WHERE reserv.ReservationDate > SYSDATETIME();
END;
GO