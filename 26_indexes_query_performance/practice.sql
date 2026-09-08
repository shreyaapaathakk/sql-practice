-- ============================================================
-- Module 26: Indexes & Query Performance
-- Practice Exercises
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module26_practice;
USE module26_practice;

-- ============================================================
-- Setup
-- ============================================================

CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL,
city VARCHAR(100),
status VARCHAR(20) NOT NULL,
created_at DATE NOT NULL
) ENGINE = InnoDB;

CREATE TABLE products (
product_id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(100) NOT NULL,
category VARCHAR(50) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock INT NOT NULL
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

-- ============================================================
-- BASIC INDEX PRACTICE
-- ============================================================

-- 1. Display all indexes on the customers table.

-- 2. Create an index on customers.city.

-- 3. Create an index on customers.status.

-- 4. Create an index on products.category.

-- 5. Create an index on products.price.

-- 6. Create an index on orders.order_date.

-- 7. Display the indexes on products.

-- 8. Remove the index created on customers.status.

-- ============================================================
-- EXPLAIN PRACTICE
-- ============================================================

-- 9. Use EXPLAIN to analyze a query searching for a customer
--    by email.

-- 10. Create an index on customers.email and run EXPLAIN again.

-- 11. Use EXPLAIN to analyze a query searching for products
--     with price greater than 10000.

-- 12. Create an appropriate index and compare the plan.

-- 13. Use EXPLAIN on a query filtering orders by customer_id.

-- ============================================================
-- COMPOSITE INDEXES
-- ============================================================

-- 14. Create a composite index on:
--     orders(customer_id, status)

-- 15. Use EXPLAIN for:
--     WHERE customer_id = 1

-- 16. Use EXPLAIN for:
--     WHERE customer_id = 1 AND status = 'Completed'

-- 17. Use EXPLAIN for:
--     WHERE status = 'Completed'

-- 18. Explain why the queries in Exercises 15–17
--     may use the composite index differently.

-- ============================================================
-- COMPOSITE INDEX DESIGN
-- ============================================================

-- 19. Create a composite index suitable for queries that
--     frequently filter orders by customer_id and order_date.

## -- 20. Analyze this query using EXPLAIN:

--     SELECT *
--     FROM orders
--     WHERE customer_id = 2
--       AND order_date >= '2026-01-01';

-- 21. Create a composite index on:
--     products(category, price)

## -- 22. Analyze:

--     SELECT *
--     FROM products
--     WHERE category = 'Electronics'
--       AND price > 5000;

-- ============================================================
-- JOIN PERFORMANCE
-- ============================================================

## -- 23. Use EXPLAIN to analyze:

--     SELECT c.name, o.order_id, o.total_amount
--     FROM customers c
--     JOIN orders o
--         ON c.customer_id = o.customer_id;

-- 24. Create an index on orders.customer_id.

-- 25. Run EXPLAIN again and compare the execution plan.

-- ============================================================
-- ORDER BY
-- ============================================================

## -- 26. Create an index that may help:

--     SELECT product_name, price
--     FROM products
--     ORDER BY price;

-- 27. Use EXPLAIN to analyze the query.

-- ============================================================
-- DATE PERFORMANCE
-- ============================================================

-- 28. Create an index on customers.created_at.

## -- 29. Analyze:

--     SELECT *
--     FROM customers
--     WHERE YEAR(created_at) = 2025;

-- 30. Rewrite the query using a date range and analyze it
--     with EXPLAIN.

-- ============================================================
-- LIKE PERFORMANCE
-- ============================================================

-- 31. Create an index on customers.name.

## -- 32. Analyze:

--     WHERE name LIKE 'Amit%'

## -- 33. Analyze:

--     WHERE name LIKE '%Amit'

-- 34. Explain why the two LIKE patterns can behave differently
--     with a normal B-tree index.

-- ============================================================
-- COVERING INDEXES
-- ============================================================

## -- 35. Create an index that could cover:

--     SELECT category, price
--     FROM products
--     WHERE category = 'Electronics';

-- 36. Analyze the query with EXPLAIN.

-- ============================================================
-- INDEX MANAGEMENT
-- ============================================================

-- 37. Display all indexes on orders.

-- 38. Remove an index from orders.

-- 39. Display the indexes again.

-- 40. Run ANALYZE TABLE on customers.

-- ============================================================
-- PERFORMANCE REASONING
-- ============================================================

-- 41. Why can too many indexes hurt INSERT performance?

-- 42. Why can too many indexes hurt UPDATE performance?

-- 43. Why can too many indexes hurt DELETE performance?

-- 44. Why does the order of columns in a composite index matter?

-- 45. What is the leftmost-prefix principle?

-- 46. What is selectivity?

-- 47. Why might MySQL choose not to use an available index?

-- 48. What does a full table scan mean?

-- 49. What is the difference between possible_keys and key
--     in EXPLAIN?

-- 50. Why should EXPLAIN be used before and after optimization?
