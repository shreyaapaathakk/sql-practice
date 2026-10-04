-- ============================================================
-- Library Management System
-- File: challenge.sql
-- SQL Dialect: MySQL 8.0+
--
-- Solve these challenges independently.
-- ============================================================

USE library_management;

SET @analysis_date = '2026-10-04';

-- ============================================================
-- CHALLENGE 1
-- ============================================================
-- Find the five most borrowed books.
--
-- Return:
-- book_id
-- title
-- category_name
-- borrow_count


-- ============================================================
-- CHALLENGE 2
-- ============================================================
-- Find the top three most active members.
--
-- Return:
-- member_id
-- member_name
-- total_loans
--
-- Use ORDER BY and LIMIT.


-- ============================================================
-- CHALLENGE 3
-- ============================================================
-- Find all books that have never been borrowed.
--
-- Return:
-- book_id
-- title
-- category_name
--
-- Hint:
-- Consider using LEFT JOIN.


-- ============================================================
-- CHALLENGE 4
-- ============================================================
-- Find members who currently have more than one book borrowed.
--
-- Return:
-- member_id
-- member_name
-- current_loans


-- ============================================================
-- CHALLENGE 5
-- ============================================================
-- Find all currently overdue books.
--
-- A book is overdue when:
--
-- return_date IS NULL
-- AND due_date is earlier than @analysis_date
--
-- Return:
-- loan_id
-- book_title
-- member_name
-- due_date
-- days_overdue


-- ============================================================
-- CHALLENGE 6
-- ============================================================
-- Find the members with unpaid fines.
--
-- Return:
-- member_id
-- member_name
-- total_unpaid_fines
--
-- Sort by total_unpaid_fines descending.


-- ============================================================
-- CHALLENGE 7
-- ============================================================
-- Calculate the percentage of books currently unavailable.
--
-- Return:
-- total_copies
-- available_copies
-- borrowed_copies
-- unavailable_percentage


-- ============================================================
-- CHALLENGE 8
-- ============================================================
-- Find the most borrowed author.
--
-- Because a book can have multiple authors, use the
-- book_authors relationship correctly.
--
-- Return:
-- author_id
-- author_name
-- total_borrowings


-- ============================================================
-- CHALLENGE 9
-- ============================================================
-- Find the most popular category based on total borrowing
-- activity.
--
-- Return:
-- category_name
-- total_borrowings
--
-- Return the top category.


-- ============================================================
-- CHALLENGE 10
-- ============================================================
-- Calculate the average number of days that returned books
-- were kept by members.
--
-- Return:
-- average_borrowing_days


-- ============================================================
-- CHALLENGE 11
-- ============================================================
-- Rank all books according to borrowing frequency.
--
-- Return:
-- title
-- borrow_count
-- popularity_rank
--
-- Requirement:
-- Use RANK().


-- ============================================================
-- CHALLENGE 12
-- ============================================================
-- Rank books within each category according to the number
-- of times they were borrowed.
--
-- Return:
-- title
-- category_name
-- borrow_count
-- category_rank
--
-- Requirement:
-- Use a window function with PARTITION BY.


-- ============================================================
-- CHALLENGE 13
-- ============================================================
-- Find the most borrowed book in each category.
--
-- If two books are tied for first place, return both.


-- ============================================================
-- CHALLENGE 14
-- ============================================================
-- Find members who have borrowed more books than the
-- average number of loans per member.
--
-- Return:
-- member_name
-- total_loans


-- ============================================================
-- CHALLENGE 15
-- ============================================================
-- Find books that are currently unavailable because every
-- copy is currently borrowed.
--
-- Return:
-- title
-- total_copies
-- available_copies


-- ============================================================
-- CHALLENGE 16
-- ============================================================
-- Create a member borrowing report.
--
-- Return one row per member containing:
--
-- member_id
-- member_name
-- membership_status
-- total_loans
-- current_loans
-- returned_loans
-- total_fines
-- unpaid_fines
--
-- Members with no loans must still appear.


-- ============================================================
-- CHALLENGE 17
-- ============================================================
-- Find the category with the highest number of available
-- copies.
--
-- Return:
-- category_name
-- available_copies


-- ============================================================
-- CHALLENGE 18
-- ============================================================
-- Find authors who have never had any of their books borrowed.
--
-- Return:
-- author_id
-- author_name


-- ============================================================
-- CHALLENGE 19
-- ============================================================
-- Create an overdue risk report.
--
-- Risk rules:
--
-- More than 14 days overdue = High Risk
-- 8-14 days overdue = Medium Risk
-- 1-7 days overdue = Low Risk
--
-- Return:
-- member_name
-- book_title
-- days_overdue
-- risk_level


-- ============================================================
-- CHALLENGE 20
-- ============================================================
-- Calculate monthly borrowing activity.
--
-- Return:
-- year
-- month
-- total_loans
--
-- Sort chronologically.


-- ============================================================
-- CHALLENGE 21
-- ============================================================
-- Find the month with the highest borrowing activity.
--
-- Return:
-- year
-- month
-- total_loans


-- ============================================================
-- CHALLENGE 22
-- ============================================================
-- Calculate each category's percentage contribution to
-- total library borrowing activity.
--
-- Return:
-- category_name
-- total_borrowings
-- percentage_of_total


-- ============================================================
-- CHALLENGE 23
-- ============================================================
-- Find members who have both:
--
-- 1. At least three total loans
-- 2. At least one unpaid fine
--
-- Return:
-- member_name
-- total_loans
-- unpaid_fines


-- ============================================================
-- CHALLENGE 24
-- ============================================================
-- Find the second most borrowed book.
--
-- Handle ties correctly.


-- ============================================================
-- CHALLENGE 25
-- ============================================================
-- Create a complete library performance report.
--
-- Include:
--
-- Total books
-- Total copies
-- Available copies
-- Currently borrowed copies
-- Total members
-- Active members
-- Total loans
-- Total fines
-- Unpaid fines
-- Most borrowed book
-- Most active member
-- Most popular category
--
-- Use CTEs and/or subqueries to produce the report.


-- ============================================================
-- PORTFOLIO CHALLENGE
-- ============================================================
-- Build a complete Library Analytics Report.
--
-- Your report should contain:
--
-- 1. Library inventory summary
-- 2. Most borrowed books
-- 3. Most active members
-- 4. Category performance
-- 5. Author popularity
-- 6. Current loans
-- 7. Overdue loans
-- 8. Fine collection summary
-- 9. Monthly borrowing trends
-- 10. Book popularity rankings
--
-- Requirements:
--
-- - Use at least three CTEs.
-- - Use at least one window function.
-- - Use conditional aggregation.
-- - Use meaningful column aliases.
-- - Sort results logically.
--
-- The goal is to create a report that could realistically
-- be presented to a library manager.
