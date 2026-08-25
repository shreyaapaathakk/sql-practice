-- ============================================================
-- MODULE 08: UNION & SET OPERATIONS
-- File: challenge.sql
-- Database: school
-- MySQL 8.0+
--
-- These challenges are intentionally different from
-- practice.sql.
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Basic UNION
-- ============================================================
-- Create a unique list containing:
--
--   all student cities
--   all employee departments
--
-- Return one column called:
--
--   location_or_department


-- ============================================================
-- CHALLENGE 2 — UNION ALL
-- ============================================================
-- Create a combined list of student names and employee names.
--
-- Keep duplicate names.
--
-- Return:
--
--   person_name
--   category


-- ============================================================
-- CHALLENGE 3 — Interview Question
-- ============================================================
-- Explain through SQL the practical difference between:
--
--   UNION
--   UNION ALL
--
-- Use a small query that demonstrates the difference.


-- ============================================================
-- CHALLENGE 4 — Combined Directory
-- ============================================================
-- Create a school directory containing:
--
--   person_name
--   location
--   type
--
-- Students:
--   first_name
--   city
--   'Student'
--
-- Employees:
--   employee_name
--   department
--   'Employee'


-- ============================================================
-- CHALLENGE 5 — Filtered Directory
-- ============================================================
-- Create a combined list containing:
--
--   students from Delhi
--   employees from Technology
--
-- Return:
--
--   person_name
--   source


-- ============================================================
-- CHALLENGE 6 — UNION + JOIN
-- ============================================================
-- Create a report containing:
--
--   person_name
--   activity
--
-- For students:
--   activity should be their course name.
--
-- For employees:
--   activity should be their department.


-- ============================================================
-- CHALLENGE 7 — Interview Question
-- ============================================================
-- Return the five alphabetically first names from a combined
-- student and employee list.
--
-- Display:
--
--   person_name
--
-- Keep duplicate names.


-- ============================================================
-- CHALLENGE 8 — Remove Duplicates
-- ============================================================
-- Modify Challenge 7 so duplicate person_name values
-- appear only once.


-- ============================================================
-- CHALLENGE 9 — Same Name
-- ============================================================
-- Find names that exist in both the students and employees
-- tables.
--
-- Return each matching name once.
--
-- Do not use INTERSECT.


-- ============================================================
-- CHALLENGE 10 — Two Sources
-- ============================================================
-- Create a result containing:
--
--   name
--   source
--
-- Include students from:
--   Delhi
--   Pune
--
-- Include employees from:
--   Technology
--   Marketing
--
-- Use UNION ALL.


-- ============================================================
-- CHALLENGE 11 — Category Counts
-- ============================================================
-- Create a combined result of students and employees with:
--
--   person_name
--   category
--
-- Then determine how many records belong to each category.
--
-- Hint:
-- You may need to use a UNION as a derived result.
--
-- Do not use concepts that have not yet been studied.


-- ============================================================
-- CHALLENGE 12 — UNION With NULL
-- ============================================================
-- Create:
--
--   person_id
--   person_name
--   city
--   category
--
-- Students should contain their city.
--
-- Employees should contain NULL for city.


-- ============================================================
-- CHALLENGE 13 — Student Activity
-- ============================================================
-- Create a combined activity report containing:
--
--   person_name
--   activity
--   source
--
-- Students:
--   activity = course_name
--   source = 'Course'
--
-- Employees:
--   activity = department
--   source = 'Department'


-- ============================================================
-- CHALLENGE 14 — Interview Question
-- ============================================================
-- Which is more appropriate for combining January and February
-- sales records:
--
--   UNION
--   UNION ALL
--
-- Write a short SQL example demonstrating your choice.
--
-- You may use hypothetical table names such as:
--
--   sales_january
--   sales_february


-- ============================================================
-- CHALLENGE 15 — Real-World Reporting
-- ============================================================
-- Build a combined people report containing:
--
--   person_name
--   location
--   role
--
-- Students should be classified as:
--   'Student'
--
-- Employees should be classified as:
--   'Employee'
--
-- Sort alphabetically by person_name.


-- ============================================================
-- CHALLENGE 16 — UNION Reasoning
-- ============================================================
-- Consider the following two queries:
--
-- Query A:
--
-- SELECT first_name, city
-- FROM students;
--
-- Query B:
--
-- SELECT employee_name
-- FROM employees;
--
-- Can these queries be combined directly with UNION?
--
-- If not, explain why and write a corrected version.


-- ============================================================
-- CHALLENGE 17 — UNION vs IN
-- ============================================================
-- Write two versions of a query that finds students
-- from Delhi and Mumbai:
--
-- Version 1:
--   using UNION
--
-- Version 2:
--   using IN
--
-- Compare which query is simpler.


-- ============================================================
-- CHALLENGE 18 — Advanced Reporting
-- ============================================================
-- Create one result containing:
--
--   person_name
--   information
--   category
--
-- Students:
--   information = their city
--   category = 'Student'
--
-- Employees:
--   information = their department
--   category = 'Employee'
--
-- Keep every row.


-- ============================================================
-- CHALLENGE 19 — Final Result Control
-- ============================================================
-- Create a combined student + employee directory.
--
-- Requirements:
--
-- 1. Use UNION ALL.
-- 2. Return person_name and category.
-- 3. Sort alphabetically by person_name.
-- 4. Return only the first 8 rows.


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Build a school-wide activity report.
--
-- The final result should contain:
--
--   person_name
--   activity
--   category
--
-- Students should appear with their enrolled courses.
--
-- Employees should appear with their departments.
--
-- Requirements:
--
-- 1. Use UNION ALL.
-- 2. Use JOINs where necessary.
-- 3. Use meaningful aliases.
-- 4. Sort by person_name.
-- 5. Keep the query readable and professional.


-- ============================================================
-- END OF CHALLENGES
-- ============================================================
