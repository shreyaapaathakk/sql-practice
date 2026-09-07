```sql
-- ============================================================
-- MODULE 21: ADVANCED VIEWS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module21_advanced_views;

USE module21_advanced_views;


-- ============================================================
-- 1. SAMPLE TABLES
-- ============================================================

DROP VIEW IF EXISTS customer_performance;
DROP VIEW IF EXISTS customer_order_summary;
DROP VIEW IF EXISTS employee_salary_ranking;
DROP VIEW IF EXISTS active_employee_details;
DROP VIEW IF EXISTS department_salary_summary;
DROP VIEW IF EXISTS active_customer_directory;

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


-- ============================================================
-- 3. SIMPLE FILTERED VIEW
-- ============================================================

CREATE VIEW active_customer_directory AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE';


SELECT *
FROM active_customer_directory;


-- ============================================================
-- 4. VIEW WITH JOIN
-- ============================================================

CREATE VIEW active_employee_details AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.salary,
    e.hire_date
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.status = 'ACTIVE';


SELECT *
FROM active_employee_details;


-- ============================================================
-- 5. VIEW WITH AGGREGATION
-- ============================================================

CREATE VIEW department_salary_summary AS
SELECT
    department_id,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees
WHERE status = 'ACTIVE'
GROUP BY department_id;


SELECT *
FROM department_salary_summary;


-- ============================================================
-- 6. VIEW WITH JOIN + AGGREGATION
-- ============================================================

CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.status,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.status;


SELECT *
FROM customer_order_summary
ORDER BY total_spent DESC;


-- ============================================================
-- 7. VIEW WITH CALCULATED COLUMN
-- ============================================================

CREATE OR REPLACE VIEW employee_salary_information AS
SELECT
    employee_id,
    employee_name,
    salary,
    salary * 12 AS annual_salary
FROM employees;


SELECT *
FROM employee_salary_information;


-- ============================================================
-- 8. VIEW WITH CASE EXPRESSION
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


SELECT *
FROM employee_salary_categories;


-- ============================================================
-- 9. VIEW WITH WINDOW FUNCTION
-- ============================================================

CREATE VIEW employee_salary_ranking AS
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


SELECT *
FROM employee_salary_ranking
ORDER BY department_id, salary_rank;


-- ============================================================
-- 10. TOP EMPLOYEES USING A VIEW
-- ============================================================

SELECT
    e.employee_name,
    d.department_name,
    e.salary,
    e.salary_rank
FROM employee_salary_ranking e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.salary_rank <= 2
ORDER BY
    d.department_name,
    e.salary_rank;


-- ============================================================
-- 11. VIEW BASED ON ANOTHER VIEW
-- ============================================================

CREATE VIEW customer_performance AS
SELECT
    customer_id,
    customer_name,
    order_count,
    total_spent,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_order_summary;


SELECT *
FROM customer_performance
ORDER BY total_spent DESC;


-- ============================================================
-- 12. FILTERING A REPORTING VIEW
-- ============================================================

SELECT *
FROM customer_performance
WHERE customer_category IN ('VIP', 'PREMIUM')
ORDER BY total_spent DESC;


-- ============================================================
-- 13. VIEW WITH CHECK OPTION
-- ============================================================

CREATE OR REPLACE VIEW active_customers_check AS
SELECT
    customer_id,
    customer_name,
    email,
    status
FROM customers
WHERE status = 'ACTIVE'
WITH CHECK OPTION;


SELECT *
FROM active_customers_check;


-- ============================================================
-- 14. UPDATE THROUGH A SIMPLE VIEW
-- ============================================================

UPDATE active_customers_check
SET customer_name = 'Rahul Kumar Updated'
WHERE customer_id = 1;


SELECT *
FROM active_customers_check
WHERE customer_id = 1;


-- ============================================================
-- 15. VIEW DEFINITION
-- ============================================================

SHOW CREATE VIEW active_customer_directory;


-- ============================================================
-- 16. REPLACE VIEW DEFINITION
-- ============================================================

CREATE OR REPLACE VIEW active_customer_directory AS
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE status = 'ACTIVE';


SELECT *
FROM active_customer_directory;


-- ============================================================
-- 17. VIEW AS A SECURITY / ABSTRACTION LAYER
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
-- 18. VIEW FOR BUSINESS LOGIC
-- ============================================================

CREATE OR REPLACE VIEW customer_business_segments AS
SELECT
    customer_id,
    customer_name,
    total_spent,
    CASE
        WHEN total_spent >= 20000 THEN 'VIP'
        WHEN total_spent >= 10000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS segment
FROM customer_order_summary;


SELECT *
FROM customer_business_segments;


-- ============================================================
-- 19. COMPLEX REPORTING VIEW
-- ============================================================

CREATE OR REPLACE VIEW employee_performance_report AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.salary,
    e.hire_date,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS salary_rank,
    AVG(e.salary) OVER (
        PARTITION BY e.department_id
    ) AS department_average_salary
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
WHERE e.status = 'ACTIVE';


SELECT
    employee_name,
    department_name,
    salary,
    salary_rank,
    department_average_salary,
    salary - department_average_salary
        AS salary_difference
FROM employee_performance_report
ORDER BY department_name, salary_rank;


-- ============================================================
-- 20. VIEW INFORMATION
-- ============================================================

SHOW CREATE VIEW customer_order_summary;

SHOW CREATE VIEW employee_performance_report;


-- ============================================================
-- END OF EXAMPLES
-- ============================================================
```
