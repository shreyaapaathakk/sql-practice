/*
============================================================
Module 31: Database Security & Access Control
File: solutions.sql
Dialect: MySQL 8.0+
============================================================
*/

CREATE DATABASE IF NOT EXISTS security_practice;

USE security_practice;


-- ============================================================
-- Exercise 1: Create a Read-Only User
-- ============================================================

CREATE USER IF NOT EXISTS
    'sales_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_Sales!';

GRANT SELECT
ON security_practice.*
TO 'sales_reader'@'localhost';


-- ============================================================
-- Exercise 2: Inspect User Privileges
-- ============================================================

SHOW GRANTS
FOR 'sales_reader'@'localhost';


-- ============================================================
-- Exercise 3: Create a Table-Specific User
-- ============================================================

CREATE USER IF NOT EXISTS
    'department_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_Department!';

GRANT SELECT
ON security_practice.departments
TO 'department_reader'@'localhost';


-- ============================================================
-- Exercise 4: Revoke a Privilege
-- ============================================================

REVOKE INSERT
ON security_practice.employee_public
FROM 'employee_reader'@'localhost';


-- ============================================================
-- Exercise 5: Create a Column-Level User
-- ============================================================

CREATE USER IF NOT EXISTS
    'employee_basic_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_Basic!';

GRANT SELECT (
    employee_id,
    employee_name,
    department_id,
    hire_date
)
ON security_practice.employees
TO 'employee_basic_reader'@'localhost';


-- ============================================================
-- Exercise 6: Create a Read-Only Role
-- ============================================================

CREATE ROLE IF NOT EXISTS
    'hr_readonly';

GRANT SELECT
ON security_practice.employees
TO 'hr_readonly';

GRANT SELECT
ON security_practice.departments
TO 'hr_readonly';


-- ============================================================
-- Exercise 7: Assign a Role to a User
-- ============================================================

CREATE USER IF NOT EXISTS
    'hr_reporter'@'localhost'
IDENTIFIED BY 'ExamplePassword_HR!';

GRANT 'hr_readonly'
TO 'hr_reporter'@'localhost';

SET DEFAULT ROLE
    'hr_readonly'
TO 'hr_reporter'@'localhost';


-- ============================================================
-- Exercise 8: Create an Application Role
-- ============================================================

CREATE ROLE IF NOT EXISTS
    'application_reader';

GRANT SELECT
ON security_practice.employee_public
TO 'application_reader';


-- ============================================================
-- Exercise 9: Assign the Application Role
-- ============================================================

CREATE USER IF NOT EXISTS
    'employee_application'@'localhost'
IDENTIFIED BY 'ExamplePassword_Application!';

GRANT 'application_reader'
TO 'employee_application'@'localhost';

SET DEFAULT ROLE
    'application_reader'
TO 'employee_application'@'localhost';


-- ============================================================
-- Exercise 10: Create a Security View
-- ============================================================

CREATE OR REPLACE VIEW employee_safe_view AS
SELECT
    employee_id,
    employee_name,
    department_id,
    hire_date
FROM employees;


-- ============================================================
-- Exercise 11: Grant Access to the Security View
-- ============================================================

CREATE USER IF NOT EXISTS
    'safe_view_user'@'localhost'
IDENTIFIED BY 'ExamplePassword_SafeView!';

GRANT SELECT
ON security_practice.employee_safe_view
TO 'safe_view_user'@'localhost';


-- ============================================================
-- Exercise 12: Create a Department Directory View
-- ============================================================

CREATE OR REPLACE VIEW employee_department_directory AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.hire_date
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id;


-- ============================================================
-- Exercise 13: Grant View Access
-- ============================================================

CREATE USER IF NOT EXISTS
    'directory_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_DirectoryReader!';

GRANT SELECT
ON security_practice.employee_department_directory
TO 'directory_reader'@'localhost';


-- ============================================================
-- Exercise 14: Create a Controlled Procedure
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_public_employee_data()
SQL SECURITY DEFINER
BEGIN
    SELECT
        employee_id,
        employee_name,
        department_id,
        hire_date
    FROM employees;
END //

DELIMITER ;


-- ============================================================
-- Exercise 15: Grant EXECUTE
-- ============================================================

CREATE USER IF NOT EXISTS
    'procedure_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_ProcedureReader!';

GRANT EXECUTE
ON PROCEDURE security_practice.get_public_employee_data
TO 'procedure_reader'@'localhost';


-- ============================================================
-- Exercise 16: Account Locking
-- ============================================================

ALTER USER
    'sales_reader'@'localhost'
ACCOUNT LOCK;

ALTER USER
    'sales_reader'@'localhost'
ACCOUNT UNLOCK;


-- ============================================================
-- Exercise 17: Password Management
-- ============================================================

ALTER USER
    'department_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_Department_New!';


-- ============================================================
-- Exercise 18: Host Restriction
-- ============================================================

CREATE USER IF NOT EXISTS
    'local_reporter'@'localhost'
IDENTIFIED BY 'ExamplePassword_Local!';

/*
The '@localhost' portion restricts this account identity
to connections matching localhost.
*/


-- ============================================================
-- Exercise 19: Least-Privilege Design
-- ============================================================

CREATE OR REPLACE VIEW employee_reporting_view AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.hire_date
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id;


CREATE ROLE IF NOT EXISTS
    'employee_reporting';

GRANT SELECT
ON security_practice.employee_reporting_view
TO 'employee_reporting';


CREATE USER IF NOT EXISTS
    'employee_reporter'@'localhost'
IDENTIFIED BY 'ExamplePassword_EmployeeReport!';

GRANT 'employee_reporting'
TO 'employee_reporter'@'localhost';

SET DEFAULT ROLE
    'employee_reporting'
TO 'employee_reporter'@'localhost';


-- ============================================================
-- Exercise 20: Audit Privileges
-- ============================================================

SHOW GRANTS
FOR 'employee_reporter'@'localhost';

SHOW GRANTS
FOR 'procedure_reader'@'localhost';

SHOW GRANTS
FOR 'safe_view_user'@'localhost';

SELECT CURRENT_ROLE();
