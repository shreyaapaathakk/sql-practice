SQL

```
/*
File: 35_dynamic_sql_in_mysql/solutions.sql
Module 35: Dynamic SQL in MySQL

Requires the setup from practice.sql.
*/

-- ============================================================
-- SOLUTION 1: PARAMETERIZED FILTER
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_dynamic_filter;

DELIMITER $$

CREATE PROCEDURE sp_practice_dynamic_filter(
    IN p_department_id INT
)
BEGIN
    SET @practice_filter_sql = '
        SELECT employee_id, employee_name, salary
        FROM practice_dynamic_employees
        WHERE department_id = ?
        ORDER BY employee_id
    ';

    SET @practice_filter_department = p_department_id;

    PREPARE stmt_practice_filter
    FROM @practice_filter_sql;

    EXECUTE stmt_practice_filter
    USING @practice_filter_department;

    DEALLOCATE PREPARE stmt_practice_filter;
END$$

DELIMITER ;

CALL sp_practice_dynamic_filter(1);


-- ============================================================
-- SOLUTION 2: VALIDATED DYNAMIC SORTING
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_dynamic_sort;

DELIMITER $$

CREATE PROCEDURE sp_practice_dynamic_sort(
    IN p_sort_column VARCHAR(30),
    IN p_sort_direction VARCHAR(4)
)
BEGIN
    DECLARE v_column VARCHAR(30);
    DECLARE v_direction VARCHAR(4);

    CASE p_sort_column
        WHEN 'name' THEN
            SET v_column = 'employee_name';
        WHEN 'salary' THEN
            SET v_column = 'salary';
        WHEN 'id' THEN
            SET v_column = 'employee_id';
        ELSE
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid sort column';
    END CASE;

    SET v_direction = UPPER(p_sort_direction);

    IF v_direction NOT IN ('ASC', 'DESC') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid sort direction';
    END IF;

    SET @practice_sort_sql = CONCAT(
        'SELECT employee_id, employee_name, salary ',
        'FROM practice_dynamic_employees ORDER BY ',
        v_column, ' ', v_direction
    );

    PREPARE stmt_practice_sort
    FROM @practice_sort_sql;

    EXECUTE stmt_practice_sort;

    DEALLOCATE PREPARE stmt_practice_sort;
END$$

DELIMITER ;

CALL sp_practice_dynamic_sort('salary', 'DESC');
CALL sp_practice_dynamic_sort('name', 'ASC');


-- ============================================================
-- SOLUTION 3: DYNAMIC TABLE SELECTION
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_dynamic_table;

DELIMITER $$

CREATE PROCEDURE sp_practice_dynamic_table(
    IN p_table_name VARCHAR(50)
)
BEGIN
    DECLARE v_table_name VARCHAR(50);

    CASE p_table_name
        WHEN 'practice_dynamic_employees' THEN
            SET v_table_name = 'practice_dynamic_employees';
        WHEN 'practice_dynamic_departments' THEN
            SET v_table_name = 'practice_dynamic_departments';
        ELSE
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid table name';
    END CASE;

    SET @practice_table_sql = CONCAT(
        'SELECT * FROM ',
        v_table_name
    );

    PREPARE stmt_practice_table
    FROM @practice_table_sql;

    EXECUTE stmt_practice_table;

    DEALLOCATE PREPARE stmt_practice_table;
END$$

DELIMITER ;

CALL sp_practice_dynamic_table('practice_dynamic_employees');
CALL sp_practice_dynamic_table('practice_dynamic_departments');


-- ============================================================
-- SOLUTION 4: PARAMETERIZED UPDATE
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_dynamic_salary_update;

DELIMITER $$

CREATE PROCEDURE sp_practice_dynamic_salary_update(
    IN p_employee_id INT,
    IN p_increase DECIMAL(10, 2)
)
BEGIN
    IF p_increase IS NULL OR p_increase < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Increase must be non-negative';
    END IF;

    SET @practice_update_sql = '
        UPDATE practice_dynamic_employees
        SET salary = salary + ?
        WHERE employee_id = ?
    ';

    SET @practice_update_increase = p_increase;
    SET @practice_update_employee_id = p_employee_id;

    PREPARE stmt_practice_update
    FROM @practice_update_sql;

    EXECUTE stmt_practice_update
    USING
        @practice_update_increase,
        @practice_update_employee_id;

    DEALLOCATE PREPARE stmt_practice_update;

    SELECT employee_id, employee_name, salary
    FROM practice_dynamic_employees
    WHERE employee_id = p_employee_id;
END$$

DELIMITER ;

CALL sp_practice_dynamic_salary_update(201, 2500.00);


-- ============================================================
-- CLEANUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_practice_dynamic_filter;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_sort;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_table;
DROP PROCEDURE IF EXISTS sp_practice_dynamic_salary_update;

DROP TEMPORARY TABLE IF EXISTS practice_dynamic_employees;
DROP TEMPORARY TABLE IF EXISTS practice_dynamic_departments;

SET @practice_filter_sql = NULL;
SET @practice_filter_department = NULL;
SET @practice_sort_sql = NULL;
SET @practice_table_sql = NULL;
SET @practice_update_sql = NULL;
SET @practice_update_increase = NULL;
SET @practice_update_employee_id = NULL;
```
