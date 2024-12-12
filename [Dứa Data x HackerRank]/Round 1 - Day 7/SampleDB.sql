-- create database:
CREATE DATABASE SampleDB
GO

USE SampleDB
GO

-- create table:
CREATE TABLE dbo.SalesData (
	OrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	CustomerID INT NULL,
	Region VARCHAR(50) NULL,
	ProductCategory VARCHAR(150) NOT NULL,
	OrderDate DATE NOT NULL,
	Quantity INT NULL,
	UnitPrice DECIMAL(10,2) NOT NULL,
	Discount DECIMAL(10,2) NULL,
	Revenue DECIMAL(10,2) NULL
);

-- insert value:
INSERT INTO dbo.SalesData (CustomerID, Region, ProductCategory, OrderDate, Quantity, UnitPrice, Discount, Revenue)
VALUES (101, 'North', 'Electronics', '2024-01-10', 5, 200, 0.1, NULL),
	   (102, 'South', 'Clothing', '2024-02-05', NULL, 50, 0.05, NULL),
	   (103, 'East', 'Electronics', '2024-03-15', 10, 150, NULL, NULL),
	   (104, 'North', 'Furniture', '2024-01-25', 3, 500, 0.2, 1200),
	   (NULL, 'West', 'Electronics', '2024-03-01', 8, 300, 0.15, 2040),
	   (105, NULL, 'Clothing', '2024-04-10', 2, 70, 0.1, NULL);
