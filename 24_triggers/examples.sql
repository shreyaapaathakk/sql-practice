-- ============================================================
-- MODULE 24: TRIGGERS
-- examples.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS module24_triggers;

USE module24_triggers;

-- ============================================================
-- CLEANUP
-- ============================================================

DROP TRIGGER IF EXISTS after_employee_insert;
DROP TRIGGER IF EXISTS before_employee_update;
DROP TRIGGER IF EXISTS after_employee_salary_update;
DROP TRIGGER IF EXISTS before_employee_delete;
DROP TRIGGER IF EXISTS after_employee_delete;
DROP TRIGGER IF EXISTS before_product_insert;
DROP TRIGGER IF EXISTS after_customer_insert;

DROP TABLE IF EXISTS employee_delete_history;
DROP TABLE IF EXISTS employee_salary_history;
DROP TABLE IF EXISTS employee_audit;
DROP TABLE IF EXISTS customer_audit;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;

-- ============================================================
-- TABLES
-- ============================================================

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(100) NOT NULL,
salary DECIMAL(10,2) NOT NULL,
job_title VARCHAR(100) NOT NULL,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100) NOT NULL,
city VARCHAR(100)
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100) NOT NULL,
quantity INT NOT NULL,
price DECIMAL(10,2) NOT NULL
);

CREATE TABLE employee_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT NOT NULL,
action_type VARCHAR(20) NOT NULL,
action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_salary_history (
history_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT NOT NULL,
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee_delete_history (
history_id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT NOT NULL,
employee_name VARCHAR(100) NOT NULL,
salary DECIMAL(10,2),
deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
action_type VARCHAR(20) NOT NULL,
action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- DATA
-- ============================================================

INSERT INTO employees
VALUES
(101, 'Aarav Sharma', 55000, 'Developer', CURRENT_TIMESTAMP),
(102, 'Priya Singh', 72000, 'Manager', CURRENT_TIMESTAMP),
(103, 'Rohan Verma', 48000, 'Analyst', CURRENT_TIMESTAMP),
(104, 'Neha Gupta', 65000, 'Designer', CURRENT_TIMESTAMP);

INSERT INTO customers
VALUES
(1, 'Rahul', 'Delhi'),
(2, 'Priya', 'Mumbai');

INSERT INTO products
VALUES
(1, 'Keyboard', 20, 1500),
(2, 'Mouse', 50, 800),
(3, 'Monitor', 10, 12000);

-- ============================================================
-- 1. AFTER INSERT TRIGGER
-- ============================================================

DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
INSERT INTO employee_audit (
employee_id,
action_type
)
VALUES (
NEW.employee_id,
'INSERT'
);
END//

DELIMITER ;

INSERT INTO employees
VALUES
(105, 'Kavya Patel', 58000, 'Developer', CURRENT_TIMESTAMP);

SELECT *
FROM employee_audit;

-- ============================================================
-- 2. BEFORE UPDATE VALIDATION
-- ============================================================

DELIMITER //

CREATE TRIGGER before_employee_update
BEFORE UPDATE
ON employees
FOR EACH ROW
BEGIN
IF NEW.salary < 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Salary cannot be negative';
END IF;
END//

DELIMITER ;

-- Valid update:

UPDATE employees
SET salary = salary + 2000
WHERE employee_id = 101;

-- ============================================================
-- 3. AFTER UPDATE SALARY HISTORY
-- ============================================================

DELIMITER //

CREATE TRIGGER after_employee_salary_update
AFTER UPDATE
ON employees
FOR EACH ROW
BEGIN
IF OLD.salary <> NEW.salary THEN
INSERT INTO employee_salary_history (
employee_id,
old_salary,
new_salary
)
VALUES (
OLD.employee_id,
OLD.salary,
NEW.salary
);
END IF;
END//

DELIMITER ;

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 102;

SELECT *
FROM employee_salary_history;

-- ============================================================
-- 4. BEFORE DELETE
-- ============================================================

DELIMITER //

CREATE TRIGGER before_employee_delete
BEFORE DELETE
ON employees
FOR EACH ROW
BEGIN
IF OLD.employee_id = 101 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Employee 101 cannot be deleted';
END IF;
END//

DELIMITER ;

-- This would produce an error:
-- DELETE FROM employees
-- WHERE employee_id = 101;

-- ============================================================
-- 5. AFTER DELETE AUDIT
-- ============================================================

DELIMITER //

CREATE TRIGGER after_employee_delete
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
INSERT INTO employee_delete_history (
employee_id,
employee_name,
salary
)
VALUES (
OLD.employee_id,
OLD.employee_name,
OLD.salary
);
END//

DELIMITER ;

DELETE FROM employees
WHERE employee_id = 105;

SELECT *
FROM employee_delete_history;

-- ============================================================
-- 6. BEFORE INSERT VALIDATION
-- ============================================================

DELIMITER //

CREATE TRIGGER before_product_insert
BEFORE INSERT
ON products
FOR EACH ROW
BEGIN
IF NEW.quantity < 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Quantity cannot be negative';
END IF;

```
IF NEW.price < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Price cannot be negative';
END IF;
```

END//

DELIMITER ;

INSERT INTO products
VALUES
(4, 'Webcam', 15, 2500);

-- ============================================================
-- 7. AFTER CUSTOMER INSERT
-- ============================================================

DELIMITER //

CREATE TRIGGER after_customer_insert
AFTER INSERT
ON customers
FOR EACH ROW
BEGIN
INSERT INTO customer_audit (
customer_id,
action_type
)
VALUES (
NEW.customer_id,
'INSERT'
);
END//

DELIMITER ;

INSERT INTO customers
VALUES
(3, 'Aman', 'Bangalore');

SELECT *
FROM customer_audit;

-- ============================================================
-- 8. SHOW TRIGGERS
-- ============================================================

SHOW TRIGGERS;

-- ============================================================
-- 9. SHOW CREATE TRIGGER
-- ============================================================

SHOW CREATE TRIGGER after_employee_insert;

-- ============================================================
-- 10. TRANSACTION + TRIGGER
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 3000
WHERE employee_id = 103;

SELECT *
FROM employees
WHERE employee_id = 103;

SELECT *
FROM employee_salary_history
WHERE employee_id = 103
ORDER BY history_id DESC;

ROLLBACK;

-- Verify that the employee update and the trigger-generated
-- history record were rolled back together.

SELECT *
FROM employees
WHERE employee_id = 103;

SELECT *
FROM employee_salary_history
WHERE employee_id = 103
ORDER BY history_id DESC;

-- ============================================================
-- 11. OLD AND NEW DEMONSTRATION
-- ============================================================

SELECT
employee_id,
salary
FROM employees
WHERE employee_id = 102;

UPDATE employees
SET salary = 80000
WHERE employee_id = 102;

SELECT *
FROM employee_salary_history
WHERE employee_id = 102
ORDER BY history_id DESC;

-- ============================================================
-- 12. DROP TRIGGER EXAMPLE
-- ============================================================

## -- Example:

## -- DROP TRIGGER after_customer_insert;

-- Uncomment when you want to remove the trigger.

-- DROP TRIGGER after_customer_insert;

-- ============================================================
-- FINAL DATA
-- ============================================================

SELECT *
FROM employees
ORDER BY employee_id;

SELECT *
FROM employee_salary_history
ORDER BY history_id;

SELECT *
FROM employee_delete_history
ORDER BY history_id;

SELECT *
FROM products
ORDER BY product_id;

SELECT *
FROM customer_audit
ORDER BY audit_id;
