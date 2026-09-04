-- ============================================================
-- MODULE 23: TRANSACTIONS
-- practice.sql
-- ============================================================

USE module23_transactions;

-- ============================================================
-- BASIC TRANSACTIONS
-- ============================================================

-- Exercise 1
-- Increase employee 101's salary by 2000.
------------------------------------------

-- Use a transaction.
-- Commit the change.

-- Exercise 2
-- Increase employee 102's salary by 5000.
------------------------------------------

-- Start a transaction.
-- Perform the update.
-- Roll back the transaction.
-----------------------------

-- Verify that the salary did not change.

-- Exercise 3
-- Insert a new employee.
-------------------------

-- Use a transaction and COMMIT.

-- Exercise 4
-- Insert another employee.
---------------------------

## -- Use a transaction and ROLLBACK.

-- Verify that the employee was not inserted.

-- ============================================================
-- BANK TRANSFERS
-- ============================================================

-- Exercise 5
-- Transfer 2000 from account 1 to account 2.
---------------------------------------------

-- Use one transaction containing both UPDATE statements.
-- Commit the transaction.

-- Exercise 6
-- Transfer 3000 from account 2 to account 3.
---------------------------------------------

-- Perform both updates.
-- Inspect the balances.
-- Roll back the transaction.

-- Exercise 7
-- Transfer 1500 from account 3 to account 1.
---------------------------------------------

-- Use:
-- START TRANSACTION
-- UPDATE
-- UPDATE
-- COMMIT

-- Exercise 8
-- Explain why both account updates should belong to
-- the same transaction.

-- ============================================================
-- MULTIPLE OPERATIONS
-- ============================================================

-- Exercise 9
-- Create a transaction that:
-----------------------------

-- 1. Inserts an order.
-- 2. Inserts two order items.
-- 3. Commits all changes.

-- Exercise 10
-- Repeat Exercise 9 but roll back the transaction.
---------------------------------------------------

-- Verify that neither the order nor its items remain.

-- Exercise 11
-- Create a transaction that:
-----------------------------

-- 1. Inserts an order.
-- 2. Inserts an order item.
-- 3. Updates an employee salary.
---------------------------------

-- Commit all changes together.

-- ============================================================
-- SAVEPOINTS
-- ============================================================

-- Exercise 12
-- Start a transaction.
-----------------------

-- Update employee 101.
-- Create a savepoint.
-- Update employee 102.
-- Roll back to the savepoint.
-- Commit.

-- Exercise 13
-- Create two savepoints inside one transaction.
------------------------------------------------

## -- Perform three UPDATE operations.

-- Roll back to the second savepoint.
-- Commit.

-- Exercise 14
-- Create a savepoint named before_salary_change.
-------------------------------------------------

## -- Perform a salary update.

-- Roll back to before_salary_change.

-- Exercise 15
-- Practice RELEASE SAVEPOINT.

-- ============================================================
-- AUTOCOMMIT
-- ============================================================

-- Exercise 16
-- Check the current autocommit setting.

-- Exercise 17
-- Temporarily disable autocommit.
----------------------------------

-- Make a change.
-- Commit the change.
---------------------

-- Restore autocommit.

-- ============================================================
-- ISOLATION LEVELS
-- ============================================================

-- Exercise 18
-- Display the current transaction isolation level.

-- Exercise 19
-- Change the session isolation level to:
-----------------------------------------

-- READ COMMITTED

-- Exercise 20
-- Change the session isolation level to:
-----------------------------------------

## -- SERIALIZABLE

## -- Then restore:

-- REPEATABLE READ

-- Exercise 21
-- Write down the four standard isolation levels in order
-- from weakest to strongest.

-- ============================================================
-- FOR UPDATE
-- ============================================================

-- Exercise 22
-- Start a transaction.
-----------------------

## -- Select account 1 using:

## -- SELECT ... FOR UPDATE

## -- Then modify its balance.

-- Commit.

-- Exercise 23
-- Explain why FOR UPDATE can be useful when reading a row
-- that you intend to modify.

-- ============================================================
-- ACID
-- ============================================================

-- Exercise 24
-- Explain Atomicity using the bank transfer example.

-- Exercise 25
-- Explain Consistency.

-- Exercise 26
-- Explain Isolation.

-- Exercise 27
-- Explain Durability.

-- Exercise 28
-- Write the four ACID properties without looking at
-- the notes.

-- ============================================================
-- TRANSACTION ANALYSIS
-- ============================================================

-- Exercise 29
-- Consider:
------------

## -- START TRANSACTION;

-- UPDATE accounts
-- SET balance = balance - 5000
-- WHERE account_id = 1;
------------------------

-- UPDATE accounts
-- SET balance = balance + 5000
-- WHERE account_id = 2;
------------------------

## -- COMMIT;

-- Explain what happens after COMMIT.

-- Exercise 30
-- Consider the same transaction but replace COMMIT
-- with ROLLBACK.
-----------------

-- What happens?

-- ============================================================
-- SCENARIO PRACTICE
-- ============================================================

-- Exercise 31
-- A customer places an order.
------------------------------

## -- The database must:

-- 1. Create the order.
-- 2. Add order items.
-- 3. Reduce inventory.
-----------------------

-- Explain why these operations should be treated as
-- one transaction.

-- Exercise 32
-- A bank transfer consists of:
-------------------------------

-- 1. Deduct money from sender.
-- 2. Add money to receiver.
----------------------------

-- Write the transaction.

-- Exercise 33
-- An employee promotion requires:
----------------------------------

-- 1. Increase salary.
-- 2. Update job title.
-----------------------

-- Write the transaction.

-- Exercise 34
-- An operation performs three updates.
---------------------------------------

## -- The first two should remain if the third fails.

-- Use a SAVEPOINT to implement this behavior.

-- ============================================================
-- DEBUGGING
-- ============================================================

-- Exercise 35
-- Write a transaction that updates employee 101.
-------------------------------------------------

## -- Before committing, inspect the employee.

-- If the result is correct:
-- COMMIT
---------

-- Otherwise:
-- ROLLBACK

-- Exercise 36
-- Create a transaction that intentionally makes a change,
-- inspect it, and then roll it back.

-- ============================================================
-- THEORY
-- ============================================================

-- Exercise 37
-- Difference between:
----------------------

-- COMMIT
-- ROLLBACK

-- Exercise 38
-- Difference between:
----------------------

-- SAVEPOINT
-- ROLLBACK TO SAVEPOINT

-- Exercise 39
-- Difference between:
----------------------

-- START TRANSACTION
-- SET autocommit = 0

-- Exercise 40
-- Why can long-running transactions be problematic?

-- ============================================================
-- MINI PROJECT
-- ============================================================

## -- Build a transaction-based banking operation.

## -- Requirements:

## -- 1. Use the accounts table.

## -- 2. Transfer money between two accounts.

## -- 3. Use START TRANSACTION.

## -- 4. Check the source account.

## -- 5. Use SELECT ... FOR UPDATE.

## -- 6. Perform the withdrawal.

## -- 7. Perform the deposit.

## -- 8. Use COMMIT if successful.

## -- 9. Use ROLLBACK if the operation should be cancelled.

## -- 10. Test both successful and cancelled transfers.

-- 11. Verify the balances before and after each test.
