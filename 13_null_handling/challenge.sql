-- ============================================================
-- MODULE 13: NULL HANDLING
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- CHALLENGE 1 — Missing Data Audit
-- ============================================================
-- Create a report showing:
--
-- total_students
-- missing_email
-- missing_phone
-- missing_scholarship
-- missing_mentor
--
-- Use COUNT(*) and COUNT(column).


-- ============================================================
-- CHALLENGE 2 — Contact Priority
-- ============================================================
-- Create:
--
-- student_id
-- preferred_contact
--
-- Contact priority:
--
-- 1. phone
-- 2. email
-- 3. 'No Contact Available'
--
-- Use COALESCE().


-- ============================================================
-- CHALLENGE 3 — Contact Completeness
-- ============================================================
-- Categorize every student as:
--
-- 'Complete'
-- 'Partial'
-- 'Missing'
--
-- Complete:
-- phone and email both available
--
-- Partial:
-- exactly one is available
--
-- Missing:
-- both are NULL
--
-- Use CASE.


-- ============================================================
-- CHALLENGE 4 — Scholarship Status
-- ============================================================
-- Categorize scholarship information:
--
-- NULL → 'Unknown'
-- 0    → 'No Scholarship'
-- > 0  → 'Awarded'
--
-- Return:
--
-- student_id
-- scholarship
-- status


-- ============================================================
-- CHALLENGE 5 — Data Quality Percentage
-- ============================================================
-- Calculate the percentage of students who have:
--
-- 1. an email
-- 2. a phone
-- 3. both email and phone
--
-- Return all three percentages in one result.


-- ============================================================
-- CHALLENGE 6 — Interview Question
-- ============================================================
-- What is the difference between:
--
-- COUNT(*)
-- COUNT(column)
--
-- Demonstrate the difference using student_details.


-- ============================================================
-- CHALLENGE 7 — Interview Question
-- ============================================================
-- Explain why this query does not correctly find NULL values:
--
-- WHERE phone = NULL
--
-- Write the correct version.


-- ============================================================
-- CHALLENGE 8 — Interview Question
-- ============================================================
-- Explain the difference between:
--
-- COALESCE()
-- IFNULL()
--
-- Demonstrate both using the phone column.


-- ============================================================
-- CHALLENGE 9 — Data Cleaning
-- ============================================================
-- Assume empty email strings represent missing data.
--
-- Build a cleaned email column that:
--
-- 1. Converts '' to NULL.
-- 2. Replaces NULL with 'Not Provided'.
--
-- Use NULLIF() and COALESCE().


-- ============================================================
-- CHALLENGE 10 — NULL and Zero
-- ============================================================
-- Explain why NULL and 0 should not automatically be
-- treated as the same value.
--
-- Demonstrate the difference using scholarship.


-- ============================================================
-- CHALLENGE 11 — Mentor Analysis
-- ============================================================
-- Show:
--
-- mentor
-- student_count
--
-- Include the NULL mentor group.
--
-- Sort so that named mentors appear first
-- and NULL appears last.


-- ============================================================
-- CHALLENGE 12 — Complete Contact Report
-- ============================================================
-- Build a report containing:
--
-- student_id
-- email
-- phone
-- contact_status
-- preferred_contact
--
-- Rules:
--
-- contact_status:
-- both available → 'Complete'
-- one available  → 'Partial'
-- neither        → 'Missing'
--
-- preferred_contact:
-- phone
-- email
-- 'No Contact'


-- ============================================================
-- CHALLENGE 13 — Scholarship Report
-- ============================================================
-- Create a report containing:
--
-- student_id
-- scholarship
-- display_scholarship
-- scholarship_status
--
-- display_scholarship should replace NULL with 0.
--
-- scholarship_status:
-- NULL → 'Not Recorded'
-- 0    → 'No Scholarship'
-- > 0  → 'Awarded'


-- ============================================================
-- CHALLENGE 14 — Missing Data Ranking
-- ============================================================
-- Rank students by the number of missing fields among:
--
-- email
-- phone
-- scholarship
-- mentor
--
-- Display:
--
-- student_id
-- missing_field_count
--
-- Sort from most missing information to least.


-- ============================================================
-- CHALLENGE 15 — Interview Style
-- ============================================================
-- Explain what happens when NULL participates in:
--
-- arithmetic
-- comparison
-- aggregate functions
--
-- Demonstrate each behavior with SQL queries.


-- ============================================================
-- CHALLENGE 16 — Safe Division
-- ============================================================
-- Demonstrate how NULLIF() can prevent division by zero.
--
-- Create a query that calculates:
--
-- total_scholarship / number_of_students
--
-- while safely handling a denominator of zero.


-- ============================================================
-- CHALLENGE 17 — Data Quality Dashboard
-- ============================================================
-- Create one result containing:
--
-- total_students
-- students_with_email
-- students_without_email
-- students_with_phone
-- students_without_phone
-- students_with_scholarship
-- students_without_scholarship
--
-- Use aggregate functions.


-- ============================================================
-- CHALLENGE 18 — NULL Sorting
-- ============================================================
-- Sort students so that:
--
-- 1. Students with scholarship values appear first.
-- 2. Higher scholarships appear first.
-- 3. NULL scholarship values appear last.


-- ============================================================
-- CHALLENGE 19 — Multiple Fallbacks
-- ============================================================
-- Create:
--
-- student_id
-- best_available_information
--
-- Priority:
--
-- phone
-- email
-- mentor
-- 'No Information'
--
-- Use COALESCE().


-- ============================================================
-- CHALLENGE 20 — Portfolio Challenge
-- ============================================================
-- Build a complete data-quality report.
--
-- Include:
--
-- student_id
-- email_status
-- phone_status
-- scholarship_status
-- mentor_status
-- missing_field_count
-- preferred_contact
--
-- Requirements:
--
-- 1. Use IS NULL / IS NOT NULL.
-- 2. Use CASE.
-- 3. Use COALESCE().
-- 4. Count how many of the four fields are NULL.
-- 5. Provide a preferred contact.
-- 6. Sort students from most incomplete to least
--    incomplete.
--
-- Keep the query readable and professional.
