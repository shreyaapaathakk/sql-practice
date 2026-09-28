SQL

```
/*
File: 35_dynamic_sql_in_mysql/examples.sql
Module 35: Dynamic SQL in MySQL

MySQL Version: 8.0+
*/

-- ============================================================
-- SETUP: SAMPLE EMPLOYEE DATA
-- ============================================================

DROP PROCEDURE IF EXISTS sp_dynamic_employees_by_department;
DROP PROCEDURE IF EXISTS sp_dynamic_employee_sort;
DROP PROCEDURE IF EXISTS sp_dynamic_table_report;

DROP TEMPORARY TABLE IF EXISTS dynamic_employees;
DROP TEMPORARY TABLE IF EXISTS dynamic_departments;

CREATE TEMPORARY TABLE dynamic_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TEMPORARY TABLE dynamic_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO dynamic_departments
    (department_id, department_name)
VALUES
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance');

INSERT INTO dynamic_employees
    (employee_id, employee_name, department_id, salary)
VALUES
    (101, 'Aarav Sharma', 1, 65000.00),
    (102, 'Diya Verma', 2, 48000.00),
    (103, 'Kabir Singh', 1, 72000.00),
    (104, 'Anaya Gupta', 3, 58000.00),
    (105, 'Ishaan Mehta', 2, 45000.00);


-- ============================================================
-- EXAMPLE 1: BASIC PREPARED STATEMENT
-- ============================================================

SET @sql = '
    SELECT employee_id, employee_name, salary
    FROM dynamic_employees
    ORDER BY employee_id
';

PREPARE stmt_basic FROM @sql;

EXECUTE stmt_basic;

DEALLOCATE PREPARE stmt_basic;


-- ============================================================
-- EXAMPLE 2: PARAMETERIZED QUERY
-- ============================================================

SET @sql = '
    SELECT employee_id, employee_name, salary
    FROM dynamic_employees
    WHERE department_id = ?
    ORDER BY salary DESC
';

SET @department_id = 1;

PREPARE stmt_department FROM @sql;

EXECUTE stmt_department USING @department_id;

DEALLOCATE PREPARE stmt_department;


-- ============================================================
-- EXAMPLE 3: DYNAMIC SQL IN A STORED PROCEDURE
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_dynamic_employees_by_department(
    IN p_department_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        DEALLOCATE PREPARE stmt_dept;
        RESIGNAL;
    END;

    SET @dynamic_department_sql = '
        SELECT
            employee_id,
            employee_name,
            salary
        FROM dynamic_employees
        WHERE department_id = ?
        ORDER BY employee_id
    ';

    SET @dynamic_department_id = p_department_id;

    PREPARE stmt_dept FROM @dynamic_department_sql;

    EXECUTE stmt_dept USING @dynamic_department_id;

    DEALLOCATE PREPARE stmt_dept;
END$$

DELIMITER ;

CALL sp_dynamic_employees_by_department(1);
CALL sp_dynamic_employees_by_department(2);


-- ============================================================
-- EXAMPLE 4: DYNAMIC SORT COLUMN
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_dynamic_employee_sort(
    IN p_sort_column VARCHAR(30),
    IN p_sort_direction VARCHAR(4)
)
BEGIN
    DECLARE v_sort_column VARCHAR(30);
    DECLARE v_sort_direction VARCHAR(4);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        DEALLOCATE PREPARE stmt_sort;
        RESIGNAL;
    END;

    -- Allowlist the column names.
    CASE p_sort_column
        WHEN 'name' THEN
            SET v_sort_column = 'employee_name';
        WHEN 'salary' THEN
            SET v_sort_column = 'salary';
        WHEN 'id' THEN
            SET v_sort_column = 'employee_id';
        ELSE
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid sort column';
    END CASE;

    -- Validate the sort direction.
    SET v_sort_direction = UPPER(p_sort_direction);

    IF v_sort_direction NOT IN ('ASC', 'DESC') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid sort direction';
    END IF;

    SET @dynamic_sort_sql = CONCAT(
        'SELECT employee_id, employee_name, salary ',
        'FROM dynamic_employees ORDER BY ',
        v_sort_column,
        ' ',
        v_sort_direction
    );

    PREPARE stmt_sort FROM @dynamic_sort_sql;

    EXECUTE stmt_sort;

    DEALLOCATE PREPARE stmt_sort;
END$$

DELIMITER ;

CALL sp_dynamic_employee_sort('salary', 'DESC');
CALL sp_dynamic_employee_sort('name', 'ASC');


-- ============================================================
-- EXAMPLE 5: DYNAMIC TABLE SELECTION WITH AN ALLOWLIST
-- ============================================================

DELIMITER $$

CREATE PROCEDURE sp_dynamic_table_report(
    IN p_table_name VARCHAR(50)
)
BEGIN
    DECLARE v_table_name VARCHAR(50);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        DEALLOCATE PREPARE stmt_table;
        RESIGNAL;
    END;

    -- Only permit explicitly approved table names.
    CASE p_table_name
        WHEN 'dynamic_employees' THEN
            SET v_table_name = 'dynamic_employees';
        WHEN 'dynamic_departments' THEN
            SET v_table_name = 'dynamic_departments';
        ELSE
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Invalid table name';
    END CASE;

    SET @dynamic_table_sql = CONCAT(
        'SELECT * FROM ',
        v_table_name
    );

    PREPARE stmt_table FROM @dynamic_table_sql;

    EXECUTE stmt_table;

    DEALLOCATE PREPARE stmt_table;
END$$

DELIMITER ;

CALL sp_dynamic_table_report('dynamic_employees');
CALL sp_dynamic_table_report('dynamic_departments');


-- ============================================================
-- CLEANUP
-- ============================================================

DROP PROCEDURE IF EXISTS sp_dynamic_employees_by_department;
DROP PROCEDURE IF EXISTS sp_dynamic_employee_sort;
DROP PROCEDURE IF EXISTS sp_dynamic_table_report;

DROP TEMPORARY TABLE IF EXISTS dynamic_employees;
DROP TEMPORARY TABLE IF EXISTS dynamic_departments;

-- Prepared statements have already been deallocated.
-- Session variables can be cleared if desired.
SET @sql = NULL;
SET @department_id = NULL;
SET @dynamic_department_sql = NULL;
SET @dynamic_department_id = NULL;
SET @dynamic_sort_sql = NULL;
SET @dynamic_table_sql = NULL;
```
