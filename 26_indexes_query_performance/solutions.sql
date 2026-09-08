-- ============================================================
-- Module 26: Indexes & Query Performance
-- Solutions
-- MySQL 8.0+
-- ============================================================

USE module26_practice;

-- ============================================================
-- BASIC INDEX PRACTICE
-- ============================================================

-- 1. Display all indexes on customers.

SHOW INDEX FROM customers;

-- 2. Create an index on customers.city.

CREATE INDEX idx_customers_city
ON customers(city);

-- 3. Create an index on customers.status.

CREATE INDEX idx_customers_status
ON customers(status);

-- 4. Create an index on products.category.

CREATE INDEX idx_products_category
ON products(category);

-- 5. Create an index on products.price.

CREATE INDEX idx_products_price
ON products(price);

-- 6. Create an index on orders.order_date.

CREATE INDEX idx_orders_order_date
ON orders(order_date);

-- 7. Display indexes on products.

SHOW INDEX FROM products;

-- 8. Remove the status index.

DROP INDEX idx_customers_status
ON customers;

-- ============================================================
-- EXPLAIN PRACTICE
-- ============================================================

-- 9. Analyze customer email search.

EXPLAIN
SELECT *
FROM customers
WHERE email = '[amit@example.com](mailto:amit@example.com)';

-- 10. Create email index and analyze again.

CREATE INDEX idx_customers_email
ON customers(email);

EXPLAIN
SELECT *
FROM customers
WHERE email = '[amit@example.com](mailto:amit@example.com)';

-- 11. Analyze product price filtering.

EXPLAIN
SELECT *
FROM products
WHERE price > 10000;

-- 12. Create price index and analyze again.

CREATE INDEX idx_products_price_search
ON products(price);

EXPLAIN
SELECT *
FROM products
WHERE price > 10000;

-- ============================================================
-- COMPOSITE INDEXES
-- ============================================================

-- 13. Analyze orders by customer.

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

-- 14. Create composite index.

CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);

-- 15. Query using first column.

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

-- 16. Query using both columns.

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1
AND status = 'Completed';

-- 17. Query using only second column.

EXPLAIN
SELECT *
FROM orders
WHERE status = 'Completed';

## -- 18. Explanation:

-- The composite index starts with customer_id.
-- Therefore, queries using customer_id can generally
-- benefit from the index.
--------------------------

-- Queries using customer_id and status can generally
-- use both parts of the index.
-------------------------------

-- A query using only status cannot generally use the
-- composite index as effectively because status is not
-- the leftmost column.

-- ============================================================
-- COMPOSITE INDEX DESIGN
-- ============================================================

-- 19. Customer + order date index.

CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);

-- 20. Analyze customer/date query.

EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 2
AND order_date >= '2026-01-01';

-- 21. Category + price index.

CREATE INDEX idx_products_category_price
ON products(category, price);

-- 22. Analyze category + price query.

EXPLAIN
SELECT *
FROM products
WHERE category = 'Electronics'
AND price > 5000;

-- ============================================================
-- JOIN PERFORMANCE
-- ============================================================

-- 23. Analyze the join.

EXPLAIN
SELECT
c.name,
o.order_id,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- 24. Create customer_id index.

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

-- 25. Analyze again.

EXPLAIN
SELECT
c.name,
o.order_id,
o.total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

-- ============================================================
-- ORDER BY
-- ============================================================

-- 26. Price index.

CREATE INDEX idx_products_price_order
ON products(price);

-- 27. Analyze ORDER BY.

EXPLAIN
SELECT product_name, price
FROM products
ORDER BY price;

-- ============================================================
-- DATE PERFORMANCE
-- ============================================================

-- 28. Date index.

CREATE INDEX idx_customers_created_at
ON customers(created_at);

-- 29. Function applied to date column.

EXPLAIN
SELECT *
FROM customers
WHERE YEAR(created_at) = 2025;

-- 30. Range-based alternative.

EXPLAIN
SELECT *
FROM customers
WHERE created_at >= '2025-01-01'
AND created_at < '2026-01-01';

-- ============================================================
-- LIKE PERFORMANCE
-- ============================================================

-- 31. Name index.

CREATE INDEX idx_customers_name
ON customers(name);

-- 32. Prefix search.

EXPLAIN
SELECT *
FROM customers
WHERE name LIKE 'Amit%';

-- 33. Leading wildcard.

EXPLAIN
SELECT *
FROM customers
WHERE name LIKE '%Amit';

## -- 34. Explanation:

-- 'Amit%' has a known starting point, so a normal B-tree
-- index may be useful.
-----------------------

-- '%Amit' begins with a wildcard, making normal B-tree
-- index usage much less effective for locating the start
-- of the matching values.

-- ============================================================
-- COVERING INDEXES
-- ============================================================

-- 35. Create covering-style index.

CREATE INDEX idx_products_category_price_cover
ON products(category, price);

-- 36. Analyze.

EXPLAIN
SELECT category, price
FROM products
WHERE category = 'Electronics';

-- ============================================================
-- INDEX MANAGEMENT
-- ============================================================

-- 37. Display order indexes.

SHOW INDEX FROM orders;

## -- 38. Remove an index.

-- Remove the single-column order date index.

DROP INDEX idx_orders_order_date
ON orders;

-- 39. Display indexes again.

SHOW INDEX FROM orders;

-- 40. Refresh statistics.

ANALYZE TABLE customers;

-- ============================================================
-- PERFORMANCE REASONING
-- ============================================================

-- 41.
-- Too many indexes increase the work required to maintain
-- index structures when rows are inserted.

-- 42.
-- Updates to indexed columns may require index entries
-- to be modified.

-- 43.
-- Deleted rows require corresponding index entries to
-- be removed.

-- 44.
-- Composite index column order determines which query
-- patterns can efficiently use the index.

-- 45.
-- The leftmost-prefix principle means that a composite
-- index can generally be used effectively beginning with
-- its leftmost column or columns.

-- 46.
-- Selectivity describes how effectively a column
-- distinguishes rows. A column with many distinct values
-- generally has higher selectivity.

-- 47.
-- MySQL may choose not to use an index when it estimates
-- that another execution strategy will be cheaper.

-- 48.
-- A full table scan means MySQL examines rows across
-- the table rather than efficiently locating a smaller
-- matching subset through an index.

-- 49.
-- possible_keys shows indexes MySQL may consider.
-- key shows the index actually selected for the plan.

-- 50.
-- EXPLAIN allows you to compare execution plans before
-- and after changes and verify whether your optimization
-- actually affected the query plan.
