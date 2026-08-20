-- =====================================================
-- Module 03 : INSERT, UPDATE & DELETE
-- File       : challenge.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

USE school;


-- =====================================================
-- 🏆 INSERT / UPDATE / DELETE CHALLENGES
-- =====================================================


-- -----------------------------------------------------
-- Challenge 1 — New Student
-- -----------------------------------------------------
-- Insert a new student with your own chosen:
--
-- student_id
-- first_name
-- last_name
-- age
-- city
--
-- Make sure the student_id does not already exist.


-- -----------------------------------------------------
-- Challenge 2 — Multiple Students
-- -----------------------------------------------------
-- Insert five new students using a SINGLE INSERT
-- statement.


-- -----------------------------------------------------
-- Challenge 3 — Correct Student Information
-- -----------------------------------------------------
-- Imagine that student_id 3 has moved to Delhi and
-- is now 20 years old.
--
-- Update both values in a single UPDATE statement.


-- -----------------------------------------------------
-- Challenge 4 — Bulk Update
-- -----------------------------------------------------
-- Suppose every student currently living in Pune
-- has moved to Mumbai.
--
-- Update all matching records.


-- -----------------------------------------------------
-- Challenge 5 — Age Update
-- -----------------------------------------------------
-- Increase the age of every student by 1.
--
-- Think carefully before executing this query.
--
-- First use SELECT to inspect the table.


-- -----------------------------------------------------
-- Challenge 6 — Select Before Delete
-- -----------------------------------------------------
-- Find all students younger than 20.
--
-- First display the records using SELECT.
--
-- Then delete those records.


-- -----------------------------------------------------
-- Challenge 7 — Remove One Student
-- -----------------------------------------------------
-- Find a student using their student_id.
--
-- First display the student.
--
-- Then delete that student.


-- -----------------------------------------------------
-- Challenge 8 — Transaction Rollback
-- -----------------------------------------------------
-- Start a transaction.
--
-- Change the city of at least one student.
--
-- Verify the change using SELECT.
--
-- Then use ROLLBACK and verify that the original
-- value has returned.


-- -----------------------------------------------------
-- Challenge 9 — Transaction Commit
-- -----------------------------------------------------
-- Start a transaction.
--
-- Change the city of a student.
--
-- Verify the change.
--
-- Use COMMIT.
--
-- Verify that the change remains.


-- -----------------------------------------------------
-- Challenge 10 — Safe Bulk Update
-- -----------------------------------------------------
-- Write a SELECT query that identifies all students
-- who are 21 years old.
--
-- Then write an UPDATE statement that changes their
-- city to Delhi.
--
-- Do not execute the UPDATE until you have verified
-- the SELECT results.


-- =====================================================
-- 🔥 BONUS CHALLENGES
-- =====================================================


-- -----------------------------------------------------
-- Bonus 1 — Data Correction
-- -----------------------------------------------------
-- Find all students whose city is NULL.
--
-- Update their city to 'Unknown'.


-- -----------------------------------------------------
-- Bonus 2 — Multiple Conditions
-- -----------------------------------------------------
-- Find students who:
--
-- - Are at least 20 years old
-- - AND live in Delhi or Mumbai
--
-- Then update their city to 'Online'.


-- -----------------------------------------------------
-- Bonus 3 — Delete Carefully
-- -----------------------------------------------------
-- Identify all students who are 22 years old.
--
-- Use SELECT first.
--
-- If the results are correct, delete them.


-- -----------------------------------------------------
-- Bonus 4 — Transaction Safety
-- -----------------------------------------------------
-- Perform the following sequence:
--
-- 1. START TRANSACTION
-- 2. Insert a new student
-- 3. Update another student's city
-- 4. Verify both changes
-- 5. ROLLBACK
-- 6. Verify that both changes were undone


-- -----------------------------------------------------
-- Bonus 5 — Transaction Persistence
-- -----------------------------------------------------
-- Perform the following sequence:
--
-- 1. START TRANSACTION
-- 2. Insert a new student
-- 3. Update another student's age
-- 4. Verify both changes
-- 5. COMMIT
-- 6. Verify that both changes remain


-- =====================================================
-- 💡 Challenge Rules
-- =====================================================

-- 1. Always inspect records before UPDATE or DELETE.
-- 2. Be careful with UPDATE without WHERE.
-- 3. Be careful with DELETE without WHERE.
-- 4. Use transactions when experimenting with
--    potentially destructive operations.
-- 5. Try solving each challenge without opening
--    solutions.sql.
-- 6. Test every query in MySQL 8.0+.
