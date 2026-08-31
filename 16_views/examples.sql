-- ============================================================
-- MODULE 16: VIEWS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

-- This file demonstrates the main concepts covered in Module 16.
-- The examples use a separate module16 database so that the
-- earlier school database is not unnecessarily modified.

-- ============================================================
-- 1. CREATE DATABASE
-- ============================================================

CREATE DATABASE IF NOT EXISTS module16_views;

USE module16_views;

-- ============================================================
-- 2. CREATE SAMPLE TABLES
-- ============================================================

DROP VIEW IF EXISTS monthly_sales_summary;
DROP VIEW IF EXISTS customer_order_details;
DROP VIEW IF EXISTS employee_department_report;
DROP VIEW IF EXISTS employee_salary_summary;
DROP VIEW IF EXISTS employee_contact;
DROP VIEW IF EXISTS active_employees;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Departments
CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL
);

-- Employees
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

-- Customers
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
city VARCHAR(100)
);

-- Orders
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,
total_amount DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

-- ============================================================
-- 3. INSERT SAMPLE DATA
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
-- 4. CREATE A SIMPLE VIEW
-- ============================================================

-- This view exposes only selected employee columns.

CREATE VIEW employee_contact AS
SELECT
employee_id,
first_name,
last_name,
email
FROM employees;

-- Query the view like a table.

SELECT *
FROM employee_contact;

-- ============================================================
-- 5. VIEW WITH WHERE
-- ============================================================

CREATE VIEW active_employees AS
SELECT
employee_id,
first_name,
last_name,
salary,
department_id
FROM employees
WHERE salary >= 60000;

SELECT *
FROM active_employees;

-- A view can still be filtered by an outer query.

SELECT
employee_id,
first_name,
salary
FROM active_employees
WHERE salary < 80000
ORDER BY salary DESC;

-- ============================================================
-- 6. VIEW WITH ALIASES
-- ============================================================

CREATE VIEW employee_salary_summary AS
SELECT
employee_id AS id,
CONCAT(first_name, ' ', last_name) AS employee_name,
salary AS monthly_salary
FROM employees;

SELECT *
FROM employee_salary_summary;

-- ============================================================
-- 7. VIEW WITH CALCULATED COLUMN
-- ============================================================

CREATE OR REPLACE VIEW employee_salary_summary AS
SELECT
employee_id AS id,
CONCAT(first_name, ' ', last_name) AS employee_name,
salary AS monthly_salary,
salary * 12 AS annual_salary
FROM employees;

SELECT *
FROM employee_salary_summary;

-- ============================================================
-- 8. VIEW BASED ON MULTIPLE TABLES
-- ============================================================

CREATE VIEW employee_department_report AS
SELECT
e.employee_id,
CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
d.department_name,
e.salary,
e.hire_date
FROM employees AS e
INNER JOIN departments AS d
ON e.department_id = d.department_id;

SELECT *
FROM employee_department_report;

-- Filter the view.

SELECT
employee_name,
department_name,
salary
FROM employee_department_report
WHERE department_name = 'Technology';

-- Sort the view.

SELECT *
FROM employee_department_report
ORDER BY salary DESC;

-- ============================================================
-- 9. VIEW WITH JOIN BETWEEN CUSTOMERS AND ORDERS
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
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

SELECT *
FROM customer_order_details;

-- ============================================================
-- 10. VIEW WITH AGGREGATE FUNCTIONS
-- ============================================================

CREATE VIEW monthly_sales_summary AS
SELECT
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
COUNT(*) AS order_count,
SUM(total_amount) AS total_sales,
AVG(total_amount) AS average_order_value
FROM orders
GROUP BY
YEAR(order_date),
MONTH(order_date);

SELECT *
FROM monthly_sales_summary
ORDER BY
order_year,
order_month;

-- ============================================================
-- 11. GROUPED VIEW
-- ============================================================

CREATE OR REPLACE VIEW department_salary_summary AS
SELECT
department_id,
COUNT(*) AS employee_count,
AVG(salary) AS average_salary,
MAX(salary) AS highest_salary,
MIN(salary) AS lowest_salary
FROM employees
GROUP BY department_id;

SELECT *
FROM department_salary_summary;

-- ============================================================
-- 12. CREATE OR REPLACE VIEW
-- ============================================================

-- The view is recreated with an additional column.

CREATE OR REPLACE VIEW employee_contact AS
SELECT
employee_id,
first_name,
last_name,
email,
hire_date
FROM employees;

SELECT *
FROM employee_contact;

-- ============================================================
-- 13. SHOW CREATE VIEW
-- ============================================================

SHOW CREATE VIEW employee_contact;

-- ============================================================
-- 14. SHOW FULL TABLES
-- ============================================================

-- This shows tables and views in the current database.

SHOW FULL TABLES;

-- ============================================================
-- 15. INFORMATION_SCHEMA.VIEWS
-- ============================================================

SELECT
TABLE_SCHEMA,
TABLE_NAME,
VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = DATABASE();

-- Inspect one particular view.

SELECT
TABLE_NAME,
VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = 'employee_department_report';

-- ============================================================
-- 16. UPDATING DATA THROUGH A SIMPLE VIEW
-- ============================================================

-- employee_contact is a simple view based on one table.
-- A simple view may be updatable.

SELECT *
FROM employee_contact
WHERE employee_id = 101;

UPDATE employee_contact
SET email = '[aarav.updated@example.com](mailto:aarav.updated@example.com)'
WHERE employee_id = 101;

-- Verify the change through the view.

SELECT *
FROM employee_contact
WHERE employee_id = 101;

-- Verify the underlying table.

SELECT
employee_id,
first_name,
last_name,
email
FROM employees
WHERE employee_id = 101;

-- Restore the demonstration data.

UPDATE employees
SET email = '[aarav@example.com](mailto:aarav@example.com)'
WHERE employee_id = 101;

-- ============================================================
-- 17. REPORTING VIEW
-- ============================================================

CREATE OR REPLACE VIEW customer_sales_summary AS
SELECT
c.customer_id,
c.customer_name,
COUNT(o.order_id) AS order_count,
COALESCE(SUM(o.total_amount), 0) AS total_spent,
COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY
c.customer_id,
c.customer_name;

SELECT *
FROM customer_sales_summary
ORDER BY total_spent DESC;

-- ============================================================
-- 18. DROP VIEW
-- ============================================================

-- This demonstrates how to remove a view.

CREATE VIEW temporary_demo_view AS
SELECT
employee_id,
first_name
FROM employees;

SELECT *
FROM temporary_demo_view;

DROP VIEW IF EXISTS temporary_demo_view;

-- Confirm that the view has been removed.

SHOW FULL TABLES;
