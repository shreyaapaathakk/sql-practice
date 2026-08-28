-- ============================================================
-- MODULE 14: CONSTRAINTS
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Create a table named practice_students with:
--
-- student_id INT
-- first_name VARCHAR(50)
--
-- Make student_id the PRIMARY KEY.


-- Exercise 2
-- Create a table named practice_users with:
--
-- user_id INT PRIMARY KEY
-- username VARCHAR(50) UNIQUE
-- email VARCHAR(100) UNIQUE


-- Exercise 3
-- Create a table named practice_students_required with:
--
-- student_id INT PRIMARY KEY
-- first_name VARCHAR(50) NOT NULL
-- city VARCHAR(50)
--
-- Insert one valid row.


-- Exercise 4
-- Create a table named practice_courses with:
--
-- course_id INT PRIMARY KEY
-- course_name VARCHAR(100) NOT NULL
-- status VARCHAR(20) DEFAULT 'Active'


-- Exercise 5
-- Insert a course without specifying status.
--
-- Verify that the DEFAULT value is used.


-- Exercise 6
-- Create a table named practice_exams with:
--
-- exam_id INT PRIMARY KEY
-- marks INT
--
-- Add a CHECK constraint so marks must be
-- between 0 and 100.


-- Exercise 7
-- Create a table named practice_employees with:
--
-- employee_id INT PRIMARY KEY
-- employee_name VARCHAR(100) NOT NULL
-- age INT
--
-- Add a CHECK constraint requiring age >= 18.


-- Exercise 8
-- Create a table named practice_enrollments with:
--
-- student_id INT
-- course_id INT
-- enrollment_date DATE
--
-- Make student_id + course_id a composite PRIMARY KEY.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
-- Create a departments table with:
--
-- department_id INT PRIMARY KEY
-- department_name VARCHAR(100) NOT NULL UNIQUE


-- Exercise 10
-- Create a students_constraints table with:
--
-- student_id INT PRIMARY KEY
-- first_name VARCHAR(50) NOT NULL
-- department_id INT
--
-- Add a FOREIGN KEY from department_id
-- to departments.department_id.


-- Exercise 11
-- Insert three departments.


-- Exercise 12
-- Insert students that reference valid departments.


-- Exercise 13
-- Attempt to insert a student referencing
-- a department that does not exist.
--
-- Observe the constraint violation.


-- Exercise 14
-- Create a products table with:
--
-- product_id INT PRIMARY KEY
-- product_name VARCHAR(100) NOT NULL
-- price DECIMAL(10,2)
-- quantity INT
--
-- Add constraints so:
--
-- price >= 0
-- quantity >= 0


-- Exercise 15
-- Create a users_constraints table with:
--
-- user_id INT AUTO_INCREMENT PRIMARY KEY
-- username VARCHAR(50) NOT NULL UNIQUE
-- email VARCHAR(100) UNIQUE
-- status VARCHAR(20) DEFAULT 'Active'


-- Exercise 16
-- Insert three users without specifying user_id.
--
-- Verify that MySQL generates the IDs.


-- Exercise 17
-- Add a named CHECK constraint to a table.
--
-- The constraint should ensure that a student's age
-- is at least 16.


-- Exercise 18
-- Use SHOW CREATE TABLE to inspect all constraints
-- on one of your practice tables.


-- Exercise 19
-- Query INFORMATION_SCHEMA.TABLE_CONSTRAINTS
-- to display the constraints of one practice table.


-- Exercise 20
-- Explain the difference between:
--
-- PRIMARY KEY
-- UNIQUE
--
-- Use a practical example.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21
-- Create:
--
-- departments_hard
-- students_hard
--
-- departments_hard should contain:
--
-- department_id
-- department_name
--
-- students_hard should contain:
--
-- student_id
-- first_name
-- email
-- department_id
--
-- Apply appropriate PRIMARY KEY, NOT NULL,
-- UNIQUE, and FOREIGN KEY constraints.


-- Exercise 22
-- Add a CHECK constraint to students_hard
-- requiring student_id to be greater than 0.


-- Exercise 23
-- Add a DEFAULT status column to students_hard.
--
-- The default should be:
--
-- 'Active'


-- Exercise 24
-- Create an orders table containing:
--
-- order_id
-- customer_id
-- order_date
-- total_amount
--
-- Apply appropriate constraints.
--
-- total_amount must not be negative.


-- Exercise 25
-- Create customers and orders tables.
--
-- Make orders.customer_id reference
-- customers.customer_id.


-- Exercise 26
-- Create a table using ON DELETE SET NULL.
--
-- Demonstrate the behavior by deleting
-- a referenced parent row.


-- Exercise 27
-- Create a table using ON DELETE CASCADE.
--
-- Insert related parent and child records.
--
-- Delete the parent record and observe what happens
-- to the child records.


-- Exercise 28
-- Create a table representing course enrollments.
--
-- Requirements:
--
-- A student can take many courses.
-- A course can have many students.
-- A student cannot enroll in the same course twice.
--
-- Use an appropriate composite PRIMARY KEY.


-- Exercise 29
-- Create an employee table with:
--
-- employee_id
-- employee_name
-- email
-- age
-- salary
-- status
--
-- Requirements:
--
-- employee_id → AUTO_INCREMENT PRIMARY KEY
-- employee_name → NOT NULL
-- email → UNIQUE
-- age → must be at least 18
-- salary → cannot be negative
-- status → DEFAULT 'Active'


-- Exercise 30
-- Design a table for a library system.
--
-- Include:
--
-- book_id
-- isbn
-- title
-- author
-- price
-- stock
-- status
--
-- Choose appropriate constraints for each column.
--
-- Think about which values should:
--
-- 1. be required
-- 2. be unique
-- 3. have defaults
-- 4. have valid ranges


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31
-- Create a university database design with:
--
-- departments
-- students
-- courses
-- enrollments
--
-- Apply appropriate primary keys and foreign keys.


-- Exercise 32
-- Make student email addresses unique.


-- Exercise 33
-- Prevent negative course prices.


-- Exercise 34
-- Prevent enrollment records where:
--
-- student_id = 0
-- course_id = 0


-- Exercise 35
-- Make enrollment_date default to the current date.
--
-- Use an appropriate MySQL expression.


-- Exercise 36
-- Create a status column that only accepts:
--
-- 'Active'
-- 'Inactive'
-- 'Graduated'
--
-- Use CHECK.


-- Exercise 37
-- Explain why foreign keys help prevent orphan records.


-- Exercise 38
-- Explain when ON DELETE SET NULL
-- might be preferable to ON DELETE CASCADE.


-- Exercise 39
-- Explain why ON DELETE CASCADE can be dangerous.


-- Exercise 40
-- Design a complete student table using:
--
-- AUTO_INCREMENT
-- PRIMARY KEY
-- NOT NULL
-- UNIQUE
-- DEFAULT
-- CHECK
-- FOREIGN KEY
--
-- Keep the design realistic and readable.
