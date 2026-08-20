-- =====================================================
-- Module 02 : Databases & Tables
-- File       : practice.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================


-- =====================================================
-- 🟢 EASY
-- =====================================================

-- -----------------------------------------------------
-- Question 1
-- -----------------------------------------------------
-- Create a database named `library`.


-- -----------------------------------------------------
-- Question 2
-- -----------------------------------------------------
-- Select the `library` database.


-- -----------------------------------------------------
-- Question 3
-- -----------------------------------------------------
-- Display all databases available on the MySQL server.


-- -----------------------------------------------------
-- Question 4
-- -----------------------------------------------------
-- Create a table named `books` with the following columns:
--
-- book_id       INT
-- title         VARCHAR(150)
-- author        VARCHAR(100)
-- price         DECIMAL(8, 2)
-- published_date DATE


-- -----------------------------------------------------
-- Question 5
-- -----------------------------------------------------
-- Display all tables in the currently selected database.


-- -----------------------------------------------------
-- Question 6
-- -----------------------------------------------------
-- Display the structure of the `books` table.


-- =====================================================
-- 🟡 MEDIUM
-- =====================================================

-- -----------------------------------------------------
-- Question 7
-- -----------------------------------------------------
-- Add the following column to the `books` table:
--
-- isbn VARCHAR(20)


-- -----------------------------------------------------
-- Question 8
-- -----------------------------------------------------
-- Add a column named `publisher` with a maximum length
-- of 100 characters.


-- -----------------------------------------------------
-- Question 9
-- -----------------------------------------------------
-- Change the size of the `author` column to VARCHAR(150).


-- -----------------------------------------------------
-- Question 10
-- -----------------------------------------------------
-- Rename the `publisher` column to `publisher_name`.


-- -----------------------------------------------------
-- Question 11
-- -----------------------------------------------------
-- Remove the `isbn` column from the `books` table.


-- -----------------------------------------------------
-- Question 12
-- -----------------------------------------------------
-- Display the complete CREATE TABLE statement for
-- the `books` table.


-- =====================================================
-- 🔴 HARD
-- =====================================================

-- -----------------------------------------------------
-- Question 13
-- -----------------------------------------------------
-- Create another table named `members` with:
--
-- member_id       INT
-- first_name      VARCHAR(50)
-- last_name       VARCHAR(50)
-- email           VARCHAR(100)
-- registration_date DATE


-- -----------------------------------------------------
-- Question 14
-- -----------------------------------------------------
-- Rename the `members` table to `library_members`.


-- -----------------------------------------------------
-- Question 15
-- -----------------------------------------------------
-- Rename the `library_members` table back to `members`.


-- -----------------------------------------------------
-- Question 16
-- -----------------------------------------------------
-- Create a temporary table named `borrowed_books` with:
--
-- book_id       INT
-- member_id     INT
-- borrowed_date DATE


-- -----------------------------------------------------
-- Question 17
-- -----------------------------------------------------
-- Write a command that removes all records from a table
-- while keeping its structure.
--
-- Do not execute it on an important table.


-- -----------------------------------------------------
-- Question 18
-- -----------------------------------------------------
-- Write a command that permanently removes the
-- `borrowed_books` table.


-- =====================================================
-- 🏆 CHALLENGE PREVIEW
-- =====================================================

-- -----------------------------------------------------
-- Challenge
-- -----------------------------------------------------
-- Design a database called `online_store`.
--
-- Create a table named `products` containing suitable
-- columns for:
--
-- - Product ID
-- - Product name
-- - Category
-- - Price
-- - Stock quantity
-- - Product creation date
--
-- Choose appropriate MySQL data types for each column.
--
-- Then inspect the structure of your table.
