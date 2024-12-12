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
	   COUNT(*) AS count_order
FROM dbo.SalesData
GROUP BY Region;

-- 2. Tính giá trị trung bình của UnitPrice theo danh mục sản phẩm (ProductCategory):
SELECT ProductCategory,
	   AVG(UnitPrice) AS avg_unit_price
FROM dbo.SalesData
GROUP BY ProductCategory;

-- 3. Đếm số lượng đơn hàng theo từng khu vực và sắp xếp theo số lượng giảm dần:
SELECT Region,
	   COUNT(*) AS count_order
FROM dbo.SalesData
GROUP BY Region
ORDER BY count_order DESC;

-- Phần 03: Xử lý NULL và Subqueries
-- 1. Tính lại Revenue cho các dòng dữ liệu bị NULL bằng công thức: Revenue = Quantity * UnitPrice * (1 - Discount)
SELECT OrderID,
	   CustomerID,
	   Region,
	   ProductCategory,
	   OrderDate,
	   Quantity,
	   UnitPrice,
	   Discount,
	   CASE
	   WHEN Revenue IS NULL THEN COALESCE(Quantity, 0) * UnitPrice * (1 - COALESCE(Discount, 0))
	   ELSE Revenue END AS fill_revenue
FROM dbo.SalesData

-- 2. Tìm danh mục sản phẩm (ProductCategory) có tổng Quantity cao nhất:
SELECT TOP 1 ProductCategory,
			 SUM(COALESCE(Quantity, 0)) AS sum_quantity
FROM dbo.SalesData
GROUP BY ProductCategory
ORDER BY sum_quantity DESC;

-- 3. Truy vấn danh sách các khu vực (Region) có ít hơn 2 đơn hàng:
SELECT Region,
	   COUNT(*) AS count_order
FROM dbo.SalesData
GROUP BY Region
HAVING COUNT(*) < 2;

-- Phần 04: Sử dụng CTE và Window Functions
-- 1. CTE: Tạo một CTE để tính tổng doanh thu (Revenue) theo từng khu vực. Sau đó, chọn khu vực có doanh thu cao nhất.
WITH CTE_TOTAL_REVENUE_BY_REGION AS (
	SELECT Region,
		   SUM(COALESCE(Revenue, 0)) AS sum_revenue
	FROM dbo.SalesData
	GROUP BY Region
)
SELECT TOP 1 Region,
			 sum_revenue AS max_revenue
FROM CTE_TOTAL_REVENUE_BY_REGION
ORDER BY max_revenue DESC;

-- 2. Window Functions: Tính tổng doanh thu tích lũy (Cumulative Revenue) cho từng khu vực dựa trên OrderDate.
SELECT Region,
	   CASE
	   WHEN Revenue IS NULL THEN COALESCE(Quantity, 0) * UnitPrice * (1 - COALESCE(Discount, 0))
	   ELSE Revenue END AS fill_revenue,
	   SUM(
			CASE
			WHEN Revenue IS NULL THEN COALESCE(Quantity, 0) * UnitPrice * (1 - COALESCE(Discount, 0))
			ELSE Revenue END
	   ) OVER(PARTITION BY Region ORDER BY OrderDate) AS cumulative_revenue
FROM dbo.SalesData;

-- 3. Sử dụng CTE để tính trung bình UnitPrice theo danh mục sản phẩm. Sau đó, chỉ chọn các danh mục có UnitPrice trung bình lớn hơn 150.
WITH CTE_AVG_UNIT_PRICE_BY_PRODUCT_CATEGORY AS (
	SELECT ProductCategory,
		   AVG(UnitPrice) AS avg_unit_price
	FROM dbo.SalesData
	GROUP BY ProductCategory
)
SELECT ProductCategory,
	   avg_unit_price
FROM CTE_AVG_UNIT_PRICE_BY_PRODUCT_CATEGORY
WHERE avg_unit_price > 150;
