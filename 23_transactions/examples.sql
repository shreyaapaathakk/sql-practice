-- ============================================================
-- MODULE 23: TRANSACTIONS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module23_transactions;

USE module23_transactions;

-- ============================================================
-- TABLES
-- ============================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS employees;

CREATE TABLE accounts (
account_id INT PRIMARY KEY,
account_holder VARCHAR(100) NOT NULL,
balance DECIMAL(12,2) NOT NULL
);

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(100) NOT NULL,
salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
total_amount DECIMAL(10,2) NOT NULL
);

CREATE TABLE order_items (
item_id INT PRIMARY KEY,
order_id INT NOT NULL,
product_name VARCHAR(100) NOT NULL,
quantity INT NOT NULL,
FOREIGN KEY (order_id)
REFERENCES orders(order_id)
);

-- ============================================================
-- DATA
-- ============================================================

INSERT INTO accounts
VALUES
(1, 'Aarav', 20000),
(2, 'Priya', 10000),
(3, 'Rohan', 15000);

INSERT INTO employees
VALUES
(101, 'Aarav Sharma', 55000),
(102, 'Priya Singh', 72000),
(103, 'Rohan Verma', 48000),
(104, 'Neha Gupta', 65000);

-- ============================================================
-- 1. BASIC COMMIT
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

COMMIT;

SELECT *
FROM employees
WHERE employee_id = 101;

-- ============================================================
-- 2. BASIC ROLLBACK
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 102;

ROLLBACK;

SELECT *
FROM employees
WHERE employee_id = 102;

-- ============================================================
-- 3. BANK TRANSFER
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;

SELECT *
FROM accounts
ORDER BY account_id;

-- ============================================================
-- 4. TEST TRANSFER WITH ROLLBACK
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 3;

SELECT *
FROM accounts
ORDER BY account_id;

ROLLBACK;

SELECT *
FROM accounts
ORDER BY account_id;

-- ============================================================
-- 5. INSERT + COMMIT
-- ============================================================

START TRANSACTION;

INSERT INTO orders (
order_id,
customer_name,
total_amount
)
VALUES (
1001,
'Rahul',
2500
);

COMMIT;

SELECT *
FROM orders;

-- ============================================================
-- 6. INSERT + ROLLBACK
-- ============================================================

START TRANSACTION;

INSERT INTO orders (
order_id,
customer_name,
total_amount
)
VALUES (
1002,
'Meera',
3500
);

ROLLBACK;

SELECT *
FROM orders;

-- ============================================================
-- 7. MULTIPLE OPERATIONS
-- ============================================================

START TRANSACTION;

INSERT INTO orders (
order_id,
customer_name,
total_amount
)
VALUES (
1003,
'Kavya',
5000
);

INSERT INTO order_items (
item_id,
order_id,
product_name,
quantity
)
VALUES
(1, 1003, 'Keyboard', 1),
(2, 1003, 'Mouse', 2);

COMMIT;

SELECT *
FROM orders;

SELECT *
FROM order_items;

-- ============================================================
-- 8. SAVEPOINT
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

SAVEPOINT after_first_update;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 2;

ROLLBACK TO SAVEPOINT after_first_update;

COMMIT;

SELECT *
FROM accounts
ORDER BY account_id;

-- ============================================================
-- 9. MULTIPLE SAVEPOINTS
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

SAVEPOINT salary_update_1;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 102;

SAVEPOINT salary_update_2;

UPDATE employees
SET salary = salary + 3000
WHERE employee_id = 103;

ROLLBACK TO SAVEPOINT salary_update_2;

COMMIT;

SELECT *
FROM employees
ORDER BY employee_id;

-- ============================================================
-- 10. RELEASE SAVEPOINT
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 104;

SAVEPOINT before_second_update;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 103;

RELEASE SAVEPOINT before_second_update;

COMMIT;

-- ============================================================
-- 11. AUTOCOMMIT
-- ============================================================

SELECT @@autocommit;

-- Temporarily disable autocommit.

SET autocommit = 0;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 101;

COMMIT;

-- Restore autocommit.

SET autocommit = 1;

-- ============================================================
-- 12. ISOLATION LEVEL
-- ============================================================

SELECT @@transaction_isolation;

-- Example of changing the session isolation level.

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT @@transaction_isolation;

-- Restore MySQL's common default for InnoDB practice.

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- ============================================================
-- 13. SELECT ... FOR UPDATE
-- ============================================================

START TRANSACTION;

SELECT
account_id,
account_holder,
balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

UPDATE accounts
SET balance = balance - 1000
WHERE account_id = 1;

COMMIT;

-- ============================================================
-- 14. DELETE + ROLLBACK
-- ============================================================

START TRANSACTION;

DELETE FROM employees
WHERE employee_id = 104;

SELECT *
FROM employees;

ROLLBACK;

SELECT *
FROM employees;

-- ============================================================
-- 15. DELETE + COMMIT
-- ============================================================

START TRANSACTION;

DELETE FROM employees
WHERE employee_id = 104;

COMMIT;

SELECT *
FROM employees;

-- ============================================================
-- REINSERT FOR FURTHER PRACTICE
-- ============================================================

INSERT INTO employees
VALUES
(104, 'Neha Gupta', 65000);

-- ============================================================
-- 16. TRANSACTION WITH CHECK
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 3000
WHERE account_id = 1;

SELECT *
FROM accounts
WHERE account_id = 1;

ROLLBACK;

-- ============================================================
-- 17. FINAL STATE
-- ============================================================

SELECT *
FROM accounts
ORDER BY account_id;

SELECT *
FROM employees
ORDER BY employee_id;

SELECT *
FROM orders
ORDER BY order_id;
