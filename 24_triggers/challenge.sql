-- ============================================================
-- MODULE 24: TRIGGERS
-- challenge.sql
-- ============================================================

USE module24_triggers;

-- ============================================================
-- CHALLENGE 1 — EMPLOYEE INSERT AUDIT
-- ============================================================

-- Create a trigger that automatically records every new
-- employee insertion.
----------------------

## -- Store:

-- employee_id
-- action_type
-- timestamp

-- ============================================================
-- CHALLENGE 2 — SALARY HISTORY
-- ============================================================

## -- Create a trigger that records salary changes.

## -- Store:

-- employee_id
-- old_salary
-- new_salary
-- changed_at
-------------

-- Do not create a history record when only the job title
-- changes.

-- ============================================================
-- CHALLENGE 3 — PREVENT INVALID SALARY
-- ============================================================

## -- Create a BEFORE UPDATE trigger that rejects:

## -- salary < 0

-- Use SIGNAL SQLSTATE '45000'.

-- ============================================================
-- CHALLENGE 4 — PRODUCT VALIDATION
-- ============================================================

## -- Create a BEFORE INSERT trigger that rejects:

-- quantity < 0
-- price < 0
------------

-- Return different error messages for the two conditions.

-- ============================================================
-- CHALLENGE 5 — DELETE AUDIT
-- ============================================================

## -- Create an AFTER DELETE trigger.

## -- Store:

-- employee_id
-- employee_name
-- salary
-- deletion timestamp

-- ============================================================
-- CHALLENGE 6 — PROTECTED EMPLOYEE
-- ============================================================

-- Create a BEFORE DELETE trigger that prevents deletion of
-- employees whose job_title is 'CEO'.

-- ============================================================
-- CHALLENGE 7 — CUSTOMER AUDIT
-- ============================================================

## -- Create triggers that record:

-- INSERT
-- UPDATE
-- DELETE
---------

-- for customers.

-- ============================================================
-- CHALLENGE 8 — OLD VS NEW
-- ============================================================

## -- Create an UPDATE trigger that records:

-- old city
-- new city
-----------

-- whenever a customer's city changes.

-- ============================================================
-- CHALLENGE 9 — TRANSACTION + TRIGGER
-- ============================================================

## -- Start a transaction.

## -- Update an employee salary.

## -- Allow the salary-history trigger to fire.

## -- Inspect both tables.

## -- ROLLBACK.

-- Verify that both the salary change and trigger-generated
-- history record were rolled back.

-- ============================================================
-- CHALLENGE 10 — COMMIT VERSION
-- ============================================================

## -- Repeat Challenge 9.

## -- This time COMMIT.

-- Verify that both the employee change and history record
-- remain.

-- ============================================================
-- CHALLENGE 11 — MULTIPLE ROW UPDATE
-- ============================================================

## -- Create an UPDATE trigger on employees.

-- Then execute one UPDATE statement that changes the salaries
-- of multiple employees.
-------------------------

-- Verify how many trigger-generated history rows were created.

-- ============================================================
-- CHALLENGE 12 — AUDIT DESIGN
-- ============================================================

## -- Design a general audit table containing:

-- audit_id
-- table_name
-- record_id
-- action_type
-- action_time
--------------

-- Create a trigger for one table that writes to this audit
-- table.

-- ============================================================
-- CHALLENGE 13 — AUTOMATIC NORMALIZATION
-- ============================================================

-- Create a BEFORE INSERT trigger that removes unnecessary
-- spaces from a customer name.
-------------------------------

## -- Example:

## -- '   Rahul Kumar   '

## -- should become:

-- 'Rahul Kumar'

-- ============================================================
-- CHALLENGE 14 — UPPERCASE CITY
-- ============================================================

-- Create a BEFORE INSERT trigger that stores a customer's
-- city in uppercase.
---------------------

## -- Example:

## -- 'delhi'

## -- becomes:

-- 'DELHI'

-- ============================================================
-- CHALLENGE 15 — PRICE VALIDATION
-- ============================================================

-- Prevent products from being inserted with a price of zero
-- or less.

-- ============================================================
-- CHALLENGE 16 — STOCK VALIDATION
-- ============================================================

-- Prevent product quantity from becoming negative during
-- UPDATE as well as INSERT.

-- ============================================================
-- CHALLENGE 17 — SALARY CHANGE RESTRICTION
-- ============================================================

-- Create a trigger that prevents an employee's salary from
-- being reduced by more than 30% in a single UPDATE.

-- ============================================================
-- CHALLENGE 18 — TRIGGER INSPECTION
-- ============================================================

## -- Display all triggers in the database.

-- Select one trigger and display its complete CREATE statement.

-- ============================================================
-- CHALLENGE 19 — TRIGGER CLEANUP
-- ============================================================

## -- Identify one trigger that is no longer needed.

## -- Drop it.

-- Verify that it no longer appears in SHOW TRIGGERS.

-- ============================================================
-- CHALLENGE 20 — TRIGGER VS CONSTRAINT
-- ============================================================

-- For each requirement, decide whether a CHECK constraint
-- or trigger would be more appropriate:
----------------------------------------

-- A. Salary must be >= 0.
-- B. Record every salary change.
-- C. Quantity must be >= 0.
-- D. Preserve deleted employee information.
--------------------------------------------

-- Explain your choices.

-- ============================================================
-- CHALLENGE 21 — TRIGGER SIDE EFFECTS
-- ============================================================

## -- Create a trigger that automatically writes to another table.

## -- Document the hidden side effect.

-- Then explain why developers should know about this behavior.

-- ============================================================
-- CHALLENGE 22 — AUDIT SYSTEM
-- ============================================================

## -- Build a complete employee audit system.

## -- Requirements:

-- 1. Employee INSERT audit.
-- 2. Employee UPDATE audit.
-- 3. Employee DELETE audit.
-- 4. Salary old/new values.
-- 5. Timestamp.
-- 6. Validation for negative salary.
-- 7. Protected employees cannot be deleted.
--------------------------------------------

-- Test every requirement.

-- ============================================================
-- CHALLENGE 23 — TRIGGER + TRANSACTION PROJECT
-- ============================================================

## -- Build a transaction-safe employee update workflow.

## -- Requirements:

-- 1. Start a transaction.
-- 2. Update employee data.
-- 3. Allow triggers to execute.
-- 4. Inspect the resulting data.
-- 5. ROLLBACK in one test.
-- 6. COMMIT in another test.
-- 7. Verify audit behavior in both cases.

-- ============================================================
-- CHALLENGE 24 — FINAL MODULE PROJECT
-- ============================================================

-- PROJECT:
-- BUILD A DATABASE AUDIT SYSTEM
--------------------------------

## -- Create an audit system for:

-- employees
-- customers
-- products
-----------

## -- Requirements:

-- 1. Track INSERT operations.
-- 2. Track UPDATE operations.
-- 3. Track DELETE operations.
-- 4. Store timestamps.
-- 5. Store old and new values where appropriate.
-- 6. Reject invalid data.
-- 7. Protect selected records from deletion.
-- 8. Use BEFORE triggers where validation/modification
--    is appropriate.
-- 9. Use AFTER triggers where audit logging is appropriate.
-- 10. Test all triggers.
-- 11. Test trigger behavior inside transactions.
-- 12. Test both COMMIT and ROLLBACK.
-- 13. Inspect trigger definitions.
-- 14. Document every trigger and its purpose.
----------------------------------------------

## -- Your final project should demonstrate:

-- CREATE TRIGGER
-- BEFORE
-- AFTER
-- INSERT
-- UPDATE
-- DELETE
-- OLD
-- NEW
-- FOR EACH ROW
-- DELIMITER
-- SIGNAL
-- audit logging
-- validation
-- transactions
-- COMMIT
-- ROLLBACK
