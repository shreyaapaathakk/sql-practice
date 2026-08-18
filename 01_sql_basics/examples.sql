
-- =====================================================
-- Module 01 : SQL Basics
-- File       : examples.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

-- -----------------------------------------------------
-- 1. Create a Database
-- -----------------------------------------------------

CREATE DATABASE school;

-- Select the database
USE school;


-- -----------------------------------------------------
-- 2. Create a Table
-- -----------------------------------------------------

CREATE TABLE students (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);


-- -----------------------------------------------------
-- 3. View Available Tables
-- -----------------------------------------------------

SHOW TABLES;


-- -----------------------------------------------------
-- 4. View Table Structure
-- -----------------------------------------------------

DESCRIBE students;

-- Short form
DESC students;


-- -----------------------------------------------------
-- 5. Insert Records
-- -----------------------------------------------------

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES
    (1, 'Rahul', 'Sharma', 20, 'Delhi'),
    (2, 'Priya', 'Singh', 21, 'Mumbai'),
    (3, 'Aman', 'Verma', 19, 'Jaipur'),
    (4, 'Neha', 'Gupta', 22, 'Pune'),
    (5, 'Arjun', 'Mehta', 20, 'Lucknow');


-- -----------------------------------------------------
-- 6. Display All Data
-- -----------------------------------------------------

SELECT *
FROM students;


-- -----------------------------------------------------
-- 7. Select Specific Columns
-- -----------------------------------------------------

SELECT first_name, city
FROM students;


-- -----------------------------------------------------
-- 8. Display Student Names Only
-- -----------------------------------------------------

SELECT first_name, last_name
FROM students;


-- -----------------------------------------------------
-- 9. Display Ages Only
-- -----------------------------------------------------

SELECT age
FROM students;


-- -----------------------------------------------------
-- 10. Give Columns Friendly Names (Aliases)
-- -----------------------------------------------------

SELECT
    first_name AS FirstName,
    last_name AS LastName,
    city AS City
FROM students;


-- -----------------------------------------------------
-- 11. Select a Single Student Record
-- -----------------------------------------------------

SELECT *
FROM students
WHERE student_id = 3;


-- -----------------------------------------------------
-- 12. Count Total Students
-- -----------------------------------------------------

SELECT COUNT(*) AS total_students
FROM students;


-- -----------------------------------------------------
-- 13. Display Table Information
-- -----------------------------------------------------

SHOW COLUMNS FROM students;


-- -----------------------------------------------------
-- 14. SQL Comments Example
-- -----------------------------------------------------

-- This query displays every student
SELECT *
FROM students;

# MySQL also supports this comment style
SELECT first_name
FROM students;

/*
    Multi-line comments are useful
    for explaining larger SQL blocks.
*/
SELECT city
FROM students;


-- -----------------------------------------------------
-- 15. Complete Database Preview
-- -----------------------------------------------------

SELECT
    student_id,
    first_name,
    last_name,
    age,
    city
FROM students;
