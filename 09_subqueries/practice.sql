-- ============================================================
-- MODULE 09: SUBQUERIES
-- File: practice.sql
-- ============================================================

USE school;

-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Find the oldest student using a subquery.

-- Exercise 2
-- Find the youngest student using a subquery.

-- Exercise 3
-- Find students older than the average age.

-- Exercise 4
-- Display the average age alongside every student record
-- using a subquery in SELECT.

-- Exercise 5
-- Return all students from cities where at least one student
-- is age 21 or older.

-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 6
-- Find students whose age equals the average age
-- rounded to the nearest whole number.

-- Exercise 7
-- Return students from cities not returned by:
--
-- SELECT city
-- FROM students
-- WHERE age >= 21;

-- Exercise 8
-- Create a derived table containing:
-- student_id
-- first_name
-- city
--
-- Then select all columns from it.

-- Exercise 9
-- Display:
-- first_name
-- age
-- maximum_age
--
-- using a subquery in SELECT.

-- Exercise 10
-- Find students whose age is greater than
-- the minimum age in the table.

-- ============================================================
-- HARD
-- ============================================================

-- Exercise 11
-- Return students that have enrollments
-- using EXISTS.

-- Exercise 12
-- Return students that do not have enrollments
-- using NOT EXISTS.

-- Exercise 13
-- Find students whose age is greater than
-- the average age of students from the same city.

-- Exercise 14
-- Find cities that contain at least one student
-- older than the overall average age.

-- Exercise 15
-- Return students whose student_id appears
-- in the enrollments table using a subquery.
