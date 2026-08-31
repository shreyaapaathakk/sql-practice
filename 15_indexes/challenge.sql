-- ============================================================
-- MODULE 15: INDEXES
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Index Investigation
-- ============================================================
-- Create a table containing:
--
-- employee_id
-- employee_name
-- department_id
-- email
-- salary
--
-- Add a PRIMARY KEY and a UNIQUE constraint.
--
-- Use SHOW INDEX to identify the indexes created.


-- ============================================================
-- CHALLENGE 2 — Interview Question
-- ============================================================
-- Why is a PRIMARY KEY automatically indexed?
--
-- Explain why creating another normal index on the same
-- primary-key column is usually unnecessary.


-- ============================================================
-- CHALLENGE 3 — Search Performance
-- ============================================================
-- Create a customers table with:
--
-- customer_id
-- customer_name
-- email
-- city
--
-- Insert at least 100 rows.
--
-- Create an index on email.
--
-- Use EXPLAIN to inspect:
--
-- SELECT *
-- FROM customers
-- WHERE email = '...';


-- ============================================================
-- CHALLENGE 4 — Composite Index
-- ============================================================
-- An application frequently runs:
--
-- SELECT *
-- FROM orders
-- WHERE customer_id = ?
--   AND status = ?;
--
-- Design an appropriate composite index.


-- ============================================================
-- CHALLENGE 5 — Interview Question
-- ============================================================
-- Explain why these two indexes are different:
--
-- INDEX(city, age)
-- INDEX(age, city)
--
-- Give an example query where the order matters.


-- ============================================================
-- CHALLENGE 6 — ORDER BY Optimization
-- ============================================================
-- An application frequently runs:
--
-- SELECT *
-- FROM orders
-- WHERE customer_id = 15
-- ORDER BY order_date DESC
-- LIMIT 10;
--
-- Design an index that could support this query.


-- ============================================================
-- CHALLENGE 7 — Foreign Key Index
-- ============================================================
-- Create:
--
-- departments
-- employees
--
-- Make employees.department_id reference departments.
--
-- Determine whether an index exists for the foreign-key
-- column.
--
-- If necessary, create an appropriate index.


-- ============================================================
-- CHALLENGE 8 — Interview Question
-- ============================================================
-- What is the difference between:
--
-- SELECT *
-- FROM students
-- WHERE city = 'Delhi';
--
-- and:
--
-- SELECT *
-- FROM students
-- WHERE city LIKE '%Delhi%';
--
-- Discuss the implications for a normal B-tree index.


-- ============================================================
-- CHALLENGE 9 — Covering Index
-- ============================================================
-- Consider:
--
-- SELECT first_name
-- FROM students
-- WHERE city = 'Delhi';
--
-- Design a possible covering index.
--
-- Explain why it may be considered a covering index.


-- ============================================================
-- CHALLENGE 10 — Selectivity
-- ============================================================
-- Suppose a table contains 1,000,000 rows.
--
-- Column A contains only:
--
-- Active
-- Inactive
--
-- Column B contains nearly one million different email
-- addresses.
--
-- Which column is likely to have higher selectivity?
--
-- Which is generally the more obvious standalone index
-- candidate for equality searches?
--
-- Explain your reasoning.


-- ============================================================
-- CHALLENGE 11 — Over-Indexing
-- ============================================================
-- Imagine a table has 20 columns.
--
-- Someone creates 20 separate indexes, one for every column.
--
-- Explain at least three problems this design could create.


-- ============================================================
-- CHALLENGE 12 — Write Performance
-- ============================================================
-- Explain why indexes can make INSERT operations more
-- expensive.


-- ============================================================
-- CHALLENGE 13 — Update Performance
-- ============================================================
-- Suppose salary is indexed.
--
-- Explain what MySQL may need to do when this runs:
--
-- UPDATE employees
-- SET salary = 60000
-- WHERE employee_id = 10;


-- ============================================================
-- CHALLENGE 14 — Delete Performance
-- ============================================================
-- Explain why deleting rows can require index maintenance.


-- ============================================================
-- CHALLENGE 15 — EXPLAIN
-- ============================================================
-- Write an EXPLAIN statement for:
--
-- SELECT *
-- FROM students
-- WHERE email = 'student@example.com';


-- ============================================================
-- CHALLENGE 16 — EXPLAIN ANALYZE
-- ============================================================
-- Write an EXPLAIN ANALYZE statement for a query that
-- searches students by city.


-- ============================================================
-- CHALLENGE 17 — Composite Index Reasoning
-- ============================================================
-- Suppose you have:
--
-- INDEX(department_id, status, salary)
--
-- Determine which of these queries can potentially
-- benefit from the leading portion of the index:
--
-- A. WHERE department_id = 1
--
-- B. WHERE department_id = 1 AND status = 'Active'
--
-- C. WHERE department_id = 1
--    AND status = 'Active'
--    AND salary > 50000
--
-- D. WHERE status = 'Active'
--
-- E. WHERE salary > 50000
--
-- Explain your reasoning.


-- ============================================================
-- CHALLENGE 18 — Real-World Orders
-- ============================================================
-- Design indexes for an orders table where the most common
-- queries are:
--
-- 1. Find all orders for a customer.
-- 2. Find completed orders for a customer.
-- 3. Find the five newest orders for a customer.
--
-- Avoid creating unnecessary duplicate indexes.


-- ============================================================
-- CHALLENGE 19 — Index Audit
-- ============================================================
-- Create a table with several indexes.
--
-- Use:
--
-- SHOW INDEX
--
-- and:
--
-- INFORMATION_SCHEMA.STATISTICS
--
-- to audit the indexes.
--
-- Identify any redundant or duplicate indexes.


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Build a small e-commerce schema:
--
-- customers
-- products
-- orders
-- order_items
--
-- Add appropriate:
--
-- PRIMARY KEY indexes
-- UNIQUE indexes
-- FOREIGN KEY indexes
-- search indexes
-- composite indexes
--
-- Requirements:
--
-- 1. Customers should be searchable by email.
-- 2. Products should be searchable by SKU.
-- 3. Orders should be searchable by customer.
-- 4. Orders should support customer + status filtering.
-- 5. Orders should support newest-orders-for-customer queries.
-- 6. Order items should efficiently reference orders.
-- 7. Avoid indexing every column.
--
-- Use SHOW INDEX to inspect your final design.
--
-- Use EXPLAIN on at least three important queries.
--
-- Document why you selected each non-primary index.
