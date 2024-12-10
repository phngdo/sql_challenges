-- create database
CREATE DATABASE SampleDB
GO

USE SampleDB
GO

-- create table:
CREATE TABLE dbo.sales (
	sale_id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	product_id VARCHAR(20) NULL,
	customer_id VARCHAR(20) NULL,
	region VARCHAR(50) NOT NULL,
	sale_date DATE NULL,
	amount FLOAT NULL,
	discount FLOAT NULL
);

-- insert value:
INSERT INTO dbo.sales (product_id, customer_id, region, sale_date, amount, discount)
VALUES ('P001', 'C001', 'North', '2024-01-01', 100, 5),
	   ('P002', 'C002', 'North', '2024-01-01', 200, NULL),
	   ('P001', 'C003', 'South', '2024-01-02', 150, 10),
	   ('P003', 'C004', 'West', '2024-01-03', 300, 15),
	   ('P002', 'C005', 'South', '2024-01-03', NULL, 0),
	   ('P001', NULL, 'East', '2024-01-04', 120, 5),
	   ('P003', 'C006', 'North', '2024-01-05', 350, NULL),
	   (NULL, 'C007', 'South', '2024-01-05', 200, 20),
	   ('P002', 'C008', 'East', NULL, 250, 10),
	   ('P001', 'C009', 'West', '2024-01-06', 220, 15);

