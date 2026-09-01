-- ============================================================
-- MODULE 17: COMMON TABLE EXPRESSIONS (CTEs)
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module17_ctes;

USE module17_ctes;

-- ============================================================
-- 1. CREATE SAMPLE TABLES
-- ============================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100),
salary DECIMAL(10, 2) NOT NULL,
department_id INT,
hire_date DATE,
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
);

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
city VARCHAR(100)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
total_amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

-- ============================================================
-- 2. INSERT SAMPLE DATA
-- ============================================================

INSERT INTO departments (
department_id,
department_name
)
VALUES
(1, 'Sales'),
(2, 'Technology'),
(3, 'Human Resources'),
(4, 'Finance');

INSERT INTO employees (
employee_id,
first_name,
last_name,
email,
salary,
department_id,
hire_date
)
VALUES
(101, 'Aarav', 'Sharma', '[aarav@example.com](mailto:aarav@example.com)', 55000.00, 1, '2022-01-15'),
(102, 'Priya', 'Singh', '[priya@example.com](mailto:priya@example.com)', 72000.00, 2, '2021-06-10'),
(103, 'Rohan', 'Verma', '[rohan@example.com](mailto:rohan@example.com)', 48000.00, 1, '2023-03-20'),
(104, 'Neha', 'Gupta', '[neha@example.com](mailto:neha@example.com)', 65000.00, 3, '2020-11-05'),
(105, 'Arjun', 'Mehta', '[arjun@example.com](mailto:arjun@example.com)', 85000.00, 2, '2019-08-12'),
(106, 'Kavya', 'Patel', '[kavya@example.com](mailto:kavya@example.com)', 58000.00, 4, '2024-02-01');

INSERT INTO customers (
customer_id,
customer_name,
city
)
VALUES
(1, 'Rahul Enterprises', 'Delhi'),
(2, 'Priya Stores', 'Mumbai'),
(3, 'Aman Traders', 'Jaipur'),
(4, 'Neha Solutions', 'Pune'),
(5, 'Arjun Retail', 'Lucknow');

INSERT INTO orders (
order_id,
customer_id,
order_date,
total_amount
)
VALUES
(1001, 1, '2026-01-05', 1200.00),
(1002, 2, '2026-01-10', 2500.00),
(1003, 1, '2026-02-15', 1800.00),
(1004, 3, '2026-02-20', 950.00),
(1005, 4, '2026-03-01', 3200.00),
(1006, 2, '2026-03-15', 1500.00),
(1007, 5, '2026-03-20', 4100.00);

-- ============================================================
-- 3. BASIC CTE
-- ============================================================

WITH high_salary_employees AS (
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary >= 60000
)
SELECT *
FROM high_salary_employees;

-- ============================================================
-- 4. CTE WITH OUTER FILTERING
-- ============================================================

WITH high_salary_employees AS (
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary >= 60000
)
SELECT
employee_id,
first_name,
last_name,
salary
FROM high_salary_employees
WHERE salary < 80000
ORDER BY salary DESC;

-- ============================================================
-- 5. CTE WITH JOIN
-- ============================================================

WITH technology_employees AS (
SELECT
e.employee_id,
e.first_name,
e.last_name,
e.salary,
d.department_name
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.department_name = 'Technology'
)
SELECT
employee_id,
first_name,
last_name,
salary
FROM technology_employees
ORDER BY salary DESC;

-- ============================================================
-- 6. CTE WITH AGGREGATION
-- ============================================================

WITH department_salary AS (
SELECT
department_id,
COUNT(*) AS employee_count,
AVG(salary) AS average_salary,
MAX(salary) AS highest_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_salary;

-- ============================================================
-- 7. FILTERING AN AGGREGATED CTE
-- ============================================================

WITH department_salary AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
)
SELECT
department_id,
average_salary
FROM department_salary
WHERE average_salary > 60000
ORDER BY average_salary DESC;

-- ============================================================
-- 8. MULTIPLE CTEs
-- ============================================================

WITH employee_counts AS (
SELECT
department_id,
COUNT(*) AS employee_count
FROM employees
GROUP BY department_id
),
department_details AS (
SELECT
department_id,
department_name
FROM departments
)
SELECT
d.department_name,
e.employee_count
FROM department_details AS d
INNER JOIN employee_counts AS e
ON d.department_id = e.department_id
ORDER BY e.employee_count DESC;

-- ============================================================
-- 9. ONE CTE REFERENCING AN EARLIER CTE
-- ============================================================

WITH department_salary AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
),
high_salary_departments AS (
SELECT
department_id,
average_salary
FROM department_salary
WHERE average_salary > 60000
)
SELECT *
FROM high_salary_departments
ORDER BY average_salary DESC;

-- ============================================================
-- 10. CTE WITH CALCULATED COLUMN
-- ============================================================

WITH employee_salary AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name) AS employee_name,
salary,
salary * 12 AS annual_salary
FROM employees
)
SELECT
employee_id,
employee_name,
annual_salary
FROM employee_salary
ORDER BY annual_salary DESC;

-- ============================================================
-- 11. CTE WITH IN
-- ============================================================

WITH selected_employees AS (
SELECT
employee_id,
first_name,
last_name,
salary,
department_id
FROM employees
WHERE salary >= 55000
AND department_id IN (1, 2)
)
SELECT *
FROM selected_employees
ORDER BY salary DESC;

-- ============================================================
-- 12. CTE WITH LIMIT
-- ============================================================

WITH highest_paid AS (
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
ORDER BY salary DESC
LIMIT 3
)
SELECT *
FROM highest_paid
ORDER BY salary DESC;

-- ============================================================
-- 13. CUSTOMER ORDER CTE
-- ============================================================

WITH customer_orders AS (
SELECT
c.customer_id,
c.customer_name,
o.order_id,
o.order_date,
o.total_amount
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
)
SELECT *
FROM customer_orders
WHERE total_amount > 1500
ORDER BY total_amount DESC;

-- ============================================================
-- 14. MULTI-STEP CUSTOMER ANALYSIS
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
),
high_value_customers AS (
SELECT
customer_id,
total_spent
FROM customer_totals
WHERE total_spent > 2500
)
SELECT
c.customer_name,
h.total_spent
FROM high_value_customers AS h
INNER JOIN customers AS c
ON h.customer_id = c.customer_id
ORDER BY h.total_spent DESC;

-- ============================================================
-- 15. DEPARTMENT AVERAGE VS COMPANY AVERAGE
-- ============================================================

WITH department_average AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
),
company_average AS (
SELECT
AVG(salary) AS average_salary
FROM employees
)
SELECT
d.department_id,
d.average_salary AS department_average,
c.average_salary AS company_average
FROM department_average AS d
CROSS JOIN company_average AS c
WHERE d.average_salary > c.average_salary
ORDER BY d.average_salary DESC;

-- ============================================================
-- 16. CTE WITH NULL HANDLING
-- ============================================================

WITH employee_emails AS (
SELECT
employee_id,
first_name,
email
FROM employees
)
SELECT *
FROM employee_emails
WHERE email IS NULL;

-- ============================================================
-- 17. EXPLICIT CTE COLUMN LIST
-- ============================================================

WITH employee_summary (
employee_id,
employee_name,
annual_salary
) AS (
SELECT
employee_id,
CONCAT(first_name, ' ', last_name),
salary * 12
FROM employees
)
SELECT *
FROM employee_summary
ORDER BY annual_salary DESC;

-- ============================================================
-- 18. RECURSIVE CTE — SIMPLE NUMBER SEQUENCE
-- ============================================================

WITH RECURSIVE numbers AS (
-- Anchor member
SELECT 1 AS number

```
UNION ALL

-- Recursive member
SELECT number + 1
FROM numbers
WHERE number < 5
```

)
SELECT *
FROM numbers;

-- ============================================================
-- 19. RECURSIVE CTE WITH DATE VALUES
-- ============================================================

WITH RECURSIVE dates AS (
SELECT DATE('2026-01-01') AS report_date

```
UNION ALL

SELECT report_date + INTERVAL 1 DAY
FROM dates
WHERE report_date < '2026-01-05'
```

)
SELECT *
FROM dates;

-- ============================================================
-- 20. CTE COMPARED WITH A DERIVED TABLE
-- ============================================================

-- Derived-table version:

SELECT *
FROM (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
) AS department_summary
WHERE average_salary > 60000;

-- CTE version:

WITH department_summary AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_summary
WHERE average_salary > 60000;
