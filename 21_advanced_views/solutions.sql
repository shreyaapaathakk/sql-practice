```sql
-- ============================================================
-- MODULE 21: ADVANCED VIEWS
-- solutions.sql
-- ============================================================

USE module21_advanced_views;


-- ============================================================
-- Exercise 1
-- ============================================================

CREATE OR REPLACE VIEW active_customers_view AS
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE status = 'ACTIVE';


SELECT *
FROM active_customers_view;


-- ============================================================
-- Exercise 2
-- ============================================================

CREATE OR REPLACE VIEW employee_department_view AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;


SELECT *
FROM employee_department_view;


-- ============================================================
-- Exercise 3
-- ============================================================

CREATE OR REPLACE VIEW employee_salary_view AS
SELECT
    employee_name,
    salary,
    salary * 12 AS annual_salary
FROM employees;


SELECT *
FROM employee_salary_view;


-- ============================================================
-- Exercise 4
-- ============================================================

CREATE OR REPLACE VIEW department_statistics AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;


SELECT *
FROM department_statistics;


-- ============================================================
-- Exercise 5
-- ============================================================

CREATE OR REPLACE VIEW customer_order_statistics AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;


SELECT *
FROM customer_order_statistics;


-- ============================================================
-- Exercise 6
-- ============================================================

CREATE OR REPLACE VIEW customer_order_statistics AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;


-- ============================================================
-- Exercise 7
-- ============================================================

CREATE OR REPLACE VIEW employee_salary_categories AS
SELECT
    employee_id,
    employee_name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'HIGH'
        WHEN salary >= 70000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS salary_category
FROM employees;


-- ============================================================
-- Exercise 8
-- ============================================================

CREATE OR REPLACE VIEW customer_categories AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_order_statistics;


SELECT *
FROM customer_categories;


-- ============================================================
-- Exercise 9
-- ============================================================

CREATE OR REPLACE VIEW premium_customers AS
SELECT *
FROM customer_categories
WHERE customer_category IN ('VIP', 'PREMIUM');


SELECT *
FROM premium_customers;


-- ============================================================
-- Exercise 10
-- ============================================================

CREATE OR REPLACE VIEW employee_salary_ranking AS
SELECT
    employee_id,
    employee_name,
    department_id,
    salary,
    RANK() OVER (
        PARTITION BY department_id
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;


-- ============================================================
-- Exercise 11
-- ============================================================

SELECT *
FROM employee_salary_ranking
WHERE salary_rank <= 2
ORDER BY department_id, salary_rank;


-- ============================================================
-- Exercise 12
-- ============================================================

CREATE OR REPLACE VIEW employee_department_salary_analysis AS
SELECT
    employee_id,
    employee_name,
    department_id,
    salary,
    AVG(salary) OVER (
        PARTITION BY department_id
    ) AS department_average_salary
FROM employees;


-- ============================================================
-- Exercise 13
-- ============================================================

SELECT
    employee_id,
    employee_name,
    salary,
    department_average_salary
FROM employee_department_salary_analysis
WHERE salary > department_average_salary;


-- ============================================================
-- Exercise 14
-- ============================================================

CREATE OR REPLACE VIEW customer_order_summary_21 AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;


CREATE OR REPLACE VIEW customer_performance_21 AS
SELECT
    customer_id,
    customer_name,
    order_count,
    total_spent,
    average_order_value
FROM customer_order_summary_21;


SELECT *
FROM customer_performance_21;


-- ============================================================
-- Exercise 15
-- ============================================================

CREATE OR REPLACE VIEW customer_performance_21 AS
SELECT
    customer_id,
    customer_name,
    order_count,
    total_spent,
    average_order_value,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_order_summary_21;


-- ============================================================
-- Exercise 16
-- ============================================================

SELECT *
FROM customer_performance_21
WHERE customer_category IN ('VIP', 'PREMIUM');


-- ============================================================
-- Exercise 17
-- ============================================================

CREATE OR REPLACE VIEW active_customer_editable AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE';


-- ============================================================
-- Exercise 18
-- ============================================================

UPDATE active_customer_editable
SET customer_name = 'Rahul Kumar Updated Again'
WHERE customer_id = 1;


-- ============================================================
-- Exercise 19
-- ============================================================

CREATE OR REPLACE VIEW active_customer_editable AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE'
WITH CHECK OPTION;


-- ============================================================
-- Exercise 20
-- ============================================================

-- This should fail because the resulting row would no longer
-- satisfy the view condition.
--
-- UPDATE active_customer_editable
-- SET status = 'INACTIVE'
-- WHERE customer_id = 1;


-- ============================================================
-- Exercise 21
-- ============================================================

SHOW CREATE VIEW customer_order_statistics;


-- ============================================================
-- Exercise 22
-- ============================================================

CREATE OR REPLACE VIEW active_customer_editable AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE';


-- ============================================================
-- Exercise 23
-- ============================================================

DROP VIEW IF EXISTS active_customer_editable;


-- ============================================================
-- Exercise 24
-- ============================================================

CREATE OR REPLACE VIEW public_employee_directory AS
SELECT
    employee_id,
    employee_name,
    department_id,
    hire_date
FROM employees;


SELECT *
FROM public_employee_directory;


-- ============================================================
-- Exercise 25
-- ============================================================

CREATE OR REPLACE VIEW customer_directory AS
SELECT
    customer_id,
    customer_name,
    email
FROM customers;


-- ============================================================
-- Exercise 26
-- ============================================================

CREATE OR REPLACE VIEW department_reporting_view AS
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    COALESCE(SUM(e.salary), 0) AS total_salary,
    COALESCE(AVG(e.salary), 0) AS average_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name;


SELECT *
FROM department_reporting_view;


-- ============================================================
-- Exercise 27
-- ============================================================

CREATE OR REPLACE VIEW employee_performance_view AS
SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS salary_rank,
    AVG(e.salary) OVER (
        PARTITION BY e.department_id
    ) AS department_average_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;


SELECT *
FROM employee_performance_view;


-- ============================================================
-- Exercise 28
-- ============================================================

SELECT *
FROM employee_performance_view
WHERE salary_rank = 1;


-- ============================================================
-- Exercise 29
-- ============================================================

WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals;


-- ============================================================
-- Exercise 30
-- ============================================================

CREATE OR REPLACE VIEW customer_totals_view AS
SELECT
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;


SELECT *
FROM customer_totals_view;


-- ============================================================
-- Exercise 31
-- ============================================================

-- CTE:
-- Best when the logic is needed only for one query.
--
-- View:
-- Best when the result should become a reusable database object.


-- ============================================================
-- Exercise 32
-- ============================================================

CREATE OR REPLACE VIEW explicit_customer_view AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers;


-- ============================================================
-- Exercise 33
-- ============================================================

CREATE OR REPLACE VIEW active_customer_directory_21 AS
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE status = 'ACTIVE';


-- ============================================================
-- Exercise 34
-- ============================================================

-- This view is generally NON-UPDATABLE because it contains:
--
-- AVG()
-- GROUP BY
--
-- It represents department-level aggregated results rather
-- than individual employee rows.


-- ============================================================
-- Exercise 35
-- ============================================================

-- This view is generally UPDATABLE because it is a simple
-- single-table view with a filtering condition.


-- ============================================================
-- Exercise 36
-- ============================================================

CREATE OR REPLACE VIEW customer_analytics_view AS
SELECT
    customer_id,
    customer_name,
    order_count,
    total_spent,
    average_order_value,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_order_statistics;


SELECT *
FROM customer_analytics_view
ORDER BY total_spent DESC;


-- ============================================================
-- Exercise 37
-- ============================================================

CREATE OR REPLACE VIEW employee_analytics_view AS
SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS salary_rank,
    AVG(e.salary) OVER (
        PARTITION BY e.department_id
    ) AS department_average_salary,
    e.salary -
        AVG(e.salary) OVER (
            PARTITION BY e.department_id
        ) AS salary_difference
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id;


-- ============================================================
-- Exercise 38
-- ============================================================

SELECT *
FROM employee_analytics_view
WHERE salary > department_average_salary
ORDER BY department_name, salary DESC;


-- ============================================================
-- MINI PROJECT
-- ============================================================

-- View 1: Employee Department Summary

CREATE OR REPLACE VIEW employee_department_summary AS
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    COALESCE(SUM(e.salary), 0) AS total_salary,
    COALESCE(AVG(e.salary), 0) AS average_salary
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY
    d.department_id,
    d.department_name;


-- View 2: Customer Order Summary

CREATE OR REPLACE VIEW customer_order_summary_project AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;


-- View 3: Customer Performance

CREATE OR REPLACE VIEW customer_performance_project AS
SELECT
    customer_id,
    customer_name,
    order_count,
    total_spent,
    average_order_value,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_order_summary_project;


SELECT *
FROM customer_performance_project
ORDER BY total_spent DESC;
```
