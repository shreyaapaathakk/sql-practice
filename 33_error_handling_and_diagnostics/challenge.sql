-- ============================================================
-- Module 33: Error Handling & Diagnostics in MySQL
-- File: challenge.sql
-- MySQL Version: 8.0+
--
-- CHALLENGE: BUILD A SAFE BANK TRANSFER SYSTEM
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;


-- ============================================================
-- PART 1: DATABASE SETUP
-- ============================================================

DROP PROCEDURE IF EXISTS challenge_transfer_funds;
DROP TABLE IF EXISTS challenge_transfer_log;
DROP TABLE IF EXISTS challenge_accounts;
DROP TABLE IF EXISTS challenge_error_log;


CREATE TABLE challenge_accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL,
    CONSTRAINT chk_challenge_balance
        CHECK (balance >= 0)
) ENGINE = InnoDB;


INSERT INTO challenge_accounts
    (account_id, account_holder, balance)
VALUES
    (101, 'Aarav Sharma', 5000.00),
    (102, 'Diya Verma', 3000.00),
    (103, 'Kabir Singh', 1500.00);


CREATE TABLE challenge_transfer_log (
    transfer_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account INT NOT NULL,
    to_account INT NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    transfer_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;


CREATE TABLE challenge_error_log (
    error_id INT AUTO_INCREMENT PRIMARY KEY,
    error_number INT,
    sql_state CHAR(5),
    error_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;


-- ============================================================
-- PART 2: YOUR TASK
--
-- Create a procedure named challenge_transfer_funds.
--
-- Parameters:
--   p_from_account INT
--   p_to_account INT
--   p_amount DECIMAL(12, 2)
--
-- Requirements:
--
-- 1. Validate all input parameters.
--
-- 2. Reject transfers when:
--    - Either account ID is NULL.
--    - The account IDs are identical.
--    - The amount is NULL, zero, or negative.
--
-- 3. Start a transaction.
--
-- 4. Lock the account rows before checking balances.
--
-- 5. Confirm that both accounts exist.
--
-- 6. Reject transfers when the source account has
--    insufficient funds.
--
-- 7. Debit the source account and credit the destination.
--
-- 8. Insert a successful transfer record into
--    challenge_transfer_log.
--
-- 9. Commit only when all operations succeed.
--
-- 10. Declare an EXIT handler for SQLEXCEPTION.
--
-- 11. In the handler:
--     - Retrieve MYSQL_ERRNO, RETURNED_SQLSTATE,
--       and MESSAGE_TEXT using GET DIAGNOSTICS.
--     - Roll back the transaction.
--     - Record the error in challenge_error_log.
--     - Use RESIGNAL to propagate the error.
--
-- 12. Test successful transfers and failure scenarios.
--
-- Important:
-- In a real application, consider whether logging should
-- survive the rollback. If the log insert occurs in the
-- same transaction, it will be rolled back too. For this
-- exercise, design and document your approach carefully.
-- ============================================================


-- Write your procedure here.


-- ============================================================
-- PART 3: TEST CASES
-- Run these after creating the procedure.
-- ============================================================

-- Test 1: Successful transfer
-- CALL challenge_transfer_funds(101, 102, 500.00);

-- Test 2: Insufficient funds
-- CALL challenge_transfer_funds(101, 102, 999999.00);

-- Test 3: Missing source account
-- CALL challenge_transfer_funds(999, 102, 100.00);

-- Test 4: Missing destination account
-- CALL challenge_transfer_funds(101, 999, 100.00);

-- Test 5: Same source and destination
-- CALL challenge_transfer_funds(101, 101, 100.00);

-- Test 6: Invalid amount
-- CALL challenge_transfer_funds(101, 102, -100.00);

-- Test 7: NULL amount
-- CALL challenge_transfer_funds(101, 102, NULL);


-- ============================================================
-- PART 4: VERIFY RESULTS
-- ============================================================

SELECT *
FROM challenge_accounts
ORDER BY account_id;

SELECT *
FROM challenge_transfer_log
ORDER BY transfer_id;

SELECT *
FROM challenge_error_log
ORDER BY error_id;


-- ============================================================
-- BONUS TASKS
--
-- 1. Add a transfer reference code to each successful transfer.
--
-- 2. Record the balance before and after each transfer.
--
-- 3. Add a daily transfer limit per account.
--
-- 4. Prevent concurrent transfers from causing negative
--    balances.
--
-- 5. Investigate how to log errors in a separate transaction
--    or through an external application-level logging system.
--
-- 6. Use GET DIAGNOSTICS to capture the affected-row count
--    after each UPDATE and verify that exactly one account
--    row was changed.
-- ============================================================
