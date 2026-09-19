/*
============================================================
Module 31: Database Security & Access Control
File: practice.sql
Dialect: MySQL 8.0+

IMPORTANT:
- Educational exercises only.
- Never use real passwords.
- Run these exercises in a dedicated MySQL environment.
- Some statements require administrative privileges.
============================================================
*/

CREATE DATABASE IF NOT EXISTS security_practice;

USE security_practice;


-- ============================================================
-- Exercise 1: Create a Read-Only User
-- ============================================================

/*
Create a user named:

    'sales_reader'@'localhost'

Use a dummy password.

Give this user SELECT access to the entire
security_practice database.
*/


-- ============================================================
-- Exercise 2: Inspect User Privileges
-- ============================================================

/*
Display all privileges granted to:

    'sales_reader'@'localhost'
*/


-- ============================================================
-- Exercise 3: Create a Table-Specific User
-- ============================================================

/*
Create:

    'department_reader'@'localhost'

Give the user SELECT access only to:

    security_practice.departments

Do not grant access to the entire database.
*/


-- ============================================================
-- Exercise 4: Revoke a Privilege
-- ============================================================

/*
Assume the following privilege was accidentally granted:

    INSERT on security_practice.employee_public

Revoke that INSERT privilege from:

    'employee_reader'@'localhost'
*/


-- ============================================================
-- Exercise 5: Create a Column-Level User
-- ============================================================

/*
Create:

    'employee_basic_reader'@'localhost'

Allow this user to SELECT only these columns from employees:

    employee_id
    employee_name
    department_id
    hire_date

The user must not receive direct SELECT access to salary.
*/


-- ============================================================
-- Exercise 6: Create a Read-Only Role
-- ============================================================

/*
Create the role:

    'hr_readonly'

Grant the role SELECT access to:

    security_practice.employees
    security_practice.departments
*/


-- ============================================================
-- Exercise 7: Assign a Role to a User
-- ============================================================

/*
Create:

    'hr_reporter'@'localhost'

Assign the 'hr_readonly' role to this user.

Make the role the user's default role.
*/


-- ============================================================
-- Exercise 8: Create an Application Role
-- ============================================================

/*
Create:

    'application_reader'

Give this role SELECT access only to:

    security_practice.employee_public

Do not grant access to employees.
*/


-- ============================================================
-- Exercise 9: Assign the Application Role
-- ============================================================

/*
Create:

    'employee_application'@'localhost'

Assign the 'application_reader' role.

Make the role the default role.
*/


-- ============================================================
-- Exercise 10: Create a Security View
-- ============================================================

/*
Create a view named:

    employee_safe_view

The view should expose:

    employee_id
    employee_name
    department_id
    hire_date

Do not expose:

    email
    salary
*/


-- ============================================================
-- Exercise 11: Grant Access to the Security View
-- ============================================================

/*
Create:

    'safe_view_user'@'localhost'

Give this user SELECT access only to:

    security_practice.employee_safe_view

Do not grant direct access to employees.
*/


-- ============================================================
-- Exercise 12: Create a Department Directory View
-- ============================================================

/*
Create a view named:

    employee_department_directory

Return:

    employee_id
    employee_name
    department_name
    hire_date

Use employees and departments.

Do not expose salary or email.
*/


-- ============================================================
-- Exercise 13: Grant View Access
-- ============================================================

/*
Create:

    'directory_reader'@'localhost'

Give this user SELECT access only to:

    security_practice.employee_department_directory
*/


-- ============================================================
-- Exercise 14: Create a Controlled Procedure
-- ============================================================

/*
Create a procedure named:

    get_public_employee_data

The procedure should return:

    employee_id
    employee_name
    department_id
    hire_date

Use SQL SECURITY DEFINER.
*/


-- ============================================================
-- Exercise 15: Grant EXECUTE
-- ============================================================

/*
Create:

    'procedure_reader'@'localhost'

Grant this user EXECUTE permission on:

    get_public_employee_data

Do not grant the user direct SELECT access to employees.
*/


-- ============================================================
-- Exercise 16: Account Locking
-- ============================================================

/*
Lock the account:

    'sales_reader'@'localhost'

Then write the statement that would unlock it.
*/


-- ============================================================
-- Exercise 17: Password Management
-- ============================================================

/*
Change the password for:

    'department_reader'@'localhost'

Use a dummy password only.
*/


-- ============================================================
-- Exercise 18: Host Restriction
-- ============================================================

/*
Create:

    'local_reporter'@'localhost'

Use a dummy password.

Explain through the SQL account definition how this account
is restricted to localhost.
*/


-- ============================================================
-- Exercise 19: Least-Privilege Design
-- ============================================================

/*
A reporting employee needs to:

    - View employee names
    - View department names
    - View hire dates
    - NOT view salaries
    - NOT modify employee records

Design a role called:

    'employee_reporting'

Use a security view rather than granting direct access
to the employees table.

Then create:

    'employee_reporter'@'localhost'

Assign the role and make it the default role.
*/


-- ============================================================
-- Exercise 20: Audit Privileges
-- ============================================================

/*
Write statements to inspect the privileges of:

    'employee_reporter'@'localhost'
    'procedure_reader'@'localhost'
    'safe_view_user'@'localhost'

Also display the currently active role for the session.
*/
