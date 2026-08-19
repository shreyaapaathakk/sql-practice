-- =====================================================
-- Module 01 : SQL Basics
-- File       : solutions.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

USE school;


-- =====================================================
-- 🟢 EASY
-- =====================================================

-- -----------------------------------------------------
-- Question 1
-- Display all records from the students table.
-- -----------------------------------------------------

SELECT *
FROM students;


-- -----------------------------------------------------
-- Question 2
-- Display only the first_name and last_name columns.
-- -----------------------------------------------------

SELECT first_name, last_name
FROM students;


-- -----------------------------------------------------
-- Question 3
-- Display first_name, age, and city.
-- -----------------------------------------------------

SELECT first_name, age, city
FROM students;


-- -----------------------------------------------------
-- Question 4
-- Display the student whose student_id is 3.
-- -----------------------------------------------------

SELECT *
FROM students
WHERE student_id = 3;


-- -----------------------------------------------------
-- Question 5
-- Display students who are 20 years old.
-- -----------------------------------------------------

SELECT *
FROM students
WHERE age = 20;


-- =====================================================
-- 🟡 MEDIUM
-- =====================================================

-- -----------------------------------------------------
-- Question 6
-- Display first_name and city of students who live
-- in Delhi.
-- -----------------------------------------------------

SELECT first_name, city
FROM students
WHERE city = 'Delhi';


-- -----------------------------------------------------
-- Question 7
-- Display first_name, last_name, and age of students
-- older than 20.
-- -----------------------------------------------------

SELECT first_name, last_name, age
FROM students
WHERE age > 20;


-- -----------------------------------------------------
-- Question 8
-- Display first_name and city of students who live
-- in Mumbai or Pune.
-- -----------------------------------------------------

SELECT first_name, city
FROM students
WHERE city IN ('Mumbai', 'Pune');


-- -----------------------------------------------------
-- Question 9
-- Display first_name and last_name of students whose
-- age is less than or equal to 20.
-- -----------------------------------------------------

SELECT first_name, last_name
FROM students
WHERE age <= 20;


-- -----------------------------------------------------
-- Question 10
-- Use aliases:
-- student_id → ID
-- first_name → Name
-- city       → Location
-- -----------------------------------------------------

SELECT
    student_id AS ID,
    first_name AS Name,
    city AS Location
FROM students;


-- =====================================================
-- 🔴 HARD
-- =====================================================

-- -----------------------------------------------------
-- Question 11
-- Display students whose age is between 19 and 21.
-- -----------------------------------------------------

SELECT *
FROM students
WHERE age BETWEEN 19 AND 21;


-- -----------------------------------------------------
-- Question 12
-- Display students who do NOT live in Delhi.
-- -----------------------------------------------------

SELECT *
FROM students
WHERE city <> 'Delhi';


-- -----------------------------------------------------
-- Question 13
-- Display the complete record of the oldest student.
-- -----------------------------------------------------

SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);


-- -----------------------------------------------------
-- Question 14
-- Display first_name, last_name, and city of students
-- from Jaipur, Lucknow, or Mumbai.
-- -----------------------------------------------------

SELECT first_name, last_name, city
FROM students
WHERE city IN ('Jaipur', 'Lucknow', 'Mumbai');


-- -----------------------------------------------------
-- Question 15
-- Count the total number of students.
-- -----------------------------------------------------

SELECT COUNT(*) AS total_students
FROM students;


-- =====================================================
-- 🏆 CHALLENGE SOLUTIONS
-- =====================================================

-- -----------------------------------------------------
-- Challenge 1
-- Students who are at least 20 years old.
-- -----------------------------------------------------

SELECT first_name, age
FROM students
WHERE age >= 20;


-- -----------------------------------------------------
-- Challenge 2
-- Number of students who are exactly 20 years old.
-- -----------------------------------------------------

SELECT COUNT(*) AS students_age_20
FROM students
WHERE age = 20;


-- -----------------------------------------------------
-- Challenge 3
-- Students living in Delhi, Mumbai, or Pune and
-- who are at least 20 years old.
-- -----------------------------------------------------

SELECT *
FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Pune')
  AND age >= 20;


-- -----------------------------------------------------
-- Challenge 4
-- Students whose first name starts with 'A'.
-- -----------------------------------------------------

SELECT first_name, last_name, city
FROM students
WHERE first_name LIKE 'A%';


-- -----------------------------------------------------
-- Challenge 5
-- Count all students using the alias student_count.
-- -----------------------------------------------------

SELECT COUNT(*) AS student_count
FROM students;
