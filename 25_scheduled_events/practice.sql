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
