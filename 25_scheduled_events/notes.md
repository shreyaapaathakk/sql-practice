# ============================================================

# 25_scheduled_events/notes.md

# ============================================================

# Module 25 — Scheduled Events

MySQL provides the **Event Scheduler** to execute SQL statements automatically at scheduled times.

An event is similar to a scheduled task inside the database.

Instead of manually executing:

```sql
DELETE FROM logs
WHERE created_at < NOW() - INTERVAL 30 DAY;
```

you can create an event that performs the cleanup automatically every day.

---

# 1. What Is a Scheduled Event?

A MySQL event is a database object containing SQL that runs automatically according to a schedule.

Conceptually:

```text
Time arrives
    ↓
Event Scheduler
    ↓
Event executes
    ↓
SQL statements run
```

Events are useful for database-side automation.

Common examples include:

```text
Deleting old records
Generating reports
Updating summary tables
Archiving data
Refreshing statistics
Cleaning temporary data
Calling stored procedures
```

---

# 2. Event Scheduler

MySQL's Event Scheduler controls whether scheduled events execute.

Check its status:

```sql
SHOW VARIABLES LIKE 'event_scheduler';
```

To enable it:

```sql
SET GLOBAL event_scheduler = ON;
```

The exact availability of this setting can depend on your MySQL installation and permissions.

---

# 3. Basic Event Syntax

A simple event looks like:

```sql
CREATE EVENT event_name
ON SCHEDULE schedule
DO
    SQL_statement;
```

Example:

```sql
CREATE EVENT delete_old_logs
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM logs
    WHERE created_at < NOW() - INTERVAL 30 DAY;
```

---

# 4. One-Time Events

A one-time event runs once.

Syntax:

```sql
CREATE EVENT event_name
ON SCHEDULE AT 'YYYY-MM-DD HH:MM:SS'
DO
    SQL_statement;
```

Example:

```sql
CREATE EVENT one_time_cleanup
ON SCHEDULE AT '2030-01-01 00:00:00'
DO
    DELETE FROM temporary_data;
```

After execution, a one-time event may be automatically removed depending on its configuration.

---

# 5. Recurring Events

Recurring events execute repeatedly.

Example:

```sql
CREATE EVENT daily_cleanup
ON SCHEDULE EVERY 1 DAY
DO
    DELETE FROM temporary_data;
```

Possible intervals include:

```text
SECOND
MINUTE
HOUR
DAY
WEEK
MONTH
YEAR
```

Examples:

```sql
EVERY 10 MINUTE
EVERY 2 HOUR
EVERY 1 DAY
EVERY 1 WEEK
EVERY 1 MONTH
```

---

# 6. STARTS

`STARTS` specifies when a recurring event should begin.

Example:

```sql
CREATE EVENT daily_report
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2030-01-01 08:00:00'
DO
    CALL generate_daily_report();
```

The event begins according to the specified schedule.

---

# 7. ENDS

`ENDS` specifies when a recurring event should stop.

Example:

```sql
CREATE EVENT temporary_job
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2030-01-01 08:00:00'
    ENDS '2030-01-31 08:00:00'
DO
    CALL daily_task();
```

The event operates only within the specified scheduling period.

---

# 8. STARTS and ENDS Together

You can combine both:

```sql
CREATE EVENT monthly_task
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2030-01-01 00:00:00'
    ENDS '2030-12-31 23:59:59'
DO
    CALL monthly_process();
```

This creates a recurring event with a defined active period.

---

# 9. ENABLE and DISABLE

Events can be enabled or disabled.

Create an enabled event:

```sql
CREATE EVENT example_event
ON SCHEDULE EVERY 1 DAY
ENABLE
DO
    CALL daily_task();
```

Create a disabled event:

```sql
CREATE EVENT example_event
ON SCHEDULE EVERY 1 DAY
DISABLE
DO
    CALL daily_task();
```

A disabled event remains defined in the database but does not execute.

---

# 10. ALTER EVENT

You can modify an existing event.

Example:

```sql
ALTER EVENT daily_cleanup
ON SCHEDULE EVERY 12 HOUR;
```

You can also enable or disable it:

```sql
ALTER EVENT daily_cleanup ENABLE;
```

```sql
ALTER EVENT daily_cleanup DISABLE;
```

---

# 11. DROP EVENT

To remove an event:

```sql
DROP EVENT event_name;
```

Example:

```sql
DROP EVENT daily_cleanup;
```

This permanently removes the event definition.

---

# 12. SHOW EVENTS

To list events:

```sql
SHOW EVENTS;
```

You can also specify a database:

```sql
SHOW EVENTS FROM module25_events;
```

---

# 13. SHOW CREATE EVENT

To inspect an event's definition:

```sql
SHOW CREATE EVENT event_name;
```

This is useful for debugging and documentation.

---

# 14. Event with Multiple Statements

An event can execute multiple SQL statements.

Use `BEGIN ... END`:

```sql
CREATE EVENT archive_event
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO archived_orders
    SELECT *
    FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;

    DELETE FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;
END;
```

When using a MySQL client, a temporary delimiter is normally required.

Example:

```sql
DELIMITER //

CREATE EVENT archive_event
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO archived_orders
    SELECT *
    FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;

    DELETE FROM orders
    WHERE order_date < CURRENT_DATE - INTERVAL 1 YEAR;
END//

DELIMITER ;
```

---

# 15. Events and Stored Procedures

An event can call a stored procedure.

Example:

```sql
CREATE EVENT daily_report
ON SCHEDULE EVERY 1 DAY
DO
    CALL generate_daily_report();
```

This is often cleaner than placing a large amount of SQL directly inside the event.

Conceptually:

```text
Scheduled Event
      ↓
Stored Procedure
      ↓
Multiple SQL operations
```

---

# 16. Event Scheduler vs Trigger

A trigger executes because of a table event.

An event executes because of a schedule.

### Trigger

```text
INSERT / UPDATE / DELETE
          ↓
       Trigger
```

### Scheduled Event

```text
Time / Schedule
       ↓
      Event
```

Triggers react to data changes.

Events react to time.

---

# 17. Event Scheduler vs Application Scheduler

Scheduled work can be implemented in several places.

For example:

```text
Database Event Scheduler
Application scheduler
Operating-system scheduler
Cloud scheduler
```

A database event is useful when the operation is tightly related to database data and should run independently of an application server.

---

# 18. Cleanup Example

Suppose a table contains temporary sessions:

```sql
CREATE TABLE sessions (
    session_id INT PRIMARY KEY,
    user_id INT,
    created_at DATETIME
);
```

An event can remove expired sessions:

```sql
CREATE EVENT cleanup_sessions
ON SCHEDULE EVERY 1 HOUR
DO
    DELETE FROM sessions
    WHERE created_at < NOW() - INTERVAL 24 HOUR;
```

The database can now perform this cleanup automatically.

---

# 19. Scheduled Summary Updates

Suppose an application has a sales table and a daily summary table.

An event can periodically calculate summary information.

For example:

```text
sales
  ↓
Scheduled Event
  ↓
daily_sales_summary
```

This can reduce the need to repeatedly calculate expensive reports.

---

# 20. Events Calling Procedures

A practical architecture is:

```text
Event
  ↓
Stored Procedure
  ↓
INSERT / UPDATE / DELETE
  ↓
Triggers, if applicable
```

This combines several database automation features.

---

# 21. Events and Transactions

An event can contain transactional operations.

Example:

```sql
CREATE EVENT process_pending_orders
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    START TRANSACTION;

    UPDATE orders
    SET status = 'PROCESSED'
    WHERE status = 'PENDING';

    COMMIT;
END;
```

Transaction design should be used carefully, especially when many rows are processed.

---

# 22. Events and Triggers

An event can modify a table that has triggers.

For example:

```text
Scheduled Event
      ↓
UPDATE employees
      ↓
UPDATE Trigger
      ↓
Audit table
```

Therefore, an event may indirectly cause trigger actions.

This is important when debugging automated database behavior.

---

# 23. Event Status

The `SHOW EVENTS` command provides information such as:

```text
Event name
Definer
Time zone
Event type
Execute at
Interval
Starts
Ends
Status
```

This helps determine whether an event is active and how it is scheduled.

---

# 24. One-Time vs Recurring Events

### One-time

```sql
ON SCHEDULE AT ...
```

Use when an operation should happen once.

### Recurring

```sql
ON SCHEDULE EVERY ...
```

Use when an operation should repeat.

Mental model:

```text
AT
→ once

EVERY
→ repeatedly
```

---

# 25. Common Event Intervals

Examples:

```sql
EVERY 10 SECOND
EVERY 5 MINUTE
EVERY 2 HOUR
EVERY 1 DAY
EVERY 1 WEEK
EVERY 1 MONTH
```

Choose an interval based on the business requirement.

---

# 26. Event Naming

Use descriptive names.

Good:

```text
cleanup_expired_sessions
generate_daily_sales_summary
archive_old_orders
process_pending_orders
```

Avoid vague names such as:

```text
event1
test_event
job
```

Clear names make database administration easier.

---

# 27. Events Should Be Idempotent When Possible

An operation is idempotent when running it multiple times does not create unintended repeated effects.

For example, a cleanup operation:

```sql
DELETE FROM sessions
WHERE created_at < NOW() - INTERVAL 24 HOUR;
```

is naturally safe to repeat because already-deleted rows are no longer present.

When designing scheduled jobs, consider what happens if the event executes again.

---

# 28. Avoiding Duplicate Processing

Suppose an event processes pending orders:

```sql
UPDATE orders
SET status = 'PROCESSED'
WHERE status = 'PENDING';
```

Changing the status makes it clear which rows have already been processed.

This prevents the same rows from being processed repeatedly.

---

# 29. Event Scheduler Security

Creating and modifying events requires appropriate MySQL privileges.

Not every database user will be able to:

```text
Create events
Alter events
Drop events
Enable or disable events
```

Permissions should be managed appropriately in production systems.

---

# 30. Time Zones

Events operate according to MySQL's time-zone configuration and event schedule.

When designing production schedules, make sure the expected time zone is clear.

This is especially important for applications serving users in multiple countries.

---

# 31. Debugging Events

When an event does not appear to execute, check:

```sql
SHOW VARIABLES LIKE 'event_scheduler';
```

Then:

```sql
SHOW EVENTS;
```

Then inspect the event:

```sql
SHOW CREATE EVENT event_name;
```

Check:

```text
Scheduler status
Event status
Schedule
Start time
End time
SQL definition
Privileges
```

---

# 32. Common Mistakes

### Mistake 1 — Event Scheduler is disabled

An event may exist but not execute if the scheduler is disabled.

### Mistake 2 — Incorrect schedule

Always verify:

```sql
SHOW CREATE EVENT event_name;
```

### Mistake 3 — Event is disabled

Check its status using:

```sql
SHOW EVENTS;
```

### Mistake 4 — Incorrect time assumptions

Verify the server/session time-zone configuration.

### Mistake 5 — Forgetting to remove test events

Test events should be removed after experimentation.

---

# 33. Event Lifecycle

A typical event lifecycle is:

```text
CREATE EVENT
     ↓
ENABLE
     ↓
EXECUTE
     ↓
ALTER
     ↓
DISABLE
     ↓
DROP
```

You should understand every stage.

---

# 34. Event + Procedure + Trigger

A more advanced database automation system can look like:

```text
                TIME
                 ↓
          Scheduled Event
                 ↓
        Stored Procedure
                 ↓
          UPDATE / INSERT
                 ↓
              Trigger
                 ↓
            Audit Table
```

This demonstrates how different database features can work together.

---

# 35. When to Use Scheduled Events

Good use cases include:

```text
Regular cleanup
Archiving
Periodic summaries
Maintenance
Refreshing derived data
Processing database queues
Deleting expired records
```

---

# 36. When Not to Use Scheduled Events

Avoid unnecessary events when:

```text
The task belongs clearly in application logic
The schedule is controlled externally
The operation is extremely complex
The event would create difficult hidden behavior
A simpler database feature is sufficient
```

Database automation should remain understandable.

---

# 37. Scheduled Events vs Triggers vs Procedures

| Feature                  | Trigger | Stored Procedure | Event |
| ------------------------ | ------- | ---------------- | ----- |
| Runs automatically       | Yes     | No               | Yes   |
| Triggered by data change | Yes     | No               | No    |
| Triggered by time        | No      | No               | Yes   |
| Called manually          | No      | Yes              | No    |
| Can contain SQL          | Yes     | Yes              | Yes   |
| Useful for automation    | Yes     | Indirectly       | Yes   |

---

# 38. Important Commands

Remember these:

```sql
CREATE EVENT
ALTER EVENT
DROP EVENT
SHOW EVENTS
SHOW CREATE EVENT
```

And:

```sql
SET GLOBAL event_scheduler = ON;
```

when you have the required permissions and your MySQL environment supports changing it dynamically.

---

# 39. Key Syntax

One-time:

```sql
CREATE EVENT event_name
ON SCHEDULE AT '2030-01-01 00:00:00'
DO
    SQL_statement;
```

Recurring:

```sql
CREATE EVENT event_name
ON SCHEDULE EVERY 1 DAY
DO
    SQL_statement;
```

Recurring with start and end:

```sql
CREATE EVENT event_name
ON SCHEDULE
    EVERY 1 DAY
    STARTS '2030-01-01 00:00:00'
    ENDS '2030-01-31 00:00:00'
DO
    SQL_statement;
```

---

# 40. Module 25 Key Takeaways

The most important concepts are:

```text
Event
→ database task scheduled by time

AT
→ one-time execution

EVERY
→ recurring execution

STARTS
→ when recurring execution begins

ENDS
→ when recurring execution stops

ENABLE
→ event is active

DISABLE
→ event remains defined but inactive
```

Important commands:

```sql
CREATE EVENT
ALTER EVENT
DROP EVENT
SHOW EVENTS
SHOW CREATE EVENT
```

The core mental model:

```text
TRIGGER
→ reacts to a data change

PROCEDURE
→ executes when called

EVENT
→ executes according to a schedule
```

---

# ============================================================

# 25_scheduled_events/examples.sql

# ============================================================

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

# ============================================================

# 25_scheduled_events/practice.sql

# ============================================================

-- ============================================================
-- MODULE 25: SCHEDULED EVENTS
-- practice.sql
-- ============================================================

USE module25_events;

-- ============================================================
-- EVENT SCHEDULER
-- ============================================================

-- Exercise 1
-- Check whether the Event Scheduler is enabled.

-- Exercise 2
-- Explain the difference between:
----------------------------------

-- CREATE EVENT
-- CREATE TRIGGER
-- CREATE PROCEDURE

-- ============================================================
-- BASIC EVENTS
-- ============================================================

-- Exercise 3
-- Create an event named:
-------------------------

## -- cleanup_sessions_practice

-- that runs every day and deletes sessions older than
-- 24 hours.

-- Exercise 4
-- Create a one-time event scheduled for:
-----------------------------------------

## -- 2030-06-01 00:00:00

-- The event should insert a row into daily_sales_summary.

-- Exercise 5
-- Create a recurring event that executes every 1 hour.

-- Exercise 6
-- Create an event that executes every 10 minutes.

-- ============================================================
-- STARTS AND ENDS
-- ============================================================

-- Exercise 7
-- Create an event that:
------------------------

-- runs every day
-- starts on 2030-01-01
-- ends on 2030-01-31

-- Exercise 8
-- Explain the purpose of STARTS.

-- Exercise 9
-- Explain the purpose of ENDS.

-- ============================================================
-- ENABLE / DISABLE
-- ============================================================

-- Exercise 10
-- Create a disabled event.

-- Exercise 11
-- Enable the event using ALTER EVENT.

-- Exercise 12
-- Disable it again.

-- ============================================================
-- ALTER EVENT
-- ============================================================

-- Exercise 13
-- Create an event that runs every 1 day.

-- Exercise 14
-- Change its schedule to every 12 hours.

-- Exercise 15
-- Disable the event.

-- Exercise 16
-- Re-enable the event.

-- ============================================================
-- INSPECTION
-- ============================================================

-- Exercise 17
-- Display all events in the current database.

-- Exercise 18
-- Display the complete CREATE statement for one event.

-- Exercise 19
-- Identify the event status from SHOW EVENTS.

-- ============================================================
-- DROP EVENT
-- ============================================================

-- Exercise 20
-- Create a test event.

-- Exercise 21
-- Drop the test event.

-- Exercise 22
-- Verify that it no longer appears in SHOW EVENTS.

-- ============================================================
-- MULTIPLE STATEMENTS
-- ============================================================

-- Exercise 23
-- Create an event containing multiple SQL statements.

-- Exercise 24
-- Use DELIMITER correctly.

-- Exercise 25
-- Explain why BEGIN ... END is useful for events containing
-- multiple statements.

-- ============================================================
-- STORED PROCEDURES + EVENTS
-- ============================================================

-- Exercise 26
-- Create a stored procedure that calculates the total sales
-- for the current date and inserts the result into
-- daily_sales_summary.

-- Exercise 27
-- Create an event that calls the procedure once per day.

-- Exercise 28
-- Explain why calling a procedure from an event can be better
-- than putting a large amount of SQL directly inside the event.

-- ============================================================
-- CLEANUP AUTOMATION
-- ============================================================

-- Exercise 29
-- Create an event that deletes sessions older than 7 days.

-- Exercise 30
-- Create an event that deletes temporary records older than
-- 30 days.

-- ============================================================
-- SUMMARY AUTOMATION
-- ============================================================

-- Exercise 31
-- Create an event that periodically calculates total sales.

-- Exercise 32
-- Modify the design so that one summary row is created
-- per day.

-- Exercise 33
-- Explain how repeated execution could accidentally create
-- duplicate summary rows.

-- ============================================================
-- TRANSACTIONS
-- ============================================================

-- Exercise 34
-- Create an event containing:
------------------------------

-- START TRANSACTION
-- UPDATE
-- COMMIT

-- Exercise 35
-- Explain why transaction handling can be useful inside
-- scheduled database operations.

-- ============================================================
-- TRIGGERS + EVENTS
-- ============================================================

-- Exercise 36
-- Suppose an event updates the employees table.
------------------------------------------------

-- If an UPDATE trigger exists on employees, explain what
-- happens when the event executes.

-- Exercise 37
-- Design an event that updates a table and causes an existing
-- audit trigger to record the change.

-- ============================================================
-- DESIGN QUESTIONS
-- ============================================================

-- Exercise 38
-- Give five practical use cases for scheduled events.

-- Exercise 39
-- Give three situations where a scheduled event may not
-- be the best solution.

-- Exercise 40
-- Compare:
-----------

-- Trigger
-- Stored Procedure
-- Scheduled Event
------------------

-- based on how they are executed.

-- ============================================================
-- MINI PROJECT
-- ============================================================

## -- Build a scheduled session-cleanup system.

## -- Requirements:

-- 1. Create a sessions table.
-- 2. Insert old and recent sessions.
-- 3. Create a recurring cleanup event.
-- 4. Delete sessions older than 24 hours.
-- 5. Inspect the event.
-- 6. Disable the event.
-- 7. Re-enable the event.
-- 8. Modify its schedule.
-- 9. Test the cleanup SQL manually.
-- 10. Document the event.

# ============================================================

# 25_scheduled_events/solutions.sql

# ============================================================

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

# ============================================================

# 25_scheduled_events/challenge.sql

# ============================================================

-- ============================================================
-- MODULE 25: SCHEDULED EVENTS
-- challenge.sql
-- ============================================================

USE module25_events;

-- ============================================================
-- CHALLENGE 1 — SESSION CLEANUP
-- ============================================================

-- Create an event that automatically removes sessions
-- older than 24 hours.
-----------------------

-- The event should execute every day.

-- ============================================================
-- CHALLENGE 2 — WEEKLY CLEANUP
-- ============================================================

-- Create an event that runs every week and removes sessions
-- older than 7 days.

-- ============================================================
-- CHALLENGE 3 — ONE-TIME EVENT
-- ============================================================

## -- Create a one-time event scheduled for:

## -- 2030-12-31 23:59:59

-- It should insert a final summary record.

-- ============================================================
-- CHALLENGE 4 — EVENT LIFECYCLE
-- ============================================================

## -- Create an event.

## -- Then:

-- 1. Inspect it.
-- 2. Disable it.
-- 3. Inspect it again.
-- 4. Enable it.
-- 5. Change its schedule.
-- 6. Inspect it again.
-- 7. Drop it.
-- 8. Verify that it is gone.

-- ============================================================
-- CHALLENGE 5 — STARTS AND ENDS
-- ============================================================

## -- Create an event that:

-- executes every day
-- starts on 2030-01-01
-- ends on 2030-03-31

-- ============================================================
-- CHALLENGE 6 — STORED PROCEDURE + EVENT
-- ============================================================

-- Create a stored procedure that calculates today's total
-- sales and stores the result in daily_sales_summary.
------------------------------------------------------

-- Then create an event that calls the procedure every day.

-- ============================================================
-- CHALLENGE 7 — MULTIPLE STATEMENTS
-- ============================================================

## -- Create an event containing at least two SQL statements.

## -- Use:

-- DELIMITER
-- BEGIN
-- END

-- ============================================================
-- CHALLENGE 8 — TRANSACTION
-- ============================================================

## -- Create an event that:

-- 1. Starts a transaction.
-- 2. Updates data.
-- 3. Performs another SQL operation.
-- 4. Commits the transaction.

-- ============================================================
-- CHALLENGE 9 — IDEMPOTENCY
-- ============================================================

-- Design a scheduled event that can safely run repeatedly
-- without processing the same records multiple times.
------------------------------------------------------

-- Explain how your design prevents duplicate processing.

-- ============================================================
-- CHALLENGE 10 — EVENT + TRIGGER
-- ============================================================

## -- Assume an employees table has an AFTER UPDATE trigger.

## -- Create an event that updates employee data.

-- Explain what happens when the scheduled event executes.

-- ============================================================
-- CHALLENGE 11 — AUTOMATED ARCHIVING
-- ============================================================

## -- Create:

-- orders
-- archived_orders
------------------

-- Then create a scheduled event that moves orders older than
-- one year into archived_orders and removes them from orders.

-- ============================================================
-- CHALLENGE 12 — DAILY REPORT
-- ============================================================

## -- Build an automated daily reporting system.

## -- Requirements:

-- 1. sales table.
-- 2. daily_sales_summary table.
-- 3. Stored procedure for calculating the day's total.
-- 4. Scheduled event that calls the procedure.
-- 5. Appropriate indexes.
-- 6. Protection against duplicate daily summaries.

-- ============================================================
-- CHALLENGE 13 — EVENT DEBUGGING
-- ============================================================

## -- An event exists but does not seem to execute.

## -- Create a troubleshooting checklist covering:

-- Event Scheduler status
-- Event status
-- Schedule
-- STARTS
-- ENDS
-- Time zone
-- Permissions
-- SQL errors
-------------

-- Use SHOW EVENTS and SHOW CREATE EVENT.

-- ============================================================
-- CHALLENGE 14 — EVENT DESIGN
-- ============================================================

## -- Decide whether an event is appropriate for each:

-- A. Delete expired sessions every hour.
-- B. Validate every inserted employee salary.
-- C. Generate a daily sales report.
-- D. Return employee information to an application.
-- E. Record every employee salary change.

-- ============================================================
-- CHALLENGE 15 — FINAL PROJECT
-- ============================================================

## -- PROJECT: DATABASE AUTOMATION SYSTEM

## -- Build a small automated database maintenance system.

## -- Requirements:

-- 1. Create a sessions table.
-- 2. Create a sales table.
-- 3. Create a daily_sales_summary table.
-- 4. Insert realistic sample data.
-- 5. Create a cleanup event.
-- 6. Create a summary stored procedure.
-- 7. Create a scheduled event that calls the procedure.
-- 8. Use STARTS and ENDS for at least one event.
-- 9. Demonstrate ENABLE and DISABLE.
-- 10. Demonstrate ALTER EVENT.
-- 11. Demonstrate SHOW EVENTS.
-- 12. Demonstrate SHOW CREATE EVENT.
-- 13. Demonstrate DROP EVENT.
-- 14. Use a transaction in one scheduled operation.
-- 15. Explain how events can interact with triggers.
-- 16. Document every automated operation.
------------------------------------------

## -- Your final architecture should resemble:

--             TIME
--              ↓
--       SCHEDULED EVENT
--              ↓
--       STORED PROCEDURE
--              ↓
--       DATABASE CHANGE
--              ↓
--           TRIGGER
--              ↓
--          AUDIT DATA
----------------------

-- This project should demonstrate that you understand
-- database-side automation rather than merely knowing the
-- CREATE EVENT syntax.
