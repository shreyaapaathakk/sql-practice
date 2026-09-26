-- ============================================================
-- Module 33: Error Handling & Diagnostics in MySQL
-- File: examples.sql
-- MySQL Version: 8.0+
-- ============================================================

-- Create and select the practice database.
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;


-- ============================================================
-- EXAMPLE 1: CONTINUE HANDLER
-- A CONTINUE handler allows execution to continue after
-- the statement that raised the condition.
-- ============================================================

DROP PROCEDURE IF EXISTS example_continue_handler;

DELIMITER //

CREATE PROCEDURE example_continue_handler()
BEGIN
    DECLARE duplicate_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR 1062
        SET duplicate_found = TRUE;

    DROP TEMPORARY TABLE IF EXISTS temp_handler_demo;

    CREATE TEMPORARY TABLE temp_handler_demo (
        id INT PRIMARY KEY,
        name VARCHAR(50)
    );

    INSERT INTO temp_handler_demo (id, name)
    VALUES (1, 'Aarav');

    -- This insert raises MySQL error 1062.
    INSERT INTO temp_handler_demo (id, name)
    VALUES (1, 'Duplicate Aarav');

    -- Execution continues because the handler is CONTINUE.
    SELECT
        duplicate_found AS duplicate_was_detected;

    SELECT *
    FROM temp_handler_demo;

    DROP TEMPORARY TABLE temp_handler_demo;
END //

DELIMITER ;

CALL example_continue_handler();


-- ============================================================
-- EXAMPLE 2: EXIT HANDLER
-- An EXIT handler exits the BEGIN...END block in which
-- the handler is declared.
-- ============================================================

DROP PROCEDURE IF EXISTS example_exit_handler;

DELIMITER //

CREATE PROCEDURE example_exit_handler()
BEGIN
    DECLARE operation_status VARCHAR(100)
        DEFAULT 'Operation started';

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET operation_status = 'Operation failed';
        SELECT operation_status AS status_message;
    END;

    DROP TEMPORARY TABLE IF EXISTS temp_exit_demo;

    CREATE TEMPORARY TABLE temp_exit_demo (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_exit_demo (id)
    VALUES (1);

    -- This causes a duplicate-key error.
    INSERT INTO temp_exit_demo (id)
    VALUES (1);

    -- This statement is skipped because the EXIT handler runs.
    SELECT 'This statement will not execute' AS message;

    DROP TEMPORARY TABLE temp_exit_demo;
END //

DELIMITER ;

CALL example_exit_handler();

DROP TEMPORARY TABLE IF EXISTS temp_exit_demo;


-- ============================================================
-- EXAMPLE 3: HANDLE A MISSING ROW WITH NOT FOUND
-- SELECT ... INTO raises NOT FOUND when no row is returned.
-- ============================================================

DROP TABLE IF EXISTS employees_error_demo;

CREATE TABLE employees_error_demo (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees_error_demo
    (employee_id, employee_name, salary)
VALUES
    (1, 'Aarav Sharma', 45000.00),
    (2, 'Diya Verma', 52000.00),
    (3, 'Kabir Singh', 48000.00);


DROP PROCEDURE IF EXISTS example_not_found_handler;

DELIMITER //

CREATE PROCEDURE example_not_found_handler(
    IN p_employee_id INT
)
BEGIN
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10, 2);
    DECLARE v_employee_found BOOLEAN DEFAULT TRUE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_employee_found = FALSE;

    SELECT employee_name, salary
    INTO v_employee_name, v_salary
    FROM employees_error_demo
    WHERE employee_id = p_employee_id;

    IF v_employee_found = TRUE THEN
        SELECT
            v_employee_name AS employee_name,
            v_salary AS salary;
    ELSE
        SELECT
            'Employee not found' AS message;
    END IF;
END //

DELIMITER ;

CALL example_not_found_handler(1);
CALL example_not_found_handler(999);


-- ============================================================
-- EXAMPLE 4: SIGNAL A CUSTOM ERROR
-- SIGNAL allows a stored program to raise a user-defined
-- condition.
-- ============================================================

DROP PROCEDURE IF EXISTS example_signal_error;

DELIMITER //

CREATE PROCEDURE example_signal_error(
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Amount must be greater than zero';
    END IF;

    SELECT
        p_amount AS accepted_amount,
        'Amount accepted' AS status_message;
END //

DELIMITER ;

-- Valid input:
CALL example_signal_error(250.00);

-- Uncomment to test the custom error:
-- CALL example_signal_error(-50.00);


-- ============================================================
-- EXAMPLE 5: CAPTURE ERROR DETAILS WITH GET DIAGNOSTICS
-- Retrieve the MySQL error number, SQLSTATE, and message.
-- ============================================================

DROP TABLE IF EXISTS error_log_demo;

CREATE TABLE error_log_demo (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    error_number INT,
    sql_state CHAR(5),
    error_message TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DROP PROCEDURE IF EXISTS example_diagnostics;

DELIMITER //

CREATE PROCEDURE example_diagnostics()
BEGIN
    DECLARE v_error_number INT;
    DECLARE v_sql_state CHAR(5);
    DECLARE v_error_message TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Retrieve diagnostics before running other SQL statements.
        GET DIAGNOSTICS CONDITION 1
            v_error_number = MYSQL_ERRNO,
            v_sql_state = RETURNED_SQLSTATE,
            v_error_message = MESSAGE_TEXT;

        INSERT INTO error_log_demo (
            error_number,
            sql_state,
            error_message
        )
        VALUES (
            v_error_number,
            v_sql_state,
            v_error_message
        );

        SELECT
            v_error_number AS error_number,
            v_sql_state AS sql_state,
            v_error_message AS error_message;
    END;

    DROP TEMPORARY TABLE IF EXISTS temp_diagnostics_demo;

    CREATE TEMPORARY TABLE temp_diagnostics_demo (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_diagnostics_demo (id)
    VALUES (1);

    -- Deliberately trigger a duplicate-key error.
    INSERT INTO temp_diagnostics_demo (id)
    VALUES (1);

    DROP TEMPORARY TABLE temp_diagnostics_demo;
END //

DELIMITER ;

CALL example_diagnostics();

SELECT *
FROM error_log_demo;


-- ============================================================
-- EXAMPLE 6: ROLLBACK AND RESIGNAL
-- Roll back a transaction when an SQL exception occurs,
-- then propagate the error to the caller.
-- ============================================================

DROP TABLE IF EXISTS accounts_error_demo;

CREATE TABLE accounts_error_demo (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL
);

INSERT INTO accounts_error_demo
    (account_id, account_name, balance)
VALUES
    (1, 'Account A', 1000.00),
    (2, 'Account B', 500.00);


DROP PROCEDURE IF EXISTS example_transaction_handler;

DELIMITER //

CREATE PROCEDURE example_transaction_handler(
    IN p_from_account INT,
    IN p_to_account INT,
    IN p_amount DECIMAL(12, 2)
)
BEGIN
    DECLARE v_balance DECIMAL(12, 2);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transfer amount must be positive';
    END IF;

    START TRANSACTION;

    SELECT balance
    INTO v_balance
    FROM accounts_error_demo
    WHERE account_id = p_from_account
    FOR UPDATE;

    IF v_balance < p_amount THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient funds';
    END IF;

    UPDATE accounts_error_demo
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;

    UPDATE accounts_error_demo
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;

    COMMIT;
END //

DELIMITER ;

-- Successful transfer:
CALL example_transaction_handler(1, 2, 100.00);

SELECT *
FROM accounts_error_demo;

-- Uncomment to test rollback and error propagation:
-- CALL example_transaction_handler(1, 2, 50000.00);


-- ============================================================
-- EXAMPLE 7: DECLARE A NAMED CONDITION
-- A named condition makes error-handling code easier to read.
-- ============================================================

DROP PROCEDURE IF EXISTS example_named_condition;

DELIMITER //

CREATE PROCEDURE example_named_condition()
BEGIN
    DECLARE duplicate_key CONDITION FOR 1062;
    DECLARE v_duplicate_detected BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR duplicate_key
        SET v_duplicate_detected = TRUE;

    DROP TEMPORARY TABLE IF EXISTS temp_named_condition;

    CREATE TEMPORARY TABLE temp_named_condition (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_named_condition (id)
    VALUES (10);

    INSERT INTO temp_named_condition (id)
    VALUES (10);

    SELECT
        v_duplicate_detected AS duplicate_detected;

    DROP TEMPORARY TABLE temp_named_condition;
END //

DELIMITER ;

CALL example_named_condition();


-- ============================================================
-- EXAMPLE 8: GET DIAGNOSTICS ROW_COUNT
-- Retrieve the number of rows affected by the preceding
-- statement.
-- ============================================================

DROP PROCEDURE IF EXISTS example_row_count;

DELIMITER //

CREATE PROCEDURE example_row_count(
    IN p_raise_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_rows_updated INT DEFAULT 0;

    UPDATE employees_error_demo
    SET salary = salary + p_raise_amount
    WHERE employee_id IN (1, 2);

    GET DIAGNOSTICS v_rows_updated = ROW_COUNT;

    SELECT
        v_rows_updated AS rows_updated;
END //

DELIMITER ;

CALL example_row_count(1000.00);


-- ============================================================
-- CLEANUP
-- Uncomment these statements if you want to remove the
-- demonstration objects.
-- ============================================================

-- DROP PROCEDURE IF EXISTS example_continue_handler;
-- DROP PROCEDURE IF EXISTS example_exit_handler;
-- DROP PROCEDURE IF EXISTS example_not_found_handler;
-- DROP PROCEDURE IF EXISTS example_signal_error;
-- DROP PROCEDURE IF EXISTS example_diagnostics;
-- DROP PROCEDURE IF EXISTS example_transaction_handler;
-- DROP PROCEDURE IF EXISTS example_named_condition;
-- DROP PROCEDURE IF EXISTS example_row_count;
-- DROP TABLE IF EXISTS employees_error_demo;
-- DROP TABLE IF EXISTS error_log_demo;
-- DROP TABLE IF EXISTS accounts_error_demo;
