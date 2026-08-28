-- ============================================================
-- MODULE 13: NULL HANDLING
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- Dataset:
--
-- student_details
--
-- Columns:
-- student_id
-- email
-- phone
-- scholarship
-- mentor


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1
-- Find all students whose phone number is NULL.


-- Exercise 2
-- Find all students whose phone number is NOT NULL.


-- Exercise 3
-- Find all students whose email is NULL.


-- Exercise 4
-- Find all students whose scholarship is NULL.


-- Exercise 5
-- Count the total number of students.


-- Exercise 6
-- Count how many students have a phone number.


-- Exercise 7
-- Count how many students have an email address.


-- Exercise 8
-- Display each student's phone number.
--
-- If phone is NULL, display:
-- 'Not Provided'
--
-- Use COALESCE().


-- Exercise 9
-- Display each student's scholarship.
--
-- If scholarship is NULL, display 0.
--
-- Use IFNULL().


-- Exercise 10
-- Find students who have both:
--
-- phone
-- email
--
-- Neither value should be NULL.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11
-- Find students who have neither a phone number
-- nor an email address.


-- Exercise 12
-- Find students who have at least one contact method.


-- Exercise 13
-- Count the number of students missing a phone number.


-- Exercise 14
-- Count the number of students missing an email address.


-- Exercise 15
-- Calculate the percentage of students
-- who are missing a phone number.


-- Exercise 16
-- Calculate the total scholarship amount.
--
-- NULL values should be handled normally by SUM().


-- Exercise 17
-- Calculate the average scholarship amount.


-- Exercise 18
-- Find the minimum and maximum scholarship amounts.


-- Exercise 19
-- Display:
--
-- student_id
-- phone_status
--
-- phone_status should be:
-- 'Available'
-- 'Missing'
--
-- Use CASE.


-- Exercise 20
-- Display:
--
-- student_id
-- contact
--
-- Use COALESCE() in this order:
--
-- phone
-- email
-- 'No Contact Information'


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21
-- Find students whose mentor is NULL.


-- Exercise 22
-- Display every distinct mentor.
--
-- Include the NULL group.


-- Exercise 23
-- Count students in each mentor group.
--
-- Remember that NULL mentors form their own group.


-- Exercise 24
-- Display scholarship values with NULL replaced by 0.
--
-- Do not modify the table.


-- Exercise 25
-- Assume that scholarship value 0 means
-- 'missing scholarship information'.
--
-- Use NULLIF() to convert 0 to NULL in the result.


-- Exercise 26
-- Find students whose email is either NULL
-- or an empty string.


-- Exercise 27
-- Use NULLIF() to convert an empty email string
-- into NULL.


-- Exercise 28
-- Create a cleaned email report.
--
-- Requirements:
--
-- 1. Convert empty strings to NULL.
-- 2. Replace NULL with 'Not Provided'.
--
-- Use NULLIF() and COALESCE().


-- Exercise 29
-- Create a data-quality report containing:
--
-- total_students
-- students_with_email
-- students_without_email
-- students_with_phone
-- students_without_phone


-- Exercise 30
-- Sort students so that:
--
-- 1. Students with scholarship values appear first.
-- 2. Students with NULL scholarship values appear last.
-- 3. Within non-NULL values, sort from highest to lowest.


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31
-- Display:
--
-- student_id
-- scholarship_status
--
-- Rules:
--
-- NULL → 'Not Recorded'
-- 0    → 'No Scholarship'
-- > 0  → 'Scholarship Available'


-- Exercise 32
-- Display:
--
-- student_id
-- contact_status
--
-- Rules:
--
-- phone AND email available
--     → 'Complete'
--
-- at least one available
--     → 'Partial'
--
-- neither available
--     → 'Missing'


-- Exercise 33
-- Calculate the percentage of students
-- who have complete contact information.
--
-- Complete means:
--
-- phone IS NOT NULL
-- AND
-- email IS NOT NULL


-- Exercise 34
-- Find students whose scholarship is either:
--
-- greater than 3000
-- OR NULL.
--
-- Return student_id and scholarship.


-- Exercise 35
-- Create a report showing:
--
-- student_id
-- email
-- phone
-- preferred_contact
--
-- preferred_contact should use:
--
-- phone
-- email
-- 'No Contact'
--
-- in that order.


-- Exercise 36
-- Find students whose mentor is NULL
-- but who have at least one contact method.


-- Exercise 37
-- Calculate:
--
-- total_students
-- total_scholarship_records
-- missing_scholarship_records
--
-- Use COUNT(*) and COUNT(scholarship).


-- Exercise 38
-- Create a scholarship report:
--
-- student_id
-- scholarship
-- scholarship_amount
--
-- Replace NULL scholarship with 0
-- using COALESCE().


-- Exercise 39
-- Create an email-cleaning report:
--
-- student_id
-- original_email
-- cleaned_email
--
-- Convert empty strings to NULL and then
-- replace NULL with 'Not Provided'.


-- Exercise 40
-- Create a complete NULL analysis report containing:
--
-- student_id
-- email_status
-- phone_status
-- scholarship_status
-- mentor_status
--
-- Each status should indicate:
--
-- 'Available'
-- or
-- 'Missing'
