# `challenge.sql`

```sql
-- ============================================================
-- MODULE 05: AGGREGATE FUNCTIONS
-- File: challenge.sql
-- Database: school
-- MySQL 8.0+
--
-- These challenges are intentionally different from
-- practice.sql and include beginner interview-style questions.
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Interview Question
-- ============================================================
-- How many students are there whose age is exactly 20?


-- ============================================================
-- CHALLENGE 2 — Interview Question
-- ============================================================
-- What is the difference between the oldest and youngest
-- student ages?
--
-- Return a column named age_difference.


-- ============================================================
-- CHALLENGE 3 — Interview Question
-- ============================================================
-- How many unique cities are represented in the table?


-- ============================================================
-- CHALLENGE 4 — Average
-- ============================================================
-- Find the average age of students whose city is
-- not Delhi.


-- ============================================================
-- CHALLENGE 5 — Grouping
-- ============================================================
-- Show each age and the number of students who have that age.
--
-- Sort from the most common age to the least common age.


-- ============================================================
-- CHALLENGE 6 — HAVING
-- ============================================================
-- Find ages that are shared by at least two students.
--
-- Return:
--   age
--   student_count


-- ============================================================
-- CHALLENGE 7 — Filtering Before Grouping
-- ============================================================
-- For students aged 20 or older, show the number of students
-- in each city.
--
-- Only show cities containing at least two such students.


-- ============================================================
-- CHALLENGE 8 — City Analysis
-- ============================================================
-- Find the city with the highest average student age.
--
-- Return:
--   city
--   average_age
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 9 — City Analysis
-- ============================================================
-- Find the city with the lowest average student age.
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 10 — Interview Question
-- ============================================================
-- Find all cities where the difference between the oldest
-- and youngest student is at least 1 year.
--
-- Return:
--   city
--   youngest_age
--   oldest_age
--   age_range


-- ============================================================
-- CHALLENGE 11 — Combined Aggregation
-- ============================================================
-- Create a city-level report containing:
--
--   city
--   student_count
--   average_age
--   age_range
--
-- Sort by age_range from highest to lowest.


-- ============================================================
-- CHALLENGE 12 — Business-Style Question
-- ============================================================
-- The school wants to identify cities that have:
--
--   - at least two students
--   - an average age of at least 20
--
-- Return the city and average age.
-- Sort by average age descending.


-- ============================================================
-- CHALLENGE 13 — Filtering + Aggregation
-- ============================================================
-- Consider only students whose first name contains "a".
--
-- For each city, calculate:
--   - number of matching students
--   - average age
--
-- Show only cities with at least one matching student.


-- ============================================================
-- CHALLENGE 14 — Interview Question
-- ============================================================
-- Find the most common student age.
--
-- Return:
--   age
--   student_count
--
-- Return only the most common age.
--
-- Hint:
-- GROUP BY + COUNT() + ORDER BY + LIMIT


-- ============================================================
-- CHALLENGE 15 — Interview Question
-- ============================================================
-- Find the second most common student age.
--
-- Return:
--   age
--   student_count
--
-- Hint:
-- ORDER BY, LIMIT, and OFFSET may be useful.


-- ============================================================
-- CHALLENGE 16 — Reasoning Challenge
-- ============================================================
-- Write a query to determine whether every city contains
-- exactly one student.
--
-- Your query should produce a useful summary that allows
-- you to answer the question without manually inspecting
-- every row.


-- ============================================================
-- CHALLENGE 17 — NULL Challenge
-- ============================================================
-- Assume some rows may have NULL values in city.
--
-- Write two queries:
--
-- 1. Count all student rows.
-- 2. Count students that have a non-NULL city.
--
-- Explain the difference in comments.


-- ============================================================
-- CHALLENGE 18 — SUM() Challenge
-- ============================================================
-- Using the student_fees table from the examples,
-- calculate the total fees for students whose fee_amount
-- is greater than 15000.


-- ============================================================
-- BONUS CHALLENGE
-- ============================================================
-- Create a summary showing:
--
--   city
--   number_of_students
--   average_age
--   youngest_age
--   oldest_age
--
-- Then:
--
--   1. Keep only cities with at least two students.
--   2. Keep only groups whose average age is 20 or higher.
--   3. Sort by number_of_students descending.
--   4. If two cities have the same count, sort by
--      average_age descending.
--   5. Return only the top city.
--
-- Try to write this query without looking at solutions.


-- ============================================================
-- END OF CHALLENGES
-- ============================================================
```
