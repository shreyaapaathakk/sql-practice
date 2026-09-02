-- ============================================================
-- MODULE 19: WINDOW FUNCTIONS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module19_window_functions;

USE module19_window_functions;

-- ============================================================
-- SAMPLE TABLES
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
-- SAMPLE DATA
-- ============================================================

INSERT INTO departments
VALUES
(1, 'Sales'),
(2, 'Technology'),
(3, 'Human Resources'),
(4, 'Finance');

INSERT INTO employees
VALUES
(101, 'Aarav', 'Sharma', '[aarav@example.com](mailto:aarav@example.com)', 55000, 1, '2022-01-15'),
(102, 'Priya', 'Singh', '[priya@example.com](mailto:priya@example.com)', 72000, 2, '2021-06-10'),
(103, 'Rohan', 'Verma', '[rohan@example.com](mailto:rohan@example.com)', 48000, 1, '2023-03-20'),
(104, 'Neha', 'Gupta', NULL, 65000, 3, '2020-11-05'),
(105, 'Arjun', 'Mehta', '[arjun@example.com](mailto:arjun@example.com)', 85000, 2, '2019-08-12'),
(106, 'Kavya', 'Patel', '[kavya@example.com](mailto:kavya@example.com)', 58000, 4, '2024-02-01');

INSERT INTO customers
VALUES
(1, 'Rahul Enterprises', 'Delhi'),
(2, 'Priya Stores', 'Mumbai'),
(3, 'Aman Traders', 'Jaipur'),
(4, 'Neha Solutions', 'Pune'),
(5, 'Arjun Retail', 'Lucknow');

INSERT INTO orders
VALUES
(1001, 1, '2026-01-05', 1200),
(1002, 2, '2026-01-10', 2500),
(1003, 1, '2026-02-15', 1800),
(1004, 3, '2026-02-20', 950),
(1005, 4, '2026-03-01', 3200),
(1006, 2, '2026-03-15', 1500),
(1007, 5, '2026-03-20', 4100);

-- ============================================================
-- 1. AVG OVER ALL ROWS
-- ============================================================

SELECT
first_name,
salary,
AVG(salary) OVER () AS company_average_salary
FROM employees;

-- ============================================================
-- 2. SUM OVER ALL ROWS
-- ============================================================

SELECT
first_name,
salary,
SUM(salary) OVER () AS total_company_salary
FROM employees;

-- ============================================================
-- 3. DEPARTMENT AVERAGE
-- ============================================================

SELECT
first_name,
department_id,
salary,
AVG(salary) OVER (
PARTITION BY department_id
) AS department_average
FROM employees;

-- ============================================================
-- 4. DEPARTMENT MAXIMUM
-- ============================================================

SELECT
first_name,
department_id,
salary,
MAX(salary) OVER (
PARTITION BY department_id
) AS department_max_salary
FROM employees;

-- ============================================================
-- 5. ROW_NUMBER
-- ============================================================

SELECT
first_name,
salary,
ROW_NUMBER() OVER (
ORDER BY salary DESC
) AS row_num
FROM employees;

-- ============================================================
-- 6. ROW_NUMBER BY DEPARTMENT
-- ============================================================

SELECT
first_name,
department_id,
salary,
ROW_NUMBER() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_row_num
FROM employees;

-- ============================================================
-- 7. RANK
-- ============================================================

SELECT
first_name,
salary,
RANK() OVER (
ORDER BY salary DESC
) AS salary_rank
FROM employees;

-- ============================================================
-- 8. DENSE_RANK
-- ============================================================

SELECT
first_name,
salary,
DENSE_RANK() OVER (
ORDER BY salary DESC
) AS salary_dense_rank
FROM employees;

-- ============================================================
-- 9. LAG
-- ============================================================

SELECT
order_id,
order_date,
total_amount,
LAG(total_amount) OVER (
ORDER BY order_date
) AS previous_order_amount
FROM orders;

-- ============================================================
-- 10. LEAD
-- ============================================================

SELECT
order_id,
order_date,
total_amount,
LEAD(total_amount) OVER (
ORDER BY order_date
) AS next_order_amount
FROM orders;

-- ============================================================
-- 11. ORDER DIFFERENCE
-- ============================================================

SELECT
order_id,
order_date,
total_amount,
total_amount
- LAG(total_amount) OVER (
ORDER BY order_date
) AS difference_from_previous
FROM orders;

-- ============================================================
-- 12. RUNNING TOTAL
-- ============================================================

SELECT
order_id,
order_date,
total_amount,
SUM(total_amount) OVER (
ORDER BY order_date
) AS running_total
FROM orders;

-- ============================================================
-- 13. CUSTOMER RUNNING TOTAL
-- ============================================================

SELECT
customer_id,
order_id,
order_date,
total_amount,
SUM(total_amount) OVER (
PARTITION BY customer_id
ORDER BY order_date
) AS customer_running_total
FROM orders;

-- ============================================================
-- 14. DEPARTMENT SALARY PERCENTAGE
-- ============================================================

SELECT
first_name,
department_id,
salary,
ROUND(
salary /
SUM(salary) OVER (
PARTITION BY department_id
) * 100,
2
) AS salary_percentage
FROM employees;

-- ============================================================
-- 15. DIFFERENCE FROM DEPARTMENT AVERAGE
-- ============================================================

SELECT
first_name,
department_id,
salary,
AVG(salary) OVER (
PARTITION BY department_id
) AS department_average,

```
salary
    - AVG(salary) OVER (
        PARTITION BY department_id
    ) AS difference_from_average
```

FROM employees;

-- ============================================================
-- 16. NTILE
-- ============================================================

SELECT
first_name,
salary,
NTILE(4) OVER (
ORDER BY salary DESC
) AS salary_quartile
FROM employees;

-- ============================================================
-- 17. FIRST_VALUE
-- ============================================================

SELECT
first_name,
department_id,
salary,
FIRST_VALUE(salary) OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS highest_department_salary
FROM employees;

-- ============================================================
-- 18. LAST_VALUE
-- ============================================================

SELECT
first_name,
department_id,
salary,
LAST_VALUE(salary) OVER (
PARTITION BY department_id
ORDER BY salary DESC
ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING
) AS lowest_department_salary
FROM employees;

-- ============================================================
-- 19. MOVING AVERAGE
-- ============================================================

SELECT
order_id,
order_date,
total_amount,
AVG(total_amount) OVER (
ORDER BY order_date
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
) AS three_order_average
FROM orders;

-- ============================================================
-- 20. TOP EMPLOYEES USING CTE
-- ============================================================

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
salary,
RANK() OVER (
ORDER BY salary DESC
) AS salary_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 3;

-- ============================================================
-- 21. TOP TWO EMPLOYEES PER DEPARTMENT
-- ============================================================

WITH ranked_employees AS (
SELECT
employee_id,
first_name,
department_id,
salary,
ROW_NUMBER() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees
)
SELECT *
FROM ranked_employees
WHERE department_rank <= 2;

-- ============================================================
-- 22. EMPLOYEE STATUS USING CASE + WINDOW FUNCTION
-- ============================================================

SELECT
first_name,
salary,
CASE
WHEN salary > AVG(salary) OVER ()
THEN 'Above Average'
ELSE 'Below Average'
END AS salary_status
FROM employees;

-- ============================================================
-- 23. MULTIPLE WINDOW FUNCTIONS
-- ============================================================

SELECT
first_name,
department_id,
salary,

```
ROW_NUMBER() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
) AS row_num,

RANK() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
) AS salary_rank,

DENSE_RANK() OVER (
    PARTITION BY department_id
    ORDER BY salary DESC
) AS dense_salary_rank,

AVG(salary) OVER (
    PARTITION BY department_id
) AS department_average
```

FROM employees;

-- ============================================================
-- 24. CUSTOMER ORDER COMPARISON
-- ============================================================

SELECT
customer_id,
order_id,
order_date,
total_amount,

```
LAG(total_amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
) AS previous_order_amount,

LEAD(total_amount) OVER (
    PARTITION BY customer_id
    ORDER BY order_date
) AS next_order_amount
```

FROM orders;

-- ============================================================
-- 25. CUSTOMER ORDER CHANGE
-- ============================================================

SELECT
customer_id,
order_id,
order_date,
total_amount,

```
total_amount
    - LAG(total_amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS amount_change
```

FROM orders;

-- ============================================================
-- 26. NAMED WINDOW
-- ============================================================

SELECT
first_name,
salary,

```
ROW_NUMBER() OVER w AS row_num,

RANK() OVER w AS salary_rank
```

FROM employees

WINDOW w AS (
ORDER BY salary DESC
);
