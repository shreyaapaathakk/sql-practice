# `challenge.sql`

```sql
-- ============================================================
-- MODULE 06: JOINs
-- File: challenge.sql
-- Database: school
-- MySQL 8.0+
--
-- These challenges are different from practice.sql.
-- Try solving them without looking at solutions.sql.
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Interview Question
-- ============================================================
-- Display every student who is enrolled in at least one course.
--
-- Return:
--   student_id
--   first_name
--   last_name
--
-- Each student should appear only once.


-- ============================================================
-- CHALLENGE 2 — Interview Question
-- ============================================================
-- Find the total number of enrollment records.


-- ============================================================
-- CHALLENGE 3 — Course Lookup
-- ============================================================
-- Display:
--   course_name
--   instructor
--   student first_name
--   student last_name
--
-- Sort by course_name alphabetically.


-- ============================================================
-- CHALLENGE 4 — Student Lookup
-- ============================================================
-- Find all courses taken by Rahul.
--
-- Return:
--   course_name
--   instructor


-- ============================================================
-- CHALLENGE 5 — Filtering Across Tables
-- ============================================================
-- Find students from Jaipur or Lucknow who are enrolled
-- in "Data Analytics".


-- ============================================================
-- CHALLENGE 6 — Aggregation Across Tables
-- ============================================================
-- Find the total number of students enrolled in
-- "SQL Fundamentals".


-- ============================================================
-- CHALLENGE 7 — Course Ranking
-- ============================================================
-- Display all courses with their enrollment counts.
--
-- Sort:
--   1. highest enrollment first
--   2. course name alphabetically when counts are equal


-- ============================================================
-- CHALLENGE 8 — Unmatched Records
-- ============================================================
-- Find every student who has no enrollment.
--
-- Use LEFT JOIN rather than NOT IN.


-- ============================================================
-- CHALLENGE 9 — Course Enrollment Status
-- ============================================================
-- Create a report containing:
--
--   course_name
--   enrollment_count
--   enrollment_status
--
-- If enrollment_count is 0, the status should be:
--   'No Students'
--
-- Otherwise:
--   'Has Students'
--
-- Hint:
-- CASE will be formally introduced in a later module,
-- so for now try to solve the first two columns and
-- optionally attempt the status column as a bonus.


-- ============================================================
-- CHALLENGE 10 — Student Course Load
-- ============================================================
-- Find students who are enrolled in exactly two courses.
--
-- Return:
--   first_name
--   last_name
--   course_count


-- ============================================================
-- CHALLENGE 11 — Interview Question
-- ============================================================
-- Find the course with the earliest enrollment date.
--
-- Return:
--   course_name
--   enrollment_date
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 12 — Interview Question
-- ============================================================
-- Find the student who enrolled in a course most recently.
--
-- Return:
--   first_name
--   last_name
--   course_name
--   enrollment_date
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 13 — Average Age by Course
-- ============================================================
-- Find the average age of students enrolled in
-- each course.
--
-- Only show courses whose average student age is
-- greater than or equal to 20.
--
-- Sort by average age descending.


-- ============================================================
-- CHALLENGE 14 — Student Activity Report
-- ============================================================
-- Build a report showing every student:
--
--   first_name
--   last_name
--   city
--   number_of_courses
--
-- Students with no courses must still appear.


-- ============================================================
-- CHALLENGE 15 — Course Popularity
-- ============================================================
-- Find courses that have more enrolled students than
-- "Python Basics".
--
-- Return:
--   course_name
--   student_count
--
-- Hint:
-- This can be solved without subqueries by using a known
-- enrollment count from the current dataset, but think about
-- how you would solve it dynamically later.


-- ============================================================
-- CHALLENGE 16 — Multi-Table Filtering
-- ============================================================
-- Find students who:
--
--   - are at least 20 years old
--   - live in Delhi, Mumbai, or Pune
--   - are enrolled in a course taught by
--     Anita Sharma or Aman Verma
--
-- Display:
--   student name
--   city
--   course name
--   instructor


-- ============================================================
-- CHALLENGE 17 — Interview-Style Report
-- ============================================================
-- For each city, calculate the number of enrolled students.
--
-- Important:
-- A student enrolled in multiple courses should be counted
-- only once for that city.
--
-- Return:
--   city
--   enrolled_student_count
--
-- Sort from highest to lowest.


-- ============================================================
-- CHALLENGE 18 — LEFT JOIN Reasoning
-- ============================================================
-- Write two queries:
--
-- Query A:
--   Use INNER JOIN to return students and their courses.
--
-- Query B:
--   Use LEFT JOIN to return students and their courses.
--
-- Compare the results.
--
-- Explain in comments why the number of rows may differ.


-- ============================================================
-- CHALLENGE 19 — Real-World Scenario
-- ============================================================
-- The school wants to contact students who have not enrolled
-- in any course.
--
-- Return:
--   student_id
--   first_name
--   last_name
--   city
--
-- Sort alphabetically by last_name.


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Create a course performance report containing:
--
--   course_name
--   instructor
--   student_count
--   average_student_age
--   earliest_enrollment
--
-- Include courses even if they have no students.
--
-- Sort by:
--   1. student_count descending
--   2. course_name ascending
--
-- Think carefully about whether INNER JOIN or LEFT JOIN
-- is more appropriate.


-- ============================================================
-- BONUS CHALLENGE — JOIN Reasoning
-- ============================================================
-- Without using a subquery or CTE, write a query that
-- displays every student and their course count.
--
-- Then identify:
--
--   1. Students with zero courses
--   2. Students with exactly one course
--   3. Students with multiple courses
--
-- Try to solve this using concepts learned so far.


-- ============================================================
-- END OF CHALLENGES
-- ============================================================
```
