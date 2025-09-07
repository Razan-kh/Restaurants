use RestaurantDB;
GO

-- 1. Seed Restaurants (50)
PRINT 'Seeding Restaurants...';
DECLARE @i INT = 1;
WHILE @i <= 50
BEGIN
    INSERT INTO Restaurant.Restaurant (Name, Address, OpeningHours, PhoneNumber)
    VALUES (
        CONCAT('Restaurant ', @i),
        CONCAT('Street ', @i, ', City'),
        '09:00-23:00',
        CAST(1000000000 + (ABS(CHECKSUM(NEWID())) % 900000000) AS VARCHAR(20))
    );
    SET @i = @i + 1;
END;

-- 2. Seed Customers (400)
PRINT 'Seeding Customers...';
SET @i = 1;
WHILE @i <= 400
BEGIN
    INSERT INTO Restaurant.Customer (FirstName, LastName, Email, PhoneNumber)
    VALUES (
        CONCAT('First', @i),
        CONCAT('Last', @i),
        CONCAT('user', @i, '@mail.com'),
        CAST(1000000000 + (ABS(CHECKSUM(NEWID())) % 900000000) AS VARCHAR(20))
    );
    SET @i = @i + 1;
END;

-- 3. Seed Restaurant Tables (100)
PRINT 'Seeding Tables...';
SET @i = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO Restaurant.[Table] (Capacity, RestaurantID)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 8) + 2, -- capacity 2–10
        ((@i - 1) % 50) + 1
    );
    SET @i = @i + 1;
END;

-- 4. Seed Employees (100)
PRINT 'Seeding Employees...';
SET @i = 1;
WHILE @i <= 100
BEGIN
    INSERT INTO Restaurant.Employee (FirstName, LastName, Position, RestaurantID)
    VALUES (
        CONCAT('Emp', @i),
        CONCAT('LN', @i),
        CASE (ABS(CHECKSUM(NEWID())) % 3)
            WHEN 0 THEN 'Chef'
            WHEN 1 THEN 'Waiter'
            ELSE 'Manager'
        END,
        ((@i - 1) % 50) + 1
    );
    SET @i = @i + 1;
END;

-- 5. Seed Menu Items (1000)
PRINT 'Seeding Menu Items...';
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Restaurant.MenuItem (Name, Price, Description, RestaurantID)
    VALUES (
        CONCAT('Item', @i),
        (ABS(CHECKSUM(NEWID())) % 50) + 5, -- price 5–55
        CONCAT('Description ', @i),
        ((@i - 1) % 50) + 1
    );
    SET @i = @i + 1;
END;

-- 6. Seed Reservations (500)
PRINT 'Seeding Reservations...';
SET @i = 1;
WHILE @i <= 500
BEGIN
    INSERT INTO Restaurant.Reservation (Quantity, TableID, CustomerID, RestaurantID, PartySize, ReservationDate)
    VALUES (
        1,
        ((@i - 1) % 100) + 1,
        ((@i - 1) % 400) + 1,
        ((@i - 1) % 50) + 1,
        (ABS(CHECKSUM(NEWID())) % 6) + 2,
        DATEADD(DAY, -(@i % 30), GETDATE())
    );
    SET @i = @i + 1;
END;

-- 7. Seed Orders (500)
PRINT 'Seeding Orders...';
SET @i = 1;
WHILE @i <= 500
BEGIN
    INSERT INTO Restaurant.[Order] (OrderDate, TotalAmount, EmployeeID, ReservationID)
    VALUES (
        DATEADD(DAY, -(@i % 30), GETDATE()),
        (ABS(CHECKSUM(NEWID())) % 200) + 20,
        ((@i - 1) % 100) + 1,
        @i
    );
    SET @i = @i + 1;
END;

-- 8. Seed Order Items (1500)
PRINT 'Seeding Order Items...';
SET @i = 1;
WHILE @i <= 1500
BEGIN
    INSERT INTO Restaurant.OrderItem (Quantity, ItemID, OrderID)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 3) + 1,
        ((@i - 1) % 1000) + 1,
        ((@i - 1) % 500) + 1
    );
    SET @i = @i + 1;
END;

PRINT '✅ Seeding Complete!';

UPDATE o
SET o.TotalAmount = t.TotalAmount
FROM Restaurant.[Order] o
INNER JOIN (
    SELECT oi.OrderID, SUM(oi.Quantity * mi.Price) AS TotalAmount
    FROM Restaurant.OrderItem oi
    JOIN Restaurant.MenuItem mi ON oi.ItemID = mi.ItemID
    GROUP BY oi.OrderID
) t ON o.OrderID = t.OrderID;