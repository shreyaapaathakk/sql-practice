-- ============================================================
-- Module 30 — Table Partitioning in MySQL
-- practice.sql
-- MySQL 8.0+
-- ============================================================

USE sql_practice_partitioning;


-- ============================================================
-- PART 1 — PARTITIONING FUNDAMENTALS
-- ============================================================

-- 1. Create a table named practice_orders with:
--    order_id
--    order_date
--    customer_id
--    total_amount
--    Use a composite primary key containing order_id and order_date.


-- 2. Create a RANGE-partitioned version of practice_orders
--    using YEAR(order_date).


-- 3. Create partitions for:
--    2024
--    2025
--    2026
--    future years


-- 4. Insert at least one order into each partition.


-- 5. Retrieve all orders from practice_orders.


-- 6. Sort the orders by order_date.


-- 7. Count the total number of orders.


-- 8. Calculate the total order value.


-- 9. Calculate the average order value.


-- 10. Find the highest-value order.


-- ============================================================
-- PART 2 — RANGE COLUMNS
-- ============================================================

-- 11. Create a table named practice_events with:
--     event_id
--     event_date
--     event_type
--     Use a composite primary key containing event_id and event_date.


-- 12. Partition practice_events by RANGE COLUMNS(event_date).


-- 13. Create partitions for:
--     2024
--     2025
--     2026
--     future dates


-- 14. Insert at least eight events covering multiple years.


-- 15. Return only events from 2026.


-- 16. Return events from January through June 2026.


-- 17. Count events from 2026.


-- 18. Count events by year.


-- 19. Count events by event_type.


-- 20. Calculate the number of events per month for 2026.


-- ============================================================
-- PART 3 — LIST PARTITIONING
-- ============================================================

-- 21. Create a table named practice_sales with:
--     sale_id
--     region_id
--     amount
--     Use a composite primary key containing sale_id and region_id.


-- 22. Partition the table using LIST(region_id).


-- 23. Create four region groups:
--     North → 1, 2
--     South → 3, 4
--     West  → 5, 6
--     East  → 7, 8


-- 24. Insert at least eight sales.


-- 25. Retrieve all sales from region IDs 1 and 2.


-- 26. Calculate total sales by region_id.


-- 27. Calculate average sales by region_id.


-- 28. Find the highest sale in each region.


-- ============================================================
-- PART 4 — LIST COLUMNS
-- ============================================================

-- 29. Create a table named practice_customers with:
--     customer_id
--     region
--     customer_name
--     Use a composite primary key containing customer_id and region.


-- 30. Partition the table using LIST COLUMNS(region).


-- 31. Create partitions for:
--     North
--     South
--     West
--     East


-- 32. Insert at least eight customers.


-- 33. Return all customers from the North region.


-- 34. Count customers by region.


-- 35. Sort customers alphabetically by customer_name.


-- ============================================================
-- PART 5 — HASH AND KEY PARTITIONING
-- ============================================================

-- 36. Create a table named practice_customer_events_hash.


-- 37. Add:
--     event_id
--     customer_id
--     event_type
--     event_date


-- 38. Create four HASH partitions based on customer_id.


-- 39. Insert at least ten events.


-- 40. Retrieve all events for customer_id 101.


-- 41. Create another table named practice_customer_events_key.


-- 42. Use KEY(customer_id) partitioning with four partitions.


-- 43. Insert at least ten events.


-- 44. Retrieve all events from the KEY-partitioned table.


-- ============================================================
-- PART 6 — PARTITION METADATA
-- ============================================================

-- 45. Use INFORMATION_SCHEMA.PARTITIONS to inspect
--     practice_orders.


-- 46. Display:
--     partition name
--     partition method
--     partition expression
--     partition description


-- 47. Display all partitioned tables in the current database.


-- 48. Display partition metadata ordered by partition position.


-- 49. Compare the number of partitions used by
--     practice_orders and practice_events.


-- 50. Display the estimated number of rows in each partition.


-- ============================================================
-- PART 7 — PARTITION PRUNING
-- ============================================================

-- 51. Use EXPLAIN on a query that retrieves only 2026 orders.


-- 52. Use EXPLAIN on a query that retrieves orders
--     for a specific customer but does not filter by order_date.


-- 53. Compare the two execution plans.


-- 54. Write a query that filters directly on order_date
--     using a date range.


-- 55. Use EXPLAIN to inspect that query.


-- ============================================================
-- PART 8 — PARTITION MAINTENANCE
-- ============================================================

-- 56. Create a partitioned events table with a MAXVALUE
--     future partition.


-- 57. Reorganize the MAXVALUE partition to create a
--     partition for 2027.


-- 58. Reorganize the future partition again to create
--     a partition for 2028.


-- 59. Create a table with a large 2026 partition.


-- 60. Reorganize the 2026 partition into two smaller
--     half-year partitions.


-- ============================================================
-- PART 9 — DATA LIFECYCLE
-- ============================================================

-- 61. Create a yearly partitioned audit_logs table.


-- 62. Insert audit records for 2024, 2025, and 2026.


-- 63. Write a query that returns only 2026 records.


-- 64. Use EXPLAIN to inspect partition pruning.


-- 65. Truncate the 2024 partition.


-- 66. Verify that the 2024 partition still exists.


-- 67. Verify that its rows have been removed.


-- 68. Drop the 2025 partition.


-- 69. Verify that the 2025 partition no longer exists.


-- 70. Explain why DROP PARTITION is a destructive operation.


-- ============================================================
-- PART 10 — DESIGN THINKING
-- ============================================================

-- 71. A logs table contains 500 million rows and every query
--     filters by event_date. Recommend a partitioning strategy.


-- 72. A customers table contains 50 million rows but queries
--     mostly search by email. Explain whether date partitioning
--     would be appropriate.


-- 73. A table contains sales from four fixed regions.
--     Recommend a partitioning strategy.


-- 74. A table contains customer events distributed across
--     millions of customer IDs. Recommend a partitioning
--     strategy if the main goal is row distribution.


-- 75. Explain why partitioning should not automatically
--     replace indexing.


-- 76. Explain partition pruning in your own words.


-- 77. Explain the difference between RANGE and LIST partitioning.


-- 78. Explain the difference between RANGE and
--     RANGE COLUMNS partitioning.


-- 79. Explain the difference between HASH and KEY partitioning.


-- 80. Explain the difference between partitioning and sharding.


-- ============================================================
-- END OF PRACTICE
-- ============================================================
