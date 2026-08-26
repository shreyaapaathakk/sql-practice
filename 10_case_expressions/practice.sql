-- ============================================================
-- MODULE 10: CASE EXPRESSIONS
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Display first_name, age, and a new column called age_group.
--
-- age >= 21 → '21+'
-- otherwise → 'Under 21'


-- Exercise 2
-- Display first_name, city, and a new column called
-- city_type.
--
-- Delhi or Mumbai → 'Major City'
-- otherwise → 'Other City'


-- Exercise 3
-- Create a column called age_status.
--
-- age > 20  → 'Above 20'
-- age = 20  → 'Exactly 20'
-- age < 20  → 'Below 20'


-- Exercise 4
-- Use a simple CASE expression to classify cities:
--
-- Delhi  → 'North'
-- Mumbai → 'West'
-- Pune   → 'West'
-- Jaipur → 'North'
-- everything else → 'Other'


-- Exercise 5
-- Create an age_range column:
--
-- 19-20 → '19-20'
-- 21-22 → '21-22'
-- otherwise → 'Other'


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 6
-- Create a student_level column:
--
-- age >= 22 → 'Level 3'
-- age >= 20 → 'Level 2'
-- otherwise → 'Level 1'
--
-- Be careful about the order of conditions.


-- Exercise 7
-- Display students with:
--
-- first_name
-- city
-- region
--
-- Delhi and Jaipur → 'North'
-- Mumbai and Pune → 'West'
-- Lucknow → 'Central'


-- Exercise 8
-- Create a column called city_priority:
--
-- Delhi → 1
-- Mumbai → 2
-- Pune → 3
-- everything else → 4
--
-- Sort the result by city_priority.


-- Exercise 9
-- Create a column called age_difference:
--
-- If age >= 21, calculate age - 20.
-- Otherwise return 0.


-- Exercise 10
-- Display:
--
-- first_name
-- age
-- age_group
--
-- Use:
--
-- age < 20     → 'Under 20'
-- age 20       → 'Exactly 20'
-- age > 20     → 'Over 20'


-- Exercise 11
-- Count how many students are age 21 or older
-- using CASE and an aggregate function.


-- Exercise 12
-- Count students under age 21 using CASE.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 13
-- Group students into:
--
-- 'Young'     → age < 20
-- 'Standard'  → age 20
-- 'Older'     → age > 20
--
-- Return:
--
-- age_group
-- student_count


-- Exercise 14
-- Create a report containing:
--
-- first_name
-- age
-- average_age
-- age_status
--
-- age_status should be:
--
-- 'Above Average' if age is greater than the average age.
-- 'Average or Below' otherwise.
--
-- Use a subquery.


-- Exercise 15
-- Sort students using this custom priority:
--
-- Delhi students first.
-- Mumbai students second.
-- Pune students third.
-- All remaining students last.
--
-- Within each priority group, sort by first_name.


-- Exercise 16
-- Create two calculated columns:
--
-- age_group
-- city_group
--
-- age_group:
-- age >= 21 → '21+'
-- otherwise → 'Under 21'
--
-- city_group:
-- Delhi/Mumbai → 'Major'
-- otherwise → 'Other'


-- Exercise 17
-- Create a report showing:
--
-- first_name
-- age
-- student_status
--
-- Rules:
--
-- age >= 22 → 'Senior'
-- age = 21  → 'Intermediate'
-- age = 20  → 'Junior'
-- age < 20  → 'Beginner'


-- Exercise 18
-- Return the number of students in each of these categories:
--
-- '21+'
-- 'Under 21'
--
-- Use CASE with GROUP BY.


-- Exercise 19
-- Return the three highest-priority students using:
--
-- custom city priority
-- first_name as the secondary sort
-- LIMIT


-- Exercise 20
-- Create a report with:
--
-- first_name
-- city
-- age
-- classification
--
-- Classification rules:
--
-- Delhi + age >= 21 → 'Priority A'
-- Delhi + age < 21  → 'Priority B'
-- all other cities + age >= 21 → 'Priority C'
-- all remaining rows → 'Priority D'
