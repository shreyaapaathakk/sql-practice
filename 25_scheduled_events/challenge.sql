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
