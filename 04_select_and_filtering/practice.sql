-- ============================================================
-- MODULE 04: SELECT & FILTERING
-- File: practice.sql
-- Database: school
-- MySQL 8.0+
--
-- Instructions:
-- Solve each exercise without looking at solutions.sql.
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Display all columns and all students.


-- Exercise 2
-- Display only first_name, last_name, and city.


-- Exercise 3
-- Display the first_name and age columns.
-- Give age the alias student_age.


-- Exercise 4
-- Find all students who are 20 years old.


-- Exercise 5
-- Find all students older than 20.


-- Exercise 6
-- Find all students who are 20 or younger.


-- Exercise 7
-- Find all students who are not from Delhi.


-- Exercise 8
-- Find all students who live in Delhi or Mumbai.


-- Exercise 9
-- Find all students whose age is between 20 and 22.


-- Exercise 10
-- Display a list of unique cities.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11
-- Find students whose age is NOT between 20 and 22.


-- Exercise 12
-- Find students whose city is one of:
-- Delhi, Pune, or Lucknow.


-- Exercise 13
-- Find students whose city is NOT:
-- Delhi, Pune, or Lucknow.


-- Exercise 14
-- Find students whose first name starts with "A".


-- Exercise 15
-- Find students whose first name ends with "a".


-- Exercise 16
-- Find students whose first name contains the letter "h".


-- Exercise 17
-- Find students whose first name has exactly four characters.


-- Exercise 18
-- Find students who are at least 20 years old
-- AND live in either Delhi or Mumbai.


-- Exercise 19
-- Find students who are either younger than 20
-- OR older than 21.


-- Exercise 20
-- Find students who are NOT from Delhi
-- AND are at least 20 years old.


-- Exercise 21
-- Sort all students by age from youngest to oldest.


-- Exercise 22
-- Sort all students by age from oldest to youngest.


-- Exercise 23
-- Sort students by age ascending.
-- For students with the same age,
-- sort by first_name alphabetically.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 24
-- Find students who are from Delhi, Mumbai, or Pune
-- AND whose age is at least 20.


-- Exercise 25
-- Find students who are either:
--   a) from Delhi and at least 20 years old
--   OR
--   b) from Mumbai and at least 21 years old.
--
-- Use parentheses to make the logic explicit.


-- Exercise 26
-- Find students whose first name starts with "A"
-- OR whose city ends with "pur".


-- Exercise 27
-- Find students whose age is between 19 and 21,
-- excluding students from Mumbai.


-- Exercise 28
-- Display first_name, last_name, and city.
-- Rename first_name as first_name and city as hometown.
-- Sort the results by hometown alphabetically.


-- Exercise 29
-- Find the two oldest students.


-- Exercise 30
-- Find the three youngest students,
-- sorted by age ascending and then first_name ascending.


-- Exercise 31
-- Find students aged 20 or older,
-- exclude students from Delhi,
-- sort by age descending,
-- and return only the first two results.


-- Exercise 32
-- Find students who are:
--   - between 19 and 22 years old,
--   - from Delhi, Mumbai, Jaipur, or Pune,
--   - and whose first name contains the letter "a".
--
-- Sort by age ascending and first_name ascending.


-- Exercise 33
-- Display each unique combination of age and city.


-- Exercise 34
-- Find students whose first name begins with "A"
-- and who are NOT from Lucknow.


-- Exercise 35
-- Find the oldest student who is from either Delhi,
-- Mumbai, or Pune.
--
-- Return only one row.


-- ============================================================
-- END OF PRACTICE
-- ============================================================
