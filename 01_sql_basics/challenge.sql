-- =====================================================
-- Module 01 : SQL Basics
-- File       : challenge.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

USE school;


-- =====================================================
-- 🏆 SQL BASICS CHALLENGES
-- =====================================================

-- -----------------------------------------------------
-- Challenge 1 — Young Students
-- -----------------------------------------------------
-- Find all students who are younger than 21.
--
-- Display:
-- first_name
-- last_name
-- age
--
-- Sort the result from youngest to oldest.


-- -----------------------------------------------------
-- Challenge 2 — City Search
-- -----------------------------------------------------
-- Find all students who live in either Delhi,
-- Jaipur, or Lucknow.
--
-- Display:
-- first_name
-- last_name
-- city


-- -----------------------------------------------------
-- Challenge 3 — Age and City
-- -----------------------------------------------------
-- Find students who:
--
-- 1. Are at least 20 years old
-- AND
-- 2. Live in either Delhi, Mumbai, or Pune.
--
-- Display all columns.


-- -----------------------------------------------------
-- Challenge 4 — Name Pattern
-- -----------------------------------------------------
-- Find all students whose first name ends with
-- the letter 'a'.
--
-- Display:
-- first_name
-- last_name
-- city


-- -----------------------------------------------------
-- Challenge 5 — Name Length
-- -----------------------------------------------------
-- Find students whose first name contains at least
-- 5 characters.
--
-- Display:
-- first_name
-- last_name


-- -----------------------------------------------------
-- Challenge 6 — Specific Age Range
-- -----------------------------------------------------
-- Find students whose age is between 19 and 22
-- and who do not live in Delhi.
--
-- Display:
-- first_name
-- age
-- city


-- -----------------------------------------------------
-- Challenge 7 — Count by Condition
-- -----------------------------------------------------
-- Find the total number of students who live in
-- Mumbai.


-- -----------------------------------------------------
-- Challenge 8 — Multiple Conditions
-- -----------------------------------------------------
-- Find students who are:
--
-- - 20 years old or older
-- - AND live in Delhi, Mumbai, Jaipur, or Pune
--
-- Display:
-- first_name
-- age
-- city


-- -----------------------------------------------------
-- Challenge 9 — Oldest Student
-- -----------------------------------------------------
-- Find the oldest student in the database.
--
-- Display:
-- first_name
-- last_name
-- age
-- city
--
-- Do not manually enter the student's age.
-- Your query should determine it from the table.


-- -----------------------------------------------------
-- Challenge 10 — Youngest Student
-- -----------------------------------------------------
-- Find the youngest student in the database.
--
-- Display:
-- first_name
-- last_name
-- age
-- city


-- =====================================================
-- 🔥 BONUS CHALLENGES
-- =====================================================

-- -----------------------------------------------------
-- Bonus 1
-- -----------------------------------------------------
-- Count how many students are between 20 and 22 years
-- old, inclusive.


-- -----------------------------------------------------
-- Bonus 2
-- -----------------------------------------------------
-- Find all students whose first name starts with 'A'
-- or 'P'.


-- -----------------------------------------------------
-- Bonus 3
-- -----------------------------------------------------
-- Find all students whose city name contains the
-- letter 'u'.


-- -----------------------------------------------------
-- Bonus 4
-- -----------------------------------------------------
-- Find the average age of all students.
--
-- Display the result using the alias:
-- average_age


-- -----------------------------------------------------
-- Bonus 5
-- -----------------------------------------------------
-- Find the total number of students and the oldest
-- student's age in a single query.
--
-- Use these aliases:
-- student_count
-- oldest_age


-- =====================================================
-- 💡 Challenge Rules
-- =====================================================

-- 1. Try every challenge without looking at solutions.
-- 2. Use only concepts covered in SQL Basics whenever
--    possible.
-- 3. Test each query in MySQL 8.0+.
-- 4. Focus on understanding why the query works.
-- 5. If multiple valid approaches exist, try more than
--    one approach.
-- 6. Write clean and readable SQL.
