-- ============================================================
-- MODULE 25: SCHEDULED EVENTS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module25_events;

USE module25_events;

-- ============================================================
-- CHECK EVENT SCHEDULER
-- ============================================================

SHOW VARIABLES LIKE 'event_scheduler';

## -- If your MySQL installation and permissions allow it:

-- SET GLOBAL event_scheduler = ON;

-- ============================================================
-- CLEANUP
-- ============================================================

DROP EVENT IF EXISTS cleanup_sessions;
DROP EVENT IF EXISTS generate_daily_summary;
DROP EVENT IF EXISTS recurring_test_event;
DROP EVENT IF EXISTS disabled_test_event;
DROP EVENT IF EXISTS procedure_event;
DROP EVENT IF EXISTS transaction_event;

DROP PROCEDURE IF EXISTS generate_summary;

DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS daily_sales_summary;

-- ============================================================
-- TABLES
-- ============================================================

CREATE TABLE sessions (
session_id INT PRIMARY KEY,
user_id INT NOT NULL,
created_at DATETIME NOT NULL
);

CREATE TABLE sales (
sale_id INT PRIMARY KEY,
sale_amount DECIMAL(10,2) NOT NULL,
sale_date DATE NOT NULL
);

CREATE TABLE daily_sales_summary (
summary_id INT AUTO_INCREMENT PRIMARY KEY,
summary_date DATE NOT NULL,
total_sales DECIMAL(12,2) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

INSERT INTO sessions
VALUES
(1, 101, NOW() - INTERVAL 3 DAY),
(2, 102, NOW() - INTERVAL 2 DAY),
(3, 103, NOW() - INTERVAL 1 HOUR),
(4, 104, NOW());

INSERT INTO sales
VALUES
(1, 5000.00, CURRENT_DATE),
(2, 7500.00, CURRENT_DATE),
(3, 2500.00, CURRENT_DATE);

-- ============================================================
-- 1. RECURRING CLEANUP EVENT
-- ============================================================

DELIMITER //

CREATE EVENT cleanup_sessions
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;
END//

DELIMITER ;

-- Inspect:

SHOW EVENTS;

-- ============================================================
-- 2. ONE-TIME EVENT
-- ============================================================

-- Example only.
-- The event is scheduled far in the future so it does not
-- unexpectedly modify the practice data.

CREATE EVENT recurring_test_event
ON SCHEDULE AT '2030-01-01 00:00:00'
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
-- 3. DISABLED EVENT
-- ============================================================

CREATE EVENT disabled_test_event
ON SCHEDULE EVERY 1 DAY
DISABLE
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
-- 4. ALTER EVENT
-- ============================================================

ALTER EVENT disabled_test_event ENABLE;

ALTER EVENT disabled_test_event DISABLE;

-- ============================================================
-- 5. STORED PROCEDURE
-- ============================================================

DELIMITER //

CREATE PROCEDURE generate_summary()
BEGIN
INSERT INTO daily_sales_summary (
summary_date,
total_sales
)
SELECT
CURRENT_DATE,
COALESCE(SUM(sale_amount), 0)
FROM sales
WHERE sale_date = CURRENT_DATE;
END//

DELIMITER ;

-- ============================================================
-- 6. EVENT CALLING PROCEDURE
-- ============================================================

CREATE EVENT procedure_event
ON SCHEDULE EVERY 1 DAY
DO
CALL generate_summary();

-- ============================================================
-- 7. SHOW EVENT DEFINITIONS
-- ============================================================

SHOW CREATE EVENT cleanup_sessions;

SHOW CREATE EVENT procedure_event;

-- ============================================================
-- 8. STARTS AND ENDS
-- ============================================================

CREATE EVENT generate_daily_summary
ON SCHEDULE
EVERY 1 DAY
STARTS '2030-01-01 08:00:00'
ENDS '2030-01-31 08:00:00'
DO
CALL generate_summary();

-- ============================================================
-- 9. MULTIPLE STATEMENTS
-- ============================================================

CREATE EVENT transaction_event
ON SCHEDULE EVERY 1 WEEK
DO
BEGIN
START TRANSACTION;

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

COMMIT;
```

END;

-- ============================================================
-- 10. INSPECT ALL EVENTS
-- ============================================================

SHOW EVENTS FROM module25_events;

-- ============================================================
-- 11. ALTER EVENT SCHEDULE
-- ============================================================

ALTER EVENT cleanup_sessions
ON SCHEDULE EVERY 12 HOUR;

-- ============================================================
-- 12. DISABLE / ENABLE
-- ============================================================

ALTER EVENT transaction_event DISABLE;

ALTER EVENT transaction_event ENABLE;

-- ============================================================
-- 13. TEST TABLES
-- ============================================================

SELECT *
FROM sessions
ORDER BY session_id;

SELECT *
FROM sales
ORDER BY sale_id;

SELECT *
FROM daily_sales_summary
ORDER BY summary_id;

-- ============================================================
-- 14. DROP TEST EVENTS
-- ============================================================

DROP EVENT IF EXISTS recurring_test_event;
DROP EVENT IF EXISTS disabled_test_event;

## -- Keep the following events for inspection while practicing:

-- cleanup_sessions
-- generate_daily_summary
-- procedure_event
-- transaction_event
