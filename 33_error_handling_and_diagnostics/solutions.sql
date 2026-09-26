-- ============================================================
-- Module 33: Error Handling & Diagnostics in MySQL
-- File: solutions.sql
-- MySQL Version: 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;


-- ============================================================
-- EXERCISE 1: CONTINUE HANDLER
-- ============================================================

DROP PROCEDURE IF EXISTS practice_duplicate_handler;

DELIMITER //

CREATE PROCEDURE practice_duplicate_handler()
BEGIN
    DECLARE v_duplicate_detected BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR 1062
        SET v_duplicate_detected = TRUE;

    DROP TEMPORARY TABLE IF EXISTS temp_practice_duplicate;

    CREATE TEMPORARY TABLE temp_practice_duplicate (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_practice_duplicate (id)
    VALUES (1);

    INSERT INTO temp_practice_duplicate (id)
    VALUES (1);

    SELECT
        v_duplicate_detected AS duplicate_detected;

    DROP TEMPORARY TABLE temp_practice_duplicate;
END //

DELIMITER ;

CALL practice_duplicate_handler();


-- ============================================================
-- EXERCISE 2: EXIT HANDLER
-- ============================================================

DROP PROCEDURE IF EXISTS practice_exit_handler;

DELIMITER //

CREATE PROCEDURE practice_exit_handler()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT
            'An SQL exception occurred' AS error_message;
    END;

    DROP TEMPORARY TABLE IF EXISTS temp_practice_exit;

    CREATE TEMPORARY TABLE temp_practice_exit (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_practice_exit (id)
    VALUES (1);

    INSERT INTO temp_practice_exit (id)
    VALUES (1);

    -- This statement is skipped when the EXIT handler runs.
    SELECT 'This statement is skipped' AS message;

    DROP TEMPORARY TABLE temp_practice_exit;
END //

DELIMITER ;

CALL practice_exit_handler();

DROP TEMPORARY TABLE IF EXISTS temp_practice_exit;


-- ============================================================
-- EXERCISE 3: HANDLE A MISSING EMPLOYEE
-- ============================================================

DROP PROCEDURE IF EXISTS practice_find_employee;

DELIMITER //

CREATE PROCEDURE practice_find_employee(
    IN p_employee_id INT
)
BEGIN
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_employee_found BOOLEAN DEFAULT TRUE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_employee_found = FALSE;

    SELECT employee_name
    INTO v_employee_name
    FROM practice_employees
    WHERE employee_id = p_employee_id;

    IF v_employee_found THEN
        SELECT v_employee_name AS employee_name;
    ELSE
        SELECT 'Employee not found' AS message;
    END IF;
END //

DELIMITER ;

CALL practice_find_employee(1);
CALL practice_find_employee(999);


-- ============================================================
-- EXERCISE 4: RAISE A CUSTOM ERROR
-- ============================================================

DROP PROCEDURE IF EXISTS practice_validate_amount;

DELIMITER //

CREATE PROCEDURE practice_validate_amount(
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Amount must be greater than zero';
    END IF;

    SELECT
        p_amount AS accepted_amount;
END //

DELIMITER ;

CALL practice_validate_amount(100.00);

-- Uncomment to test the custom error:
-- CALL practice_validate_amount(0);


-- ============================================================
-- EXERCISE 5: LOG ERROR DIAGNOSTICS
-- ============================================================

DROP PROCEDURE IF EXISTS practice_log_duplicate;

DELIMITER //

CREATE PROCEDURE practice_log_duplicate()
BEGIN
    DECLARE v_error_number INT;
    DECLARE v_sql_state CHAR(5);
    DECLARE v_error_message TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            v_error_number = MYSQL_ERRNO,
            v_sql_state = RETURNED_SQLSTATE,
            v_error_message = MESSAGE_TEXT;

        INSERT INTO practice_error_log (
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

    DROP TEMPORARY TABLE IF EXISTS temp_practice_log;

    CREATE TEMPORARY TABLE temp_practice_log (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_practice_log (id)
    VALUES (1);

    INSERT INTO temp_practice_log (id)
    VALUES (1);

    DROP TEMPORARY TABLE temp_practice_log;
END //

DELIMITER ;

CALL practice_log_duplicate();

SELECT *
FROM practice_error_log;


-- ============================================================
-- EXERCISE 6: COUNT UPDATED ROWS
-- ============================================================

DROP PROCEDURE IF EXISTS practice_raise_salary;

DELIMITER //

CREATE PROCEDURE practice_raise_salary(
    IN p_increase DECIMAL(10, 2)
)
BEGIN
    DECLARE v_rows_updated INT DEFAULT 0;

    UPDATE practice_employees
    SET salary = salary + p_increase
    WHERE employee_id IN (1, 2);

    GET DIAGNOSTICS v_rows_updated = ROW_COUNT;

    SELECT
        v_rows_updated AS rows_updated;
END //

DELIMITER ;

CALL practice_raise_salary(1000.00);


-- ============================================================
-- EXERCISE 7: TRANSACTION ERROR HANDLING
-- ============================================================

DROP PROCEDURE IF EXISTS practice_transfer;

DELIMITER //

CREATE PROCEDURE practice_transfer(
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

    IF p_from_account = p_to_account THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Source and destination must differ';
    END IF;

    START TRANSACTION;

    SELECT balance
    INTO v_balance
    FROM practice_accounts
    WHERE account_id = p_from_account
    FOR UPDATE;

    IF v_balance < p_amount THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient funds';
    END IF;

    UPDATE practice_accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;

    UPDATE practice_accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;

    COMMIT;
END //

DELIMITER ;

-- Successful transfer:
CALL practice_transfer(1, 2, 200.00);

SELECT *
FROM practice_accounts;

-- Uncomment to test rollback and error propagation:
-- CALL practice_transfer(1, 2, 999999.00);


-- ============================================================
-- EXERCISE 8: NAMED CONDITION
-- ============================================================

DROP PROCEDURE IF EXISTS practice_named_condition;

DELIMITER //

CREATE PROCEDURE practice_named_condition()
BEGIN
    DECLARE duplicate_key CONDITION FOR 1062;
    DECLARE v_duplicate_detected BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR duplicate_key
        SET v_duplicate_detected = TRUE;

    DROP TEMPORARY TABLE IF EXISTS temp_practice_named;

    CREATE TEMPORARY TABLE temp_practice_named (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_practice_named (id)
    VALUES (5);

    INSERT INTO temp_practice_named (id)
    VALUES (5);

    SELECT
        v_duplicate_detected AS duplicate_detected;

    DROP TEMPORARY TABLE temp_practice_named;
END //

DELIMITER ;

CALL practice_named_condition();


-- ============================================================
-- EXERCISE 9: RESIGNAL
-- ============================================================

DROP PROCEDURE IF EXISTS practice_resignal;

DELIMITER //

CREATE PROCEDURE practice_resignal()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- RESIGNAL propagates the original error to the caller.
        -- Without it, the handler would consume the exception.
        RESIGNAL;
    END;

    DROP TEMPORARY TABLE IF EXISTS temp_practice_resignal;

    CREATE TEMPORARY TABLE temp_practice_resignal (
        id INT PRIMARY KEY
    );

    INSERT INTO temp_practice_resignal (id)
    VALUES (1);

    INSERT INTO temp_practice_resignal (id)
    VALUES (1);

    DROP TEMPORARY TABLE temp_practice_resignal;
END //

DELIMITER ;

-- This call raises a duplicate-key error:
-- CALL practice_resignal();


-- ============================================================
-- EXERCISE 10: INTEGRATED SAFE TRANSFER
-- ============================================================

DROP PROCEDURE IF EXISTS practice_safe_transfer;

DELIMITER //

CREATE PROCEDURE practice_safe_transfer(
    IN p_from_account INT,
    IN p_to_account INT,
    IN p_amount DECIMAL(12, 2)
)
BEGIN
    DECLARE v_from_balance DECIMAL(12, 2);
    DECLARE v_to_balance DECIMAL(12, 2);
    DECLARE v_account_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    -- Validate input before starting the transaction.
    IF p_from_account IS NULL OR p_to_account IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Account IDs cannot be NULL';
    END IF;

    IF p_from_account = p_to_account THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Source and destination must differ';
    END IF;

    IF p_amount IS NULL OR p_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transfer amount must be positive';
    END IF;

    START TRANSACTION;

    -- Lock both account rows in a consistent order to reduce
    -- the risk of deadlocks between concurrent transfers.
    SELECT COUNT(*)
    INTO v_account_count
    FROM practice_accounts
    WHERE account_id IN (p_from_account, p_to_account)
    FOR UPDATE;

    IF v_account_count <> 2 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'One or both accounts do not exist';
    END IF;

    SELECT balance
    INTO v_from_balance
    FROM practice_accounts
    WHERE account_id = p_from_account;

    SELECT balance
    INTO v_to_balance
    FROM practice_accounts
    WHERE account_id = p_to_account;

    IF v_from_balance < p_amount THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient funds';
    END IF;

    UPDATE practice_accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;

    UPDATE practice_accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;

    COMMIT;
END //

DELIMITER ;

-- Successful transfer:
CALL practice_safe_transfer(1, 3, 100.00);

SELECT *
FROM practice_accounts;

-- Uncomment to test insufficient funds:
-- CALL practice_safe_transfer(1, 3, 999999.00);

-- Uncomment to test a missing account:
-- CALL practice_safe_transfer(1, 999, 100.00);

-- Uncomment to test identical source and destination:
-- CALL practice_safe_transfer(1, 1, 100.00);
