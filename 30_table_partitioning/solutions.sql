-- ============================================================
-- Module 30 — Table Partitioning in MySQL
-- solutions.sql
-- MySQL 8.0+
-- ============================================================

USE sql_practice_partitioning;


-- ============================================================
-- PART 1 — PARTITIONING FUNDAMENTALS
-- ============================================================

-- 1. Create practice_orders.

DROP TABLE IF EXISTS practice_orders;

CREATE TABLE practice_orders (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    customer_id BIGINT NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,

    PRIMARY KEY (order_id, order_date)
);


-- 2. Convert the table into a RANGE-partitioned table.

ALTER TABLE practice_orders
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);


-- 3. Partitions for 2024, 2025, 2026, and future years
--    were created in Question 2.


-- 4. Insert orders into multiple partitions.

INSERT INTO practice_orders
    (order_id, order_date, customer_id, total_amount)
VALUES
    (1, '2024-03-10', 101, 150.00),
    (2, '2024-08-20', 102, 250.00),
    (3, '2025-02-15', 103, 350.00),
    (4, '2025-10-05', 104, 450.00),
    (5, '2026-01-20', 105, 550.00),
    (6, '2026-07-18', 106, 650.00),
    (7, '2027-03-01', 107, 750.00);


-- 5. Retrieve all orders.

SELECT *
FROM practice_orders;


-- 6. Sort by order_date.

SELECT *
FROM practice_orders
ORDER BY order_date;


-- 7. Count orders.

SELECT COUNT(*) AS total_orders
FROM practice_orders;


-- 8. Calculate total order value.

SELECT SUM(total_amount) AS total_order_value
FROM practice_orders;


-- 9. Calculate average order value.

SELECT AVG(total_amount) AS average_order_value
FROM practice_orders;


-- 10. Find highest-value order.

SELECT
    order_id,
    order_date,
    customer_id,
    total_amount
FROM practice_orders
ORDER BY total_amount DESC
LIMIT 1;


-- ============================================================
-- PART 2 — RANGE COLUMNS
-- ============================================================

-- 11. Create practice_events.

DROP TABLE IF EXISTS practice_events;

CREATE TABLE practice_events (
    event_id BIGINT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, event_date)
);


-- 12. Partition using RANGE COLUMNS.

ALTER TABLE practice_events
PARTITION BY RANGE COLUMNS (event_date) (
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- 13. The requested partitions were created above.


-- 14. Insert events covering multiple years.

INSERT INTO practice_events
    (event_id, event_date, event_type)
VALUES
    (1, '2024-01-10', 'LOGIN'),
    (2, '2024-06-15', 'PURCHASE'),
    (3, '2025-02-20', 'LOGIN'),
    (4, '2025-09-12', 'PURCHASE'),
    (5, '2026-01-05', 'LOGIN'),
    (6, '2026-03-18', 'PURCHASE'),
    (7, '2026-06-22', 'LOGIN'),
    (8, '2026-10-11', 'LOGOUT');


-- 15. Events from 2026.

SELECT *
FROM practice_events
WHERE event_date >= '2026-01-01'
  AND event_date < '2027-01-01';


-- 16. Events from January through June 2026.

SELECT *
FROM practice_events
WHERE event_date >= '2026-01-01'
  AND event_date < '2026-07-01';


-- 17. Count events from 2026.

SELECT COUNT(*) AS events_2026
FROM practice_events
WHERE event_date >= '2026-01-01'
  AND event_date < '2027-01-01';


-- 18. Count events by year.

SELECT
    YEAR(event_date) AS event_year,
    COUNT(*) AS event_count
FROM practice_events
GROUP BY YEAR(event_date)
ORDER BY event_year;


-- 19. Count events by type.

SELECT
    event_type,
    COUNT(*) AS event_count
FROM practice_events
GROUP BY event_type
ORDER BY event_count DESC;


-- 20. Events per month in 2026.

SELECT
    MONTH(event_date) AS event_month,
    COUNT(*) AS event_count
FROM practice_events
WHERE event_date >= '2026-01-01'
  AND event_date < '2027-01-01'
GROUP BY MONTH(event_date)
ORDER BY event_month;


-- ============================================================
-- PART 3 — LIST PARTITIONING
-- ============================================================

-- 21. Create practice_sales.

DROP TABLE IF EXISTS practice_sales;

CREATE TABLE practice_sales (
    sale_id BIGINT NOT NULL,
    region_id INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,

    PRIMARY KEY (sale_id, region_id)
);


-- 22. Partition by LIST.

ALTER TABLE practice_sales
PARTITION BY LIST (region_id) (
    PARTITION p_north VALUES IN (1, 2),
    PARTITION p_south VALUES IN (3, 4),
    PARTITION p_west VALUES IN (5, 6),
    PARTITION p_east VALUES IN (7, 8)
);


-- 23. Region groups were created above.


-- 24. Insert sales.

INSERT INTO practice_sales
    (sale_id, region_id, amount)
VALUES
    (1, 1, 1000.00),
    (2, 2, 1200.00),
    (3, 3, 900.00),
    (4, 4, 1100.00),
    (5, 5, 800.00),
    (6, 6, 950.00),
    (7, 7, 1300.00),
    (8, 8, 1500.00);


-- 25. Sales from North.

SELECT *
FROM practice_sales
WHERE region_id IN (1, 2);


-- 26. Total sales by region.

SELECT
    region_id,
    SUM(amount) AS total_sales
FROM practice_sales
GROUP BY region_id
ORDER BY region_id;


-- 27. Average sales by region.

SELECT
    region_id,
    AVG(amount) AS average_sales
FROM practice_sales
GROUP BY region_id
ORDER BY region_id;


-- 28. Highest sale in each region.

SELECT
    region_id,
    MAX(amount) AS highest_sale
FROM practice_sales
GROUP BY region_id
ORDER BY region_id;


-- ============================================================
-- PART 4 — LIST COLUMNS
-- ============================================================

-- 29. Create practice_customers.

DROP TABLE IF EXISTS practice_customers;

CREATE TABLE practice_customers (
    customer_id BIGINT NOT NULL,
    region VARCHAR(30) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,

    PRIMARY KEY (customer_id, region)
);


-- 30. Partition by LIST COLUMNS.

ALTER TABLE practice_customers
PARTITION BY LIST COLUMNS (region) (
    PARTITION p_north VALUES IN ('North'),
    PARTITION p_south VALUES IN ('South'),
    PARTITION p_west VALUES IN ('West'),
    PARTITION p_east VALUES IN ('East')
);


-- 31. The four regional partitions were created above.


-- 32. Insert customers.

INSERT INTO practice_customers
    (customer_id, region, customer_name)
VALUES
    (1, 'North', 'Aarav'),
    (2, 'North', 'Diya'),
    (3, 'South', 'Kabir'),
    (4, 'South', 'Meera'),
    (5, 'West', 'Arjun'),
    (6, 'West', 'Ishita'),
    (7, 'East', 'Ananya'),
    (8, 'East', 'Rohan');


-- 33. North customers.

SELECT *
FROM practice_customers
WHERE region = 'North';


-- 34. Count customers by region.

SELECT
    region,
    COUNT(*) AS customer_count
FROM practice_customers
GROUP BY region
ORDER BY region;


-- 35. Sort customers alphabetically.

SELECT *
FROM practice_customers
ORDER BY customer_name;


-- ============================================================
-- PART 5 — HASH AND KEY PARTITIONING
-- ============================================================

-- 36–38. Create HASH-partitioned table.

DROP TABLE IF EXISTS practice_customer_events_hash;

CREATE TABLE practice_customer_events_hash (
    event_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    event_date DATE NOT NULL,

    PRIMARY KEY (event_id, customer_id)
)
PARTITION BY HASH (customer_id)
PARTITIONS 4;


-- 39. Insert events.

INSERT INTO practice_customer_events_hash
    (event_id, customer_id, event_type, event_date)
VALUES
    (1, 101, 'LOGIN', '2026-01-01'),
    (2, 102, 'PURCHASE', '2026-01-02'),
    (3, 103, 'LOGIN', '2026-01-03'),
    (4, 104, 'LOGOUT', '2026-01-04'),
    (5, 105, 'PURCHASE', '2026-01-05'),
    (6, 106, 'LOGIN', '2026-01-06'),
    (7, 107, 'PURCHASE', '2026-01-07'),
    (8, 108, 'LOGIN', '2026-01-08'),
    (9, 109, 'LOGOUT', '2026-01-09'),
    (10, 110, 'LOGIN', '2026-01-10');


-- 40. Events for customer 101.

SELECT *
FROM practice_customer_events_hash
WHERE customer_id = 101;


-- 41–42. Create KEY-partitioned table.

DROP TABLE IF EXISTS practice_customer_events_key;

CREATE TABLE practice_customer_events_key (
    event_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, customer_id)
)
PARTITION BY KEY (customer_id)
PARTITIONS 4;


-- 43. Insert events.

INSERT INTO practice_customer_events_key
    (event_id, customer_id, event_type)
VALUES
    (1, 101, 'LOGIN'),
    (2, 102, 'PURCHASE'),
    (3, 103, 'LOGIN'),
    (4, 104, 'LOGOUT'),
    (5, 105, 'PURCHASE'),
    (6, 106, 'LOGIN'),
    (7, 107, 'PURCHASE'),
    (8, 108, 'LOGIN'),
    (9, 109, 'LOGOUT'),
    (10, 110, 'LOGIN');


-- 44. Retrieve events.

SELECT *
FROM practice_customer_events_key
ORDER BY event_id;


-- ============================================================
-- PART 6 — PARTITION METADATA
-- ============================================================

-- 45. Inspect practice_orders.

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
  AND TABLE_NAME = 'practice_orders'
ORDER BY PARTITION_ORDINAL_POSITION;


-- 46. Display selected partition metadata.

SELECT
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'practice_orders'
ORDER BY PARTITION_ORDINAL_POSITION;


-- 47. Display all partitioned tables.

SELECT DISTINCT
    TABLE_NAME
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND PARTITION_NAME IS NOT NULL
ORDER BY TABLE_NAME;


-- 48. Partition metadata by position.

SELECT
    TABLE_NAME,
    PARTITION_NAME,
    PARTITION_ORDINAL_POSITION
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND PARTITION_NAME IS NOT NULL
ORDER BY TABLE_NAME, PARTITION_ORDINAL_POSITION;


-- 49. Compare partition counts.

SELECT
    TABLE_NAME,
    COUNT(*) AS partition_count
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND PARTITION_NAME IS NOT NULL
  AND TABLE_NAME IN (
      'practice_orders',
      'practice_events'
  )
GROUP BY TABLE_NAME
ORDER BY TABLE_NAME;


-- 50. Estimated rows per partition.

SELECT
    TABLE_NAME,
    PARTITION_NAME,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND PARTITION_NAME IS NOT NULL
ORDER BY TABLE_NAME, PARTITION_ORDINAL_POSITION;


-- ============================================================
-- PART 7 — PARTITION PRUNING
-- ============================================================

-- 51. EXPLAIN query for 2026.

EXPLAIN
SELECT *
FROM practice_orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';


-- 52. EXPLAIN query by customer without partition key.

EXPLAIN
SELECT *
FROM practice_orders
WHERE customer_id = 105;


-- 53. The plans can be compared by examining the
--     partitions column in EXPLAIN output.


-- 54. Direct date-range predicate.

SELECT *
FROM practice_orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';


-- 55. EXPLAIN the date-range query.

EXPLAIN
SELECT *
FROM practice_orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';


-- ============================================================
-- PART 8 — PARTITION MAINTENANCE
-- ============================================================

-- 56. Create an events table with MAXVALUE.

DROP TABLE IF EXISTS maintenance_events;

CREATE TABLE maintenance_events (
    event_id BIGINT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, event_date)
)
PARTITION BY RANGE COLUMNS (event_date) (
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- 57. Create a 2027 partition.

ALTER TABLE maintenance_events
REORGANIZE PARTITION p_future INTO (
    PARTITION p2027 VALUES LESS THAN ('2028-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- 58. Create a 2028 partition.

ALTER TABLE maintenance_events
REORGANIZE PARTITION p_future INTO (
    PARTITION p2028 VALUES LESS THAN ('2029-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- 59. Create a table with a large 2026 partition.

DROP TABLE IF EXISTS half_year_events;

CREATE TABLE half_year_events (
    event_id BIGINT NOT NULL,
    event_date DATE NOT NULL,
    event_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (event_id, event_date)
)
PARTITION BY RANGE COLUMNS (event_date) (
    PARTITION p2026 VALUES LESS THAN ('2027-01-01')
);


-- 60. Split 2026 into two half-year partitions.

ALTER TABLE half_year_events
REORGANIZE PARTITION p2026 INTO (
    PARTITION p2026_h1 VALUES LESS THAN ('2026-07-01'),
    PARTITION p2026_h2 VALUES LESS THAN ('2027-01-01')
);


-- ============================================================
-- PART 9 — DATA LIFECYCLE
-- ============================================================

-- 61. Create yearly audit_logs.

DROP TABLE IF EXISTS audit_logs;

CREATE TABLE audit_logs (
    log_id BIGINT NOT NULL,
    created_at DATE NOT NULL,
    action_type VARCHAR(50) NOT NULL,

    PRIMARY KEY (log_id, created_at)
)
PARTITION BY RANGE COLUMNS (created_at) (
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);


-- 62. Insert audit records.

INSERT INTO audit_logs
    (log_id, created_at, action_type)
VALUES
    (1, '2024-02-10', 'LOGIN'),
    (2, '2024-08-20', 'UPDATE'),
    (3, '2025-03-15', 'LOGIN'),
    (4, '2025-09-05', 'DELETE'),
    (5, '2026-01-10', 'LOGIN'),
    (6, '2026-07-25', 'UPDATE');


-- 63. Return 2026 records.

SELECT *
FROM audit_logs
WHERE created_at >= '2026-01-01'
  AND created_at < '2027-01-01';


-- 64. Inspect pruning.

EXPLAIN
SELECT *
FROM audit_logs
WHERE created_at >= '2026-01-01'
  AND created_at < '2027-01-01';


-- 65. Truncate 2024.

ALTER TABLE audit_logs
TRUNCATE PARTITION p2024;


-- 66. Verify p2024 still exists.

SELECT
    PARTITION_NAME
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'audit_logs'
  AND PARTITION_NAME = 'p2024';


-- 67. Verify that p2024 contains no rows.

SELECT COUNT(*) AS rows_in_2024
FROM audit_logs PARTITION (p2024);


-- 68. Drop 2025.

ALTER TABLE audit_logs
DROP PARTITION p2025;


-- 69. Verify that p2025 no longer exists.

SELECT
    PARTITION_NAME
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'audit_logs'
ORDER BY PARTITION_ORDINAL_POSITION;


-- 70. Explanation:
--
-- DROP PARTITION removes both the partition definition and
-- the rows stored in that partition. Therefore it is a
-- destructive data operation and should only be performed
-- after confirming retention and archival requirements.


-- ============================================================
-- PART 10 — DESIGN THINKING
-- ============================================================

-- 71. Large logs table:
--
-- Recommended strategy:
-- RANGE COLUMNS(event_date)
--
-- Reason:
-- Queries frequently filter by event_date and old data can
-- be archived or removed by partition.


-- 72. Customers searched mostly by email:
--
-- Date partitioning would generally not be appropriate.
--
-- A UNIQUE or regular index on email is more directly related
-- to the workload.
--
-- Partitioning should not be introduced without a clear
-- partition-related benefit.


-- 73. Four fixed regions:
--
-- LIST or LIST COLUMNS partitioning is a natural choice.
--
-- Example:
--
-- PARTITION BY LIST COLUMNS(region)


-- 74. Millions of customer IDs where row distribution
-- is the primary goal:
--
-- HASH or KEY partitioning may be considered.
--
-- The actual workload and distribution should be tested
-- before choosing one.


-- 75. Partitioning does not replace indexing.
--
-- Partitioning determines which physical partitions may need
-- to be examined.
--
-- Indexes help locate rows efficiently inside the relevant
-- partition(s).


-- 76. Partition pruning:
--
-- Partition pruning is the optimizer's ability to eliminate
-- partitions that cannot contain rows matching a query.


-- 77. RANGE vs LIST:
--
-- RANGE divides data according to ordered ranges.
--
-- LIST assigns specific discrete values to partitions.


-- 78. RANGE vs RANGE COLUMNS:
--
-- RANGE commonly partitions using an expression such as:
--
-- YEAR(order_date)
--
-- RANGE COLUMNS can partition directly using column values:
--
-- order_date
--
-- RANGE COLUMNS is often convenient for date boundaries.


-- 79. HASH vs KEY:
--
-- HASH uses a hash calculation based on the specified
-- partitioning expression.
--
-- KEY uses MySQL's key-based partitioning mechanism.


-- 80. Partitioning vs sharding:
--
-- Partitioning divides data among partitions of a logical
-- table.
--
-- Sharding distributes data across separate database
-- instances or nodes.


-- ============================================================
-- END OF SOLUTIONS
-- ============================================================
