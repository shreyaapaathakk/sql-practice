-- ============================================================
-- Module 26: Indexes & Query Performance
-- Challenge Exercises
-- MySQL 8.0+
-- ============================================================

USE module26_practice;

-- ============================================================
-- Challenge 1: Customer Lookup
-- ============================================================

## -- The following query searches for customers by email:

-- SELECT *
-- FROM customers
-- WHERE email = '[amit@example.com](mailto:amit@example.com)';
---------------------------------------------------------------

-- Analyze it with EXPLAIN.
-- Decide whether an index on email is appropriate.
-- Create the index and analyze the query again.

-- ============================================================
-- Challenge 2: Product Price Search
-- ============================================================

## -- Analyze:

-- SELECT *
-- FROM products
-- WHERE price BETWEEN 5000 AND 20000;
--------------------------------------

-- Create an appropriate index if justified.
-- Compare the EXPLAIN output.

-- ============================================================
-- Challenge 3: Customer Order Search
-- ============================================================

## -- A frequently executed query is:

-- SELECT *
-- FROM orders
-- WHERE customer_id = 2
--   AND status = 'Completed';
------------------------------

-- Design a suitable index.
-- Explain why you chose the column order.

-- ============================================================
-- Challenge 4: Composite Index Test
-- ============================================================

## -- Create:

## -- INDEX(customer_id, status)

## -- Then analyze all three queries:

-- A:
-- WHERE customer_id = 2
------------------------

-- B:
-- WHERE customer_id = 2
--   AND status = 'Completed'
-----------------------------

-- C:
-- WHERE status = 'Completed'
-----------------------------

-- Explain the differences.

-- ============================================================
-- Challenge 5: Date Filtering
-- ============================================================

## -- Analyze:

-- SELECT *
-- FROM customers
-- WHERE YEAR(created_at) = 2025;
---------------------------------

-- Rewrite it using a date range.
-- Compare both queries using EXPLAIN.

-- ============================================================
-- Challenge 6: LIKE Optimization
-- ============================================================

## -- Compare:

-- SELECT *
-- FROM customers
-- WHERE name LIKE 'A%';
------------------------

## -- with:

-- SELECT *
-- FROM customers
-- WHERE name LIKE '%A';
------------------------

-- Explain which pattern is more compatible with
-- normal B-tree index usage and why.

-- ============================================================
-- Challenge 7: Join Optimization
-- ============================================================

## -- Analyze:

-- SELECT
--     c.name,
--     o.order_id,
--     o.total_amount
-- FROM customers c
-- JOIN orders o
--     ON c.customer_id = o.customer_id
-- WHERE o.status = 'Completed';
--------------------------------

-- Identify columns that may benefit from indexing.
-- Create suitable indexes and analyze again.

-- ============================================================
-- Challenge 8: ORDER BY Optimization
-- ============================================================

## -- Analyze:

-- SELECT product_name, price
-- FROM products
-- ORDER BY price DESC;
-----------------------

-- Create a suitable index.
-- Use EXPLAIN to inspect the result.

-- ============================================================
-- Challenge 9: Covering Index
-- ============================================================

## -- Analyze:

-- SELECT category, price
-- FROM products
-- WHERE category = 'Electronics';
----------------------------------

-- Design a covering-style index.
-- Explain which columns are included and why.

-- ============================================================
-- Challenge 10: Index Audit
-- ============================================================

## -- Display all indexes on:

-- customers
-- products
-- orders
---------

## -- Identify:

-- 1. Useful indexes
-- 2. Potentially redundant indexes
-- 3. Indexes that may not be useful
------------------------------------

-- Do not delete anything until you have justified
-- the decision.

-- ============================================================
-- Challenge 11: Duplicate Index Investigation
-- ============================================================

## -- Create these indexes:

-- INDEX(customer_id)
-- INDEX(customer_id, status)
-----------------------------

## -- Inspect the indexes.

-- Question:
-- Is the first index necessarily required?
-------------------------------------------

-- Explain your answer based on workload and query patterns.

-- ============================================================
-- Challenge 12: EXPLAIN ANALYZE
-- ============================================================

## -- Choose a query from this module.

## -- Run:

-- EXPLAIN ANALYZE
-- SELECT ...;
--------------

## -- Identify:

-- 1. Actual execution time
-- 2. Estimated rows
-- 3. Actual rows
-- 4. Access strategy
---------------------

-- Explain whether the estimates appear reasonable.

-- ============================================================
-- Challenge 13: Performance Investigation
-- ============================================================

## -- You receive this query from an application:

-- SELECT *
-- FROM orders
-- WHERE status = 'Completed'
-- ORDER BY order_date DESC;
----------------------------

## -- Investigate it systematically:

-- 1. Run EXPLAIN.
-- 2. Identify possible performance issues.
-- 3. Consider an appropriate index.
-- 4. Create the index.
-- 5. Run EXPLAIN again.
-- 6. Compare the plans.
------------------------

-- Explain your reasoning.

-- ============================================================
-- Challenge 14: Query Rewrite
-- ============================================================

## -- Analyze:

-- SELECT *
-- FROM customers
-- WHERE YEAR(created_at) = 2025
-- ORDER BY created_at;
-----------------------

-- Rewrite the filtering condition using a range.
-- Consider whether an index on created_at could help.
-- Compare both execution plans.

-- ============================================================
-- Challenge 15: Index Design Case Study
-- ============================================================

## -- Assume an application frequently executes:

-- Query A:
-- SELECT *
-- FROM orders
-- WHERE customer_id = 5;
-------------------------

-- Query B:
-- SELECT *
-- FROM orders
-- WHERE customer_id = 5
--   AND status = 'Pending';
----------------------------

-- Query C:
-- SELECT *
-- FROM orders
-- WHERE customer_id = 5
--   AND order_date >= '2026-01-01';
------------------------------------

-- Design an index strategy that supports these queries
-- while avoiding unnecessary duplicate indexes.
------------------------------------------------

-- Explain your design.

-- ============================================================
-- Challenge 16: Final Performance Project
-- ============================================================

## -- Build a performance investigation for the orders table.

## -- Investigate the following workload:

## -- 1. Search orders by customer_id.

## -- 2. Search orders by customer_id and status.

## -- 3. Search orders by customer_id and date range.

## -- 4. Retrieve completed orders ordered by date.

## -- 5. Join orders with customers.

## -- For each query:

-- A. Run EXPLAIN.
-- B. Identify the access strategy.
-- C. Determine whether an index could help.
-- D. Design the index.
-- E. Run EXPLAIN again.
-- F. Record your observations.
-------------------------------

## -- Final question:

-- How would you balance faster reads against the additional
-- storage and write overhead created by your indexes?

-- ============================================================
-- Final Review Questions
-- ============================================================

-- 17. Why is indexing every column usually a bad strategy?

-- 18. Why does column order matter in composite indexes?

-- 19. What is the leftmost-prefix principle?

-- 20. What does EXPLAIN tell you?

-- 21. What is the difference between estimated and actual
--     execution information?

-- 22. Why can an index improve SELECT performance but hurt
--     INSERT performance?

-- 23. Why can a low-selectivity column sometimes be a poor
--     candidate for a standalone index?

-- 24. Why should performance optimization be based on
--     measurement rather than assumptions?

-- ============================================================
-- End of Module 26
-- ============================================================
