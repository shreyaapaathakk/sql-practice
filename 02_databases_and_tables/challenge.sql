-- =====================================================
-- Module 02 : Databases & Tables
-- File       : challenge.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================


-- =====================================================
-- 🏆 DATABASE & TABLE CHALLENGES
-- =====================================================


-- -----------------------------------------------------
-- Challenge 1 — University Database
-- -----------------------------------------------------
-- Create a database named `university`.
--
-- Inside it, create a table named `students` with
-- appropriate data types for:
--
-- student_id
-- first_name
-- last_name
-- email
-- date_of_birth
-- course
-- enrollment_date
--
-- Choose the data types yourself.


-- -----------------------------------------------------
-- Challenge 2 — Employee Database
-- -----------------------------------------------------
-- Create a database named `company_hr`.
--
-- Create an `employees` table containing:
--
-- employee_id
-- first_name
-- last_name
-- email
-- department
-- salary
-- hire_date
--
-- Choose suitable MySQL data types.


-- -----------------------------------------------------
-- Challenge 3 — Alter the Employee Table
-- -----------------------------------------------------
-- Using your `employees` table:
--
-- 1. Add a phone_number column.
-- 2. Add a job_title column.
-- 3. Change the department column to VARCHAR(100).
-- 4. Rename phone_number to contact_number.
-- 5. Remove the job_title column.


-- -----------------------------------------------------
-- Challenge 4 — Library System
-- -----------------------------------------------------
-- Create a database named `library_system`.
--
-- Create these three tables:
--
-- books
-- members
-- borrowings
--
-- Choose appropriate columns and data types for each
-- table.
--
-- Do not worry about primary keys or foreign keys yet.
-- Those concepts will be covered in a later module.


-- -----------------------------------------------------
-- Challenge 5 — Table Investigation
-- -----------------------------------------------------
-- Choose one of your tables and use:
--
-- SHOW TABLES
-- DESCRIBE
-- SHOW CREATE TABLE
--
-- to investigate its structure.
--
-- Compare the information returned by each command.


-- =====================================================
-- 🔥 BONUS CHALLENGES
-- =====================================================

-- -----------------------------------------------------
-- Bonus 1 — Product Database
-- -----------------------------------------------------
-- Create a database called `store`.
--
-- Create a `products` table containing at least:
--
-- product_id
-- product_name
-- category
-- price
-- stock_quantity
-- description
-- created_at
--
-- Choose appropriate data types.


-- -----------------------------------------------------
-- Bonus 2 — Modify Your Design
-- -----------------------------------------------------
-- Add the following columns to your products table:
--
-- brand
-- discount_percentage
--
-- Choose suitable data types.


-- -----------------------------------------------------
-- Bonus 3 — Safe Database Creation
-- -----------------------------------------------------
-- Write commands that can safely create your database
-- and tables even if they already exist.
--
-- Use the appropriate `IF NOT EXISTS` syntax.


-- -----------------------------------------------------
-- Bonus 4 — Safe Removal
-- -----------------------------------------------------
-- Write commands that safely remove a test database
-- and test table only when they exist.
--
-- Be careful when executing DROP commands.


-- =====================================================
-- 💡 Challenge Rules
-- =====================================================

-- 1. Try to solve the challenges without opening
--    solutions.sql.
--
-- 2. Choose data types based on the kind of information
--    being stored.
--
-- 3. Use descriptive names.
--
-- 4. Test your commands in MySQL 8.0+.
--
-- 5. Be especially careful with DROP DATABASE,
--    DROP TABLE, and TRUNCATE.
--
-- 6. Remember that database design becomes more
--    important as the project grows.
