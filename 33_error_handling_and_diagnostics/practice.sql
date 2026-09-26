-- ============================================================
-- Module 33: Error Handling & Diagnostics in MySQL
-- File: practice.sql
-- MySQL Version: 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;


-- ============================================================
-- SETUP
-- Run this section before attempting the exercises.
-- ============================================================

DROP TABLE IF EXISTS practice_accounts;
DROP TABLE IF EXISTS practice_employees;
DROP TABLE IF EXISTS practice_error_log;

CREATE TABLE practice_accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL
);

INSERT INTO practice_accounts
    (account_id, account_name, balance)
VALUES
    (1, 'Savings', 2000.00),
    (2, 'Checking', 1000.00),
    (3, 'Emergency', 500.00);


CREATE TABLE practice_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO practice_employees
    (employee_id, employee_name, salary)
VALUES
    (1, 'Aarav Sharma', 45000.00),
    (2, 'Diya Verma', 52000.00),
    (3, 'Kabir Singh', 48000.00);


CREATE TABLE practice_error_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    error_number INT,
    sql_state CHAR(5),
    error_message TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- EXERCISE 1: CONTINUE HANDLER
-- Create a procedure named practice_duplicate_handler.
--
-- Requirements:
-- 1. Create a temporary table with an INT PRIMARY KEY.
-- 2. Declare a CONTINUE handler for error 1062.
-- 3. Set a Boolean variable when a duplicate is detected.
-- 4. Insert the same primary key twice.
-- 5. Display whether the duplicate was detected.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 2: EXIT HANDLER
-- Create a procedure named practice_exit_handler.
--
-- Requirements:
-- 1. Declare an EXIT handler for SQLEXCEPTION.
-- 2. Create a temporary table with a primary key.
-- 3. Insert the same key twice.
-- 4. Display a message from the handler.
-- 5. Include a SELECT after the duplicate insert to demonstrate
--    that the EXIT handler skips the remaining statements.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 3: HANDLE A MISSING EMPLOYEE
-- Create a procedure named practice_find_employee.
--
-- Requirements:
-- 1. Accept an employee ID as an input parameter.
-- 2. Use SELECT ... INTO to retrieve the employee's name.
-- 3. Declare a CONTINUE handler for NOT FOUND.
-- 4. Display the name if the employee exists.
-- 5. Display "Employee not found" otherwise.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 4: RAISE A CUSTOM ERROR
-- Create a procedure named practice_validate_amount.
--
-- Requirements:
-- 1. Accept a DECIMAL amount.
-- 2. Raise SQLSTATE '45000' if the amount is NULL or <= 0.
-- 3. Use this message:
--    "Amount must be greater than zero"
-- 4. Display the accepted amount if validation succeeds.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 5: LOG ERROR DIAGNOSTICS
-- Create a procedure named practice_log_duplicate.
--
-- Requirements:
-- 1. Declare an EXIT handler for SQLEXCEPTION.
-- 2. Use GET DIAGNOSTICS CONDITION 1 to capture:
--    - MYSQL_ERRNO
--    - RETURNED_SQLSTATE
--    - MESSAGE_TEXT
-- 3. Insert these values into practice_error_log.
-- 4. Trigger a duplicate-key error using a temporary table.
-- 5. Display the logged error details.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 6: COUNT UPDATED ROWS
-- Create a procedure named practice_raise_salary.
--
-- Requirements:
-- 1. Accept a salary increase amount.
-- 2. Increase the salary of employees with IDs 1 and 2.
-- 3. Use GET DIAGNOSTICS to retrieve ROW_COUNT.
-- 4. Display the number of rows updated.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 7: TRANSACTION ERROR HANDLING
-- Create a procedure named practice_transfer.
--
-- Parameters:
-- - p_from_account INT
-- - p_to_account INT
-- - p_amount DECIMAL(12, 2)
--
-- Requirements:
-- 1. Validate that the amount is positive.
-- 2. Start a transaction.
-- 3. Lock and retrieve the source account balance.
-- 4. Raise a custom error if funds are insufficient.
-- 5. Debit the source account and credit the destination.
-- 6. Commit on success.
-- 7. Roll back and RESIGNAL on SQL exceptions.
-- 8. Test with a successful transfer and an invalid transfer.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 8: NAMED CONDITION
-- Create a procedure named practice_named_condition.
--
-- Requirements:
-- 1. Declare a named condition for MySQL error 1062.
-- 2. Declare a CONTINUE handler for that condition.
-- 3. Attempt a duplicate-key insert.
-- 4. Display whether the duplicate was detected.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 9: RESIGNAL
-- Create a procedure named practice_resignal.
--
-- Requirements:
-- 1. Declare an EXIT handler for SQLEXCEPTION.
-- 2. In the handler, use RESIGNAL to propagate the error.
-- 3. Trigger a duplicate-key error.
-- 4. Explain in a comment why the caller receives the error.
-- ============================================================

-- Write your solution here.


-- ============================================================
-- EXERCISE 10: INTEGRATED CHALLENGE
-- Create a procedure named practice_safe_transfer.
--
-- Requirements:
-- 1. Validate both account IDs and the transfer amount.
-- 2. Reject transfers where the source and destination IDs match.
-- 3. Handle missing accounts.
-- 4. Prevent transfers that exceed the source balance.
-- 5. Use a transaction and row locks.
-- 6. Roll back on failure and RESIGNAL the error.
-- 7. Commit only after both account balances are updated.
-- ============================================================

-- Write your solution here.
