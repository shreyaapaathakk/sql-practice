-- ============================================================
-- Student Database Management System
-- File: challenge.sql
-- SQL Dialect: MySQL 8.0+
--
-- Instructions:
-- Solve each challenge independently before checking your
-- previous SQL files or searching for a solution.
-- ============================================================

USE student_database;

-- ============================================================
-- CHALLENGE 1
-- ============================================================
-- Find the student with the highest overall average marks.
--
-- Return:
-- student_id
-- student_name
-- department_name
-- average_marks


-- ============================================================
-- CHALLENGE 2
-- ============================================================
-- Find the top 3 students from each department based on
-- average exam marks.
--
-- Return:
-- student_id
-- student_name
-- department_name
-- average_marks
-- department_rank
--
-- Requirement:
-- Use a window function.


-- ============================================================
-- CHALLENGE 3
-- ============================================================
-- Find all courses whose average marks are below the overall
-- average marks across all courses.
--
-- Return:
-- course_code
-- course_name
-- course_average
-- overall_average


-- ============================================================
-- CHALLENGE 4
-- ============================================================
-- Find students who have scored above 80 in every exam they
-- have taken.
--
-- Return:
-- student_id
-- student_name
-- average_marks
-- exams_taken


-- ============================================================
-- CHALLENGE 5
-- ============================================================
-- Find the department with the highest average student
-- performance.
--
-- First calculate each student's average.
-- Then calculate the average of those student averages
-- for each department.
--
-- Return:
-- department_name
-- student_count
-- department_average


-- ============================================================
-- CHALLENGE 6
-- ============================================================
-- Find the highest scorer for every course.
--
-- If two students have the same highest score, return both.
--
-- Requirement:
-- Use RANK(), DENSE_RANK(), or ROW_NUMBER() appropriately.


-- ============================================================
-- CHALLENGE 7
-- ============================================================
-- Calculate the percentage of students who scored at least
-- 80 in each course.
--
-- Return:
-- course_code
-- course_name
-- total_students
-- students_scoring_80_or_more
-- percentage_above_80


-- ============================================================
-- CHALLENGE 8
-- ============================================================
-- Find students who have taken at least three courses and
-- whose average score is above 75.
--
-- Return:
-- student_id
-- student_name
-- courses_taken
-- average_marks


-- ============================================================
-- CHALLENGE 9
-- ============================================================
-- Identify students who are academically at risk.
--
-- A student is considered at risk if:
--
-- 1. Their average score is below 65
-- OR
-- 2. They have failed at least one exam.
--
-- Return:
-- student_id
-- student_name
-- average_marks
-- failed_exams
-- risk_reason
--
-- Use CASE to explain the reason.


-- ============================================================
-- CHALLENGE 10
-- ============================================================
-- Create a department performance report.
--
-- Return one row per department containing:
--
-- department_name
-- number_of_students
-- number_of_courses
-- average_marks
-- highest_student_average
-- lowest_student_average
--
-- Sort by average_marks descending.


-- ============================================================
-- CHALLENGE 11
-- ============================================================
-- Find the percentage contribution of each department to the
-- total number of students.
--
-- Return:
-- department_name
-- student_count
-- percentage_of_total_students


-- ============================================================
-- CHALLENGE 12
-- ============================================================
-- Find the second-highest scoring student in each department.
--
-- Return:
-- department_name
-- student_name
-- average_marks
--
-- Important:
-- Handle ties correctly.


-- ============================================================
-- CHALLENGE 13
-- ============================================================
-- For every student, calculate the difference between their
-- average score and the average score of their department.
--
-- Return:
-- student_name
-- department_name
-- student_average
-- department_average
-- difference_from_department_average


-- ============================================================
-- CHALLENGE 14
-- ============================================================
-- Find courses where at least one student scored below 50.
--
-- Return:
-- course_code
-- course_name
-- lowest_marks
-- number_of_students_below_50


-- ============================================================
-- CHALLENGE 15
-- ============================================================
-- Create a final student performance report.
--
-- Return:
--
-- student_id
-- student_name
-- department_name
-- courses_taken
-- exams_taken
-- average_marks
-- highest_marks
-- lowest_marks
-- failed_exams
-- performance_category
--
-- Performance categories:
--
-- 90+  = Outstanding
-- 80-89.99 = Excellent
-- 70-79.99 = Good
-- 60-69.99 = Satisfactory
-- Below 60 = Needs Improvement
--
-- Sort students by average_marks descending.


-- ============================================================
-- BONUS CHALLENGE
-- ============================================================
-- Create a department leaderboard.
--
-- Rank departments according to their average student
-- performance.
--
-- Return:
--
-- department_rank
-- department_name
-- student_count
-- average_department_score
--
-- Requirement:
-- Calculate student averages first, then calculate the
-- department average, and finally rank the departments.


-- ============================================================
-- PORTFOLIO CHALLENGE
-- ============================================================
-- Create a single SQL report that identifies:
--
-- 1. Top-performing students
-- 2. Students at academic risk
-- 3. Highest-performing courses
-- 4. Lowest-performing courses
-- 5. Department performance
--
-- Your final result should demonstrate your ability to combine
-- multiple CTEs and window functions into a meaningful
-- academic analytics report.
