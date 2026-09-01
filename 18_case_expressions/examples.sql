-- ============================================================
-- MODULE 18: CASE EXPRESSIONS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module18_case_expressions;

USE module18_case_expressions;

-- ============================================================
-- 1. SAMPLE TABLES
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
-- 2. SAMPLE DATA
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
(104, 'Neha', 'Gupta', NULL, 65000.00, 3, '2020-11-05'),
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
-- 3. SIMPLE CASE
-- ============================================================

SELECT
first_name,
department_id,
CASE department_id
WHEN 1 THEN 'Sales'
WHEN 2 THEN 'Technology'
WHEN 3 THEN 'Human Resources'
WHEN 4 THEN 'Finance'
ELSE 'Unknown'
END AS department_name
FROM employees;

-- ============================================================
-- 4. SEARCHED CASE
-- ============================================================

SELECT
first_name,
salary,
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level
FROM employees;

-- ============================================================
-- 5. CASE WITH BETWEEN
-- ============================================================

SELECT
first_name,
salary,
CASE
WHEN salary < 50000 THEN 'Low Salary'
WHEN salary BETWEEN 50000 AND 69999 THEN 'Mid Salary'
ELSE 'High Salary'
END AS salary_category
FROM employees;

-- ============================================================
-- 6. CASE WITH DATES
-- ============================================================

SELECT
first_name,
hire_date,
CASE
WHEN hire_date < '2022-01-01' THEN 'Experienced'
WHEN hire_date < '2024-01-01' THEN 'Recent'
ELSE 'New'
END AS employee_type
FROM employees;

-- ============================================================
-- 7. CASE WITH MULTIPLE CONDITIONS
-- ============================================================

SELECT
first_name,
salary,
department_id,
CASE
WHEN salary >= 70000
AND department_id = 2
THEN 'Senior Technology Employee'
WHEN salary >= 70000
THEN 'High Salary Employee'
ELSE 'Standard Employee'
END AS employee_category
FROM employees;

-- ============================================================
-- 8. CASE WITH IN
-- ============================================================

SELECT
first_name,
department_id,
CASE
WHEN department_id IN (1, 4) THEN 'Business'
WHEN department_id = 2 THEN 'Technology'
ELSE 'Other'
END AS department_group
FROM employees;

-- ============================================================
-- 9. CASE WITH NULL
-- ============================================================

SELECT
first_name,
email,
CASE
WHEN email IS NULL THEN 'Missing Email'
ELSE 'Email Available'
END AS email_status
FROM employees;

-- ============================================================
-- 10. CASE FOR NULL REPLACEMENT
-- ============================================================

SELECT
first_name,
CASE
WHEN email IS NULL THEN 'No Email'
ELSE email
END AS contact_email
FROM employees;

-- ============================================================
-- 11. CONDITIONAL COUNT USING SUM + CASE
-- ============================================================

SELECT
SUM(
CASE
WHEN salary >= 60000 THEN 1
ELSE 0
END
) AS high_salary_count
FROM employees;

-- ============================================================
-- 12. CONDITIONAL COUNT USING COUNT + CASE
-- ============================================================

SELECT
COUNT(
CASE
WHEN salary >= 60000 THEN 1
END
) AS high_salary_count
FROM employees;

-- ============================================================
-- 13. CONDITIONAL SUM
-- ============================================================

SELECT
SUM(
CASE
WHEN salary >= 60000 THEN salary
ELSE 0
END
) AS high_salary_total
FROM employees;

-- ============================================================
-- 14. CONDITIONAL AGGREGATION BY DEPARTMENT
-- ============================================================

SELECT
department_id,
SUM(
CASE
WHEN salary >= 60000 THEN 1
ELSE 0
END
) AS high_salary_employees
FROM employees
GROUP BY department_id;

-- ============================================================
-- 15. MULTIPLE CONDITIONAL AGGREGATES
-- ============================================================

SELECT
department_id,

```
SUM(
    CASE
        WHEN salary >= 70000 THEN 1
        ELSE 0
    END
) AS high_salary_count,

SUM(
    CASE
        WHEN salary BETWEEN 50000 AND 69999 THEN 1
        ELSE 0
    END
) AS medium_salary_count,

SUM(
    CASE
        WHEN salary < 50000 THEN 1
        ELSE 0
    END
) AS low_salary_count
```

FROM employees
GROUP BY department_id;

-- ============================================================
-- 16. CASE IN ORDER BY
-- ============================================================

SELECT
first_name,
salary,
department_id
FROM employees
ORDER BY
CASE
WHEN department_id = 2 THEN 1
WHEN department_id = 1 THEN 2
ELSE 3
END,
first_name;

-- ============================================================
-- 17. CASE IN GROUP BY
-- ============================================================

SELECT
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level,
COUNT(*) AS employee_count
FROM employees
GROUP BY
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END;

-- ============================================================
-- 18. CASE WITH JOIN
-- ============================================================

SELECT
e.first_name,
d.department_name,
CASE
WHEN d.department_name = 'Technology'
THEN 'Technical'
ELSE 'Non-Technical'
END AS department_type
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

-- ============================================================
-- 19. CASE WITH CTE
-- ============================================================

WITH employee_categories AS (
SELECT
employee_id,
first_name,
salary,
CASE
WHEN salary >= 70000 THEN 'High'
WHEN salary >= 50000 THEN 'Medium'
ELSE 'Low'
END AS salary_level
FROM employees
)
SELECT
salary_level,
COUNT(*) AS employee_count
FROM employee_categories
GROUP BY salary_level
ORDER BY employee_count DESC;

-- ============================================================
-- 20. CONDITIONAL ORDER ANALYSIS
-- ============================================================

SELECT
order_id,
total_amount,
CASE
WHEN total_amount >= 3000 THEN 'Large'
WHEN total_amount >= 1500 THEN 'Medium'
ELSE 'Small'
END AS order_size
FROM orders
ORDER BY total_amount DESC;

-- ============================================================
-- 21. CUSTOMER CLASSIFICATION
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
)
SELECT
c.customer_name,
ct.total_spent,
CASE
WHEN ct.total_spent >= 4000 THEN 'Premium'
WHEN ct.total_spent >= 2500 THEN 'Standard'
ELSE 'Basic'
END AS customer_segment
FROM customer_totals AS ct
INNER JOIN customers AS c
ON ct.customer_id = c.customer_id
ORDER BY ct.total_spent DESC;

-- ============================================================
-- 22. CONDITIONAL AVERAGE
-- ============================================================

SELECT
AVG(
CASE
WHEN department_id = 2 THEN salary
END
) AS technology_average_salary
FROM employees;

-- ============================================================
-- 23. NESTED CASE
-- ============================================================

SELECT
first_name,
salary,
department_id,
CASE
WHEN salary >= 70000 THEN
CASE
WHEN department_id = 2 THEN 'Senior Technology'
ELSE 'Senior Employee'
END
ELSE 'Other Employee'
END AS employee_category
FROM employees;

-- ============================================================
-- 24. CASE VS IF
-- ============================================================

SELECT
first_name,
salary,
IF(
salary >= 60000,
'High',
'Low'
) AS if_salary_level,
CASE
WHEN salary >= 60000 THEN 'High'
ELSE 'Low'
END AS case_salary_level
FROM employees;
