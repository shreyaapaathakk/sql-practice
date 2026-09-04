-- ============================================================
-- MODULE 23: TRANSACTIONS
-- challenge.sql
-- ============================================================

USE module23_transactions;

-- ============================================================
-- CHALLENGE 1 — SAFE BANK TRANSFER
-- ============================================================

-- Create a transaction that transfers money between
-- two accounts.
----------------

## -- Requirements:

-- 1. Start a transaction.
-- 2. Lock the source account using FOR UPDATE.
-- 3. Check the balance.
-- 4. Withdraw money.
-- 5. Deposit money into the destination account.
-- 6. Commit the transaction.
-----------------------------

## -- Test with:

-- account 1 → account 2
-- amount = 2000

-- ============================================================
-- CHALLENGE 2 — ROLLBACK TRANSFER
-- ============================================================

## -- Perform a transfer but intentionally roll it back.

-- Verify that both balances return to their original values.

-- ============================================================
-- CHALLENGE 3 — SAVEPOINT
-- ============================================================

## -- Create a transaction with three salary updates.

-- Update employee 101.
-- Create SAVEPOINT one.
------------------------

-- Update employee 102.
-- Create SAVEPOINT two.
------------------------

## -- Update employee 103.

## -- Roll back to SAVEPOINT two.

## -- Commit.

-- Determine which changes remain.

-- ============================================================
-- CHALLENGE 4 — ORDER TRANSACTION
-- ============================================================

## -- Build a transaction for creating an order.

## -- Steps:

-- 1. Insert an order.
-- 2. Insert three order items.
-- 3. Commit everything together.
---------------------------------

-- If any part must be cancelled:
-- roll back the entire transaction.

-- ============================================================
-- CHALLENGE 5 — ORDER + EMPLOYEE
-- ============================================================

## -- Create a transaction that:

-- 1. Creates an order.
-- 2. Adds order items.
-- 3. Updates an employee.
--------------------------

-- Commit everything together.

-- ============================================================
-- CHALLENGE 6 — TRANSACTION INSPECTION
-- ============================================================

## -- Create a transaction that:

-- 1. Changes an employee salary.
-- 2. SELECTs the employee.
-- 3. Decides whether to COMMIT or ROLLBACK.
--------------------------------------------

## -- Perform the exercise twice:

-- First time → COMMIT
-- Second time → ROLLBACK

-- ============================================================
-- CHALLENGE 7 — ACID
-- ============================================================

## -- Explain how the bank transfer demonstrates:

-- Atomicity
-- Consistency
-- Isolation
-- Durability

-- ============================================================
-- CHALLENGE 8 — ISOLATION
-- ============================================================

## -- Research and demonstrate the conceptual difference between:

-- READ UNCOMMITTED
-- READ COMMITTED
-- REPEATABLE READ
-- SERIALIZABLE
---------------

-- Record your observations in comments.

-- ============================================================
-- CHALLENGE 9 — FOR UPDATE
-- ============================================================

## -- Create a transaction that:

-- 1. Selects an account using FOR UPDATE.
-- 2. Checks the balance.
-- 3. Updates the balance.
-- 4. Commits.
--------------

-- Explain why FOR UPDATE is useful in this scenario.

-- ============================================================
-- CHALLENGE 10 — SAFE TRANSFER LOGIC
-- ============================================================

-- Design a transaction that should NOT allow a withdrawal
-- if the account balance is insufficient.
------------------------------------------

## -- Example:

-- Current balance = 5000
-- Requested withdrawal = 7000
------------------------------

-- The transaction should not leave the account with
-- a negative balance.

-- ============================================================
-- CHALLENGE 11 — SAVEPOINT WORKFLOW
-- ============================================================

## -- Create this transaction:

-- Operation A
-- SAVEPOINT A
--------------

-- Operation B
-- SAVEPOINT B
--------------

## -- Operation C

## -- Roll back to B.

## -- Operation D

## -- Commit.

-- Determine which operations remain.

-- ============================================================
-- CHALLENGE 12 — AUTOCOMMIT
-- ============================================================

## -- Demonstrate the difference between:

-- autocommit = 1
-- autocommit = 0
-----------------

-- Perform an UPDATE under each configuration and explain
-- when the change becomes permanent.

-- ============================================================
-- CHALLENGE 13 — TRANSACTION DEBUGGING
-- ============================================================

## -- Write a transaction containing several operations.

## -- Intentionally inspect intermediate results.

## -- Use a SAVEPOINT to undo only part of the transaction.

-- Commit the remaining changes.

-- ============================================================
-- CHALLENGE 14 — FAILURE SCENARIO
-- ============================================================

## -- Simulate this situation:

-- 1. Account A loses money.
-- 2. Account B should receive money.
-- 3. The second operation cannot be completed.
-----------------------------------------------

-- Demonstrate why ROLLBACK prevents the first operation
-- from remaining permanently applied.

-- ============================================================
-- CHALLENGE 15 — TRANSACTION DESIGN
-- ============================================================

## -- Design a transaction for an e-commerce purchase.

## -- It must:

-- 1. Create the order.
-- 2. Create order items.
-- 3. Reduce inventory.
-- 4. Record payment.
---------------------

-- Explain which operations should be committed together
-- and why.

-- ============================================================
-- CHALLENGE 16 — TRANSACTION + STORED PROCEDURE
-- ============================================================

-- Using concepts from Module 22, design a stored procedure
-- for transferring money.
--------------------------

## -- Requirements:

-- 1. Input source account.
-- 2. Input destination account.
-- 3. Input transfer amount.
-- 4. Start transaction.
-- 5. Lock the required account.
-- 6. Validate balance.
-- 7. Withdraw.
-- 8. Deposit.
-- 9. COMMIT on success.
-- 10. ROLLBACK on SQL error.
-----------------------------

-- Use an appropriate error handler.

-- ============================================================
-- CHALLENGE 17 — TRANSACTION API
-- ============================================================

## -- Design a small transaction layer containing procedures for:

-- 1. Transfer money.
-- 2. Deposit money.
-- 3. Withdraw money.
---------------------

-- Every operation should use appropriate transaction logic.

-- ============================================================
-- CHALLENGE 18 — ADVANCED CONCURRENCY
-- ============================================================

## -- Research and explain:

-- Dirty read
-- Non-repeatable read
-- Phantom read
---------------

-- Give one SQL scenario for each.

-- ============================================================
-- CHALLENGE 19 — ACID ANALYSIS
-- ============================================================

-- For an online shopping transaction, explain how each
-- ACID property protects the operation.
----------------------------------------

## -- Include:

-- Order creation
-- Inventory update
-- Payment
-- Customer record

-- ============================================================
-- CHALLENGE 20 — MODULE 23 PORTFOLIO PROJECT
-- ============================================================

-- PROJECT:
-- BUILD A TRANSACTION-SAFE BANKING SYSTEM
------------------------------------------

## -- Requirements:

## -- 1. Create an accounts table.

## -- 2. Support deposits.

## -- 3. Support withdrawals.

## -- 4. Support transfers.

## -- 5. Use START TRANSACTION.

## -- 6. Use COMMIT.

## -- 7. Use ROLLBACK.

## -- 8. Use SAVEPOINT.

## -- 9. Use SELECT ... FOR UPDATE.

## -- 10. Validate sufficient balance.

## -- 11. Prevent invalid transactions.

## -- 12. Use stored procedures from Module 22.

## -- 13. Add error handling.

## -- 14. Test successful operations.

## -- 15. Test failed operations.

## -- 16. Test rollback behavior.

-- 17. Verify account balances before and after every
--     transaction.
-------------------

## -- 18. Document the transaction design in notes.md.

## -- The final project should demonstrate:

-- ACID
-- transactions
-- COMMIT
-- ROLLBACK
-- SAVEPOINT
-- isolation
-- row locking
-- stored procedures
-- validation
-- error handling
