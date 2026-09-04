-- ============================================================
-- MODULE 24: TRIGGERS
-- solutions.sql
-- ============================================================

USE module24_triggers;

-- ============================================================
-- Exercise 1
-- AFTER INSERT
-- ============================================================

DROP TRIGGER IF EXISTS after_employee_insert_solution;

DELIMITER //

CREATE TRIGGER after_employee_insert_solution
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

-- ============================================================
-- Exercise 2
-- Test INSERT trigger
-- ============================================================

INSERT INTO employees (
employee_id,
employee_name,
salary,
job_title
)
VALUES (
201,
'Test Employee',
50000,
'Developer'
);

-- ============================================================
-- Exercise 3
-- Verify audit
-- ============================================================

SELECT *
FROM employee_audit
WHERE employee_id = 201;

-- ============================================================
-- Exercise 4
-- Prevent negative salary
-- ============================================================

DROP TRIGGER IF EXISTS prevent_negative_salary_solution;

DELIMITER //

CREATE TRIGGER prevent_negative_salary_solution
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

-- ============================================================
-- Exercise 5
-- Valid update
-- ============================================================

UPDATE employees
SET salary = salary + 1000
WHERE employee_id = 201;

-- ============================================================
-- Exercise 6
-- Invalid update
-- ============================================================

## -- This should produce an error:

-- UPDATE employees
-- SET salary = -5000
-- WHERE employee_id = 201;

-- ============================================================
-- Exercise 7
-- Salary history trigger
-- ============================================================

DROP TRIGGER IF EXISTS salary_history_solution;

DELIMITER //

CREATE TRIGGER salary_history_solution
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

-- ============================================================
-- Exercise 8
-- Test salary history
-- ============================================================

UPDATE employees
SET salary = salary + 5000
WHERE employee_id = 201;

SELECT *
FROM employee_salary_history
WHERE employee_id = 201
ORDER BY history_id DESC;

-- ============================================================
-- Exercise 9
-- Job title only
-- ============================================================

UPDATE employees
SET job_title = 'Senior Developer'
WHERE employee_id = 201;

SELECT *
FROM employee_salary_history
WHERE employee_id = 201
ORDER BY history_id DESC;

-- ============================================================
-- Exercise 11
-- Delete history
-- ============================================================

DROP TRIGGER IF EXISTS employee_delete_history_solution;

DELIMITER //

CREATE TRIGGER employee_delete_history_solution
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

-- ============================================================
-- Exercise 12
-- Test DELETE trigger
-- ============================================================

DELETE FROM employees
WHERE employee_id = 201;

SELECT *
FROM employee_delete_history
WHERE employee_id = 201;

-- ============================================================
-- Exercise 14
-- Prevent deleting employee 101
-- ============================================================

DROP TRIGGER IF EXISTS prevent_employee_101_delete_solution;

DELIMITER //

CREATE TRIGGER prevent_employee_101_delete_solution
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

-- ============================================================
-- Exercise 15 + 16
-- Product validation
-- ============================================================

DROP TRIGGER IF EXISTS validate_product_solution;

DELIMITER //

CREATE TRIGGER validate_product_solution
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

-- ============================================================
-- Exercise 17
-- Valid product
-- ============================================================

INSERT INTO products (
product_id,
product_name,
quantity,
price
)
VALUES (
201,
'USB Hub',
20,
1200
);

-- ============================================================
-- Exercises 18 + 19
-- Invalid examples
-- ============================================================

## -- These should produce errors:

-- INSERT INTO products
-- VALUES (202, 'Invalid Quantity', -5, 1000);
----------------------------------------------

-- INSERT INTO products
-- VALUES (203, 'Invalid Price', 5, -100);

-- ============================================================
-- Exercise 20
-- Customer audit table
-- ============================================================

CREATE TABLE IF NOT EXISTS customer_audit_solution (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
action_type VARCHAR(20) NOT NULL,
action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Exercise 21
-- Customer INSERT trigger
-- ============================================================

DROP TRIGGER IF EXISTS customer_insert_solution;

DELIMITER //

CREATE TRIGGER customer_insert_solution
AFTER INSERT
ON customers
FOR EACH ROW
BEGIN
INSERT INTO customer_audit_solution (
customer_id,
action_type
)
VALUES (
NEW.customer_id,
'INSERT'
);
END//

DELIMITER ;

-- ============================================================
-- Exercise 22
-- Customer UPDATE trigger
-- ============================================================

DROP TRIGGER IF EXISTS customer_update_solution;

DELIMITER //

CREATE TRIGGER customer_update_solution
AFTER UPDATE
ON customers
FOR EACH ROW
BEGIN
INSERT INTO customer_audit_solution (
customer_id,
action_type
)
VALUES (
NEW.customer_id,
'UPDATE'
);
END//

DELIMITER ;

-- ============================================================
-- Exercise 23
-- Customer DELETE trigger
-- ============================================================

DROP TRIGGER IF EXISTS customer_delete_solution;

DELIMITER //

CREATE TRIGGER customer_delete_solution
AFTER DELETE
ON customers
FOR EACH ROW
BEGIN
INSERT INTO customer_audit_solution (
customer_id,
action_type
)
VALUES (
OLD.customer_id,
'DELETE'
);
END//

DELIMITER ;

-- ============================================================
-- Exercise 24
-- Test all customer triggers
-- ============================================================

INSERT INTO customers (
customer_id,
customer_name,
city
)
VALUES (
201,
'Test Customer',
'Delhi'
);

UPDATE customers
SET city = 'Mumbai'
WHERE customer_id = 201;

DELETE FROM customers
WHERE customer_id = 201;

SELECT *
FROM customer_audit_solution
WHERE customer_id = 201
ORDER BY audit_id;

-- ============================================================
-- Exercise 26
-- BEFORE / AFTER decisions
-- ============================================================

-- A. Reject negative salary
--    → BEFORE UPDATE
---------------------

-- B. Record completed salary change
--    → AFTER UPDATE
--------------------

-- C. Store deleted employee
--    → AFTER DELETE
--------------------

-- D. Modify incoming value
--    → BEFORE INSERT
---------------------

-- E. Create audit record after insert
--    → AFTER INSERT

-- ============================================================
-- Exercise 27
-- Multiple statements
-- ============================================================

DROP TRIGGER IF EXISTS multiple_statement_solution;

DELIMITER //

CREATE TRIGGER multiple_statement_solution
AFTER INSERT
ON products
FOR EACH ROW
BEGIN
INSERT INTO employee_audit (
employee_id,
action_type
)
VALUES (
0,
'PRODUCT INSERT'
);
END//

DELIMITER ;

-- ============================================================
-- Exercise 29 + 30
-- SIGNAL validation
-- ============================================================

-- Already demonstrated in validate_product_solution.

-- ============================================================
-- Exercise 32
-- Show all triggers
-- ============================================================

SHOW TRIGGERS;

-- ============================================================
-- Exercise 33
-- Show trigger definition
-- ============================================================

SHOW CREATE TRIGGER salary_history_solution;

-- ============================================================
-- Exercise 34
-- Drop a trigger
-- ============================================================

## -- Example:

-- DROP TRIGGER multiple_statement_solution;

-- ============================================================
-- Exercise 35
-- Recreate trigger
-- ============================================================

## -- Example:

## -- DELIMITER //

-- CREATE TRIGGER multiple_statement_solution
-- AFTER INSERT
-- ON products
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO employee_audit (
--         employee_id,
--         action_type
--     )
--     VALUES (
--         0,
--         'PRODUCT INSERT'
--     );
-- END//
--------

-- DELIMITER ;

-- ============================================================
-- Exercise 36
-- Transaction + trigger
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 3000
WHERE employee_id = 102;

SELECT *
FROM employees
WHERE employee_id = 102;

SELECT *
FROM employee_salary_history
WHERE employee_id = 102
ORDER BY history_id DESC;

ROLLBACK;

-- The trigger-generated history operation participates in
-- the transaction and should be rolled back with the update.

-- ============================================================
-- Exercise 37
-- Commit version
-- ============================================================

START TRANSACTION;

UPDATE employees
SET salary = salary + 3000
WHERE employee_id = 103;

COMMIT;

SELECT *
FROM employee_salary_history
WHERE employee_id = 103
ORDER BY history_id DESC;

-- ============================================================
-- FINAL VERIFICATION
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
FROM customer_audit_solution
ORDER BY audit_id;
