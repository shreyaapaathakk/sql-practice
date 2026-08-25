-- ============================================================
-- MODULE 07: ADVANCED JOINs
-- File: practice.sql
-- Database: school
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Use RIGHT JOIN to display every enrollment and
-- the corresponding student's name.


-- Exercise 2
-- Rewrite Exercise 1 using LEFT JOIN instead of RIGHT JOIN.


-- Exercise 3
-- Use RIGHT JOIN to display every course and its
-- enrollment_id.


-- Exercise 4
-- Find courses that have no enrollments using RIGHT JOIN.


-- Exercise 5
-- Find the same result as Exercise 4 using LEFT JOIN.


-- Exercise 6
-- Use a SELF JOIN to display each employee and their manager.


-- Exercise 7
-- Display only employees who have a manager.


-- Exercise 8
-- Find employees who do not have a manager.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9
-- Display:
--   employee
--   employee department
--   manager
--   manager department
--
-- Use SELF JOIN.


-- Exercise 10
-- Find all employees who report directly to
-- "Rahul Mehta".


-- Exercise 11
-- Display every employee, their manager, and their
-- manager's manager.
--
-- Employees without a manager should still appear.


-- Exercise 12
-- Display every course and its number of distinct students.
--
-- Include courses with zero students.


-- Exercise 13
-- Find courses with more than one distinct student.


-- Exercise 14
-- Display every student and the number of courses
-- they are enrolled in.
--
-- Include students with zero courses.


-- Exercise 15
-- Find students enrolled in exactly one course.


-- Exercise 16
-- Find students enrolled in more than one course.


-- Exercise 17
-- Find all students who are enrolled in SQL Fundamentals.
--
-- Display:
--   first_name
--   last_name
--   city
--   course_name


-- Exercise 18
-- Find all students from Mumbai who are enrolled
-- in a course.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 19
-- Display each employee and their manager.
--
-- Sort first by manager name and then employee name.


-- Exercise 20
-- Find pairs of employees who report to the same manager.
--
-- Each pair should appear only once.
--
-- Do not match an employee with themselves.


-- Exercise 21
-- Display the number of employees reporting to
-- each manager.
--
-- Managers with zero direct reports should also appear.


-- Exercise 22
-- Find managers who have at least two direct reports.


-- Exercise 23
-- Find students who are enrolled in both:
--
--   SQL Fundamentals
--   Python Basics
--
-- Each student should appear only once.


-- Exercise 24
-- Find courses that have at least one student aged 21 or older,
-- but also include courses with no matching students.
--
-- Think carefully about where the age condition belongs.


-- Exercise 25
-- Display:
--   course_name
--   student_count
--   average_student_age
--
-- Include courses with zero students.
--
-- Sort by student_count descending.


-- Exercise 26
-- Find the manager with the greatest number of direct reports.
--
-- Return:
--   manager_name
--   report_count
--
-- Return only one row.


-- Exercise 27
-- Find the student with the highest number of enrollments.
--
-- Return:
--   student_name
--   course_count
--
-- Return only one row.


-- Exercise 28
-- Find employees who work in the same department as
-- their manager.


-- ============================================================
-- END OF PRACTICE
-- ============================================================
