-- 01. Lập danh sách các mã chi nhánh không lặp lại từ bảng khách hàng.
SELECT DISTINCT BRCODE
FROM dbo.CIF;

-- 02. Lập danh sách khách hàng gồm các thông tin: Mã khách hàng, Tên khách hàng, Tên chi nhánh, Tên khu vực
SELECT cif.CIF_ID,
	   cif.CIF_NAME,
	   branch.BRNAME,
	   area.AREA_NAME
FROM dbo.CIF cif
INNER JOIN dbo.BRANCH branch ON branch.BRCODE = cif.BRCODE
INNER JOIN dbo.AREA area ON area.AREA_CODE = branch.AREA;

-- 03. Đếm số lượng khách hàng theo các tiêu chí khác nhau:
-- Số lượng khách hàng tại mỗi chi nhánh.
SELECT branch.BRCODE,
	   COUNT(*) AS N'Số lượng khách hàng'
FROM dbo.CIF cif
LEFT JOIN dbo.BRANCH branch ON branch.BRCODE = cif.BRCODE
GROUP BY branch.BRCODE;

-- Số lượng khách hàng tại từng khu vực.
SELECT area.AREA_CODE,
	   COUNT(*) AS N'Số lượng khách hàng'
FROM dbo.CIF cif
LEFT JOIN dbo.BRANCH branch ON branch.BRCODE = cif.BRCODE
LEFT JOIN dbo.AREA area ON area.AREA_CODE = branch.AREA
GROUP BY area.AREA_CODE;

-- Số lượng khách hàng theo loại hình (cá nhân, doanh nghiệp).
SELECT CIF_TYPE,
	   COUNT(*) AS N'Số lượng khách hàng'
FROM dbo.CIF
GROUP BY CIF_TYPE;
