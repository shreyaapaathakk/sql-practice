-- ============================================================
-- Module 30 — Table Partitioning in MySQL
-- examples.sql
-- MySQL 8.0+
-- ============================================================


-- ============================================================
-- 1. CREATE DATABASE
-- ============================================================

DROP DATABASE IF EXISTS sql_practice_partitioning;

CREATE DATABASE sql_practice_partitioning;

USE sql_practice_partitioning;


-- ============================================================
-- 2. RANGE PARTITIONING
-- ============================================================

DROP TABLE IF EXISTS orders_range;

CREATE TABLE orders_range (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    customer_id BIGINT NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,

    PRIMARY KEY (order_id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);


-- ============================================================
-- 3. INSERT DATA INTO RANGE PARTITIONS
-- ============================================================

INSERT INTO orders_range
    (order_id, order_date, customer_id, total_amount)
VALUES
    (1, '2024-03-15', 101, 150.00),
    (2, '2024-08-21', 102, 275.50),
    (3, '2025-01-10', 103, 500.00),
    (4, '2025-07-19', 104, 125.75),
    (5, '2026-02-11', 105, 900.00),
    (6, '2026-06-30', 106, 320.00),
    (7, '2027-01-05', 107, 450.00);


-- ============================================================
-- 4. VIEW DATA
-- ============================================================

SELECT *
FROM orders_range
ORDER BY order_date;


-- ============================================================
-- 5. RANGE COLUMNS PARTITIONING
-- ============================================================

DROP TABLE IF EXISTS orders_range_columns;

CREATE TABLE orders_range_columns (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    customer_id BIGINT NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,

    PRIMARY KEY (order_id, order_date)
)
PARTITION BY RANGE COLUMNS (order_date) (
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- ============================================================
-- 6. INSERT DATA INTO RANGE COLUMNS TABLE
-- ============================================================

INSERT INTO orders_range_columns
    (order_id, order_date, customer_id, total_amount)
VALUES
    (1, '2024-02-10', 101, 100.00),
    (2, '2024-11-25', 102, 250.00),
    (3, '2025-03-18', 103, 450.00),
    (4, '2025-09-07', 104, 325.00),
    (5, '2026-01-12', 105, 800.00),
    (6, '2026-08-22', 106, 650.00),
    (7, '2027-03-05', 107, 900.00);


-- ============================================================
-- 7. QUERY A SPECIFIC DATE RANGE
-- ============================================================

SELECT
    order_id,
    order_date,
    customer_id,
    total_amount
FROM orders_range_columns
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01'
ORDER BY order_date;


-- ============================================================
-- 8. LIST PARTITIONING
-- ============================================================

DROP TABLE IF EXISTS regional_sales;

CREATE TABLE regional_sales (
    sale_id BIGINT NOT NULL,
    region_id INT NOT NULL,
    sale_date DATE NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,

    PRIMARY KEY (sale_id, region_id)
)
PARTITION BY LIST (region_id) (
    PARTITION p_north VALUES IN (1, 2),
    PARTITION p_south VALUES IN (3, 4),
    PARTITION p_west VALUES IN (5, 6),
    PARTITION p_east VALUES IN (7, 8)
);


-- ============================================================
-- 9. INSERT LIST-PARTITIONED DATA
-- ============================================================

INSERT INTO regional_sales
    (sale_id, region_id, sale_date, amount)
VALUES
    (1, 1, '2026-01-05', 1000.00),
    (2, 2, '2026-01-07', 1250.00),
    (3, 3, '2026-01-10', 900.00),
    (4, 4, '2026-01-11', 1100.00),
    (5, 5, '2026-01-14', 750.00),
    (6, 6, '2026-01-18', 875.00),
    (7, 7, '2026-01-20', 1300.00),
    (8, 8, '2026-01-25', 1450.00);


-- ============================================================
-- 10. LIST COLUMNS PARTITIONING
-- ============================================================

DROP TABLE IF EXISTS regional_customers;

CREATE TABLE regional_customers (
    customer_id BIGINT NOT NULL,
    region VARCHAR(30) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,

    PRIMARY KEY (customer_id, region)
)
PARTITION BY LIST COLUMNS (region) (
    PARTITION p_north VALUES IN ('North'),
    PARTITION p_south VALUES IN ('South'),
    PARTITION p_west VALUES IN ('West'),
    PARTITION p_east VALUES IN ('East')
);


-- ============================================================
-- 11. INSERT LIST COLUMNS DATA
-- ============================================================

INSERT INTO regional_customers
    (customer_id, region, customer_name)
VALUES
    (1, 'North', 'Aarav'),
    (2, 'North', 'Diya'),
    (3, 'South', 'Kabir'),
    (4, 'South', 'Meera'),
    (5, 'West', 'Arjun'),
    (6, 'East', 'Ananya');


-- ============================================================
-- 12. HASH PARTITIONING
-- ============================================================

DROP TABLE IF EXISTS customer_events_hash;

CREATE TABLE customer_events_hash (
    event_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,

    PRIMARY KEY (event_id, customer_id)
)
PARTITION BY HASH (customer_id)
PARTITIONS 4;


-- ============================================================
-- 13. INSERT HASH-PARTITIONED DATA
-- ============================================================

INSERT INTO customer_events_hash
    (event_id, customer_id, event_type, event_date)
VALUES
    (1, 101, 'LOGIN', '2026-01-01'),
    (2, 102, 'PURCHASE', '2026-01-02'),
    (3, 103, 'LOGIN', '2026-01-03'),
    (4, 104, 'LOGOUT', '2026-01-04'),
    (5, 105, 'PURCHASE', '2026-01-05'),
    (6, 106, 'LOGIN', '2026-01-06'),
    (7, 107, 'PURCHASE', '2026-01-07'),
    (8, 108, 'LOGIN', '2026-01-08');


-- ============================================================
-- 14. KEY PARTITIONING
-- ============================================================

DROP TABLE IF EXISTS customer_events_key;

CREATE TABLE customer_events_key (
    event_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, customer_id)
)
PARTITION BY KEY (customer_id)
PARTITIONS 4;


-- ============================================================
-- 15. INSERT KEY-PARTITIONED DATA
-- ============================================================

INSERT INTO customer_events_key
    (event_id, customer_id, event_type)
VALUES
    (1, 101, 'LOGIN'),
    (2, 102, 'PURCHASE'),
    (3, 103, 'LOGIN'),
    (4, 104, 'LOGOUT'),
    (5, 105, 'PURCHASE'),
    (6, 106, 'LOGIN');


-- ============================================================
-- 16. INSPECT PARTITION METADATA
-- ============================================================

SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'orders_range_columns'
ORDER BY PARTITION_ORDINAL_POSITION;


-- ============================================================
-- 17. INSPECT ALL PARTITIONED TABLES
-- ============================================================

SELECT
    TABLE_NAME,
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND PARTITION_NAME IS NOT NULL
ORDER BY TABLE_NAME, PARTITION_ORDINAL_POSITION;


-- ============================================================
-- 18. PARTITION PRUNING WITH EXPLAIN
-- ============================================================

EXPLAIN
SELECT
    order_id,
    order_date,
    total_amount
FROM orders_range_columns
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';


-- ============================================================
-- 19. QUERY WITHOUT PARTITION KEY
-- ============================================================

EXPLAIN
SELECT
    order_id,
    order_date,
    customer_id,
    total_amount
FROM orders_range_columns
WHERE customer_id = 105;


-- ============================================================
-- 20. EXPLICIT PARTITION SELECTION
-- ============================================================

SELECT *
FROM orders_range_columns PARTITION (p2026);


-- ============================================================
-- 21. CREATE A TABLE FOR PARTITION MAINTENANCE
-- ============================================================

DROP TABLE IF EXISTS events_maintenance;

CREATE TABLE events_maintenance (
    event_id BIGINT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, event_date)
)
PARTITION BY RANGE COLUMNS (event_date) (
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- ============================================================
-- 22. INSERT MAINTENANCE DATA
-- ============================================================

INSERT INTO events_maintenance
    (event_id, event_date, event_type)
VALUES
    (1, '2024-01-15', 'LOGIN'),
    (2, '2024-07-20', 'PURCHASE'),
    (3, '2025-02-10', 'LOGIN'),
    (4, '2025-08-12', 'PURCHASE'),
    (5, '2026-03-01', 'LOGIN'),
    (6, '2026-09-15', 'PURCHASE');


-- ============================================================
-- 23. REORGANIZE MAXVALUE PARTITION
-- ============================================================

ALTER TABLE events_maintenance
REORGANIZE PARTITION p_future INTO (
    PARTITION p2027 VALUES LESS THAN ('2028-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- ============================================================
-- 24. ADD ANOTHER FUTURE PARTITION
-- ============================================================

ALTER TABLE events_maintenance
REORGANIZE PARTITION p_future INTO (
    PARTITION p2028 VALUES LESS THAN ('2029-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- ============================================================
-- 25. TRUNCATE A PARTITION
-- ============================================================

-- Removes rows from p2024 but keeps the partition.

ALTER TABLE events_maintenance
TRUNCATE PARTITION p2024;


-- ============================================================
-- 26. DROP A PARTITION
-- ============================================================

-- WARNING:
-- This permanently removes the partition and its data.

ALTER TABLE events_maintenance
DROP PARTITION p2025;


-- ============================================================
-- 27. CREATE A TABLE FOR PARTITION REORGANIZATION
-- ============================================================

DROP TABLE IF EXISTS monthly_events;

CREATE TABLE monthly_events (
    event_id BIGINT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, event_date)
)
PARTITION BY RANGE COLUMNS (event_date) (
    PARTITION p2026_h1 VALUES LESS THAN ('2026-07-01'),
    PARTITION p2026_h2 VALUES LESS THAN ('2027-01-01')
);


-- ============================================================
-- 28. INSERT REORGANIZATION DATA
-- ============================================================

INSERT INTO monthly_events
    (event_id, event_date, event_type)
VALUES
    (1, '2026-01-10', 'LOGIN'),
    (2, '2026-03-15', 'PURCHASE'),
    (3, '2026-08-20', 'LOGIN'),
    (4, '2026-11-25', 'PURCHASE');


-- ============================================================
-- 29. SPLIT A RANGE INTO SMALLER RANGES
-- ============================================================

ALTER TABLE monthly_events
REORGANIZE PARTITION p2026_h1 INTO (
    PARTITION p2026_q1 VALUES LESS THAN ('2026-04-01'),
    PARTITION p2026_q2 VALUES LESS THAN ('2026-07-01')
);


-- ============================================================
-- 30. INSPECT THE RESULT
-- ============================================================

SELECT
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'monthly_events'
ORDER BY PARTITION_ORDINAL_POSITION;


-- ============================================================
-- 31. QUERY PARTITIONED DATA
-- ============================================================

SELECT
    event_id,
    event_date,
    event_type
FROM monthly_events
WHERE event_date >= '2026-01-01'
  AND event_date < '2026-04-01'
ORDER BY event_date;


-- ============================================================
-- 32. EXPLAIN PARTITION PRUNING
-- ============================================================

EXPLAIN
SELECT *
FROM monthly_events
WHERE event_date >= '2026-01-01'
  AND event_date < '2026-04-01';


-- ============================================================
-- 33. AGGREGATION OVER PARTITIONED DATA
-- ============================================================

SELECT
    YEAR(order_date) AS order_year,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_sales
FROM orders_range_columns
GROUP BY YEAR(order_date)
ORDER BY order_year;


-- ============================================================
-- 34. FILTER + AGGREGATION
-- ============================================================

SELECT
    COUNT(*) AS orders_2026,
    SUM(total_amount) AS sales_2026,
    AVG(total_amount) AS average_order_value
FROM orders_range_columns
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';


-- ============================================================
-- 35. PARTITION-AWARE REPORT
-- ============================================================

SELECT
    order_date,
    COUNT(*) AS order_count,
    SUM(total_amount) AS daily_sales
FROM orders_range_columns
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01'
GROUP BY order_date
ORDER BY order_date;


-- ============================================================
-- 36. VERIFY PARTITION LOCATIONS
-- ============================================================

SELECT
    PARTITION_NAME,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'orders_range_columns'
  AND PARTITION_NAME IS NOT NULL
ORDER BY PARTITION_ORDINAL_POSITION;


-- ============================================================
-- END OF EXAMPLES
-- ============================================================
