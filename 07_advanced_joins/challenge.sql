-- ============================================================
-- MODULE 07: ADVANCED JOINs
-- File: challenge.sql
-- Database: school
-- MySQL 8.0+
--
-- Try these independently.
-- They are intentionally different from practice.sql.
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — RIGHT JOIN Reasoning
-- ============================================================
-- Write a RIGHT JOIN that returns every course,
-- including courses without enrollments.
--
-- Display:
--   course_name
--   enrollment_id


-- ============================================================
-- CHALLENGE 2 — LEFT JOIN Rewrite
-- ============================================================
-- Rewrite Challenge 1 using LEFT JOIN.
--
-- The result should represent the same relationship.


-- ============================================================
-- CHALLENGE 3 — Interview Question
-- ============================================================
-- Find students who have enrolled in at least one course
-- but live in a city other than Delhi.
--
-- Display:
--   first_name
--   last_name
--   city
--   course_name


-- ============================================================
-- CHALLENGE 4 — SELF JOIN
-- ============================================================
-- Find every employee who has a manager.
--
-- Display:
--   employee_name
--   manager_name
--
-- Use SELF JOIN.


-- ============================================================
-- CHALLENGE 5 — Management Hierarchy
-- ============================================================
-- Display:
--   employee
--   manager
--   manager's manager
--
-- Include employees even if one of these relationships
-- does not exist.


-- ============================================================
-- CHALLENGE 6 — Same Manager
-- ============================================================
-- Find pairs of employees who report to the same manager.
--
-- Do not return:
--   employee paired with themselves
--
-- Do not return the same pair twice.


-- ============================================================
-- CHALLENGE 7 — Interview Question
-- ============================================================
-- Find the number of direct reports for every employee.
--
-- Employees with zero reports must also appear.


-- ============================================================
-- CHALLENGE 8 — Manager Identification
-- ============================================================
-- Find all employees who manage at least one other employee.
--
-- Each manager should appear once.


-- ============================================================
-- CHALLENGE 9 — Course Statistics
-- ============================================================
-- Create a report showing:
--
--   course_name
--   instructor
--   student_count
--
-- Include courses with zero students.
--
-- Sort by student_count descending.


-- ============================================================
-- CHALLENGE 10 — Age-Based Course Report
-- ============================================================
-- For every course, calculate the number of enrolled
-- students aged 20 or older.
--
-- Include courses with zero qualifying students.
--
-- Hint:
-- Carefully choose whether the age condition belongs
-- in ON or WHERE.


-- ============================================================
-- CHALLENGE 11 — Interview Question
-- ============================================================
-- Find students who are enrolled in more than one course
-- but do not display their individual course names.
--
-- Return:
--   student_id
--   first_name
--   last_name
--   course_count


-- ============================================================
-- CHALLENGE 12 — Two-Course Students
-- ============================================================
-- Find students who are enrolled in both:
--
--   SQL Fundamentals
--   Data Analytics
--
-- Return each student only once.


-- ============================================================
-- CHALLENGE 13 — Course With Youngest Average
-- ============================================================
-- Find the course with the lowest average age among
-- its enrolled students.
--
-- Return:
--   course_name
--   average_age
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 14 — Course With Most Students
-- ============================================================
-- Find the course with the highest number of distinct
-- enrolled students.
--
-- Return:
--   course_name
--   student_count
--
-- Return only one row.


-- ============================================================
-- CHALLENGE 15 — Student Activity
-- ============================================================
-- Build a report containing every student:
--
--   first_name
--   last_name
--   city
--   course_count
--
-- Add enrollment counts without removing students
-- who have no courses.


-- ============================================================
-- CHALLENGE 16 — Manager Department
-- ============================================================
-- Find employees whose department differs from their
-- manager's department.
--
-- Display:
--   employee
--   employee_department
--   manager
--   manager_department


-- ============================================================
-- CHALLENGE 17 — Same Department
-- ============================================================
-- Find employees whose manager works in the same department.
--
-- Display:
--   employee
--   manager
--   department


-- ============================================================
-- CHALLENGE 18 — Enrollment Date
-- ============================================================
-- Find the most recent enrollment for each student.
--
-- Display:
--   first_name
--   last_name
--   enrollment_date
--
-- Hint:
-- Think carefully about how GROUP BY and MAX() interact
-- with JOINs.


-- ============================================================
-- CHALLENGE 19 — Portfolio Report
-- ============================================================
-- Create a report showing:
--
--   student name
--   city
--   course count
--   latest enrollment date
--
-- Every student must appear, including students with
-- no enrollment.


-- ============================================================
-- CHALLENGE 20 — Advanced JOIN Reasoning
-- ============================================================
-- Write a query that lists every course and:
--
--   course_name
--   instructor
--   number of students
--   average student age
--   earliest enrollment date
--
-- Courses without students must remain in the result.
--
-- Sort:
--   1. student count descending
--   2. course name ascending
--
-- Think carefully about:
--   INNER JOIN vs LEFT JOIN
--   COUNT()
--   AVG()
--   MIN()
--   GROUP BY


-- ============================================================
-- BONUS — SELF JOIN INTERVIEW QUESTION
-- ============================================================
-- Find pairs of employees who:
--
--   1. report to the same manager
--   2. work in the same department
--
-- Each pair should appear only once.


-- ============================================================
-- END OF CHALLENGES
-- ============================================================
