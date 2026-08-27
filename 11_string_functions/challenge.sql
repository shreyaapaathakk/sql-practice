-- ============================================================
-- MODULE 11: STRING FUNCTIONS
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Full Name
-- ============================================================
-- Create a full_name column containing first_name
-- and last_name separated by a single space.


-- ============================================================
-- CHALLENGE 2 — Name Initials
-- ============================================================
-- Return:
--
-- first_name
-- last_name
-- initials
--
-- Example:
--
-- Rahul Sharma → RS


-- ============================================================
-- CHALLENGE 3 — Username Generator
-- ============================================================
-- Generate usernames in this format:
--
-- first_name.last_name
--
-- Convert the entire username to lowercase.


-- ============================================================
-- CHALLENGE 4 — Name Length Interview Question
-- ============================================================
-- Find the student(s) with the longest first_name.
--
-- Do not simply hard-code the name.
--
-- Use a subquery together with CHAR_LENGTH().


-- ============================================================
-- CHALLENGE 5 — Shortest Name
-- ============================================================
-- Find the student(s) with the shortest first_name.
--
-- Use a subquery.


-- ============================================================
-- CHALLENGE 6 — Custom Display Format
-- ============================================================
-- Create:
--
-- LAST_NAME, First_Name
--
-- Last name must be uppercase.


-- ============================================================
-- CHALLENGE 7 — String Search
-- ============================================================
-- Find students whose first_name contains the letter 'h'.
--
-- Use LOCATE() or INSTR().


-- ============================================================
-- CHALLENGE 8 — Prefix Search Without LIKE
-- ============================================================
-- Find students whose first_name begins with 'P'.
--
-- Do not use LIKE.


-- ============================================================
-- CHALLENGE 9 — Suffix Search Without LIKE
-- ============================================================
-- Find students whose first_name ends with 'n'.
--
-- Do not use LIKE.


-- ============================================================
-- CHALLENGE 10 — Data Formatting
-- ============================================================
-- Create:
--
-- student_code
--
-- Format:
--
-- STUDENT-00001
-- STUDENT-00002
-- etc.


-- ============================================================
-- CHALLENGE 11 — Case + String Function
-- ============================================================
-- Categorize students based on first_name length:
--
-- 4 or fewer → 'Short'
-- 5          → 'Medium'
-- 6 or more  → 'Long'


-- ============================================================
-- CHALLENGE 12 — Sorting Challenge
-- ============================================================
-- Sort students:
--
-- 1. Longest first_name first
-- 2. Shortest first_name last
-- 3. Alphabetically when lengths are equal


-- ============================================================
-- CHALLENGE 13 — Cleaning Challenge
-- ============================================================
-- Create a cleaned_name column that:
--
-- removes leading/trailing spaces
-- converts the name to uppercase


-- ============================================================
-- CHALLENGE 14 — String Extraction
-- ============================================================
-- Display:
--
-- first_name
-- first_two
-- last_two
--
-- first_two = first two characters
-- last_two  = last two characters


-- ============================================================
-- CHALLENGE 15 — Interview Style
-- ============================================================
-- What is the difference between:
--
-- LENGTH()
-- CHAR_LENGTH()
--
-- Demonstrate the difference with SQL.


-- ============================================================
-- CHALLENGE 16 — Interview Style
-- ============================================================
-- What is the difference between:
--
-- CONCAT()
-- CONCAT_WS()
--
-- Demonstrate both with the students table.


-- ============================================================
-- CHALLENGE 17 — Practical Report
-- ============================================================
-- Create a student directory containing:
--
-- full_name
-- initials
-- username
-- city
--
-- Sort alphabetically by full_name.


-- ============================================================
-- CHALLENGE 18 — Advanced String Report
-- ============================================================
-- Create:
--
-- first_name
-- reversed_name
-- name_length
-- name_category
--
-- Use REVERSE(), CHAR_LENGTH(), and CASE.


-- ============================================================
-- CHALLENGE 19 — Interview Style
-- ============================================================
-- Find students whose first_name contains the letter 'a'
-- at least once.
--
-- Solve it using a string function rather than LIKE.


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Build a professional student profile query containing:
--
-- student_code
-- full_name
-- initials
-- username
-- city
-- name_length
-- name_category
--
-- Requirements:
--
-- 1. student_code must use LPAD().
-- 2. full_name must combine first_name and last_name.
-- 3. initials must use LEFT().
-- 4. username must be lowercase.
-- 5. name_category must use CASE.
-- 6. Sort by city and then full_name.
--
-- Keep the query clean and readable.
