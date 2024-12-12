-- Phần 01: Sử dụng SELECT và WHERE
-- 1. Truy vấn danh sách tất cả các đơn hàng thuộc khu vực "North":
SELECT OrderID,
	   CustomerID,
	   Region,
	   ProductCategory,
	   OrderDate,
	   Quantity,
	   UnitPrice,
	   Discount,
	   Revenue
FROM dbo.SalesData
WHERE Region = 'North';

-- 2. Truy vấn các đơn hàng có Discount > 0.1 và không có giá trị NULL trong Revenue:
SELECT OrderID,
	   CustomerID,
	   Region,
	   ProductCategory,
	   OrderDate,
	   Quantity,
	   UnitPrice,
	   Discount,
	   Revenue
FROM dbo.SalesData
WHERE Discount > 0.1
  AND Revenue IS NOT NULL;

-- 3. Tính tổng Quantity của các đơn hàng thuộc danh mục "Electronics":
SELECT ProductCategory,
	   SUM(COALESCE(Quantity, 0)) AS sum_quantity
FROM dbo.SalesData
WHERE ProductCategory = 'Electronics'
GROUP BY ProductCategory;
