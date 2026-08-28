-- ============================================================
-- MODULE 14: CONSTRAINTS
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Student Registration
-- ============================================================
-- Design a student registration table.
--
-- Requirements:
--
-- student_id → automatically generated
-- first_name → required
-- last_name → required
-- email → unique
-- age → minimum 16
-- status → defaults to 'Active'
--
-- Choose and apply appropriate constraints.


-- ============================================================
-- CHALLENGE 2 — Department Relationship
-- ============================================================
-- Create a departments table and connect students to it.
--
-- Requirements:
--
-- department_id must uniquely identify departments.
-- department_name cannot be duplicated.
-- student.department_id must reference a valid department.


-- ============================================================
-- CHALLENGE 3 — Interview Question
-- ============================================================
-- What is the difference between:
--
-- PRIMARY KEY
-- UNIQUE
--
-- Explain when you would use each one.
--
-- Then demonstrate both in SQL.


-- ============================================================
-- CHALLENGE 4 — Interview Question
-- ============================================================
-- Why can a foreign key contain NULL?
--
-- Under what circumstances would you make the foreign-key
-- column NOT NULL?
--
-- Demonstrate both designs.


-- ============================================================
-- CHALLENGE 5 — Product Catalog
-- ============================================================
-- Design a products table.
--
-- Requirements:
--
-- product_id → AUTO_INCREMENT PRIMARY KEY
-- product_name → required
-- sku → unique and required
-- price → cannot be negative
-- stock → cannot be negative
-- status → defaults to 'Available'
--
-- Use appropriate constraints.


-- ============================================================
-- CHALLENGE 6 — Course Enrollment
-- ============================================================
-- Create:
--
-- students
-- courses
-- enrollments
--
-- Requirements:
--
-- A student can enroll in many courses.
-- A course can contain many students.
-- The same student cannot enroll in the same course twice.
--
-- Use foreign keys and a composite primary key.


-- ============================================================
-- CHALLENGE 7 — ON DELETE Behavior
-- ============================================================
-- Create two parent/child table examples:
--
-- Example A:
-- ON DELETE SET NULL
--
-- Example B:
-- ON DELETE CASCADE
--
-- Insert sample records and demonstrate the difference.


-- ============================================================
-- CHALLENGE 8 — Safe Business Rules
-- ============================================================
-- Create an employees table with:
--
-- employee_id
-- employee_name
-- email
-- age
-- salary
-- employment_status
--
-- Requirements:
--
-- email must be unique.
-- age must be at least 18.
-- salary cannot be negative.
-- employment_status can only be:
--
-- 'Active'
-- 'Inactive'
-- 'Terminated'
--
-- Default status should be 'Active'.


-- ============================================================
-- CHALLENGE 9 — Library Database
-- ============================================================
-- Design:
--
-- authors
-- books
--
-- Requirements:
--
-- Each author has a unique ID.
-- Author name is required.
-- ISBN must be unique.
-- Book title is required.
-- Book price cannot be negative.
-- Each book must reference a valid author.


-- ============================================================
-- CHALLENGE 10 — Interview Question
-- ============================================================
-- What is referential integrity?
--
-- Explain how a FOREIGN KEY helps maintain it.
--
-- Demonstrate an invalid foreign-key INSERT.


-- ============================================================
-- CHALLENGE 11 — Composite Key
-- ============================================================
-- Design a student_attendance table.
--
-- Requirements:
--
-- A student can have attendance for many dates.
-- A student should have only one attendance record
-- for a particular date.
--
-- Choose an appropriate primary key.


-- ============================================================
-- CHALLENGE 12 — Constraint Inspection
-- ============================================================
-- Create a table with at least four different constraints.
--
-- Then use:
--
-- SHOW CREATE TABLE
--
-- to inspect its definition.
--
-- Also query:
--
-- INFORMATION_SCHEMA.TABLE_CONSTRAINTS
--
-- to list its constraints.


-- ============================================================
-- CHALLENGE 13 — Data Validation
-- ============================================================
-- Create an orders table with:
--
-- order_id
-- customer_id
-- order_date
-- total_amount
-- status
--
-- Requirements:
--
-- total_amount >= 0
-- status must be:
-- 'Pending'
-- 'Completed'
-- 'Cancelled'
--
-- status defaults to 'Pending'.


-- ============================================================
-- CHALLENGE 14 — Constraint Debugging
-- ============================================================
-- Create a table with:
--
-- username UNIQUE
-- age CHECK (age >= 18)
--
-- Try inserting:
--
-- 1. A duplicate username.
-- 2. An age below 18.
--
-- Observe how MySQL rejects both operations.


-- ============================================================
-- CHALLENGE 15 — Interview Question
-- ============================================================
-- Explain the difference between:
--
-- NOT NULL
-- DEFAULT
--
-- Why does DEFAULT not mean NOT NULL?


-- ============================================================
-- CHALLENGE 16 — Database Design
-- ============================================================
-- Design a simple e-commerce database containing:
--
-- customers
-- products
-- orders
-- order_items
--
-- Identify:
--
-- 1. Primary keys.
-- 2. Foreign keys.
-- 3. Unique columns.
-- 4. NOT NULL columns.
-- 5. CHECK constraints.
-- 6. Default values.
--
-- You do not need to implement every business rule.


-- ============================================================
-- CHALLENGE 17 — Constraint Choice
-- ============================================================
-- For each requirement, choose the best constraint:
--
-- A. Every employee must have an ID.
-- B. Two employees cannot share an email.
-- C. Employee age cannot be below 18.
-- D. Employee status should default to 'Active'.
-- E. An order must reference an existing customer.
--
-- Write the appropriate SQL definitions.


-- ============================================================
-- CHALLENGE 18 — Cascading Risk
-- ============================================================
-- Create a parent/child relationship using ON DELETE CASCADE.
--
-- Insert:
--
-- 1 parent
-- 3 child rows
--
-- Delete the parent.
--
-- Verify what happened.
--
-- Then explain why this behavior should be used carefully.


-- ============================================================
-- CHALLENGE 19 — Real-World Constraint Design
-- ============================================================
-- Design a university student table.
--
-- Include:
--
-- student_id
-- roll_number
-- first_name
-- last_name
-- email
-- age
-- status
-- department_id
--
-- Requirements:
--
-- student_id → AUTO_INCREMENT PRIMARY KEY
-- roll_number → UNIQUE and NOT NULL
-- first_name → NOT NULL
-- last_name → NOT NULL
-- email → UNIQUE
-- age → CHECK
-- status → DEFAULT
-- department_id → FOREIGN KEY


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Build a small but realistic university database:
--
-- departments
-- students
-- courses
-- enrollments
--
-- Requirements:
--
-- 1. Every table must have an appropriate primary key.
-- 2. Required values must use NOT NULL.
-- 3. Appropriate identifiers must be UNIQUE.
-- 4. Relationships must use FOREIGN KEY.
-- 5. Invalid numeric values must be prevented with CHECK.
-- 6. Sensible values should use DEFAULT.
-- 7. Enrollment must prevent duplicate
--    student/course combinations.
-- 8. Use meaningful constraint names where appropriate.
-- 9. Inspect the resulting tables using SHOW CREATE TABLE.
--
-- Treat this as a portfolio-quality database design exercise.
