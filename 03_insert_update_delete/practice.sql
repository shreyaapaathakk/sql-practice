-- =====================================================
-- Module 03 : INSERT, UPDATE & DELETE
-- File       : practice.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

USE school;


-- =====================================================
-- Practice Table
-- =====================================================
--
-- students
--
-- | student_id | first_name | last_name | age | city    |
-- |------------|------------|-----------|-----|---------|
-- | 1          | Rahul      | Sharma    | 20  | Delhi   |
-- | 2          | Priya      | Singh     | 21  | Mumbai  |
-- | 3          | Aman       | Verma     | 19  | Jaipur  |
-- | 4          | Neha       | Gupta     | 22  | Pune    |
-- | 5          | Arjun      | Mehta     | 20  | Lucknow |
--
-- =====================================================


-- =====================================================
-- 🟢 INSERT — EASY
-- =====================================================

-- Question 1
-- Insert a new student:
--
-- student_id: 6
-- first_name: Riya
-- last_name: Patel
-- age: 20
-- city: Surat


-- Question 2
-- Insert two new students in a single INSERT statement.


-- Question 3
-- Insert a student with:
--
-- student_id: 9
-- first_name: Karan
-- age: 21
--
-- Leave last_name and city as NULL.


-- =====================================================
-- 🟡 UPDATE — MEDIUM
-- =====================================================

-- Question 4
-- Change Rahul's city from Delhi to Varanasi.


-- Question 5
-- Change Priya's age to 22 and city to Pune.


-- Question 6
-- Change the city of all students who currently
-- live in Lucknow to Delhi.


-- Question 7
-- Increase the age of student_id 3 by 1.


-- =====================================================
-- 🟡 DELETE — MEDIUM
-- =====================================================

-- Question 8
-- Delete the student whose student_id is 9.


-- Question 9
-- Delete all students who are younger than 20.


-- Question 10
-- Delete all students who live in Jaipur.


-- =====================================================
-- 🔴 MIXED PRACTICE
-- =====================================================

-- Question 11
-- Insert a new student named "Ananya Sharma",
-- age 21, from Mumbai.


-- Question 12
-- Update Ananya's city to Delhi.


-- Question 13
-- Delete Ananya from the table.


-- Question 14
-- Insert three students using a single INSERT statement.


-- Question 15
-- Change the city of every student who lives in
-- Mumbai to Pune.


-- =====================================================
-- 🏆 TRANSACTION PRACTICE
-- =====================================================

-- Question 16
-- Start a transaction and change student_id 1's
-- city to Mumbai.
--
-- Then undo the change using ROLLBACK.


-- Question 17
-- Start another transaction and change student_id 2's
-- city to Delhi.
--
-- Save the change using COMMIT.


-- =====================================================
-- ⚠️ SAFETY PRACTICE
-- =====================================================

-- Question 18
-- Before updating all students who are 20 years old,
-- write a SELECT query that identifies exactly which
-- rows will be affected.


-- Question 19
-- Before deleting all students from Jaipur, write
-- a SELECT query that identifies the affected rows.


-- Question 20
-- Explain in a SQL comment what would happen if you
-- executed:
--
-- UPDATE students
-- SET city = 'Delhi';
--
-- Do not execute the statement.
