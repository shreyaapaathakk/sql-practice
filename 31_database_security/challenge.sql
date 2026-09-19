/*
============================================================
Module 31: Database Security & Access Control
File: challenge.sql
Dialect: MySQL 8.0+

Portfolio Challenge:
Design a Least-Privilege Employee Reporting System

IMPORTANT:
- Educational environment only.
- Never use real passwords.
- Do not commit production credentials.
- Some statements require administrative privileges.
============================================================
*/

CREATE DATABASE IF NOT EXISTS security_challenge;

USE security_challenge;


-- ============================================================
-- 1. Create the Business Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


-- ============================================================
-- 2. Create Sample Data
-- ============================================================

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
    ('Ananya Sharma', 'ananya@example.com', 1, 82000.00, '2023-02-10'),
    ('Rohan Mehta', 'rohan@example.com', 2, 71000.00, '2022-07-15'),
    ('Ishita Verma', 'ishita@example.com', 3, 68000.00, '2024-01-20'),
    ('Arjun Patel', 'arjun@example.com', 4, 64000.00, '2023-09-05');


-- ============================================================
-- CHALLENGE 1
-- Create a Public Employee View
-- ============================================================

/*
Create:

    employee_public_directory

It should expose only:

    employee_id
    employee_name
    department_name
    hire_date

The following must remain hidden:

    email
    salary

Join employees with departments.
*/


-- ============================================================
-- CHALLENGE 2
-- Create an HR Role
-- ============================================================

/*
Create the role:

    'hr_reporting_role'

The role should be able to SELECT from the public directory.

It should NOT receive INSERT, UPDATE, DELETE, or direct
access to the employees table.
*/


-- ============================================================
-- CHALLENGE 3
-- Create an HR Reporting User
-- ============================================================

/*
Create:

    'hr_reporting_user'@'localhost'

Use a dummy password.

Assign:

    'hr_reporting_role'

Make the role the default role.
*/


-- ============================================================
-- CHALLENGE 4
-- Create an Application Role
-- ============================================================

/*
An internal application needs to display employee directory
information.

Create:

    'employee_directory_app'

Grant only the SELECT privilege required to use the
employee_public_directory view.

Do not grant access to the base employees table.
*/


-- ============================================================
-- CHALLENGE 5
-- Create the Application User
-- ============================================================

/*
Create:

    'directory_application'@'localhost'

Assign:

    'employee_directory_app'

Make it the default role.

The application user should not have administrative
privileges.
*/


-- ============================================================
-- CHALLENGE 6
-- Controlled Salary Access
-- ============================================================

/*
The Finance department requires a controlled way to retrieve
salary information.

Create a procedure:

    get_employee_salary(IN p_employee_id INT)

The procedure should return:

    employee_id
    employee_name
    salary

Use SQL SECURITY DEFINER.

Do not grant the finance user direct SELECT access to the
entire employees table.
*/


-- ============================================================
-- CHALLENGE 7
-- Create a Finance Role
-- ============================================================

/*
Create:

    'finance_salary_role'

Grant this role EXECUTE permission on:

    get_employee_salary

Do not grant the role SELECT access to employees.
*/


-- ============================================================
-- CHALLENGE 8
-- Create the Finance User
-- ============================================================

/*
Create:

    'finance_reporter'@'localhost'

Assign:

    'finance_salary_role'

Make it the default role.

Use a dummy password.
*/


-- ============================================================
-- CHALLENGE 9
-- Audit the Security Design
-- ============================================================

/*
Write SQL statements that allow an administrator to verify:

1. The privileges of hr_reporting_user.
2. The privileges of directory_application.
3. The privileges of finance_reporter.
4. The privileges assigned to each role.
5. The currently active role for the current session.

Your audit should make it possible to identify excessive
privileges.
*/


-- ============================================================
-- CHALLENGE 10
-- Security Review
-- ============================================================

/*
Review your implementation and verify that:

- HR can access only public employee information.
- The application cannot directly query employees.
- Salary information is available only through the controlled
  procedure.
- Finance has EXECUTE permission rather than broad table access.
- No application role has administrative privileges.
- No user has GRANT OPTION unless there is a documented need.
- No real credentials appear anywhere in this file.

Write comments explaining how your design follows the
principle of least privilege.
*/


-- ============================================================
-- CHALLENGE 11
-- Account Lifecycle
-- ============================================================

/*
Demonstrate an account lifecycle for a temporary reporting
user named:

    'temporary_reporter'@'localhost'

Perform the following:

1. Create the account.
2. Give it access through an appropriate role.
3. Lock the account when access is temporarily suspended.
4. Unlock it.
5. Change its password using a dummy password.
6. Remove the account when it is no longer needed.

Do not use DROP USER until the final lifecycle step.
*/


-- ============================================================
-- CHALLENGE 12
-- Final Portfolio Security Architecture
-- ============================================================

/*
Design the following security architecture:

                    +----------------------+
                    |   employees table    |
                    |----------------------|
                    | salary               |
                    | email                |
                    | other sensitive data |
                    +----------+-----------+
                               |
                               |
                    +----------v-----------+
                    |  Security View       |
                    |-----------------------|
                    | public employee data  |
                    +----------+-----------+
                               |
                +--------------+--------------+
                |                             |
        +-------v-------+             +-------v-------+
        | HR Role       |             | App Role      |
        +-------+-------+             +-------+-------+
                |                             |
        +-------v-------+             +-------v-------+
        | HR User       |             | App User      |
        +---------------+             +---------------+

Finance should use a controlled stored procedure for salary
access rather than direct table access.

Implement this architecture using:

- Users
- Roles
- Grants
- Security views
- Stored procedures
- EXECUTE privilege
- Default roles
- Least privilege

Use only dummy credentials.

The final result should demonstrate a realistic,
portfolio-worthy MySQL security design.
*/
