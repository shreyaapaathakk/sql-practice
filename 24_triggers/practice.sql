-- ============================================================
-- MODULE 24: TRIGGERS
-- practice.sql
-- ============================================================

USE module24_triggers;

-- ============================================================
-- BASIC TRIGGER CONCEPTS
-- ============================================================

-- Exercise 1
-- Create an AFTER INSERT trigger on employees.
-----------------------------------------------

-- Whenever a new employee is inserted, add a record to
-- employee_audit.

-- Exercise 2
-- Test your trigger by inserting a new employee.

-- Exercise 3
-- Query employee_audit and verify that the trigger fired.

-- Exercise 4
-- Create a BEFORE UPDATE trigger that prevents a salary
-- from becoming negative.

-- Exercise 5
-- Test the validation trigger with a valid salary update.

-- Exercise 6
-- Test the validation trigger with an invalid salary update.
-------------------------------------------------------------

-- Observe the error.

-- ============================================================
-- OLD AND NEW
-- ============================================================

-- Exercise 7
-- Create an AFTER UPDATE trigger that stores:
----------------------------------------------

-- employee_id
-- OLD.salary
-- NEW.salary
-------------

-- in employee_salary_history.

-- Exercise 8
-- Update an employee's salary and inspect the history table.

-- Exercise 9
-- Update an employee's job title without changing salary.
----------------------------------------------------------

-- Determine whether your salary-history trigger should
-- create a history record.

-- Exercise 10
-- Explain the difference between:
----------------------------------

-- OLD.salary
-- NEW.salary

-- ============================================================
-- DELETE TRIGGERS
-- ============================================================

-- Exercise 11
-- Create an AFTER DELETE trigger that stores deleted employee
-- information in employee_delete_history.

-- Exercise 12
-- Delete an employee and verify that the history record
-- was created.

-- Exercise 13
-- Explain why a DELETE trigger can use OLD but not NEW.

-- Exercise 14
-- Create a BEFORE DELETE trigger that prevents deletion
-- of employee 101.

-- ============================================================
-- INSERT VALIDATION
-- ============================================================

-- Exercise 15
-- Create a BEFORE INSERT trigger on products that prevents
-- negative quantities.

-- Exercise 16
-- Extend the trigger so negative prices are also rejected.

-- Exercise 17
-- Test the trigger using valid data.

-- Exercise 18
-- Test the trigger using invalid quantity.

-- Exercise 19
-- Test the trigger using invalid price.

-- ============================================================
-- AUDIT LOGGING
-- ============================================================

-- Exercise 20
-- Create an audit table for customers.

-- Exercise 21
-- Create an AFTER INSERT trigger for customers.

-- Exercise 22
-- Create an AFTER UPDATE trigger for customers.
------------------------------------------------

-- Store the customer ID and action type.

-- Exercise 23
-- Create an AFTER DELETE trigger for customers.

-- Exercise 24
-- Insert, update, and delete a customer.
-----------------------------------------

-- Verify that all three actions were recorded.

-- ============================================================
-- BEFORE VS AFTER
-- ============================================================

-- Exercise 25
-- Explain when you would use:
------------------------------

-- BEFORE INSERT
-- AFTER INSERT
-- BEFORE UPDATE
-- AFTER UPDATE
-- BEFORE DELETE
-- AFTER DELETE

-- Exercise 26
-- Decide whether each situation should use BEFORE or AFTER:
------------------------------------------------------------

-- A. Reject a negative salary.
-- B. Record a completed salary change.
-- C. Store information about a deleted employee.
-- D. Modify an incoming value before insertion.
-- E. Create an audit record after an insert.

-- ============================================================
-- DELIMITER
-- ============================================================

-- Exercise 27
-- Write a trigger containing multiple statements.
--------------------------------------------------

-- Use DELIMITER correctly.

-- Exercise 28
-- Explain why DELIMITER is commonly used when defining
-- multi-statement triggers in MySQL clients.

-- ============================================================
-- SIGNAL
-- ============================================================

-- Exercise 29
-- Create a trigger that rejects a product with quantity < 0
-- using SIGNAL SQLSTATE '45000'.

-- Exercise 30
-- Create a trigger that rejects a product with price < 0.

-- Exercise 31
-- Create a trigger that rejects an employee salary below
-- 10000.

-- ============================================================
-- TRIGGER INSPECTION
-- ============================================================

-- Exercise 32
-- Display all triggers in the current database.

-- Exercise 33
-- Display the CREATE statement for one trigger.

-- Exercise 34
-- Drop a trigger.

-- Exercise 35
-- Recreate the trigger.

-- ============================================================
-- TRANSACTIONS + TRIGGERS
-- ============================================================

-- Exercise 36
-- Start a transaction.
-----------------------

## -- Update an employee salary.

## -- Allow the AFTER UPDATE trigger to create a history record.

## -- Roll back the transaction.

-- Verify whether the trigger-generated history record
-- was rolled back as part of the transaction.

-- Exercise 37
-- Repeat Exercise 36 but COMMIT the transaction.
-------------------------------------------------

-- Compare the result.

-- ============================================================
-- DESIGN QUESTIONS
-- ============================================================

-- Exercise 38
-- Give three good use cases for database triggers.

-- Exercise 39
-- Give three situations where triggers may be inappropriate.

-- Exercise 40
-- Explain why too many triggers can make a database
-- difficult to maintain.

-- ============================================================
-- MINI PROJECT
-- ============================================================

## -- Build an employee audit system.

## -- Requirements:

-- 1. Track employee inserts.
-- 2. Track employee salary changes.
-- 3. Track employee deletions.
-- 4. Store old and new salary values.
-- 5. Store timestamps.
-- 6. Prevent negative salaries.
-- 7. Use appropriate BEFORE and AFTER triggers.
-- 8. Test every trigger.
-- 9. Inspect the trigger definitions.
-- 10. Document the design.
