USE RestaurantDB;
GO

DROP VIEW IF EXISTS Restaurant.vw_ReservationReport;
GO

CREATE VIEW Restaurant.vw_ReservationReport AS
SELECT 
    r.ReservationID,
    r.ReservationDate,
    r.TableID,
    r.PartySize,
    c.FirstName,
    c.LastName,
    c.Email,
    c.PhoneNumber,
    res.RestaurantID,
    res.Name,
    res.OpeningHours,
    res.Address,
    res.PhoneNumber AS ContactNumber
FROM Restaurant.Reservation r
INNER JOIN Restaurant.Customer c
    ON r.CustomerID = c.CustomerID
INNER JOIN Restaurant.Restaurant res
    ON res.RestaurantID = r.RestaurantID;
GO