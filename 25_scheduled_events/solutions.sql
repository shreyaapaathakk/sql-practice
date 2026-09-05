-- ============================================================
-- MODULE 25: SCHEDULED EVENTS
-- solutions.sql
-- ============================================================

USE module25_events;

-- ============================================================
-- Exercise 1
-- ============================================================

SHOW VARIABLES LIKE 'event_scheduler';

-- ============================================================
-- Exercise 3
-- Daily cleanup
-- ============================================================

DROP EVENT IF EXISTS cleanup_sessions_practice;

DELIMITER //

CREATE EVENT cleanup_sessions_practice
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;
END//

DELIMITER ;

-- ============================================================
-- Exercise 4
-- One-time event
-- ============================================================

DROP EVENT IF EXISTS one_time_practice;

CREATE EVENT one_time_practice
ON SCHEDULE AT '2030-06-01 00:00:00'
DO
INSERT INTO daily_sales_summary (
summary_date,
total_sales
)
VALUES (
CURRENT_DATE,
0
);

-- ============================================================
-- Exercise 5
-- Hourly event
-- ============================================================

DROP EVENT IF EXISTS hourly_practice;

CREATE EVENT hourly_practice
ON SCHEDULE EVERY 1 HOUR
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

-- ============================================================
-- Exercise 6
-- Every 10 minutes
-- ============================================================

DROP EVENT IF EXISTS ten_minute_practice;

CREATE EVENT ten_minute_practice
ON SCHEDULE EVERY 10 MINUTE
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

-- ============================================================
-- Exercise 7
-- STARTS + ENDS
-- ============================================================

DROP EVENT IF EXISTS date_range_practice;

CREATE EVENT date_range_practice
ON SCHEDULE
EVERY 1 DAY
STARTS '2030-01-01 00:00:00'
ENDS '2030-01-31 23:59:59'
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

-- ============================================================
-- Exercise 10
-- Disabled event
-- ============================================================

DROP EVENT IF EXISTS disabled_practice;

CREATE EVENT disabled_practice
ON SCHEDULE EVERY 1 DAY
DISABLE
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

-- ============================================================
-- Exercise 11
-- Enable
-- ============================================================

ALTER EVENT disabled_practice ENABLE;

-- ============================================================
-- Exercise 12
-- Disable again
-- ============================================================

ALTER EVENT disabled_practice DISABLE;

-- ============================================================
-- Exercise 13
-- Create event
-- ============================================================

DROP EVENT IF EXISTS alter_practice;

CREATE EVENT alter_practice
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

-- ============================================================
-- Exercise 14
-- Change schedule
-- ============================================================

ALTER EVENT alter_practice
ON SCHEDULE EVERY 12 HOUR;

-- ============================================================
-- Exercise 15
-- Disable
-- ============================================================

ALTER EVENT alter_practice DISABLE;

-- ============================================================
-- Exercise 16
-- Re-enable
-- ============================================================

ALTER EVENT alter_practice ENABLE;

-- ============================================================
-- Exercises 17-19
-- Inspection
-- ============================================================

SHOW EVENTS;

SHOW CREATE EVENT cleanup_sessions_practice;

-- ============================================================
-- Exercises 20-22
-- Create / Drop / Verify
-- ============================================================

DROP EVENT IF EXISTS temporary_test_event;

CREATE EVENT temporary_test_event
ON SCHEDULE EVERY 1 DAY
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

DROP EVENT temporary_test_event;

SHOW EVENTS;

-- ============================================================
-- Exercise 23
-- Multiple statements
-- ============================================================

DROP EVENT IF EXISTS multi_statement_practice;

DELIMITER //

CREATE EVENT multi_statement_practice
ON SCHEDULE EVERY 1 DAY
DO
BEGIN

```
INSERT INTO daily_sales_summary (
    summary_date,
    total_sales
)
SELECT
    CURRENT_DATE,
    COALESCE(SUM(sale_amount), 0)
FROM sales
WHERE sale_date = CURRENT_DATE;

DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;
```

END//

DELIMITER ;

-- ============================================================
-- Exercise 26
-- Stored procedure
-- ============================================================

DROP PROCEDURE IF EXISTS calculate_daily_sales;

DELIMITER //

CREATE PROCEDURE calculate_daily_sales()
BEGIN

```
INSERT INTO daily_sales_summary (
    summary_date,
    total_sales
)
SELECT
    CURRENT_DATE,
    COALESCE(SUM(sale_amount), 0)
FROM sales
WHERE sale_date = CURRENT_DATE;
```

END//

DELIMITER ;

-- ============================================================
-- Exercise 27
-- Event calling procedure
-- ============================================================

DROP EVENT IF EXISTS daily_sales_event;

CREATE EVENT daily_sales_event
ON SCHEDULE EVERY 1 DAY
DO
CALL calculate_daily_sales();

-- ============================================================
-- Exercise 29
-- Delete sessions older than 7 days
-- ============================================================

DROP EVENT IF EXISTS weekly_cleanup_practice;

CREATE EVENT weekly_cleanup_practice
ON SCHEDULE EVERY 1 WEEK
DO
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 7 DAY;

-- ============================================================
-- Exercise 31
-- Periodic sales summary
-- ============================================================

DROP EVENT IF EXISTS sales_summary_practice;

CREATE EVENT sales_summary_practice
ON SCHEDULE EVERY 1 DAY
DO
CALL calculate_daily_sales();

-- ============================================================
-- Exercise 34
-- Transaction inside event
-- ============================================================

DROP EVENT IF EXISTS transaction_practice;

DELIMITER //

CREATE EVENT transaction_practice
ON SCHEDULE EVERY 1 DAY
DO
BEGIN

```
START TRANSACTION;

DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;

COMMIT;
```

END//

DELIMITER ;

-- ============================================================
-- Exercise 38
-- Example use cases
-- ============================================================

-- 1. Delete expired sessions.
-- 2. Archive old records.
-- 3. Generate daily summaries.
-- 4. Process pending records.
-- 5. Refresh database statistics.

-- ============================================================
-- FINAL INSPECTION
-- ============================================================

SHOW EVENTS;

SHOW CREATE EVENT cleanup_sessions_practice;

SHOW CREATE EVENT daily_sales_event;

-- ============================================================
-- CLEANUP
-- ============================================================

DROP EVENT IF EXISTS cleanup_sessions_practice;
DROP EVENT IF EXISTS one_time_practice;
DROP EVENT IF EXISTS hourly_practice;
DROP EVENT IF EXISTS ten_minute_practice;
DROP EVENT IF EXISTS date_range_practice;
DROP EVENT IF EXISTS disabled_practice;
DROP EVENT IF EXISTS alter_practice;
DROP EVENT IF EXISTS multi_statement_practice;
DROP EVENT IF EXISTS weekly_cleanup_practice;
DROP EVENT IF EXISTS sales_summary_practice;
DROP EVENT IF EXISTS transaction_practice;

DROP PROCEDURE IF EXISTS calculate_daily_sales;
