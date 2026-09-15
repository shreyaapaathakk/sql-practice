-- ============================================================
-- Module 30 — Table Partitioning in MySQL
-- challenge.sql
-- MySQL 8.0+
-- ============================================================

USE sql_practice_partitioning;


-- ============================================================
-- CHALLENGE 1 — YEARLY ORDER PARTITIONING
-- ============================================================

-- Create a production-style orders table with:
--
-- order_id
-- order_date
-- customer_id
-- status
-- total_amount
--
-- Partition the table by RANGE COLUMNS(order_date).
--
-- Create partitions for:
-- 2024
-- 2025
-- 2026
-- future dates
--
-- Remember the MySQL unique-key requirement.


-- ============================================================
-- CHALLENGE 2 — LOAD HISTORICAL ORDERS
-- ============================================================

-- Insert at least 20 orders distributed across
-- multiple yearly partitions.


-- ============================================================
-- CHALLENGE 3 — 2026 SALES REPORT
-- ============================================================

-- Write a query that returns:
--
-- total orders
-- total sales
-- average order value
-- minimum order value
-- maximum order value
--
-- for 2026 only.


-- ============================================================
-- CHALLENGE 4 — PARTITION PRUNING
-- ============================================================

-- Use EXPLAIN to determine which partitions are examined
-- for the 2026 sales report.


-- ============================================================
-- CHALLENGE 5 — CUSTOMER QUERY
-- ============================================================

-- Write a query that retrieves all orders for one customer.
--
-- Use EXPLAIN and compare it with a query that filters by
-- both customer_id and order_date.
--
-- Explain why the second query may provide better
-- partition pruning.


-- ============================================================
-- CHALLENGE 6 — INDEX + PARTITIONING
-- ============================================================

-- Add an index on customer_id.
--
-- Then use EXPLAIN to investigate a customer-specific query.


-- ============================================================
-- CHALLENGE 7 — MONTHLY EVENT PARTITIONING
-- ============================================================

-- Create a large events table partitioned by month for 2026.
--
-- Suggested partitions:
--
-- p2026_01
-- p2026_02
-- p2026_03
-- ...
-- p2026_12
--
-- Include a future MAXVALUE partition.


-- ============================================================
-- CHALLENGE 8 — MONTHLY EVENT DATA
-- ============================================================

-- Insert at least 36 events across the 2026 monthly partitions.


-- ============================================================
-- CHALLENGE 9 — MONTHLY REPORT
-- ============================================================

-- Return:
--
-- month
-- event_count
--
-- for all events in 2026.


-- ============================================================
-- CHALLENGE 10 — QUARTERLY ANALYSIS
-- ============================================================

-- Write a query that groups 2026 events into:
--
-- Q1
-- Q2
-- Q3
-- Q4
--
-- and returns the number of events in each quarter.


-- ============================================================
-- CHALLENGE 11 — PARTITION INSPECTION
-- ============================================================

-- Use INFORMATION_SCHEMA.PARTITIONS to display:
--
-- partition name
-- partition description
-- estimated row count
--
-- for the monthly events table.


-- ============================================================
-- CHALLENGE 12 — FUTURE PARTITION MAINTENANCE
-- ============================================================

-- Reorganize the MAXVALUE partition so that a new
-- 2027 partition is created.


-- ============================================================
-- CHALLENGE 13 — ARCHIVAL WORKFLOW
-- ============================================================

-- Design an archival strategy for data older than three years.
--
-- Explain:
--
-- 1. How you would identify expired partitions.
-- 2. How you would archive the data.
-- 3. How you would verify the archive.
-- 4. When you would drop the old partition.


-- ============================================================
-- CHALLENGE 14 — TRUNCATE VS DROP
-- ============================================================

-- Create a test table with at least three partitions.
--
-- Insert data into each partition.
--
-- Demonstrate the difference between:
--
-- TRUNCATE PARTITION
-- DROP PARTITION
--
-- Verify the resulting partition definitions and data.


-- ============================================================
-- CHALLENGE 15 — LIST PARTITIONED SALES SYSTEM
-- ============================================================

-- Create a sales table where region is one of:
--
-- North
-- South
-- East
-- West
--
-- Use LIST COLUMNS(region).


-- ============================================================
-- CHALLENGE 16 — REGIONAL SALES ANALYSIS
-- ============================================================

-- Insert at least 20 sales.
--
-- Produce:
--
-- 1. Total sales by region.
-- 2. Average sale by region.
-- 3. Highest sale by region.
-- 4. Number of sales by region.


-- ============================================================
-- CHALLENGE 17 — HASH PARTITIONED EVENTS
-- ============================================================

-- Create a customer_events table using:
--
-- HASH(customer_id)
--
-- with eight partitions.
--
-- Insert at least 50 events.


-- ============================================================
-- CHALLENGE 18 — HASH PARTITION INSPECTION
-- ============================================================

-- Use INFORMATION_SCHEMA.PARTITIONS to inspect the
-- eight HASH partitions.


-- ============================================================
-- CHALLENGE 19 — CHOOSE THE RIGHT STRATEGY
-- ============================================================

-- For each scenario, choose the most appropriate strategy:
--
-- A. Five years of application logs queried by date.
-- B. Customers divided into four fixed geographic regions.
-- C. Millions of customer IDs where even distribution
--    is the main objective.
-- D. Historical orders where old data is regularly archived.
--
-- Choose from:
--
-- RANGE
-- RANGE COLUMNS
-- LIST
-- LIST COLUMNS
-- HASH
-- KEY
--
-- Explain each decision.


-- ============================================================
-- CHALLENGE 20 — PARTITIONING DESIGN REVIEW
-- ============================================================

-- A developer proposes:
--
-- "The table has 200 million rows, so we should create
-- 5,000 partitions to make every query faster."
--
-- Analyze this proposal.
--
-- Discuss:
--
-- 1. Why table size alone is not enough.
-- 2. Why partition count matters.
-- 3. Why indexes still matter.
-- 4. Why query patterns matter.
-- 5. Why partition pruning matters.


-- ============================================================
-- CHALLENGE 21 — PARTITIONING VS INDEXING
-- ============================================================

-- Consider a table:
--
-- customer_orders
--
-- containing 300 million rows.
--
-- Most queries:
--
-- 1. Search by customer_id.
-- 2. Search by order_date.
-- 3. Search by customer_id + order_date.
--
-- Propose:
--
-- 1. A partitioning strategy.
-- 2. Appropriate indexes.
-- 3. Example queries.
-- 4. EXPLAIN tests you would perform.


-- ============================================================
-- CHALLENGE 22 — RETENTION SYSTEM
-- ============================================================

-- Design a seven-year event-retention system.
--
-- Requirements:
--
-- - Events are queried by date.
-- - Recent events are accessed frequently.
-- - Data older than seven years must be removed.
-- - Future partitions should be maintained automatically
--   through an operational process.
--
-- Design:
--
-- 1. Partitioning strategy.
-- 2. Partition granularity.
-- 3. Indexing strategy.
-- 4. Archival strategy.
-- 5. Partition creation process.
-- 6. Partition removal process.


-- ============================================================
-- CHALLENGE 23 — PRODUCTION PARTITIONING PROJECT
-- ============================================================

-- Build a complete partitioned analytics dataset.
--
-- Create:
--
-- orders
-- customers
-- events
--
-- At least one large fact-style table should be partitioned.
--
-- Requirements:
--
-- 1. Use a meaningful partition key.
-- 2. Use an appropriate partitioning method.
-- 3. Add appropriate indexes.
-- 4. Insert realistic sample data.
-- 5. Write date-filtered queries.
-- 6. Write aggregation queries.
-- 7. Use EXPLAIN.
-- 8. Inspect INFORMATION_SCHEMA.PARTITIONS.
-- 9. Demonstrate partition maintenance.
-- 10. Document why you chose the design.


-- ============================================================
-- CHALLENGE 24 — FINAL DATABASE ENGINEERING CHALLENGE
-- ============================================================

-- Design a partitioning strategy for a hypothetical
-- e-commerce platform.
--
-- Requirements:
--
-- The platform processes 20 million orders per month.
--
-- Orders contain:
--
-- order_id
-- order_date
-- customer_id
-- region
-- status
-- total_amount
--
-- Business requirements:
--
-- 1. Users frequently search their own orders.
-- 2. Analysts frequently report sales by month.
-- 3. Recent orders are accessed most frequently.
-- 4. Orders older than five years are archived.
-- 5. Monthly reports should avoid scanning unnecessary
--    historical data.
-- 6. The system must continue accepting future orders.
--
-- Produce:
--
-- A. Table design.
-- B. Partitioning strategy.
-- C. Partition boundaries.
-- D. Primary-key design.
-- E. Index strategy.
-- F. Example monthly report.
-- G. Example customer query.
-- H. EXPLAIN statements.
-- I. Partition metadata queries.
-- J. Partition maintenance plan.
-- K. Archival strategy.
--
-- Finally, explain why your design is preferable to:
--
-- 1. One completely unpartitioned table.
-- 2. A separate table for every month.
-- 3. Thousands of tiny partitions.
-- 4. Partitioning without indexes.


-- ============================================================
-- END OF CHALLENGES
-- ============================================================
