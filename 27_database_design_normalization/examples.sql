-- ============================================================
-- Module 27: Database Design & Normalization
-- examples.sql
-- MySQL 8.0+
-- ============================================================

DROP DATABASE IF EXISTS module27_normalization;
CREATE DATABASE module27_normalization;
USE module27_normalization;

-- ============================================================
-- 1. Poorly Designed Table
-- ============================================================

CREATE TABLE orders_bad (
order_id INT PRIMARY KEY,
customer_name VARCHAR(100),
customer_phone VARCHAR(20),
customer_city VARCHAR(100),
product_name VARCHAR(100),
product_price DECIMAL(10,2),
quantity INT
);

INSERT INTO orders_bad
VALUES
(101, 'Alice', '9876543210', 'Delhi', 'Laptop', 75000.00, 1),
(102, 'Alice', '9876543210', 'Delhi', 'Mouse', 800.00, 2),
(103, 'Bob', '8765432109', 'Mumbai', 'Keyboard', 1500.00, 1);

SELECT *
FROM orders_bad;

-- Problems:
-- 1. Customer information is repeated.
-- 2. Product information is mixed with order information.
-- 3. Updating customer information requires multiple updates.
-- 4. Updating product information may require multiple updates.

-- ============================================================
-- 2. Normalized Customers Table
-- ============================================================

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(100) NOT NULL,
customer_phone VARCHAR(20) UNIQUE,
customer_city VARCHAR(100)
);

INSERT INTO customers (customer_name, customer_phone, customer_city)
VALUES
('Alice', '9876543210', 'Delhi'),
('Bob', '8765432109', 'Mumbai'),
('Charlie', '7654321098', 'Bangalore');

SELECT *
FROM customers;

-- ============================================================
-- 3. Normalized Products Table
-- ============================================================

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100) NOT NULL,
product_price DECIMAL(10,2) NOT NULL,
CHECK (product_price >= 0)
);

INSERT INTO products (product_name, product_price)
VALUES
('Laptop', 75000.00),
('Mouse', 800.00),
('Keyboard', 1500.00);

SELECT *
FROM products;

-- ============================================================
-- 4. Orders Table
-- ============================================================

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
order_date DATE NOT NULL,

```
FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
```

);

INSERT INTO orders
VALUES
(101, 1, '2026-01-10'),
(102, 1, '2026-01-12'),
(103, 2, '2026-01-15');

SELECT *
FROM orders;

-- ============================================================
-- 5. Order Items Table
-- ============================================================

CREATE TABLE order_items (
order_id INT,
product_id INT,
quantity INT NOT NULL,

```
PRIMARY KEY (order_id, product_id),

FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

FOREIGN KEY (product_id)
    REFERENCES products(product_id),

CHECK (quantity > 0)
```

);

INSERT INTO order_items
VALUES
(101, 1, 1),
(102, 2, 2),
(103, 3, 1);

SELECT *
FROM order_items;

-- ============================================================
-- 6. Joining the Normalized Tables
-- ============================================================

SELECT
o.order_id,
c.customer_name,
c.customer_city,
o.order_date,
p.product_name,
p.product_price,
oi.quantity
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

-- ============================================================
-- 7. One-to-Many Relationship
-- Customer → Orders
-- ============================================================

SELECT
c.customer_name,
o.order_id,
o.order_date
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date;

-- ============================================================
-- 8. Many-to-Many Relationship
-- Students ↔ Courses
-- ============================================================

CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
student_id INT,
course_id INT,
enrollment_date DATE NOT NULL,

```
PRIMARY KEY (student_id, course_id),

FOREIGN KEY (student_id)
    REFERENCES students(student_id),

FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
```

);

INSERT INTO students (student_name)
VALUES
('Rahul'),
('Priya'),
('Aman');

INSERT INTO courses (course_name)
VALUES
('SQL'),
('Python'),
('Data Analytics');

INSERT INTO enrollments
VALUES
(1, 1, '2026-01-05'),
(1, 2, '2026-01-06'),
(2, 1, '2026-01-07'),
(2, 3, '2026-01-08'),
(3, 1, '2026-01-09');

SELECT *
FROM enrollments;

-- ============================================================
-- 9. Querying a Many-to-Many Relationship
-- ============================================================

SELECT
s.student_name,
c.course_name,
e.enrollment_date
FROM enrollments e
JOIN students s
ON e.student_id = s.student_id
JOIN courses c
ON e.course_id = c.course_id
ORDER BY s.student_name;

-- ============================================================
-- 10. Composite Primary Key
-- ============================================================

SELECT
student_id,
course_id,
enrollment_date
FROM enrollments;

## -- The combination of:

## -- student_id + course_id

-- uniquely identifies each enrollment.

-- ============================================================
-- 11. Demonstrating Referential Integrity
-- ============================================================

-- This should fail because customer_id 999 does not exist.

-- INSERT INTO orders
-- VALUES (104, 999, '2026-02-01');

-- ============================================================
-- 12. Demonstrating UNIQUE Constraint
-- ============================================================

-- This should fail because the phone number already exists.

-- INSERT INTO customers
--     (customer_name, customer_phone, customer_city)
-- VALUES
--     ('David', '9876543210', 'Pune');

-- ============================================================
-- 13. Demonstrating CHECK Constraint
-- ============================================================

-- This should fail because product_price cannot be negative.

-- INSERT INTO products
--     (product_name, product_price)
-- VALUES
--     ('Invalid Product', -100);

-- ============================================================
-- 14. Functional Dependency Example
-- ============================================================

-- customer_id → customer_name
-- customer_id → customer_phone
-- customer_id → customer_city

SELECT
customer_id,
customer_name,
customer_phone,
customer_city
FROM customers;

-- product_id → product_name
-- product_id → product_price

SELECT
product_id,
product_name,
product_price
FROM products;

-- ============================================================
-- 15. Partial Dependency Example
-- ============================================================

CREATE TABLE order_items_demo (
order_id INT,
product_id INT,
order_date DATE,
product_name VARCHAR(100),
quantity INT,

```
PRIMARY KEY (order_id, product_id)
```

);

## -- Functional dependencies:

-- order_id → order_date
-- product_id → product_name
-- (order_id, product_id) → quantity
------------------------------------

-- order_date and product_name depend on only
-- part of the composite key.
-----------------------------

-- Therefore, this structure is not in 2NF.

-- ============================================================
-- 16. Transitive Dependency Example
-- ============================================================

CREATE TABLE employees_bad (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(100),
department_id INT,
department_name VARCHAR(100)
);

INSERT INTO employees_bad
VALUES
(1, 'John', 10, 'IT'),
(2, 'Sarah', 10, 'IT'),
(3, 'Mike', 20, 'Finance');

SELECT *
FROM employees_bad;

## -- Dependencies:

-- employee_id → department_id
-- department_id → department_name
----------------------------------

## -- Therefore:

## -- employee_id → department_name

-- This creates a transitive dependency.

-- ============================================================
-- 17. Normalized Employee / Department Design
-- ============================================================

CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(100) NOT NULL,
department_id INT,

```
FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
```

);

INSERT INTO departments
VALUES
(10, 'IT'),
(20, 'Finance'),
(30, 'HR');

INSERT INTO employees
VALUES
(1, 'John', 10),
(2, 'Sarah', 10),
(3, 'Mike', 20);

SELECT
e.employee_id,
e.employee_name,
d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- ============================================================
-- 18. Avoiding Derived Data
-- ============================================================

SELECT
oi.order_id,
oi.product_id,
oi.quantity,
p.product_price,
oi.quantity * p.product_price AS line_total
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- ============================================================
-- 19. Normalized Order Total
-- ============================================================

SELECT
o.order_id,
c.customer_name,
SUM(oi.quantity * p.product_price) AS order_total
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY
o.order_id,
c.customer_name;

-- ============================================================
-- 20. Inspecting Table Structure
-- ============================================================

DESCRIBE customers;

DESCRIBE products;

DESCRIBE orders;

DESCRIBE order_items;

DESCRIBE enrollments;

-- ============================================================
-- 21. Inspecting Foreign Keys
-- ============================================================

SELECT
TABLE_NAME,
COLUMN_NAME,
CONSTRAINT_NAME,
REFERENCED_TABLE_NAME,
REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = DATABASE()
AND REFERENCED_TABLE_NAME IS NOT NULL;

-- ============================================================
-- 22. Final Normalized Query
-- ============================================================

SELECT
o.order_id,
o.order_date,
c.customer_name,
c.customer_city,
p.product_name,
p.product_price,
oi.quantity,
oi.quantity * p.product_price AS line_total
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
ORDER BY
o.order_date,
o.order_id;
