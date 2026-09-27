/*
File: 34_cursors_in_mysql/examples.sql
Module 34: Cursors in MySQL

Purpose:
- Declare, open, fetch from, and close a cursor.
- Use a NOT FOUND handler.
- Process rows individually.
- Demonstrate conditional processing.
- Keep cursor and handler declarations in valid order.

MySQL Version: 8.0+
*/

-- ============================================================
-- EXAMPLE 1: BASIC CURSOR WITH A LOOP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_cursor_basic;

DROP TEMPORARY TABLE IF EXISTS cursor_employees;

CREATE TEMPORARY TABLE cursor_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO cursor_employees
    (employee_id, employee_name, department, salary)
VALUES
    (1, 'Aarav Sharma', 'IT', 65000.00),
    (2, 'Diya Verma', 'HR', 48000.00),
    (3, 'Kabir Singh', 'IT', 72000.00),
    (4, 'Anaya Gupta', 'Finance', 58000.00);

DELIMITER $$

CREATE PROCEDURE sp_cursor_basic()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_department VARCHAR(50);
    DECLARE v_salary DECIMAL(10, 2);

    -- Declare the cursor after variables and before handlers.
    DECLARE employee_cursor CURSOR FOR
        SELECT
            employee_id,
            employee_name,
            department,
            salary
        FROM cursor_employees
        ORDER BY employee_id;

    -- The handler signals when FETCH finds no more rows.
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN employee_cursor;

    employee_loop: LOOP
        FETCH employee_cursor
        INTO
            v_employee_id,
            v_employee_name,
            v_department,
            v_salary;

        IF v_done THEN
            LEAVE employee_loop;
        END IF;

        SELECT
            v_employee_id AS employee_id,
            v_employee_name AS employee_name,
            v_department AS department,
            v_salary AS salary;
    END LOOP;

    CLOSE employee_cursor;
END$$

DELIMITER ;

CALL sp_cursor_basic();


-- ============================================================
-- EXAMPLE 2: CURSOR WITH A WHILE-STYLE FETCH FLAG
-- ============================================================

DROP PROCEDURE IF EXISTS sp_cursor_while;

DELIMITER $$

CREATE PROCEDURE sp_cursor_while()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10, 2);

    DECLARE employee_cursor CURSOR FOR
        SELECT employee_id, employee_name, salary
        FROM cursor_employees
        ORDER BY employee_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN employee_cursor;

    FETCH employee_cursor
    INTO v_employee_id, v_employee_name, v_salary;

    WHILE v_done = FALSE DO
        SELECT
            v_employee_id AS employee_id,
            v_employee_name AS employee_name,
            v_salary AS salary;

        FETCH employee_cursor
        INTO v_employee_id, v_employee_name, v_salary;
    END WHILE;

    CLOSE employee_cursor;
END$$

DELIMITER ;

CALL sp_cursor_while();


-- ============================================================
-- EXAMPLE 3: CONDITIONAL PROCESSING
-- Give a bonus to employees whose salary is below 60000.
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS cursor_bonus_results;

CREATE TEMPORARY TABLE cursor_bonus_results (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    original_salary DECIMAL(10, 2) NOT NULL,
    bonus_amount DECIMAL(10, 2) NOT NULL,
    updated_salary DECIMAL(10, 2) NOT NULL
);

DROP PROCEDURE IF EXISTS sp_cursor_bonus;

DELIMITER $$

CREATE PROCEDURE sp_cursor_bonus()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10, 2);
    DECLARE v_bonus DECIMAL(10, 2);

    DECLARE employee_cursor CURSOR FOR
        SELECT employee_id, employee_name, salary
        FROM cursor_employees
        ORDER BY employee_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN employee_cursor;

    employee_loop: LOOP
        FETCH employee_cursor
        INTO v_employee_id, v_employee_name, v_salary;

        IF v_done THEN
            LEAVE employee_loop;
        END IF;

        IF v_salary < 60000.00 THEN
            SET v_bonus = v_salary * 0.10;
        ELSE
            SET v_bonus = 0.00;
        END IF;

        INSERT INTO cursor_bonus_results (
            employee_id,
            employee_name,
            original_salary,
            bonus_amount,
            updated_salary
        )
        VALUES (
            v_employee_id,
            v_employee_name,
            v_salary,
            v_bonus,
            v_salary + v_bonus
        );
    END LOOP;

    CLOSE employee_cursor;
END$$

DELIMITER ;

CALL sp_cursor_bonus();

SELECT *
FROM cursor_bonus_results
ORDER BY employee_id;


-- ============================================================
-- EXAMPLE 4: PROCESSING A CURSOR INTO A SUMMARY
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS cursor_department_summary;

CREATE TEMPORARY TABLE cursor_department_summary (
    department VARCHAR(50) PRIMARY KEY,
    employee_count INT NOT NULL,
    total_salary DECIMAL(12, 2) NOT NULL
);

DROP PROCEDURE IF EXISTS sp_cursor_department_summary;

DELIMITER $$

CREATE PROCEDURE sp_cursor_department_summary()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_department VARCHAR(50);
    DECLARE v_employee_count INT DEFAULT 0;
    DECLARE v_total_salary DECIMAL(12, 2) DEFAULT 0.00;

    DECLARE department_cursor CURSOR FOR
        SELECT DISTINCT department
        FROM cursor_employees
        ORDER BY department;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN department_cursor;

    department_loop: LOOP
        FETCH department_cursor INTO v_department;

        IF v_done THEN
            LEAVE department_loop;
        END IF;

        SELECT
            COUNT(*),
            COALESCE(SUM(salary), 0.00)
        INTO
            v_employee_count,
            v_total_salary
        FROM cursor_employees
        WHERE department = v_department;

        INSERT INTO cursor_department_summary (
            department,
            employee_count,
            total_salary
        )
        VALUES (
            v_department,
            v_employee_count,
            v_total_salary
        );
    END LOOP;

    CLOSE department_cursor;
END$$

DELIMITER ;

CALL sp_cursor_department_summary();

SELECT *
FROM cursor_department_summary
ORDER BY department;


-- ============================================================
-- CLEANUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_cursor_basic;
DROP PROCEDURE IF EXISTS sp_cursor_while;
DROP PROCEDURE IF EXISTS sp_cursor_bonus;
DROP PROCEDURE IF EXISTS sp_cursor_department_summary;

DROP TEMPORARY TABLE IF EXISTS cursor_department_summary;
DROP TEMPORARY TABLE IF EXISTS cursor_bonus_results;
DROP TEMPORARY TABLE IF EXISTS cursor_employees;
