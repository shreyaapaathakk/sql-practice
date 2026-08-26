-- ============================================================
-- MODULE 10: CASE EXPRESSIONS
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Age Classification
-- ============================================================
-- Create a report with:
--
-- first_name
-- age
-- classification
--
-- Rules:
--
-- 22+  → 'Senior'
-- 20-21 → 'Regular'
-- below 20 → 'Junior'


-- ============================================================
-- CHALLENGE 2 — Custom City Priority
-- ============================================================
-- Display all students.
--
-- Sort them using this priority:
--
-- Delhi
-- Mumbai
-- Jaipur
-- Pune
-- Lucknow
--
-- Use CASE rather than alphabetical sorting.


-- ============================================================
-- CHALLENGE 3 — Interview Style
-- ============================================================
-- What is the difference between:
--
-- Simple CASE
-- Searched CASE
--
-- Demonstrate both using the students table.


-- ============================================================
-- CHALLENGE 4 — Conditional Report
-- ============================================================
-- Create:
--
-- first_name
-- city
-- status
--
-- A student should be 'Priority' when:
--
-- age >= 21 AND
-- city is Delhi or Mumbai
--
-- Everyone else should be 'Normal'.


-- ============================================================
-- CHALLENGE 5 — Age Distribution
-- ============================================================
-- Count students in these categories:
--
-- Under 20
-- 20
-- 21
-- 22+
--
-- Return:
--
-- age_group
-- student_count


-- ============================================================
-- CHALLENGE 6 — Above Average
-- ============================================================
-- Display:
--
-- first_name
-- age
-- performance_group
--
-- If age is greater than the overall average age:
--
-- 'Above Average'
--
-- Otherwise:
--
-- 'Average or Below'
--
-- Use a subquery inside CASE.


-- ============================================================
-- CHALLENGE 7 — Conditional Aggregation
-- ============================================================
-- Return one row containing:
--
-- students_under_21
-- students_21_plus
--
-- Use CASE with aggregate functions.


-- ============================================================
-- CHALLENGE 8 — Multiple Categories
-- ============================================================
-- Create:
--
-- first_name
-- age_group
-- city_group
--
-- Age:
-- 21+ → 'Older'
-- under 21 → 'Younger'
--
-- City:
-- Delhi/Mumbai → 'Major'
-- otherwise → 'Other'


-- ============================================================
-- CHALLENGE 9 — Business-Style Sorting
-- ============================================================
-- Imagine Delhi is the highest-priority location.
--
-- Return students in this order:
--
-- Delhi
-- Mumbai
-- all other cities
--
-- Within each group, sort students from oldest to youngest.


-- ============================================================
-- CHALLENGE 10 — Data Quality
-- ============================================================
-- Create:
--
-- first_name
-- city
-- city_status
--
-- NULL city → 'Missing'
-- otherwise → 'Available'


-- ============================================================
-- CHALLENGE 11 — CASE + GROUP BY
-- ============================================================
-- Group students into:
--
-- 'Under 21'
-- '21+'
--
-- Return the number of students in each group.


-- ============================================================
-- CHALLENGE 12 — CASE + LIMIT
-- ============================================================
-- Create a priority system:
--
-- Delhi → 1
-- Mumbai → 2
-- Pune → 3
-- Jaipur → 4
-- Lucknow → 5
--
-- Return only the first three students according
-- to this custom priority.
--
-- If two students have the same city priority,
-- sort by age descending.


-- ============================================================
-- CHALLENGE 13 — CASE + JOIN
-- ============================================================
-- Using students and enrollments, create a report containing:
--
-- first_name
-- enrollment_status
--
-- Students with at least one enrollment:
-- 'Enrolled'
--
-- Students without an enrollment:
-- 'Not Enrolled'
--
-- Use CASE and a suitable SQL technique.


-- ============================================================
-- CHALLENGE 14 — CASE + SUBQUERY
-- ============================================================
-- Create:
--
-- first_name
-- age
-- comparison
--
-- If age is greater than the maximum age minus 2:
--
-- 'Near Maximum'
--
-- Otherwise:
--
-- 'Normal'


-- ============================================================
-- CHALLENGE 15 — Interview Style
-- ============================================================
-- Write a query that categorizes students as:
--
-- 'Delhi 21+'
-- 'Delhi Under 21'
-- 'Other City 21+'
-- 'Other City Under 21'
--
-- Use one CASE expression.


-- ============================================================
-- CHALLENGE 16 — Portfolio Challenge
-- ============================================================
-- Build a professional student summary containing:
--
-- first_name
-- last_name
-- age
-- city
-- age_group
-- city_group
-- priority
--
-- Requirements:
--
-- 1. age_group must classify students by age.
-- 2. city_group must classify cities.
-- 3. priority must use custom CASE logic.
-- 4. Sort by priority and then first_name.
--
-- Keep the query readable and well formatted.
