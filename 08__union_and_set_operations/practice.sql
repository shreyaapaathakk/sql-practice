-- ============================================================
-- MODULE 08: UNION & SET OPERATIONS
-- File: practice.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Use UNION to return all unique cities from students.


-- Exercise 2
-- Use UNION ALL to return all student cities twice.
--
-- Observe the difference between UNION and UNION ALL.


-- Exercise 3
-- Return the first names of students from Delhi and Mumbai
-- using UNION.


-- Exercise 4
-- Rewrite Exercise 3 using WHERE and IN instead of UNION.


-- Exercise 5
-- Create a result containing:
--
--   person_name
--   role
--
-- Every student should have the role 'Student'.


-- Exercise 6
-- Extend Exercise 5 to include employees.
--
-- Employees should have the role 'Employee'.


-- Exercise 7
-- Combine student names and employee names into one column
-- called person_name.
--
-- Keep duplicate names if any exist.


-- Exercise 8
-- Combine student names and employee names into one column
-- and remove duplicate rows.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
-- Create a combined result containing:
--
--   person_name
--   category
--
-- Students should have category 'Student'.
-- Employees should have category 'Employee'.
--
-- Sort the final result alphabetically by person_name.


-- Exercise 10
-- Return all cities from students and departments from employees
-- in a single column called location_or_department.
--
-- Remove duplicates.


-- Exercise 11
-- Return:
--
--   person_id
--   person_name
--   city
--
-- for students.
--
-- Then UNION ALL employee information:
--
--   employee_id
--   employee_name
--   NULL for city.
--
-- Use compatible column aliases.


-- Exercise 12
-- Return students aged 21 or older using one SELECT.
--
-- Then UNION ALL students younger than 21.
--
-- Add a fourth column called age_group:
--
--   '21_or_older'
--   'under_21'


-- Exercise 13
-- Combine:
--
--   students from Delhi
--   students from Mumbai
--
-- into one result.
--
-- Display:
--   first_name
--   city
--
-- Use UNION.


-- Exercise 14
-- Combine students and employees into a single result with:
--
--   person_name
--   category
--
-- Use UNION ALL.


-- Exercise 15
-- Return the first three student names alphabetically
-- and combine them with the first three employee names
-- alphabetically.
--
-- Use parentheses and UNION ALL.


-- Exercise 16
-- Use UNION to return the following values as one column:
--
--   'SQL'
--   'Python'
--   'Java'
--   'SQL'
--
-- Observe which values remain after duplicate removal.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 17
-- Create a combined activity report:
--
--   person_name
--   activity
--   category
--
-- Students should show their enrolled course names
-- with category 'Student Course'.
--
-- Employees should show their department
-- with category 'Employee Department'.
--
-- Use JOINs where necessary.


-- Exercise 18
-- Create a single list containing:
--
--   student names from Delhi
--   employee names from the Technology department
--
-- Columns:
--   person_name
--   source
--
-- Use UNION ALL.


-- Exercise 19
-- Create a combined report containing:
--
--   person_name
--   location
--   category
--
-- Students should provide:
--   first_name
--   city
--   'Student'
--
-- Employees should provide:
--   employee_name
--   department
--   'Employee'
--
-- Sort the final result by person_name.


-- Exercise 20
-- Find the unique set of names that appear in both
-- students and employees.
--
-- Hint:
-- MySQL 8.0 does not provide INTERSECT in the same way
-- some other SQL databases do.
--
-- Solve this using concepts you already know.


-- Exercise 21
-- Create a result containing:
--
--   person_name
--   category
--
-- Include:
--   all students
--   all employees
--
-- Keep duplicates.


-- Exercise 22
-- Create the same result as Exercise 21,
-- but remove duplicate rows.


-- Exercise 23
-- Create a combined report containing:
--
--   person_name
--   information
--
-- For students:
--   information = city
--
-- For employees:
--   information = department
--
-- Use UNION ALL.


-- Exercise 24
-- Return the five alphabetically first people from a combined
-- student + employee list.
--
-- Display:
--   person_name
--   category
--
-- Use UNION ALL, ORDER BY, and LIMIT.


-- ============================================================
-- END OF PRACTICE
-- ============================================================
