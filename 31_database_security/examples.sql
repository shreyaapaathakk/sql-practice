/*
============================================================
Module 31: Database Security & Access Control
File: examples.sql
Dialect: MySQL 8.0+
============================================================

IMPORTANT:
- These examples are educational.
- Run them in a dedicated MySQL learning environment.
- Never use real passwords in a GitHub repository.
- Replace example passwords with secure credentials when
  testing locally.
- Administrative privileges may be required for many
  statements in this file.
*/

-- ============================================================
-- 1. Create a Dedicated Practice Database
-- ============================================================

CREATE DATABASE IF NOT EXISTS security_practice;

USE security_practice;


-- ============================================================
-- 2. Create Sample Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    department_id INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

CREATE TABLE IF NOT EXISTS employee_public (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    hire_date DATE
);

INSERT INTO departments (department_name)
VALUES
    ('Engineering'),
    ('Finance'),
    ('Human Resources'),
    ('Sales')
ON DUPLICATE KEY UPDATE
    department_name = VALUES(department_name);

INSERT INTO employees (
    employee_name,
    email,
    department_id,
    salary,
    hire_date
)
VALUES
    ('Aarav Sharma', 'aarav@example.com', 1, 75000.00, '2024-01-15'),
    ('Diya Singh', 'diya@example.com', 2, 68000.00, '2023-06-10'),
    ('Kabir Verma', 'kabir@example.com', 3, 62000.00, '2022-09-20'),
    ('Meera Patel', 'meera@example.com', 4, 59000.00, '2024-03-05');


-- ============================================================
-- 3. Create a User
-- ============================================================

/*
The account identity is:

    'username'@'host'

The host controls where the account may connect from.
*/

CREATE USER IF NOT EXISTS
    'report_user'@'localhost'
IDENTIFIED BY 'ExamplePassword_123!';


-- ============================================================
-- 4. Grant Database-Level Privileges
-- ============================================================

/*
This gives the user SELECT access to every table in the
security_practice database.
*/

GRANT SELECT
ON security_practice.*
TO 'report_user'@'localhost';


-- ============================================================
-- 5. Grant Table-Level Privileges
-- ============================================================

CREATE USER IF NOT EXISTS
    'employee_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_456!';

GRANT SELECT
ON security_practice.employees
TO 'employee_reader'@'localhost';


-- ============================================================
-- 6. Grant Different Privileges on Different Tables
-- ============================================================

GRANT SELECT
ON security_practice.departments
TO 'employee_reader'@'localhost';

GRANT SELECT, INSERT
ON security_practice.employee_public
TO 'employee_reader'@'localhost';


-- ============================================================
-- 7. Grant Column-Level Privileges
-- ============================================================

CREATE USER IF NOT EXISTS
    'limited_reader'@'localhost'
IDENTIFIED BY 'ExamplePassword_789!';

/*
This user can read employee names and departments but cannot
directly read sensitive columns such as salary or email.
*/

GRANT SELECT (
    employee_id,
    employee_name,
    department_id
)
ON security_practice.employees
TO 'limited_reader'@'localhost';


-- ============================================================
-- 8. Inspect User Privileges
-- ============================================================

SHOW GRANTS
FOR 'report_user'@'localhost';

SHOW GRANTS
FOR 'employee_reader'@'localhost';

SHOW GRANTS
FOR 'limited_reader'@'localhost';


-- ============================================================
-- 9. Revoke a Privilege
-- ============================================================

REVOKE INSERT
ON security_practice.employee_public
FROM 'employee_reader'@'localhost';


-- ============================================================
-- 10. Create a Read-Only Role
-- ============================================================

CREATE ROLE IF NOT EXISTS
    'security_readonly';


-- ============================================================
-- 11. Grant Privileges to a Role
-- ============================================================

GRANT SELECT
ON security_practice.*
TO 'security_readonly';


-- ============================================================
-- 12. Create a Reporting User
-- ============================================================

CREATE USER IF NOT EXISTS
    'reporting_user'@'localhost'
IDENTIFIED BY 'ExamplePassword_Reporting!';


-- ============================================================
-- 13. Grant a Role to a User
-- ============================================================

GRANT 'security_readonly'
TO 'reporting_user'@'localhost';


-- ============================================================
-- 14. Set a Default Role
-- ============================================================

SET DEFAULT ROLE
    'security_readonly'
TO 'reporting_user'@'localhost';


-- ============================================================
-- 15. Inspect Role Grants
-- ============================================================

SHOW GRANTS
FOR 'security_readonly';

SHOW GRANTS
FOR 'reporting_user'@'localhost';


-- ============================================================
-- 16. Create an Application Role
-- ============================================================

CREATE ROLE IF NOT EXISTS
    'employee_app_role';


-- ============================================================
-- 17. Give an Application Role Limited Access
-- ============================================================

/*
The application role receives only the privileges needed to
read public employee information.
*/

GRANT SELECT
ON security_practice.employee_public
TO 'employee_app_role';


-- ============================================================
-- 18. Create an Application User
-- ============================================================

CREATE USER IF NOT EXISTS
    'employee_app'@'localhost'
IDENTIFIED BY 'ExamplePassword_App!';


GRANT 'employee_app_role'
TO 'employee_app'@'localhost';

SET DEFAULT ROLE
    'employee_app_role'
TO 'employee_app'@'localhost';


-- ============================================================
-- 19. Create a Security View
-- ============================================================

/*
Instead of allowing users to query the employees table
directly, expose only the information they need.
*/

CREATE OR REPLACE VIEW employee_directory AS
SELECT
    employee_id,
    employee_name,
    department_id,
    hire_date
FROM employees;


-- ============================================================
-- 20. Grant Access to the Security View
-- ============================================================

CREATE USER IF NOT EXISTS
    'directory_user'@'localhost'
IDENTIFIED BY 'ExamplePassword_Directory!';

GRANT SELECT
ON security_practice.employee_directory
TO 'directory_user'@'localhost';


-- ============================================================
-- 21. Create a View That Hides Sensitive Columns
-- ============================================================

CREATE OR REPLACE VIEW employee_directory_with_department AS
SELECT
    e.employee_id,
    e.employee_name,
    d.department_name,
    e.hire_date
FROM employees AS e
JOIN departments AS d
    ON e.department_id = d.department_id;


-- ============================================================
-- 22. Grant View Access Instead of Base-Table Access
-- ============================================================

CREATE USER IF NOT EXISTS
    'directory_viewer'@'localhost'
IDENTIFIED BY 'ExamplePassword_View!';

GRANT SELECT
ON security_practice.employee_directory_with_department
TO 'directory_viewer'@'localhost';


-- ============================================================
-- 23. Create a Procedure for Controlled Access
-- ============================================================

DELIMITER //

CREATE PROCEDURE get_employee_directory()
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
-- 24. Grant EXECUTE Without Granting Table Access
-- ============================================================

CREATE USER IF NOT EXISTS
    'procedure_user'@'localhost'
IDENTIFIED BY 'ExamplePassword_Procedure!';

GRANT EXECUTE
ON PROCEDURE security_practice.get_employee_directory
TO 'procedure_user'@'localhost';


-- ============================================================
-- 25. Check the Current Active Role
-- ============================================================

/*
When executed in a session with an appropriate role,
CURRENT_ROLE() shows the active role(s).
*/

SELECT CURRENT_ROLE();


-- ============================================================
-- 26. Change a User's Password
-- ============================================================

ALTER USER
    'report_user'@'localhost'
IDENTIFIED BY 'ExamplePassword_New!';


-- ============================================================
-- 27. Lock and Unlock an Account
-- ============================================================

ALTER USER
    'report_user'@'localhost'
ACCOUNT LOCK;

ALTER USER
    'report_user'@'localhost'
ACCOUNT UNLOCK;


-- ============================================================
-- 28. Restrict an Account to a Specific Host
-- ============================================================

/*
This creates an account that can connect only from localhost.
*/

CREATE USER IF NOT EXISTS
    'local_admin'@'localhost'
IDENTIFIED BY 'ExamplePassword_Admin!';


-- ============================================================
-- 29. Remove a User's Privileges
-- ============================================================

REVOKE SELECT
ON security_practice.*
FROM 'report_user'@'localhost';


-- ============================================================
-- 30. Drop a User
-- ============================================================

/*
Only run this when the account is no longer needed.
*/

-- DROP USER 'local_admin'@'localhost';


-- ============================================================
-- 31. Drop a Role
-- ============================================================

/*
Only run this when the role is no longer needed.

-- DROP ROLE 'employee_app_role';
*/


-- ============================================================
-- 32. Security Audit Queries
-- ============================================================

/*
List accounts visible to the current administrative user.
*/

SELECT
    User,
    Host,
    account_locked
FROM mysql.user;


/*
Inspect privileges for an individual account.
*/

SHOW GRANTS
FOR 'procedure_user'@'localhost';


-- ============================================================
-- 33. Least-Privilege Example
-- ============================================================

CREATE ROLE IF NOT EXISTS
    'employee_reporting_role';

GRANT SELECT
ON security_practice.employee_directory_with_department
TO 'employee_reporting_role';

CREATE USER IF NOT EXISTS
    'employee_reporter'@'localhost'
IDENTIFIED BY 'ExamplePassword_Report!';

GRANT 'employee_reporting_role'
TO 'employee_reporter'@'localhost';

SET DEFAULT ROLE
    'employee_reporting_role'
TO 'employee_reporter'@'localhost';


-- ============================================================
-- 34. Cleanup Notes
-- ============================================================

/*
The following statements are intentionally commented out.

Use them only if you want to remove the educational accounts
after completing the exercises.

-- DROP USER 'report_user'@'localhost';
-- DROP USER 'employee_reader'@'localhost';
-- DROP USER 'limited_reader'@'localhost';
-- DROP USER 'reporting_user'@'localhost';
-- DROP USER 'employee_app'@'localhost';
-- DROP USER 'directory_user'@'localhost';
-- DROP USER 'directory_viewer'@'localhost';
-- DROP USER 'procedure_user'@'localhost';
-- DROP USER 'employee_reporter'@'localhost';
-- DROP USER 'local_admin'@'localhost';

-- DROP ROLE 'security_readonly';
-- DROP ROLE 'employee_app_role';
-- DROP ROLE 'employee_reporting_role';
*/
