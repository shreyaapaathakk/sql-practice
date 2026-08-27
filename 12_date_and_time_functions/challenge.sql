-- ============================================================
-- MODULE 12: DATE & TIME FUNCTIONS
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Current Date Components
-- ============================================================
-- Display:
--
-- current_date
-- current_year
-- current_month
-- current_day
--
-- Use CURDATE(), YEAR(), MONTH(), and DAY().


-- ============================================================
-- CHALLENGE 2 — Enrollment Calendar
-- ============================================================
-- Display:
--
-- student_id
-- enrollment_date
-- month_name
-- day_name
--
-- Sort by enrollment_date.


-- ============================================================
-- CHALLENGE 3 — Course Deadline
-- ============================================================
-- Assume every student has a 120-day course.
--
-- Display:
--
-- student_id
-- enrollment_date
-- course_end_date
--
-- Calculate course_end_date using DATE_ADD().


-- ============================================================
-- CHALLENGE 4 — Days Remaining
-- ============================================================
-- Calculate how many days remain until the
-- 120-day course_end_date.
--
-- Display:
--
-- student_id
-- course_end_date
-- days_remaining
--
-- A negative value means the course has already ended.


-- ============================================================
-- CHALLENGE 5 — Enrollment Age
-- ============================================================
-- Display:
--
-- student_id
-- enrollment_date
-- enrollment_age_days
--
-- enrollment_age_days should represent the number
-- of days since enrollment.


-- ============================================================
-- CHALLENGE 6 — Birthday Month
-- ============================================================
-- Find students whose birthday month is August.
--
-- Do not compare the complete birth_date.


-- ============================================================
-- CHALLENGE 7 — Weekend Enrollment
-- ============================================================
-- Find all students who enrolled on Saturday or Sunday.
--
-- Use a date function.


-- ============================================================
-- CHALLENGE 8 — Recent Activity
-- ============================================================
-- Find students whose last_login occurred within
-- the previous 3 days from the current timestamp.


-- ============================================================
-- CHALLENGE 9 — Monthly Report
-- ============================================================
-- Display:
--
-- enrollment_month
-- number of students enrolled
--
-- Group the records by enrollment month.
--
-- You may use aggregate functions from previous modules.


-- ============================================================
-- CHALLENGE 10 — Yearly Report
-- ============================================================
-- Display:
--
-- enrollment_year
-- number_of_students
--
-- Group by enrollment year.


-- ============================================================
-- CHALLENGE 11 — Oldest Student
-- ============================================================
-- Find the student with the earliest birth_date.
--
-- Return:
--
-- student_id
-- birth_date
-- age


-- ============================================================
-- CHALLENGE 12 — Youngest Student
-- ============================================================
-- Find the student with the latest birth_date.
--
-- Return:
--
-- student_id
-- birth_date
-- age


-- ============================================================
-- CHALLENGE 13 — Interview Style
-- ============================================================
-- Explain and demonstrate the difference between:
--
-- DATEDIFF()
-- TIMESTAMPDIFF()
--
-- Use the student_records table.


-- ============================================================
-- CHALLENGE 14 — Interview Style
-- ============================================================
-- Why is this potentially problematic when last_login
-- is a DATETIME column?
--
-- WHERE last_login = CURDATE()
--
-- Write a better query for finding records created
-- during the current day.


-- ============================================================
-- CHALLENGE 15 — Interview Style
-- ============================================================
-- Find all records from August 2026.
--
-- Write the query using a date range.
--
-- Avoid:
--
-- MONTH(enrollment_date) = 8


-- ============================================================
-- CHALLENGE 16 — Age Analysis
-- ============================================================
-- Display:
--
-- student_id
-- age
-- age_group
--
-- Rules:
--
-- under 20 → 'Under 20'
-- 20–21    → '20-21'
-- 22+      → '22 or Older'
--
-- Use TIMESTAMPDIFF() and CASE.


-- ============================================================
-- CHALLENGE 17 — Enrollment Status
-- ============================================================
-- Assume a course lasts 90 days.
--
-- Categorize each student:
--
-- course_end_date <= CURDATE()
--     → 'Completed'
--
-- course_end_date > CURDATE()
--     → 'Active'
--
-- Display:
--
-- student_id
-- course_end_date
-- status


-- ============================================================
-- CHALLENGE 18 — Date Formatting
-- ============================================================
-- Create:
--
-- student_id
-- formatted_enrollment
--
-- Format the enrollment date like:
--
-- 15 January 2026
--
-- Use DATE_FORMAT().


-- ============================================================
-- CHALLENGE 19 — Student Timeline
-- ============================================================
-- Create a readable timeline:
--
-- Student #1 | Born: 12 April 2005 | Enrolled: 15 January 2026
--
-- Use:
--
-- CONCAT()
-- DATE_FORMAT()


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Build a complete student activity report.
--
-- Include:
--
-- student_id
-- age
-- enrollment_date
-- enrollment_month
-- enrollment_day
-- last_login
-- days_since_enrollment
-- course_end_date
-- course_status
--
-- Requirements:
--
-- 1. Calculate age with TIMESTAMPDIFF().
-- 2. Extract the month name.
-- 3. Extract the weekday name.
-- 4. Calculate days since enrollment.
-- 5. Assume the course lasts 90 days.
-- 6. Calculate course_end_date.
-- 7. Use CASE for course_status.
-- 8. Sort by enrollment_date.
--
-- Keep the query clean and readable.
