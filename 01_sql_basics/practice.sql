-- =====================================================
-- Module 01 : SQL Basics
-- File       : practice.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

-- =====================================================
-- Practice Database
-- =====================================================

-- The exercises below use the following table:
--
-- students
--
-- | student_id | first_name | last_name | age | city    |
-- |------------|------------|-----------|-----|---------|
-- | 1          | Rahul      | Sharma    | 20  | Delhi   |
-- | 2          | Priya      | Singh     | 21  | Mumbai  |
-- | 3          | Aman       | Verma     | 19  | Jaipur  |
-- | 4          | Neha       | Gupta     | 22  | Pune    |
-- | 5          | Arjun      | Mehta     | 20  | Lucknow |
--
-- Make sure the `school` database and `students` table
-- from examples.sql have been created before practicing.


-- =====================================================
-- 🟢 EASY
-- =====================================================

-- -----------------------------------------------------
-- Question 1
-- -----------------------------------------------------
-- Display all records from the students table.


-- -----------------------------------------------------
-- Question 2
-- -----------------------------------------------------
-- Display only the first_name and last_name columns.


-- -----------------------------------------------------
-- Question 3
-- -----------------------------------------------------
-- Display the first_name, age, and city of every student.


-- -----------------------------------------------------
-- Question 4
-- -----------------------------------------------------
-- Display the complete record of the student whose
-- student_id is 3.


-- -----------------------------------------------------
-- Question 5
-- -----------------------------------------------------
-- Display the names of all students who are 20 years old.


-- =====================================================
-- 🟡 MEDIUM
-- =====================================================

-- -----------------------------------------------------
-- Question 6
-- -----------------------------------------------------
-- Display the first_name and city of students who live
-- in Delhi.


-- -----------------------------------------------------
-- Question 7
-- -----------------------------------------------------
-- Display the first_name, last_name, and age of students
-- who are older than 20.


-- -----------------------------------------------------
-- Question 8
-- -----------------------------------------------------
-- Display the first_name and city of students who live
-- in either Mumbai or Pune.


-- -----------------------------------------------------
-- Question 9
-- -----------------------------------------------------
-- Display the first_name and last_name of students whose
-- age is less than or equal to 20.


-- -----------------------------------------------------
-- Question 10
-- -----------------------------------------------------
-- Display the student_id, first_name, and city columns,
-- but give the columns the following aliases:
--
-- student_id → ID
-- first_name → Name
-- city       → Location


-- =====================================================
-- 🔴 HARD
-- =====================================================

-- -----------------------------------------------------
-- Question 11
-- -----------------------------------------------------
-- Display all students whose age is between 19 and 21.


-- -----------------------------------------------------
-- Question 12
-- -----------------------------------------------------
-- Display the names of students who do NOT live in Delhi.


-- -----------------------------------------------------
-- Question 13
-- -----------------------------------------------------
-- Display the complete record of the oldest student.


-- -----------------------------------------------------
-- Question 14
-- -----------------------------------------------------
-- Display the first_name, last_name, and city of students
-- whose city is either Jaipur, Lucknow, or Mumbai.


-- -----------------------------------------------------
-- Question 15
-- -----------------------------------------------------
-- Count the total number of students in the table.


-- =====================================================
-- 🏆 CHALLENGE
-- =====================================================

-- -----------------------------------------------------
-- Challenge 1
-- -----------------------------------------------------
-- Display the first_name and age of every student who is
-- at least 20 years old.


-- -----------------------------------------------------
-- Challenge 2
-- -----------------------------------------------------
-- Find the number of students who are exactly 20 years old.


-- -----------------------------------------------------
-- Challenge 3
-- -----------------------------------------------------
-- Display the complete record of students who live in
-- Delhi, Mumbai, or Pune and are at least 20 years old.


-- -----------------------------------------------------
-- Challenge 4
-- -----------------------------------------------------
-- Display the first_name, last_name, and city of every
-- student whose first_name starts with the letter 'A'.


-- -----------------------------------------------------
-- Challenge 5
-- -----------------------------------------------------
-- Display the total number of students and give the
-- result column the alias `student_count`.


-- =====================================================
-- 💡 Practice Rules
-- =====================================================

-- 1. Try solving every question yourself.
-- 2. Do not look at solutions until you have attempted
--    the problem.
-- 3. Write each query below its question.
-- 4. Test your queries in MySQL.
-- 5. If a query fails, read the error and try to fix it.
-- 6. After completing the exercises, compare your work
--    with solutions.sql.
