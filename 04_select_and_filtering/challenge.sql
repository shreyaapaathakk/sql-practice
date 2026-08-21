-- ============================================================
-- MODULE 04: SELECT & FILTERING
-- File: challenge.sql
-- Database: school
-- MySQL 8.0+
--
-- Challenge problems are intentionally different from
-- the exercises in practice.sql.
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Basic Interview Question
-- ============================================================
-- Return the first_name and city of every student.
-- Rename city as hometown.
-- Sort the result alphabetically by hometown.


-- ============================================================
-- CHALLENGE 2 — Filtering
-- ============================================================
-- Find all students whose age is greater than or equal to 21
-- but who do not live in Pune.


-- ============================================================
-- CHALLENGE 3 — Multiple Conditions
-- ============================================================
-- Find students who live in either:
--   Delhi or Jaipur
--
-- AND whose age is less than 21.


-- ============================================================
-- CHALLENGE 4 — LIKE
-- ============================================================
-- Find students whose first name contains the letter "r"
-- anywhere in the name.


-- ============================================================
-- CHALLENGE 5 — LIKE + NOT
-- ============================================================
-- Find students whose city starts with the letter "L"
-- and whose age is NOT 20.


-- ============================================================
-- CHALLENGE 6 — Sorting
-- ============================================================
-- Display all students sorted by:
--   1. city alphabetically
--   2. age from oldest to youngest


-- ============================================================
-- CHALLENGE 7 — LIMIT
-- ============================================================
-- Return only the student with the second-highest age.
--
-- Hint:
-- Think about ORDER BY and LIMIT.


-- ============================================================
-- CHALLENGE 8 — DISTINCT
-- ============================================================
-- Return all different ages represented in the students table.
-- Sort the ages from highest to lowest.


-- ============================================================
-- CHALLENGE 9 — Interview Question
-- ============================================================
-- Find students whose age is between 20 and 22,
-- but exclude students who live in Mumbai.


-- ============================================================
-- CHALLENGE 10 — Interview Question
-- ============================================================
-- Find the youngest student whose city is NOT Delhi.
--
-- Return only:
--   first_name
--   last_name
--   age
--   city


-- ============================================================
-- CHALLENGE 11 — Logic
-- ============================================================
-- Find students who satisfy either of these conditions:
--
-- Condition A:
--   age = 20 AND city = 'Delhi'
--
-- OR
--
-- Condition B:
--   age > 20 AND city = 'Pune'
--
-- Use parentheses.


-- ============================================================
-- CHALLENGE 12 — LIMIT + ORDER BY
-- ============================================================
-- Find the two oldest students whose first name
-- contains the letter "a".
--
-- Sort oldest to youngest.


-- ============================================================
-- CHALLENGE 13 — Practical Query
-- ============================================================
-- A school administrator wants a list of students
-- who are eligible for a "young learners" program.
--
-- Eligibility:
--   age <= 20
--   AND city must be Delhi, Jaipur, or Lucknow.
--
-- Display first_name, last_name, age, and city.
-- Sort by city and then first_name.


-- ============================================================
-- CHALLENGE 14 — Interview Question
-- ============================================================
-- Find the student whose first name comes first
-- alphabetically among students aged 20 or older.
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 15 — Combined Filtering
-- ============================================================
-- Find students who:
--
--   1. Are not from Mumbai or Delhi
--   2. Are between 19 and 22 years old
--   3. Have a first name containing the letter "a"
--
-- Display first_name, last_name, age, and city.
-- Sort by age descending and first_name ascending.


-- ============================================================
-- BONUS CHALLENGE — Query Reasoning
-- ============================================================
-- Write a query that returns the oldest student
-- from each of the following cities:
--
--   Delhi
--   Mumbai
--   Pune
--
-- Do NOT use GROUP BY or subqueries yet.
--
-- Think carefully about what can and cannot be achieved
-- using only the concepts learned in Module 04.
--
-- If you cannot solve this perfectly yet, explain why
-- and leave your attempt below.
-- ============================================================


-- Your attempt:




-- ============================================================
-- END OF CHALLENGES
-- ============================================================
