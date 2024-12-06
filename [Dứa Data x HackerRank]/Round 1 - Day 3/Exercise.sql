USE SampleDB
GO

-- Bài tập 1: Cơ Bản với SELECT và WHERE
-- 01. Truy vấn tất cả thông tin của các nhân viên làm việc trong phòng IT.
-- Câu hỏi: Liệt kê tất cả các thông tin của nhân viên làm việc tại phòng IT.
SELECT employee_id,
       first_name,
       last_name,
       department,
       salary,
       hire_date
FROM dbo.employees
WHERE department = 'IT';

-- 02. Truy vấn tất cả nhân viên có mức lương lớn hơn 50000.
-- Câu hỏi: Tìm tất cả các nhân viên có mức lương lớn hơn 50000.
SELECT employee_id,
       first_name,
       last_name,
       department,
       salary,
       hire_date
FROM dbo.employees
WHERE salary > 50000;

-- Bài tập 2: Sử Dụng DISTINCT và Xử Lý NULL
-- 01. Truy vấn các phòng ban duy nhất.
-- Câu hỏi: Lấy danh sách các phòng ban mà không bị trùng lặp.
SELECT DISTINCT department
FROM dbo.employees;

-- 02. Truy vấn nhân viên có mức lương NULL
-- Câu hỏi: Tìm các nhân viên có mức lương chưa được cập nhật (giá trị NULL).
SELECT employee_id,
       first_name,
       last_name,
       department,
       salary,
       hire_date
FROM dbo.employees
WHERE salary IS NULL;

-- Bài tập 3: GROUP BY và HAVING
-- 01. Tính mức lương trung bình của nhân viên trong mỗi phòng ban.
-- Câu hỏi: Tính mức lương trung bình của các nhân viên trong từng phòng ban, đồng thời lọc ra các phòng ban có mức lương trung bình lớn hơn 50000.
SELECT department,
       AVG(salary) AS avg_salary
FROM dbo.employees
GROUP BY department
HAVING AVG(salary) > 50000;

-- 02. Tính số lượng nhân viên trong từng phòng ban.
-- Câu hỏi: Tính số lượng nhân viên trong mỗi phòng ban và chỉ hiển thị những phòng ban có ít nhất 2 nhân viên.
SELECT department,
       COUNT(*) AS count_employee
FROM dbo.employees
GROUP BY department
HAVING COUNT(*) >= 2;

-- Bài tập 4: JOIN và COALESCE
-- 01. Truy vấn tất cả nhân viên và thay thế NULL trong ngày vào làm bằng ngày hiện tại.
-- Câu hỏi: Truy vấn tất cả thông tin về nhân viên và thay thế giá trị NULL trong hire_date bằng ngày hiện tại.
SELECT employee_id,
       first_name,
       last_name,
       department,
       salary,
       COALESCE(hire_date, CAST(GETDATE() AS Date)) AS hire_date
FROM dbo.employees;

-- 02. Truy vấn các nhân viên có mức lương cao hơn mức lương trung bình của từng phòng ban.
-- Câu hỏi: Lọc ra các nhân viên có mức lương cao hơn mức lương trung bình của phòng ban mình.
SELECT emp_1.employee_id,
       emp_1.first_name,
       emp_1.last_name,
       emp_1.department,
       emp_1.salary,
       emp_1.hire_date
FROM dbo.employees emp_1
INNER JOIN
  (SELECT department,
          AVG(salary) AS avg_salary
   FROM dbo.employees
   GROUP BY department) emp_2 ON emp_2.avg_salary < emp_1.salary
AND emp_2.department = emp_1.department;

-- Bài tập 5: ORDER BY, LIMIT, và IS NULL
-- 01. Truy vấn 5 nhân viên có mức lương cao nhất.
-- Câu hỏi: Lấy 5 nhân viên có mức lương cao nhất từ bảng nhân viên.
SELECT TOP 5 employee_id,
             first_name,
             last_name,
             department,
             salary,
             hire_date
FROM dbo.employees
ORDER BY salary DESC;

-- 02. Tìm các nhân viên chưa có thông tin ngày vào làm (NULL) và sắp xếp theo họ tên.
-- Câu hỏi: Lọc ra các nhân viên có hire_date là NULL và sắp xếp kết quả theo họ tên.
SELECT employee_id,
       first_name,
       last_name,
       department,
       salary,
       hire_date
FROM dbo.employees
WHERE hire_date IS NULL
ORDER BY first_name,
         last_name;

-- Bài tập 6: CASE và LIKE
-- 01. Thay đổi tên phòng ban theo các chữ cái đầu tiên.
-- Câu hỏi: Nếu tên phòng ban là IT, đổi thành "Information Technology". Nếu là HR, đổi thành "Human Resources".
SELECT DISTINCT CASE
	     WHEN department = 'IT' THEN 'Information Technology'
	     WHEN department = 'HR' THEN 'Human Resources'
	     ELSE department END AS deparment
FROM dbo.employees;

-- 02. Tìm các nhân viên có tên chứa chữ cái 'J'.
-- Câu hỏi: Liệt kê các nhân viên có tên chứa chữ cái "J".
SELECT employee_id,
       first_name,
       last_name,
       department,
       salary,
       hire_date
FROM dbo.employees
WHERE first_name LIKE '%J%';

-- Bài tập 7: Xử Lý NULL với IFNULL và CASE
-- 01. Thay thế các mức lương NULL bằng mức lương trung bình.
-- Câu hỏi: Thay thế mức lương NULL của nhân viên bằng mức lương trung bình của tất cả nhân viên.
SELECT employee_id,
       first_name,
       last_name,
       department,
       ISNULL(salary,
                (SELECT AVG(salary)
                 FROM dbo.employees)) AS salary,
       hire_date
FROM dbo.employees;
