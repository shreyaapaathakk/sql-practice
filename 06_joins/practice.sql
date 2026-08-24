# `practice.sql`

```sql
-- ============================================================
-- MODULE 06: JOINs
-- File: practice.sql
-- Database: school
-- MySQL 8.0+
--
-- Run examples.sql first to create the course and enrollment
-- tables and populate their sample data.
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Use INNER JOIN to display each student's first_name
-- and their enrollment_id.


-- Exercise 2
-- Display:
--   student first_name
--   student last_name
--   course_id
--
-- Join students and enrollments.


-- Exercise 3
-- Join students, enrollments, and courses.
--
-- Display:
--   first_name
--   last_name
--   course_name


-- Exercise 4
-- Display each student's name and the course instructor
-- for their enrolled courses.


-- Exercise 5
-- Find all students enrolled in "SQL Fundamentals".


-- Exercise 6
-- Find all students enrolled in "Python Basics".


-- Exercise 7
-- Display all enrollments ordered by enrollment_date
-- from earliest to latest.


-- Exercise 8
-- Display students from Delhi and the courses
-- they are enrolled in.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
-- Display every course and the number of enrollments
-- it has.
--
-- Sort by enrollment count from highest to lowest.


-- Exercise 10
-- Find courses that have at least two enrollments.


-- Exercise 11
-- Count how many courses each student is enrolled in.
--
-- Include students who are not enrolled in any course.


-- Exercise 12
-- Find students who are enrolled in at least two courses.


-- Exercise 13
-- Display:
--   student name
--   course name
--   enrollment date
--
-- Sort by student last_name and then course_name.


-- Exercise 14
-- Find students aged 20 or older and display
-- the courses they are enrolled in.


-- Exercise 15
-- Find all students enrolled in a course taught by
-- "Anita Sharma".


-- Exercise 16
-- Display each course and the number of distinct
-- students enrolled in it.


-- Exercise 17
-- Find students who have at least one course enrollment
-- and display each student only once.


-- Exercise 18
-- Find courses that currently have no enrollments.
--
-- Use LEFT JOIN.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 19
-- Find students who are NOT enrolled in any course.
--
-- Return:
--   student_id
--   first_name
--   last_name
--
-- Use LEFT JOIN.


-- Exercise 20
-- Display each student with:
--   first_name
--   last_name
--   city
--   course_count
--
-- Include students with zero courses.
-- Sort by course_count descending.


-- Exercise 21
-- Find the number of students enrolled in each course,
-- considering only students aged 20 or older.
--
-- Return:
--   course_name
--   student_count


-- Exercise 22
-- Find courses with at least two students aged 20 or older.


-- Exercise 23
-- Display the average age of students in each course.
--
-- Return:
--   course_name
--   average_age
--
-- Round average_age to two decimal places.


-- Exercise 24
-- Find courses whose average student age is greater than 20.


-- Exercise 25
-- Create a report containing:
--   course_name
--   instructor
--   student_count
--   average_student_age
--
-- Sort by student_count descending.


-- Exercise 26
-- Find the course with the highest number of enrolled students.
--
-- Return only one course.


-- Exercise 27
-- Find the student who is enrolled in the greatest
-- number of courses.
--
-- Return:
--   first_name
--   last_name
--   course_count
--
-- Return only one student.


-- Exercise 28
-- Find students from Delhi or Mumbai who are enrolled
-- in at least one course.
--
-- Display each student's name and course name.


-- ============================================================
-- END OF PRACTICE
-- ============================================================
```
