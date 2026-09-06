```sql
-- ============================================================
-- MODULE 20: ADVANCED CTE APPLICATIONS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module20_advanced_cte;

USE module20_advanced_cte;


-- ============================================================
-- 1. SAMPLE TABLES
-- ============================================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS products;


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    status VARCHAR(20)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


-- ============================================================
-- 2. SAMPLE DATA
-- ============================================================

INSERT INTO departments
VALUES
    (1, 'Engineering'),
    (2, 'Marketing'),
    (3, 'Finance'),
    (4, 'Human Resources');


INSERT INTO employees
VALUES
    (1, 'Aarav Sharma', 1, NULL, 120000, '2019-01-10', 'ACTIVE'),
    (2, 'Priya Verma', 1, 1, 95000, '2020-03-15', 'ACTIVE'),
    (3, 'Rohan Singh', 1, 1, 90000, '2021-07-20', 'ACTIVE'),
    (4, 'Ananya Gupta', 2, NULL, 100000, '2018-06-10', 'ACTIVE'),
    (5, 'Vikram Patel', 2, 4, 70000, '2022-02-01', 'ACTIVE'),
    (6, 'Neha Kapoor', 3, NULL, 110000, '2017-09-12', 'ACTIVE'),
    (7, 'Rahul Mehta', 3, 6, 75000, '2023-01-05', 'ACTIVE'),
    (8, 'Simran Das', 4, NULL, 65000, '2020-11-18', 'INACTIVE');


INSERT INTO customers
VALUES
    (1, 'Rahul Kumar', 'rahul@example.com', 'ACTIVE'),
    (2, 'Neha Singh', 'neha@example.com', 'ACTIVE'),
    (3, 'Amit Sharma', 'amit@example.com', 'ACTIVE'),
    (4, 'Sneha Verma', 'sneha@example.com', 'INACTIVE'),
    (5, 'Karan Gupta', 'karan@example.com', 'ACTIVE');


INSERT INTO orders
VALUES
    (1, 1, '2026-01-05', 5000),
    (2, 1, '2026-01-15', 7000),
    (3, 1, '2026-02-10', 3000),
    (4, 2, '2026-01-20', 10000),
    (5, 2, '2026-02-15', 8000),
    (6, 3, '2026-02-20', 4000),
    (7, 3, '2026-03-01', 6000),
    (8, 5, '2026-03-05', 15000);


INSERT INTO products
VALUES
    (1, 'Laptop', 'Electronics', 90000),
    (2, 'Monitor', 'Electronics', 25000),
    (3, 'Keyboard', 'Electronics', 5000),
    (4, 'Chair', 'Furniture', 15000),
    (5, 'Desk', 'Furniture', 30000),
    (6, 'Notebook', 'Stationery', 500),
    (7, 'Pen Set', 'Stationery', 300);


-- ============================================================
-- 3. MULTIPLE CTEs
-- ============================================================

WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
),
customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    t.total_spent
FROM active_customers c
JOIN customer_totals t
    ON c.customer_id = t.customer_id;


-- ============================================================
-- 4. CTE PIPELINE
-- ============================================================

WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
),
customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
high_value_customers AS (
    SELECT
        c.customer_id,
        c.customer_name,
        t.total_spent
    FROM active_customers c
    JOIN customer_totals t
        ON c.customer_id = t.customer_id
    WHERE t.total_spent >= 10000
)
SELECT *
FROM high_value_customers
ORDER BY total_spent DESC;


-- ============================================================
-- 5. CTE + CASE
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_totals
ORDER BY total_spent DESC;


-- ============================================================
-- 6. CTE + JOIN + AGGREGATION
-- ============================================================

WITH department_salary AS (
    SELECT
        department_id,
        SUM(salary) AS total_salary,
        AVG(salary) AS average_salary,
        COUNT(*) AS employee_count
    FROM employees
    WHERE status = 'ACTIVE'
    GROUP BY department_id
)
SELECT
    d.department_name,
    s.employee_count,
    s.average_salary,
    s.total_salary
FROM departments d
JOIN department_salary s
    ON d.department_id = s.department_id
ORDER BY s.total_salary DESC;


-- ============================================================
-- 7. CTE + WINDOW FUNCTION
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
    WHERE status = 'ACTIVE'
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 2
ORDER BY department_id, salary_rank;


-- ============================================================
-- 8. ROW_NUMBER FOR TOP-N PER GROUP
-- ============================================================

WITH ranked_employees AS (
    SELECT
        employee_id,
        employee_name,
        department_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS row_num
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE row_num <= 2;


-- ============================================================
-- 9. CTE + MULTI-LEVEL AGGREGATION
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS customer_total
    FROM orders
    GROUP BY customer_id
),
overall_statistics AS (
    SELECT
        AVG(customer_total) AS average_customer_total,
        MAX(customer_total) AS highest_customer_total
    FROM customer_totals
)
SELECT
    c.customer_id,
    c.customer_total,
    s.average_customer_total,
    s.highest_customer_total
FROM customer_totals c
CROSS JOIN overall_statistics s
WHERE c.customer_total > s.average_customer_total
ORDER BY c.customer_total DESC;


-- ============================================================
-- 10. RUNNING TOTAL
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue
FROM daily_sales
ORDER BY order_date;


-- ============================================================
-- 11. LAG()
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    daily_revenue,
    LAG(daily_revenue) OVER (
        ORDER BY order_date
    ) AS previous_day_revenue
FROM daily_sales
ORDER BY order_date;


-- ============================================================
-- 12. REVENUE CHANGE
-- ============================================================

WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
),
sales_comparison AS (
    SELECT
        order_date,
        daily_revenue,
        LAG(daily_revenue) OVER (
            ORDER BY order_date
        ) AS previous_revenue
    FROM daily_sales
)
SELECT
    order_date,
    daily_revenue,
    previous_revenue,
    daily_revenue - previous_revenue AS revenue_change
FROM sales_comparison
ORDER BY order_date;


-- ============================================================
-- 13. MONTHLY SALES
-- ============================================================

WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)
SELECT *
FROM monthly_sales
ORDER BY sales_year, sales_month;


-- ============================================================
-- 14. PERCENTAGE OF TOTAL
-- ============================================================

WITH department_totals AS (
    SELECT
        department_id,
        SUM(salary) AS department_salary
    FROM employees
    WHERE status = 'ACTIVE'
    GROUP BY department_id
),
company_total AS (
    SELECT
        SUM(department_salary) AS total_salary
    FROM department_totals
)
SELECT
    d.department_id,
    d.department_salary,
    ROUND(
        d.department_salary /
        c.total_salary * 100,
        2
    ) AS salary_percentage
FROM department_totals d
CROSS JOIN company_total c
ORDER BY salary_percentage DESC;


-- ============================================================
-- 15. DUPLICATE DETECTION
-- ============================================================

WITH duplicate_emails AS (
    SELECT
        email,
        COUNT(*) AS email_count
    FROM customers
    GROUP BY email
)
SELECT *
FROM duplicate_emails
WHERE email_count > 1;


-- ============================================================
-- 16. DATA QUALITY CHECK
-- ============================================================

WITH invalid_employees AS (
    SELECT
        employee_id,
        employee_name,
        salary,
        status
    FROM employees
    WHERE salary <= 0
       OR status NOT IN ('ACTIVE', 'INACTIVE')
)
SELECT *
FROM invalid_employees;


-- ============================================================
-- 17. RECURSIVE CTE — NUMBERS
-- ============================================================

WITH RECURSIVE numbers AS (
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM numbers
    WHERE number < 10
)
SELECT *
FROM numbers;


-- ============================================================
-- 18. RECURSIVE CTE — EMPLOYEE HIERARCHY
-- ============================================================

WITH RECURSIVE employee_hierarchy AS (

    -- Anchor member
    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive member
    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        h.hierarchy_level + 1
    FROM employees e
    JOIN employee_hierarchy h
        ON e.manager_id = h.employee_id
)
SELECT
    employee_id,
    employee_name,
    manager_id,
    hierarchy_level
FROM employee_hierarchy
ORDER BY hierarchy_level, employee_id;


-- ============================================================
-- 19. MULTI-STAGE REPORT
-- ============================================================

WITH active_orders AS (
    SELECT
        *
    FROM orders
    WHERE order_date >= '2026-01-01'
),
customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM active_orders
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        order_count,
        total_spent,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM customer_totals
)
SELECT
    c.customer_name,
    r.order_count,
    r.total_spent,
    r.spending_rank
FROM ranked_customers r
JOIN customers c
    ON r.customer_id = c.customer_id
ORDER BY r.spending_rank;


-- ============================================================
-- 20. FINAL COMPLEX QUERY
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_statistics AS (
    SELECT
        AVG(total_spent) AS average_spending
    FROM customer_totals
),
classified_customers AS (
    SELECT
        customer_id,
        order_count,
        total_spent,
        CASE
            WHEN total_spent >= 20000 THEN 'VIP'
            WHEN total_spent >= 10000 THEN 'PREMIUM'
            ELSE 'STANDARD'
        END AS customer_type
    FROM customer_totals
),
ranked_customers AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS spending_rank
    FROM classified_customers
)
SELECT
    c.customer_name,
    r.order_count,
    r.total_spent,
    r.customer_type,
    r.spending_rank,
    s.average_spending
FROM ranked_customers r
JOIN customers c
    ON r.customer_id = c.customer_id
CROSS JOIN customer_statistics s
WHERE r.total_spent > s.average_spending
ORDER BY r.spending_rank;
```
