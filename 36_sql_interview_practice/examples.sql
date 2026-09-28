SQL

```
/*
File: 36_sql_interview_practice/examples.sql
Module 36: SQL Interview Practice

MySQL Version: 8.0+
*/

-- ============================================================
-- SETUP: INTERVIEW DATASET
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS interview_orders;
DROP TEMPORARY TABLE IF EXISTS interview_employees;
DROP TEMPORARY TABLE IF EXISTS interview_customers;

CREATE TEMPORARY TABLE interview_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150)
);

CREATE TEMPORARY TABLE interview_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TEMPORARY TABLE interview_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO interview_customers VALUES
    (1, 'Aarav Sharma', 'aarav@example.com'),
    (2, 'Diya Verma', 'diya@example.com'),
    (3, 'Kabir Singh', 'kabir@example.com'),
    (4, 'Anaya Gupta', 'diya@example.com'),
    (5, 'Meera Joshi', NULL);

INSERT INTO interview_employees VALUES
    (101, 'Rohan', 'IT', 80000.00),
    (102, 'Sara', 'IT', 80000.00),
    (103, 'Ishaan', 'HR', 55000.00),
    (104, 'Tara', 'HR', 62000.00),
    (105, 'Vikram', 'Finance', 70000.00),
    (106, 'Neha', 'Finance', 60000.00);

INSERT INTO interview_orders VALUES
    (1001, 1, '2026-01-05', 1200.00),
    (1002, 1, '2026-01-20', 800.00),
    (1003, 2, '2026-02-10', 1500.00),
    (1004, 2, '2026-03-02', 500.00),
    (1005, 3, '2026-03-15', 2200.00),
    (1006, 1, '2026-03-25', 700.00),
    (1007, 4, '2026-04-01', 900.00);


-- ============================================================
-- EXAMPLE 1: SECOND-HIGHEST DISTINCT SALARY
-- ============================================================

SELECT MAX(salary) AS second_highest_salary
FROM interview_employees
WHERE salary < (
    SELECT MAX(salary)
    FROM interview_employees
);


-- ============================================================
-- EXAMPLE 2: HIGHEST-PAID EMPLOYEES PER DEPARTMENT
-- Include ties.
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_rank
    FROM interview_employees
)
SELECT
    employee_id,
    employee_name,
    department,
    salary
FROM ranked_employees
WHERE salary_rank = 1
ORDER BY department, employee_id;


-- ============================================================
-- EXAMPLE 3: DUPLICATE EMAILS
-- ============================================================

SELECT
    email,
    COUNT(*) AS occurrences
FROM interview_customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;


-- ============================================================
-- EXAMPLE 4: CUSTOMERS WITHOUT ORDERS
-- ============================================================

SELECT
    c.customer_id,
    c.customer_name
FROM interview_customers AS c
LEFT JOIN interview_orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;


-- ============================================================
-- EXAMPLE 5: RUNNING TOTAL OF ORDERS
-- ============================================================

SELECT
    order_id,
    order_date,
    amount,
    SUM(amount) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING
                 AND CURRENT ROW
    ) AS running_total
FROM interview_orders
ORDER BY order_date, order_id;


-- ============================================================
-- EXAMPLE 6: MONTHLY REVENUE AND PREVIOUS MONTH
-- ============================================================

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS order_month,
        SUM(amount) AS revenue
    FROM interview_orders
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        order_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY order_month
        ) AS previous_revenue
    FROM monthly_revenue
)
SELECT
    order_month,
    revenue,
    previous_revenue,
    revenue - previous_revenue AS revenue_change
FROM monthly_comparison
ORDER BY order_month;


-- ============================================================
-- CLEANUP
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS interview_orders;
DROP TEMPORARY TABLE IF EXISTS interview_employees;
DROP TEMPORARY TABLE IF EXISTS interview_customers;
```

Once Module 36 is complete, we'll move to Module 37 and finish the planned 37-module learning roadmap for `sql-practice`.
