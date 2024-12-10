-- Phần 01: Cơ bản
-- Câu 01. Tổng doanh thu mỗi khu vực:
-- Tính tổng doanh thu (amount) theo từng region, loại bỏ các giá trị NULL trong amount
SELECT region,
	   SUM(amount) AS total_amount
FROM dbo.sales
WHERE amount IS NOT NULL
GROUP BY region;

-- Câu 02. Số lượng giao dịch mỗi sản phẩm:
-- Đếm số lượng giao dịch (sale_id) theo từng product_id. Bao gồm cả NULL trong product_id.
SELECT product_id,
	   COUNT(sale_id) AS number_of_transaction
FROM dbo.sales
GROUP BY product_id;

-- Phần 02: Trung cấp
-- Câu 01. Tính giá trị trung bình chiết khấu mỗi khu vực:
-- Tính giá trị trung bình của discount theo từng region, nhưng thay giá trị NULL trong discount bằng 0.
SELECT region,
	   AVG(COALESCE(discount, 0)) AS avg_discount
FROM dbo.sales
GROUP BY region;

-- Câu 02. Tổng số khách hàng giao dịch mỗi khu vực:
-- Đếm số lượng khách hàng (customer_id) duy nhất trong từng khu vực (region). Loại bỏ giá trị NULL trong customer_id.
SELECT region,
	   COUNT(DISTINCT customer_id) AS count_customer
FROM dbo.sales
WHERE customer_id IS NOT NULL
GROUP BY region;

-- Phần 03: Nâng cao
-- Câu 01. Doanh thu cao nhất mỗi khu vực:
-- Tìm doanh thu cao nhất (amount) trong từng region, loại bỏ các giá trị NULL.
SELECT region,
	   MAX(amount) AS max_amount
FROM dbo.sales
WHERE amount IS NOT NULL
GROUP BY region;

-- Câu 02. Giao dịch lớn nhất theo sản phẩm trong mỗi khu vực:
-- Tìm sale_id có amount lớn nhất theo từng product_id trong mỗi region.
SELECT S1.region,
	   S1.product_id,
	   S1.sale_id,
	   S1.amount
FROM dbo.sales S1
INNER JOIN (
	SELECT region,
		   product_id,
		   MAX(amount) AS max_amount
	FROM dbo.sales
	GROUP BY region,
			 product_id
) S2 ON S2.region = S1.region
    AND S2.product_id = S1.product_id
	AND S2.max_amount = S1.amount;

-- Câu 03. Tổng doanh thu và số lượng giao dịch với chiết khấu > 10:
-- Tính tổng doanh thu và số lượng giao dịch cho các đơn hàng có discount > 10.
SELECT SUM(amount) AS total_amount,
	   COUNT(*) AS number_of_transaction
FROM dbo.sales
WHERE discount > 10;

-- Phần 04: Thử thách
-- Câu 01. Doanh thu trung bình mỗi khu vực (bao gồm các khu vực không có giao dịch):
-- Tính doanh thu trung bình của mỗi khu vực, bao gồm cả khu vực không có giao dịch (NULL).
SELECT region,
	   AVG(COALESCE(amount, 0)) AS avg_amount
FROM dbo.sales
GROUP BY region;

-- Câu 02. Tỷ lệ giao dịch có chiết khấu trong từng khu vực:
-- Tính tỷ lệ giao dịch có discount (không NULL) trên tổng số giao dịch trong từng region.
SELECT region,
       COUNT(CASE
                 WHEN discount IS NOT NULL THEN 1
             END) * 1.0 / COUNT(*) AS discount_ratio
FROM dbo.sales
GROUP BY region;

-- Câu 03. Xử lý các giá trị thiếu trong bảng dữ liệu:
-- Thay thế tất cả các giá trị NULL trong amount bằng giá trị trung bình amount của từng khu vực.
WITH CTE_AVG_AMOUNT AS (
	SELECT region,
		   AVG(COALESCE(amount, 0)) AS avg_amount
	FROM dbo.sales
	GROUP BY region
)
SELECT S1.region,
	   CASE
	   WHEN S1.amount IS NULL THEN S2.avg_amount
	   ELSE S1.amount END AS amount
FROM dbo.sales S1
INNER JOIN CTE_AVG_AMOUNT S2 ON S2.region = S1.region;
