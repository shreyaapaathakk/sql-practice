-- ============================================================
-- MODULE 21: SQL VIEWS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module21_views;

USE module21_views;

-- ============================================================
-- CLEANUP
-- ============================================================

DROP VIEW IF EXISTS employee_public_info;
DROP VIEW IF EXISTS high_salary_employees;
DROP VIEW IF EXISTS employee_salary_categories;
DROP VIEW IF EXISTS employee_details;
DROP VIEW IF EXISTS employee_rankings;
DROP VIEW IF EXISTS department_salary_summary;
DROP VIEW IF EXISTS customer_order_details;
DROP VIEW IF EXISTS customer_spending;
DROP VIEW IF EXISTS sales_employees;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- ============================================================
-- TABLES
-- ============================================================

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
-- 1. BASIC VIEW
-- ============================================================

CREATE VIEW high_salary_employees AS
SELECT
employee_id,
first_name,
salary
FROM employees
WHERE salary > 60000;

SELECT *
FROM high_salary_employees;

-- ============================================================
-- 2. FILTERING A VIEW
-- ============================================================

SELECT *
FROM high_salary_employees
WHERE salary > 70000;

-- ============================================================
-- 3. VIEW WITH JOIN
-- ============================================================

CREATE VIEW employee_details AS
SELECT
e.employee_id,
e.first_name,
e.last_name,
e.salary,
d.department_name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id;

SELECT *
FROM employee_details;

-- ============================================================
-- 4. FILTER AND SORT A VIEW
-- ============================================================

SELECT
first_name,
department_name,
salary
FROM employee_details
WHERE salary > 60000
ORDER BY salary DESC;

-- ============================================================
-- 5. VIEW WITH AGGREGATION
-- ============================================================

CREATE VIEW department_salary_summary AS
SELECT
department_id,
COUNT(*) AS employee_count,
SUM(salary) AS total_salary,
AVG(salary) AS average_salary
FROM employees
GROUP BY department_id;

SELECT *
FROM department_salary_summary;

-- ============================================================
-- 6. VIEW WITH CASE
-- ============================================================

CREATE VIEW employee_salary_categories AS
SELECT
employee_id,
first_name,
salary,
CASE
WHEN salary >= 80000 THEN 'High'
WHEN salary >= 60000 THEN 'Medium'
ELSE 'Low'
END AS salary_category
FROM employees;

SELECT *
FROM employee_salary_categories;

-- ============================================================
-- 7. VIEW WITH WINDOW FUNCTION
-- ============================================================

CREATE VIEW employee_rankings AS
SELECT
employee_id,
first_name,
department_id,
salary,
RANK() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS department_rank
FROM employees;

SELECT *
FROM employee_rankings;

-- ============================================================
-- 8. TOP TWO EMPLOYEES PER DEPARTMENT
-- ============================================================

SELECT *
FROM employee_rankings
WHERE department_rank <= 2;

-- ============================================================
-- 9. CUSTOMER ORDER VIEW
-- ============================================================

CREATE VIEW customer_order_details AS
SELECT
c.customer_id,
c.customer_name,
c.city,
o.order_id,
o.order_date,
o.total_amount
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id;

SELECT *
FROM customer_order_details;

-- ============================================================
-- 10. FILTER CUSTOMER ORDERS
-- ============================================================

SELECT *
FROM customer_order_details
WHERE total_amount > 2000
ORDER BY total_amount DESC;

-- ============================================================
-- 11. CUSTOMER SPENDING VIEW
-- ============================================================

CREATE VIEW customer_spending AS
SELECT
c.customer_id,
c.customer_name,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.total_amount), 0) AS total_spending,
COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name;

SELECT *
FROM customer_spending;

-- ============================================================
-- 12. TOP CUSTOMERS
-- ============================================================

SELECT *
FROM customer_spending
ORDER BY total_spending DESC
LIMIT 3;

-- ============================================================
-- 13. PUBLIC EMPLOYEE VIEW
-- ============================================================

CREATE VIEW employee_public_info AS
SELECT
employee_id,
first_name,
last_name,
department_id
FROM employees;

SELECT *
FROM employee_public_info;

-- ============================================================
-- 14. CREATE OR REPLACE VIEW
-- ============================================================

CREATE OR REPLACE VIEW high_salary_employees AS
SELECT
employee_id,
first_name,
last_name,
salary
FROM employees
WHERE salary >= 65000;

SELECT *
FROM high_salary_employees;

-- ============================================================
-- 15. VIEW WITH CHECK OPTION
-- ============================================================

CREATE VIEW sales_employees AS
SELECT
employee_id,
first_name,
salary,
department_id
FROM employees
WHERE department_id = 1
WITH CHECK OPTION;

SELECT *
FROM sales_employees;

-- ============================================================
-- 16. INSPECT VIEW DEFINITION
-- ============================================================

SHOW CREATE VIEW employee_details;

-- ============================================================
-- 17. LIST TABLES AND VIEWS
-- ============================================================

SHOW FULL TABLES;

-- ============================================================
-- 18. QUERY VIEW WITH GROUPING
-- ============================================================

SELECT
department_name,
COUNT(*) AS employee_count,
AVG(salary) AS average_salary
FROM employee_details
GROUP BY department_name;

-- ============================================================
-- 19. QUERY VIEW WITH HAVING
-- ============================================================

SELECT
department_name,
COUNT(*) AS employee_count
FROM employee_details
GROUP BY department_name
HAVING COUNT(*) > 1;

-- ============================================================
-- 20. VIEW + WINDOW FUNCTION
-- ============================================================

SELECT
employee_id,
first_name,
department_name,
salary,
department_rank
FROM employee_rankings AS er
JOIN employee_details AS ed
ON er.employee_id = ed.employee_id
WHERE department_rank = 1;

-- ============================================================
-- 21. CREATE OR REPLACE CUSTOMER VIEW
-- ============================================================

CREATE OR REPLACE VIEW customer_spending AS
SELECT
c.customer_id,
c.customer_name,
c.city,
COUNT(o.order_id) AS total_orders,
COALESCE(SUM(o.total_amount), 0) AS total_spending,
COALESCE(AVG(o.total_amount), 0) AS average_order_value,
COALESCE(MAX(o.total_amount), 0) AS largest_order
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name,
c.city;

SELECT *
FROM customer_spending
ORDER BY total_spending DESC;

-- ============================================================
-- 22. DROP VIEW EXAMPLE
-- ============================================================

DROP VIEW IF EXISTS employee_public_info;

-- ============================================================
-- 23. VERIFY DROP
-- ============================================================

SHOW FULL TABLES;
