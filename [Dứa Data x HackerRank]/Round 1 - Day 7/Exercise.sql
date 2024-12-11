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

-- Phần 02: Sử dụng GROUP BY và Aggregate Functions
-- 1. Tính tổng doanh thu (Revenue) và số lượng giao dịch theo khu vực (Region):
SELECT Region,
	   SUM(COALESCE(Revenue, 0)) AS sum_revenue,
	   COUNT(OrderID) AS count_order
FROM dbo.SalesData
WHERE Region IS NOT NULL
GROUP BY Region;

-- 2. Tính giá trị trung bình của UnitPrice theo danh mục sản phẩm (ProductCategory):
SELECT ProductCategory,
	   AVG(UnitPrice) AS avg_unit_price
FROM dbo.SalesData
GROUP BY ProductCategory;

-- 3. Đếm số lượng đơn hàng theo từng khu vực và sắp xếp theo số lượng giảm dần:
SELECT Region,
	   COUNT(OrderID) AS count_order
FROM dbo.SalesData
WHERE Region IS NOT NULL
GROUP BY Region
ORDER BY count_order DESC;
