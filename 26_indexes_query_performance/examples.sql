-- ============================================================
-- Module 26: Indexes & Query Performance
-- MySQL 8.0+
-- ============================================================

DROP DATABASE IF EXISTS module26_indexes;
CREATE DATABASE module26_indexes;
USE module26_indexes;

-- ============================================================
-- 1. Create Tables
-- ============================================================

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL,
city VARCHAR(100),
status VARCHAR(20) NOT NULL,
created_at DATE NOT NULL
) ENGINE = InnoDB;

CREATE TABLE departments (
department_id INT PRIMARY KEY AUTO_INCREMENT,
department_name VARCHAR(100) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE employees (
employee_id INT PRIMARY KEY AUTO_INCREMENT,
employee_name VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL,
department_id INT,
salary DECIMAL(10,2),
hire_date DATE,
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
) ENGINE = InnoDB;

CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
status VARCHAR(30) NOT NULL,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
) ENGINE = InnoDB;

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock INT NOT NULL
) ENGINE = InnoDB;

-- ============================================================
-- 2. Insert Sample Data
-- ============================================================

INSERT INTO departments (department_name)
VALUES
('IT'),
('HR'),
('Finance'),
('Sales'),
('Marketing');

INSERT INTO customers
(name, email, city, status, created_at)
VALUES
('Amit Sharma', '[amit@example.com](mailto:amit@example.com)', 'Delhi', 'Active', '2025-01-10'),
('Priya Singh', '[priya@example.com](mailto:priya@example.com)', 'Mumbai', 'Active', '2025-02-15'),
('Rahul Verma', '[rahul@example.com](mailto:rahul@example.com)', 'Delhi', 'Inactive', '2025-03-20'),
('Neha Gupta', '[neha@example.com](mailto:neha@example.com)', 'Pune', 'Active', '2025-04-05'),
('Arjun Mehta', '[arjun@example.com](mailto:arjun@example.com)', 'Bangalore', 'Active', '2025-05-12'),
('Kavya Rao', '[kavya@example.com](mailto:kavya@example.com)', 'Hyderabad', 'Inactive', '2025-06-18'),
('Rohan Das', '[rohan@example.com](mailto:rohan@example.com)', 'Kolkata', 'Active', '2025-07-22'),
('Ananya Roy', '[ananya@example.com](mailto:ananya@example.com)', 'Delhi', 'Active', '2025-08-14'),
('Vikram Shah', '[vikram@example.com](mailto:vikram@example.com)', 'Mumbai', 'Active', '2025-09-01'),
('Sneha Jain', '[sneha@example.com](mailto:sneha@example.com)', 'Jaipur', 'Inactive', '2025-10-11');

INSERT INTO employees
(employee_name, email, department_id, salary, hire_date)
VALUES
('Aman', '[aman@company.com](mailto:aman@company.com)', 1, 70000, '2021-01-10'),
('Bhavna', '[bhavna@company.com](mailto:bhavna@company.com)', 2, 55000, '2022-03-15'),
('Chetan', '[chetan@company.com](mailto:chetan@company.com)', 1, 85000, '2020-06-20'),
('Divya', '[divya@company.com](mailto:divya@company.com)', 3, 75000, '2021-09-12'),
('Esha', '[esha@company.com](mailto:esha@company.com)', 4, 60000, '2023-02-18'),
('Farhan', '[farhan@company.com](mailto:farhan@company.com)', 1, 95000, '2019-11-25'),
('Gauri', '[gauri@company.com](mailto:gauri@company.com)', 5, 65000, '2022-08-05'),
('Harsh', '[harsh@company.com](mailto:harsh@company.com)', 4, 72000, '2020-12-01');

INSERT INTO orders
(customer_id, status, order_date, total_amount)
VALUES
(1, 'Completed', '2026-01-05', 4500),
(2, 'Pending', '2026-01-10', 3200),
(1, 'Completed', '2026-01-15', 7800),
(3, 'Cancelled', '2026-01-20', 1200),
(4, 'Completed', '2026-02-01', 6500),
(5, 'Pending', '2026-02-12', 2100),
(2, 'Completed', '2026-02-20', 8900),
(6, 'Pending', '2026-03-01', 1500),
(7, 'Completed', '2026-03-08', 5600),
(8, 'Completed', '2026-03-15', 9200);

INSERT INTO products
(product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 65000, 10),
('Keyboard', 'Electronics', 1500, 25),
('Mouse', 'Electronics', 800, 40),
('Monitor', 'Electronics', 18000, 15),
('Office Chair', 'Furniture', 12000, 8),
('Desk', 'Furniture', 20000, 5),
('Notebook', 'Stationery', 100, 100),
('Pen', 'Stationery', 30, 500);

-- ============================================================
-- 3. View Existing Indexes
-- ============================================================

SHOW INDEX FROM customers;

-- ============================================================
-- 4. Create a Single-Column Index
-- ============================================================

CREATE INDEX idx_customers_city
ON customers(city);

SHOW INDEX FROM customers;

-- ============================================================
-- 5. Query Using Indexed Column
-- ============================================================

EXPLAIN
SELECT *
FROM customers
WHERE city = 'Delhi';

-- ============================================================
-- 6. Create Email Index
-- ============================================================

CREATE INDEX idx_customers_email
ON customers(email);

EXPLAIN
SELECT *
FROM customers
WHERE email = '[amit@example.com](mailto:amit@example.com)';

-- ============================================================
-- 7. Unique Index
-- ============================================================

CREATE UNIQUE INDEX idx_employees_email
ON employees(email);

SHOW INDEX FROM employees;

-- ============================================================
-- 8. Composite Index
-- ============================================================

CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);

-- Uses the first column of the composite index.

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

-- Uses both columns.

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1
AND status = 'Completed';

-- Status alone does not generally get the same benefit
-- from this composite index.

EXPLAIN
SELECT *
FROM orders
WHERE status = 'Completed';

-- ============================================================
-- 9. Composite Index with Date
-- ============================================================

CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1
AND order_date >= '2026-01-01';

-- ============================================================
-- 10. Index for JOIN
-- ============================================================

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

EXPLAIN
SELECT
c.name,
o.order_id,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- ============================================================
-- 11. Index for ORDER BY
-- ============================================================

CREATE INDEX idx_products_price
ON products(price);

EXPLAIN
SELECT product_id, product_name, price
FROM products
ORDER BY price;

-- ============================================================
-- 12. Covering Index Example
-- ============================================================

CREATE INDEX idx_products_category_price
ON products(category, price);

EXPLAIN
SELECT category, price
FROM products
WHERE category = 'Electronics';

-- ============================================================
-- 13. Function on Indexed Column
-- ============================================================

CREATE INDEX idx_customers_created_at
ON customers(created_at);

EXPLAIN
SELECT *
FROM customers
WHERE YEAR(created_at) = 2025;

-- Range-based alternative.

EXPLAIN
SELECT *
FROM customers
WHERE created_at >= '2025-01-01'
AND created_at < '2026-01-01';

-- ============================================================
-- 14. LIKE and Indexes
-- ============================================================

CREATE INDEX idx_customers_name
ON customers(name);

EXPLAIN
SELECT *
FROM customers
WHERE name LIKE 'Amit%';

EXPLAIN
SELECT *
FROM customers
WHERE name LIKE '%Amit';

-- ============================================================
-- 15. Cardinality
-- ============================================================

SHOW INDEX FROM customers;

-- ============================================================
-- 16. ANALYZE TABLE
-- ============================================================

ANALYZE TABLE customers;

ANALYZE TABLE orders;

ANALYZE TABLE products;

-- ============================================================
-- 17. EXPLAIN a Join
-- ============================================================

EXPLAIN
SELECT
e.employee_name,
d.department_name,
e.salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 70000;

-- ============================================================
-- 18. EXPLAIN with Filtering and Sorting
-- ============================================================

CREATE INDEX idx_employees_department_salary
ON employees(department_id, salary);

EXPLAIN
SELECT
employee_name,
salary
FROM employees
WHERE department_id = 1
AND salary > 70000
ORDER BY salary DESC;

-- ============================================================
-- 19. Dropping an Index
-- ============================================================

DROP INDEX idx_customers_city
ON customers;

SHOW INDEX FROM customers;

-- ============================================================
-- 20. EXPLAIN ANALYZE
-- ============================================================

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 1;

-- ============================================================
-- 21. Comparing Query Patterns
-- ============================================================

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1
AND status = 'Completed';

EXPLAIN
SELECT *
FROM orders
WHERE status = 'Completed';

-- ============================================================
-- 22. Duplicate / Overlapping Index Demonstration
-- ============================================================

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_customer_status_demo
ON orders(customer_id, status);

SHOW INDEX FROM orders;

-- ============================================================
-- 23. Final Index Inspection
-- ============================================================

SHOW INDEX FROM customers;

SHOW INDEX FROM employees;

SHOW INDEX FROM orders;

SHOW INDEX FROM products;
