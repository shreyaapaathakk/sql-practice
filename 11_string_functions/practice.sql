-- ============================================================
-- MODULE 11: STRING FUNCTIONS
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Display each student's first_name and last_name
-- as one column called full_name.


-- Exercise 2
-- Display first_name in uppercase.


-- Exercise 3
-- Display city in lowercase.


-- Exercise 4
-- Display first_name and the number of characters
-- in the first name.


-- Exercise 5
-- Display the first three characters of each first_name.


-- Exercise 6
-- Display the last two characters of each first_name.


-- Exercise 7
-- Display first_name and last_name separated by " - ".
--
-- Example:
-- Rahul - Sharma


-- Exercise 8
-- Display the first character of first_name as
-- name_initial.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
-- Create a full_name column using CONCAT_WS().


-- Exercise 10
-- Create a username using:
--
-- first_name.last_name
--
-- Convert the result to lowercase.


-- Exercise 11
-- Create initials using:
--
-- first letter of first_name
-- first letter of last_name


-- Exercise 12
-- Display students whose first_name contains
-- the letter 'a'.
--
-- Use LOCATE() or INSTR().


-- Exercise 13
-- Display students whose first_name has
-- more than four characters.


-- Exercise 14
-- Display:
--
-- first_name
-- short_name
--
-- short_name should contain the first three characters
-- of first_name.


-- Exercise 15
-- Replace "Delhi" with "New Delhi" in the query output.
--
-- Do not modify the stored data.


-- Exercise 16
-- Create a column called name_category:
--
-- 5 or more characters → 'Long'
-- fewer than 5 characters → 'Short'
--
-- Use CASE and CHAR_LENGTH().


-- Exercise 17
-- Display each first_name reversed.


-- Exercise 18
-- Display student_id as a five-character value padded
-- with zeros.
--
-- Example:
-- 1 → 00001


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 19
-- Create a student_label containing:
--
-- FULL NAME | CITY
--
-- Convert the full name to uppercase but keep city
-- in its original form.


-- Exercise 20
-- Create a report containing:
--
-- first_name
-- last_name
-- full_name
-- initials
-- username


-- Exercise 21
-- Sort students by the length of their first_name,
-- from shortest to longest.
--
-- If two names have the same length,
-- sort alphabetically.


-- Exercise 22
-- Display students whose first_name starts with 'A'.
--
-- Solve this using a string function rather than LIKE.


-- Exercise 23
-- Display students whose first_name ends with 'a'.
--
-- Solve this using a string function rather than LIKE.


-- Exercise 24
-- Create:
--
-- first_name
-- name_length
-- name_category
--
-- Rules:
--
-- length <= 4 → 'Short'
-- length = 5   → 'Medium'
-- length > 5   → 'Long'


-- Exercise 25
-- Create a formatted student ID:
--
-- STUDENT-00001
-- STUDENT-00002
-- etc.
--
-- Use CONCAT() and LPAD().


-- Exercise 26
-- Create a report containing:
--
-- full_name
-- city
-- location_label
--
-- location_label should look like:
--
-- Rahul Sharma - Delhi


-- Exercise 27
-- Create a report where first_name is:
--
-- trimmed
-- converted to uppercase
--
-- Name the column cleaned_name.


-- Exercise 28
-- Find the position of the letter 'a' in each first_name.
--
-- Return:
--
-- first_name
-- position_of_a
--
-- If 'a' does not exist, the position should be 0.


-- Exercise 29
-- Create a custom display name:
--
-- LAST_NAME, First_Name
--
-- Example:
--
-- SHARMA, Rahul
--
-- Last name should be uppercase.


-- Exercise 30
-- Create a professional student directory containing:
--
-- student_id
-- full_name
-- initials
-- username
-- city
-- name_length
--
-- Sort by city and then full_name.
