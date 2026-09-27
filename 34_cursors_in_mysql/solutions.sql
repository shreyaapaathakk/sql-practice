/*
File: 34_cursors_in_mysql/solutions.sql
Module 34: Cursors in MySQL

Contains solutions for all four practice tasks.
Requires practice_employees from practice.sql.
*/

-- ============================================================
-- SOLUTION 1: BASIC CURSOR
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_list_employees;

DELIMITER $$

CREATE PROCEDURE sp_practice_list_employees()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);

    DECLARE employee_cursor CURSOR FOR
        SELECT employee_id, employee_name
        FROM practice_employees
        ORDER BY employee_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN employee_cursor;

    employee_loop: LOOP
        FETCH employee_cursor
        INTO v_employee_id, v_employee_name;

        IF v_done THEN
            LEAVE employee_loop;
        END IF;

        SELECT
            v_employee_id AS employee_id,
            v_employee_name AS employee_name;
    END LOOP;

    CLOSE employee_cursor;
END$$

DELIMITER ;

CALL sp_practice_list_employees();


-- ============================================================
-- SOLUTION 2: CONDITIONAL BONUS PROCESSING
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS practice_bonus_results;

CREATE TEMPORARY TABLE practice_bonus_results (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    bonus_amount DECIMAL(10, 2) NOT NULL
);

DROP PROCEDURE IF EXISTS sp_practice_calculate_bonus;

DELIMITER $$

CREATE PROCEDURE sp_practice_calculate_bonus()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10, 2);
    DECLARE v_rating INT;
    DECLARE v_bonus DECIMAL(10, 2);

    DECLARE employee_cursor CURSOR FOR
        SELECT
            employee_id,
            employee_name,
            salary,
            performance_rating
        FROM practice_employees
        ORDER BY employee_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN employee_cursor;

    employee_loop: LOOP
        FETCH employee_cursor
        INTO
            v_employee_id,
            v_employee_name,
            v_salary,
            v_rating;

        IF v_done THEN
            LEAVE employee_loop;
        END IF;

        IF v_rating >= 4 THEN
            SET v_bonus = v_salary * 0.15;
        ELSE
            SET v_bonus = v_salary * 0.05;
        END IF;

        INSERT INTO practice_bonus_results (
            employee_id,
            employee_name,
            salary,
            bonus_amount
        )
        VALUES (
            v_employee_id,
            v_employee_name,
            v_salary,
            v_bonus
        );
    END LOOP;

    CLOSE employee_cursor;
END$$

DELIMITER ;

CALL sp_practice_calculate_bonus();

SELECT *
FROM practice_bonus_results
ORDER BY employee_id;


-- ============================================================
-- SOLUTION 3: FILTERED IT CURSOR
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_it_employees;

DELIMITER $$

CREATE PROCEDURE sp_practice_it_employees()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10, 2);

    DECLARE it_cursor CURSOR FOR
        SELECT employee_id, employee_name, salary
        FROM practice_employees
        WHERE department = 'IT'
        ORDER BY salary DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = TRUE;

    OPEN it_cursor;

    employee_loop: LOOP
        FETCH it_cursor
        INTO v_employee_id, v_employee_name, v_salary;

        IF v_done THEN
            LEAVE employee_loop;
        END IF;

        SELECT
            v_employee_id AS employee_id,
            v_employee_name AS employee_name,
            v_salary AS salary;
    END LOOP;

    CLOSE it_cursor;
END$$

DELIMITER ;

CALL sp_practice_it_employees();


-- ============================================================
-- SOLUTION 4: SALARY CLASSIFICATION
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS practice_salary_categories;

CREATE TEMPORARY TABLE practice_salary_categories (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    salary_category VARCHAR(10) NOT NULL
);

DROP PROCEDURE IF EXISTS sp_practice_salary_categories;

DELIMITER $$

CREATE PROCEDURE sp_practice_salary_categories()
BEGIN
    DECLARE v_done BOOLEAN DEFAULT FALSE;
    DECLARE v_employee_id INT;
    DECLARE v_employee_name VARCHAR(100);
    DECLARE v_salary DECIMAL(10, 2);
    DECLARE v_category VARCHAR(10);

    DECLARE employee_cursor CURSOR FOR
        SELECT employee_id, employee_name, salary
        FROM practice_employees
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

        IF v_salary >= 60000.00 THEN
            SET v_category = 'High';
        ELSEIF v_salary >= 45000.00 THEN
            SET v_category = 'Medium';
        ELSE
            SET v_category = 'Low';
        END IF;

        INSERT INTO practice_salary_categories (
            employee_id,
            employee_name,
            salary_category
        )
        VALUES (
            v_employee_id,
            v_employee_name,
            v_category
        );
    END LOOP;

    CLOSE employee_cursor;
END$$

DELIMITER ;

CALL sp_practice_salary_categories();

SELECT *
FROM practice_salary_categories
ORDER BY employee_id;


-- ============================================================
-- CLEANUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_list_employees;
DROP PROCEDURE IF EXISTS sp_practice_calculate_bonus;
DROP PROCEDURE IF EXISTS sp_practice_it_employees;
DROP PROCEDURE IF EXISTS sp_practice_salary_categories;

DROP TEMPORARY TABLE IF EXISTS practice_salary_categories;
DROP TEMPORARY TABLE IF EXISTS practice_bonus_results;
DROP TEMPORARY TABLE IF EXISTS practice_employees;
