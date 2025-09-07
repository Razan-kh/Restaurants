-- 1️⃣ Create Database (if not exists)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'RestaurantDB')
BEGIN
    CREATE DATABASE RestaurantDB;
END
GO

-- Switch to the new database
USE RestaurantDB;
GO

-- 2️⃣ Create Schema (if not exists)
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Restaurant')
BEGIN
    EXEC('CREATE SCHEMA Restaurant');
END
GO

-- 3️⃣ Drop old tables if they exist (avoid "already exists" errors)
DROP TABLE IF EXISTS Restaurant.OrderItem;
DROP TABLE IF EXISTS Restaurant.[Order];
DROP TABLE IF EXISTS Restaurant.Reservation;
DROP TABLE IF EXISTS Restaurant.MenuItem;
DROP TABLE IF EXISTS Restaurant.Employee;
DROP TABLE IF EXISTS Restaurant.[Table];
DROP TABLE IF EXISTS Restaurant.Customer;
DROP TABLE IF EXISTS Restaurant.Restaurant;
GO

-- 4️⃣ Create Tables
CREATE TABLE Restaurant.Restaurant (
    RestaurantID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Address VARCHAR(100),
    OpeningHours VARCHAR(50),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Restaurant.Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20)
);

CREATE TABLE Restaurant.[Table] (
    TableID INT PRIMARY KEY IDENTITY(1,1),
    Capacity INT,
    RestaurantID INT FOREIGN KEY REFERENCES Restaurant.Restaurant(RestaurantID)
);

CREATE TABLE Restaurant.Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    RestaurantID INT FOREIGN KEY REFERENCES Restaurant.Restaurant(RestaurantID)
);

CREATE TABLE Restaurant.MenuItem (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(200),
    RestaurantID INT FOREIGN KEY REFERENCES Restaurant.Restaurant(RestaurantID)
);

CREATE TABLE Restaurant.Reservation (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    RestaurantTableID INT FOREIGN KEY REFERENCES Restaurant.[Table](TableID),
    CustomerID INT FOREIGN KEY REFERENCES Restaurant.Customer(CustomerID),
    RestaurantID INT FOREIGN KEY REFERENCES Restaurant.Restaurant(RestaurantID),
    PartySize INT,
    ReservationDate DATE
);

CREATE TABLE Restaurant.[Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    EmployeeID INT FOREIGN KEY REFERENCES Restaurant.Employee(EmployeeID),
    ReservationID INT FOREIGN KEY REFERENCES Restaurant.Reservation(ReservationID)
);

CREATE TABLE Restaurant.OrderItem (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    Quantity INT,
    ItemID INT FOREIGN KEY REFERENCES Restaurant.MenuItem(ItemID),
    OrderID INT FOREIGN KEY REFERENCES Restaurant.[Order](OrderID)
);
GO