-- ============================================================
-- MODULE 23: TRANSACTIONS
-- solutions.sql
-- ============================================================

USE module23_transactions;

-- ============================================================
-- Exercise 1
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 101;

COMMIT;

-- ============================================================
-- Exercise 2
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
-- Exercise 3
-- ============================================================

START TRANSACTION;

INSERT INTO employees (
employee_id,
employee_name,
salary
)
VALUES (
105,
'Kavya Patel',
58000
);

COMMIT;

-- ============================================================
-- Exercise 4
-- ============================================================

START TRANSACTION;

INSERT INTO employees (
employee_id,
employee_name,
salary
)
VALUES (
106,
'Meera Joshi',
62000
);

ROLLBACK;

SELECT *
FROM employees
WHERE employee_id = 106;

-- ============================================================
-- Exercise 5
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 2;

COMMIT;

SELECT *
FROM accounts
ORDER BY account_id;

-- ============================================================
-- Exercise 6
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 3000
WHERE account_id = 2;

UPDATE accounts
SET balance = balance + 3000
WHERE account_id = 3;

SELECT *
FROM accounts
ORDER BY account_id;

ROLLBACK;

-- ============================================================
-- Exercise 7
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1500
WHERE account_id = 3;

UPDATE accounts
SET balance = balance + 1500
WHERE account_id = 1;

COMMIT;

-- ============================================================
-- Exercise 9
-- ============================================================

START TRANSACTION;

INSERT INTO orders (
order_id,
customer_name,
total_amount
)
VALUES (
2001,
'Aman',
4500
);

INSERT INTO order_items (
item_id,
order_id,
product_name,
quantity
)
VALUES
(10, 2001, 'Laptop Stand', 1),
(11, 2001, 'Keyboard', 1);

COMMIT;

-- ============================================================
-- Exercise 10
-- ============================================================

START TRANSACTION;

INSERT INTO orders (
order_id,
customer_name,
total_amount
)
VALUES (
2002,
'Neha',
3000
);

INSERT INTO order_items (
item_id,
order_id,
product_name,
quantity
)
VALUES
(12, 2002, 'Mouse', 2),
(13, 2002, 'Mouse Pad', 1);

ROLLBACK;

SELECT *
FROM orders
WHERE order_id = 2002;

SELECT *
FROM order_items
WHERE order_id = 2002;

-- ============================================================
-- Exercise 11
-- ============================================================

START TRANSACTION;

INSERT INTO orders (
order_id,
customer_name,
total_amount
)
VALUES (
2003,
'Riya',
6000
);

INSERT INTO order_items (
item_id,
order_id,
product_name,
quantity
)
VALUES (
14,
2003,
'Monitor',
1
);

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 103;

COMMIT;

-- ============================================================
-- Exercise 12
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

SAVEPOINT salary_point;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 102;

ROLLBACK TO SAVEPOINT salary_point;

COMMIT;

-- ============================================================
-- Exercise 13
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 101;

SAVEPOINT point_one;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 102;

SAVEPOINT point_two;

UPDATE employees
SET salary = salary + 1500
WHERE employee_id = 103;

ROLLBACK TO SAVEPOINT point_two;

COMMIT;

-- ============================================================
-- Exercise 14
-- ============================================================

START TRANSACTION;

SAVEPOINT before_salary_change;

UPDATE employees
SET salary = salary + 10000
WHERE employee_id = 104;

ROLLBACK TO SAVEPOINT before_salary_change;

COMMIT;

-- ============================================================
-- Exercise 15
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

SAVEPOINT test_point;

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 102;

RELEASE SAVEPOINT test_point;

COMMIT;

-- ============================================================
-- Exercise 16
-- ============================================================

SELECT @@autocommit;

-- ============================================================
-- Exercise 17
-- ============================================================

SET autocommit = 0;

UPDATE employees
SET salary = salary + 500
WHERE employee_id = 101;

COMMIT;

SET autocommit = 1;

-- ============================================================
-- Exercise 18
-- ============================================================

SELECT @@transaction_isolation;

-- ============================================================
-- Exercise 19
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT @@transaction_isolation;

-- ============================================================
-- Exercise 20
-- ============================================================

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SELECT @@transaction_isolation;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- ============================================================
-- Exercise 22
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
-- Exercise 29
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;

-- ============================================================
-- Exercise 30
-- ============================================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

ROLLBACK;

-- ============================================================
-- Exercise 32
-- ============================================================

START TRANSACTION;

SELECT balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

UPDATE accounts
SET balance = balance - 2500
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 2500
WHERE account_id = 2;

COMMIT;

-- ============================================================
-- Exercise 33
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 101;

-- Example job-title table would normally be updated here.
-- The salary change and job-title change should belong
-- to the same transaction.

COMMIT;

-- ============================================================
-- Exercise 34
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 101;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 102;

SAVEPOINT before_third_update;

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 103;

-- If the third operation must be undone:

ROLLBACK TO SAVEPOINT before_third_update;

COMMIT;

-- ============================================================
-- Exercise 35
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 2500
WHERE employee_id = 101;

SELECT *
FROM employees
WHERE employee_id = 101;

## -- Choose one after inspection:

-- COMMIT;
-- ROLLBACK;

-- ============================================================
-- Exercise 36
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 10000
WHERE employee_id = 102;

SELECT *
FROM employees
WHERE employee_id = 102;

ROLLBACK;

-- ============================================================
-- MINI PROJECT
-- SAFE BANK TRANSFER
-- ============================================================

-- Example transfer:
-- Transfer 3000 from account 1 to account 2.

START TRANSACTION;

-- Lock the source account while checking its balance.

SELECT
account_id,
account_holder,
balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

-- Perform the withdrawal.

UPDATE accounts
SET balance = balance - 3000
WHERE account_id = 1;

-- Perform the deposit.

UPDATE accounts
SET balance = balance + 3000
WHERE account_id = 2;

-- Verify balances before committing.

SELECT *
FROM accounts
WHERE account_id IN (1, 2)
ORDER BY account_id;

-- Commit if everything is correct.

COMMIT;

-- Final verification.

SELECT *
FROM accounts
WHERE account_id IN (1, 2)
ORDER BY account_id;
