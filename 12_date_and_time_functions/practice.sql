-- ============================================================
-- MODULE 12: DATE & TIME FUNCTIONS
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- The exercises use:
--
-- student_records
--
-- Columns:
-- record_id
-- student_id
-- enrollment_date
-- last_login
-- birth_date


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Display the current date.


-- Exercise 2
-- Display the current date and time.


-- Exercise 3
-- Display the current time.


-- Exercise 4
-- Display each student's:
--
-- student_id
-- enrollment_date
-- enrollment year


-- Exercise 5
-- Display:
--
-- student_id
-- enrollment_date
-- enrollment month number


-- Exercise 6
-- Display the month name for each enrollment_date.


-- Exercise 7
-- Display the weekday name for each enrollment_date.


-- Exercise 8
-- Display the date portion of last_login.


-- Exercise 9
-- Display the time portion of last_login.


-- Exercise 10
-- Display the year, month, and day of enrollment_date
-- using EXTRACT().


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11
-- Calculate how many days have passed since each student's
-- enrollment date.


-- Exercise 12
-- Calculate the date 30 days after each student's
-- enrollment date.


-- Exercise 13
-- Calculate the date 7 days before each student's
-- enrollment date.


-- Exercise 14
-- Calculate each student's age using birth_date.
--
-- Use TIMESTAMPDIFF().


-- Exercise 15
-- Display the last day of the month for each
-- enrollment_date.


-- Exercise 16
-- Format enrollment_date as:
--
-- DD-MM-YYYY


-- Exercise 17
-- Format last_login as:
--
-- YYYY/MM/DD HH:MM


-- Exercise 18
-- Find students who enrolled during August 2026.


-- Exercise 19
-- Find students who enrolled during the first half
-- of 2026.


-- Exercise 20
-- Display the three most recently enrolled students.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21
-- Calculate a 90-day course completion date for
-- every student.


-- Exercise 22
-- Find students who enrolled more than 100 days ago.


-- Exercise 23
-- Find students whose age is at least 20.


-- Exercise 24
-- Display:
--
-- student_id
-- enrollment_date
-- days_since_enrollment
-- enrollment_status
--
-- Rules:
--
-- 180 or more days → 'Long-Term'
-- less than 180 days → 'Recent'


-- Exercise 25
-- Find students whose last_login occurred during
-- August 27, 2026.


-- Exercise 26
-- Find the student with the earliest enrollment_date.


-- Exercise 27
-- Find the student with the latest enrollment_date.


-- Exercise 28
-- Sort students by age from oldest to youngest.
--
-- If two students have the same age,
-- sort by student_id.


-- Exercise 29
-- Display:
--
-- student_id
-- enrollment_date
-- month_name
-- day_name
--
-- Sort by enrollment_date.


-- Exercise 30
-- Create a report containing:
--
-- student_id
-- age
-- enrollment_date
-- course_end_date
-- days_since_enrollment
--
-- Course end date should be 90 days after enrollment.


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31
-- Find all students who enrolled between
-- February 1, 2026 and June 30, 2026.
--
-- Include both boundary dates.


-- Exercise 32
-- Find students whose enrollment occurred in
-- the same year as 2026 without using:
--
-- YEAR(enrollment_date) = 2026
--
-- Use a date range instead.


-- Exercise 33
-- Find students whose last_login occurred today.
--
-- Assume last_login is a DATETIME column.


-- Exercise 34
-- Find students whose last_login occurred
-- within the last 7 days.


-- Exercise 35
-- Create a formatted student report:
--
-- Student #1 | Enrolled: 15-01-2026
--
-- Use CONCAT() and DATE_FORMAT().


-- Exercise 36
-- Display each student's:
--
-- student_id
-- birth_date
-- age_in_years
-- age_in_months
--
-- Calculate age_in_months using TIMESTAMPDIFF().


-- Exercise 37
-- Determine the number of days between:
--
-- enrollment_date
-- course_end_date
--
-- where course_end_date is 90 days after enrollment.


-- Exercise 38
-- Find students whose enrollment date falls
-- in the month of their birth month.


-- Exercise 39
-- Find students who enrolled on a weekend.
--
-- Use a date function rather than manually listing
-- individual dates.


-- Exercise 40
-- Create a complete student timeline containing:
--
-- student_id
-- birth_date
-- enrollment_date
-- last_login
-- age
-- days_since_enrollment
-- course_end_date
--
-- Sort by enrollment_date.
