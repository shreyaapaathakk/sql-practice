-- ============================================================
-- MODULE 20: CTEs & ADVANCED QUERY COMPOSITION
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module20_ctes;

USE module20_ctes;

-- ============================================================
-- TABLES
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
salary DECIMAL(10, 2) NOT NULL,
department_id INT,
manager_id INT NULL,
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
(101, 'Aarav', 'Sharma', 55000, 1, NULL, '2022-01-15'),
(102, 'Priya', 'Singh', 72000, 2, NULL, '2021-06-10'),
(103, 'Rohan', 'Verma', 48000, 1, 101, '2023-03-20'),
(104, 'Neha', 'Gupta', 65000, 3, NULL, '2020-11-05'),
(105, 'Arjun', 'Mehta', 85000, 2, 102, '2019-08-12'),
(106, 'Kavya', 'Patel', 58000, 4, NULL, '2024-02-01'),
(107, 'Meera', 'Joshi', 62000, 2, 102, '2023-05-10'),
(108, 'Vikram', 'Rao', 51000, 1, 101, '2024-01-12');

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
-- 1. BASIC CTE
-- ============================================================

WITH high_salary_employees AS (
SELECT
employee_id,
first_name,
salary
FROM employees
WHERE salary > 60000
)
SELECT *
FROM high_salary_employees;

-- ============================================================
-- 2. CTE WITH AGGREGATION
-- ============================================================

WITH department_salary AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_salary;

-- ============================================================
-- 3. CTE + JOIN
-- ============================================================

WITH department_salary AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id
)
SELECT
e.first_name,
e.salary,
ds.average_salary
FROM employees AS e
JOIN department_salary AS ds
ON e.department_id = ds.department_id;

-- ============================================================
-- 4. MULTIPLE CTEs
-- ============================================================

WITH employee_data AS (
SELECT
employee_id,
first_name,
department_id,
salary
FROM employees
),

department_data AS (
SELECT
department_id,
department_name
FROM departments
)

SELECT
employee_data.first_name,
employee_data.salary,
department_data.department_name
FROM employee_data
JOIN department_data
ON employee_data.department_id =
department_data.department_id;

-- ============================================================
-- 5. CTE + WINDOW FUNCTION
-- ============================================================

WITH ranked_employees AS (
SELECT
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
-- 6. TOP TWO EMPLOYEES PER DEPARTMENT
-- ============================================================

WITH ranked_employees AS (
SELECT
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
-- 7. ABOVE DEPARTMENT AVERAGE
-- ============================================================

WITH employee_analysis AS (
SELECT
first_name,
department_id,
salary,
AVG(salary) OVER (
PARTITION BY department_id
) AS department_average
FROM employees
)
SELECT *
FROM employee_analysis
WHERE salary > department_average;

-- ============================================================
-- 8. CTE + MULTIPLE AGGREGATION LEVELS
-- ============================================================

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
)
SELECT
AVG(total_salary) AS average_department_salary
FROM department_totals;

-- ============================================================
-- 9. DEPARTMENTS ABOVE TOTAL-SALARY THRESHOLD
-- ============================================================

WITH department_totals AS (
SELECT
department_id,
SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
)
SELECT *
FROM department_totals
WHERE total_salary > 100000;

-- ============================================================
-- 10. CTE + CASE
-- ============================================================

WITH employee_status AS (
SELECT
first_name,
salary,
CASE
WHEN salary >= 80000 THEN 'High'
WHEN salary >= 60000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees
)
SELECT *
FROM employee_status;

-- ============================================================
-- 11. MULTI-STEP ANALYSIS
-- ============================================================

WITH employee_analysis AS (
SELECT
first_name,
department_id,
salary,
AVG(salary) OVER (
PARTITION BY department_id
) AS department_average
FROM employees
),

salary_comparison AS (
SELECT
first_name,
department_id,
salary,
department_average,
salary - department_average AS difference
FROM employee_analysis
)

SELECT *
FROM salary_comparison
WHERE difference > 0;

-- ============================================================
-- 12. CUSTOMER TOTALS
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
)
SELECT *
FROM customer_totals;

-- ============================================================
-- 13. CUSTOMER SPENDING ABOVE AVERAGE
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

customer_average AS (
SELECT
AVG(total_spending) AS average_spending
FROM customer_totals
)

SELECT
ct.customer_id,
ct.total_spending
FROM customer_totals AS ct
CROSS JOIN customer_average AS ca
WHERE ct.total_spending > ca.average_spending;

-- ============================================================
-- 14. CUSTOMER SPENDING WITH CUSTOMER NAME
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
)
SELECT
c.customer_name,
ct.total_spending
FROM customer_totals AS ct
JOIN customers AS c
ON ct.customer_id = c.customer_id
ORDER BY ct.total_spending DESC;

-- ============================================================
-- 15. CUSTOMER RANKING
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,
RANK() OVER (
ORDER BY total_spending DESC
) AS spending_rank
FROM customer_totals
)

SELECT *
FROM ranked_customers;

-- ============================================================
-- 16. TOP THREE CUSTOMERS
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,
ROW_NUMBER() OVER (
ORDER BY total_spending DESC
) AS spending_rank
FROM customer_totals
)

SELECT *
FROM ranked_customers
WHERE spending_rank <= 3;

-- ============================================================
-- 17. CTE + JOIN + WINDOW FUNCTION
-- ============================================================

WITH employee_data AS (
SELECT
e.employee_id,
e.first_name,
e.department_id,
e.salary,
d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
),

ranked_employees AS (
SELECT
employee_id,
first_name,
department_name,
department_id,
salary,

```
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS department_rank,

    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average

FROM employee_data
```

)

SELECT *
FROM ranked_employees
WHERE department_rank <= 2;

-- ============================================================
-- 18. RECURSIVE CTE — NUMBERS
-- ============================================================

WITH RECURSIVE numbers AS (
SELECT 1 AS n

```
UNION ALL

SELECT n + 1
FROM numbers
WHERE n < 10
```

)

SELECT *
FROM numbers;

-- ============================================================
-- 19. RECURSIVE CTE — DATES
-- ============================================================

WITH RECURSIVE dates AS (
SELECT DATE('2026-01-01') AS order_date

```
UNION ALL

SELECT order_date + INTERVAL 1 DAY
FROM dates
WHERE order_date < '2026-01-07'
```

)

SELECT *
FROM dates;

-- ============================================================
-- 20. RECURSIVE EMPLOYEE HIERARCHY
-- ============================================================

WITH RECURSIVE employee_hierarchy AS (

```
SELECT
    employee_id,
    first_name,
    manager_id,
    0 AS hierarchy_level
FROM employees
WHERE manager_id IS NULL

UNION ALL

SELECT
    e.employee_id,
    e.first_name,
    e.manager_id,
    eh.hierarchy_level + 1
FROM employees AS e
JOIN employee_hierarchy AS eh
    ON e.manager_id = eh.employee_id
```

)

SELECT
employee_id,
first_name,
manager_id,
hierarchy_level
FROM employee_hierarchy
ORDER BY hierarchy_level, employee_id;

-- ============================================================
-- 21. CTE + CUSTOMER ORDER RANKING
-- ============================================================

WITH customer_orders AS (
SELECT
o.customer_id,
o.order_id,
o.order_date,
o.total_amount
FROM orders AS o
),

ranked_orders AS (
SELECT
customer_id,
order_id,
order_date,
total_amount,

```
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY total_amount DESC
    ) AS order_rank

FROM customer_orders
```

)

SELECT *
FROM ranked_orders
WHERE order_rank = 1;

-- ============================================================
-- 22. MULTI-STEP SALES ANALYSIS
-- ============================================================

WITH customer_totals AS (
SELECT
customer_id,
SUM(total_amount) AS total_spending
FROM orders
GROUP BY customer_id
),

ranked_customers AS (
SELECT
customer_id,
total_spending,

```
    RANK() OVER (
        ORDER BY total_spending DESC
    ) AS spending_rank

FROM customer_totals
```

),

customer_analysis AS (
SELECT
rc.customer_id,
c.customer_name,
rc.total_spending,
rc.spending_rank
FROM ranked_customers AS rc
JOIN customers AS c
ON rc.customer_id = c.customer_id
)

SELECT *
FROM customer_analysis
WHERE spending_rank <= 3;
