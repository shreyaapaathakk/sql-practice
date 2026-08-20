-- =====================================================
-- Module 02 : Databases & Tables
-- File       : examples.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

-- =====================================================
-- 1. Create a Database
-- =====================================================

CREATE DATABASE IF NOT EXISTS company;

-- Select the database
USE company;


-- =====================================================
-- 2. Check Current Database
-- =====================================================

SELECT DATABASE();


-- =====================================================
-- 3. View All Databases
-- =====================================================

SHOW DATABASES;


-- =====================================================
-- 4. Create an Employees Table
-- =====================================================

CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2),
    hire_date DATE
);


-- =====================================================
-- 5. View Tables
-- =====================================================

SHOW TABLES;


-- =====================================================
-- 6. View Table Structure
-- =====================================================

DESCRIBE employees;


-- Short form
DESC employees;


-- =====================================================
-- 7. View Complete Table Definition
-- =====================================================

SHOW CREATE TABLE employees;


-- =====================================================
-- 8. Add a Column
-- =====================================================

ALTER TABLE employees
ADD email VARCHAR(100);


-- Check the new structure
DESCRIBE employees;


-- =====================================================
-- 9. Add Multiple Columns
-- =====================================================

ALTER TABLE employees
ADD phone VARCHAR(20),
ADD department VARCHAR(50);


-- =====================================================
-- 10. Modify a Column
-- =====================================================

ALTER TABLE employees
MODIFY COLUMN first_name VARCHAR(100);


-- =====================================================
-- 11. Rename a Column
-- =====================================================

ALTER TABLE employees
RENAME COLUMN phone TO phone_number;


-- =====================================================
-- 12. Remove a Column
-- =====================================================

ALTER TABLE employees
DROP COLUMN phone_number;


-- =====================================================
-- 13. Rename a Table
-- =====================================================

RENAME TABLE employees TO staff;


-- View tables
SHOW TABLES;


-- Rename it back
ALTER TABLE staff
RENAME TO employees;


-- =====================================================
-- 14. Create a Second Table
-- =====================================================

CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(100),
    location VARCHAR(100)
);


-- =====================================================
-- 15. View All Tables
-- =====================================================

SHOW TABLES;


-- =====================================================
-- 16. Create a Temporary Table
-- =====================================================

CREATE TEMPORARY TABLE temporary_employees (
    employee_id INT,
    employee_name VARCHAR(100)
);


-- View tables
SHOW TABLES;


-- =====================================================
-- 17. TRUNCATE TABLE
-- =====================================================

-- TRUNCATE removes all records but keeps the table.
--
-- This example is intentionally commented out because
-- there is currently no data that needs to be removed.
--
-- TRUNCATE TABLE employees;


-- =====================================================
-- 18. DROP TABLE
-- =====================================================

-- DROP permanently removes a table.
--
-- This example is intentionally commented out.
--
-- DROP TABLE departments;


-- =====================================================
-- 19. DROP DATABASE
-- =====================================================

-- DROP DATABASE permanently removes the database
-- and all tables inside it.
--
-- This example is intentionally commented out.
--
-- DROP DATABASE company;
