-- =====================================================
-- Module 03 : INSERT, UPDATE & DELETE
-- File       : examples.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

CREATE DATABASE IF NOT EXISTS school;

USE school;


-- =====================================================
-- 1. Create Practice Table
-- =====================================================

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    city VARCHAR(50)
);


-- =====================================================
-- 2. Insert a Single Record
-- =====================================================

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES (
    1,
    'Rahul',
    'Sharma',
    20,
    'Delhi'
);


-- =====================================================
-- 3. Insert Multiple Records
-- =====================================================

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES
    (2, 'Priya', 'Singh', 21, 'Mumbai'),
    (3, 'Aman', 'Verma', 19, 'Jaipur'),
    (4, 'Neha', 'Gupta', 22, 'Pune'),
    (5, 'Arjun', 'Mehta', 20, 'Lucknow');


-- =====================================================
-- 4. View Inserted Data
-- =====================================================

SELECT *
FROM students;


-- =====================================================
-- 5. Insert Using Selected Columns
-- =====================================================

INSERT INTO students (
    student_id,
    first_name,
    age
)
VALUES (
    6,
    'Riya',
    20
);


-- =====================================================
-- 6. Check the New Record
-- =====================================================

SELECT *
FROM students
WHERE student_id = 6;


-- =====================================================
-- 7. Insert a NULL Value
-- =====================================================

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES (
    7,
    'Karan',
    'Patel',
    21,
    NULL
);


-- =====================================================
-- 8. Update a Single Column
-- =====================================================

UPDATE students
SET city = 'Varanasi'
WHERE student_id = 1;


-- Verify the update
SELECT *
FROM students
WHERE student_id = 1;


-- =====================================================
-- 9. Update Multiple Columns
-- =====================================================

UPDATE students
SET
    age = 21,
    city = 'Delhi'
WHERE student_id = 2;


-- =====================================================
-- 10. Update Multiple Records
-- =====================================================

UPDATE students
SET city = 'Delhi'
WHERE city = 'Pune';


-- Verify
SELECT *
FROM students;


-- =====================================================
-- 11. Delete a Single Record
-- =====================================================

DELETE FROM students
WHERE student_id = 7;


-- =====================================================
-- 12. Delete Multiple Records
-- =====================================================

DELETE FROM students
WHERE age < 20;


-- =====================================================
-- 13. Check Remaining Records
-- =====================================================

SELECT *
FROM students;


-- =====================================================
-- 14. Using SELECT Before UPDATE
-- =====================================================

-- First identify the rows:

SELECT *
FROM students
WHERE age = 20;


-- Then update them:

UPDATE students
SET city = 'Delhi'
WHERE age = 20;


-- =====================================================
-- 15. Using SELECT Before DELETE
-- =====================================================

-- First identify the rows:

SELECT *
FROM students
WHERE city = 'Lucknow';


-- Then delete them:

DELETE FROM students
WHERE city = 'Lucknow';


-- =====================================================
-- 16. Transaction Example
-- =====================================================

START TRANSACTION;

UPDATE students
SET city = 'Mumbai'
WHERE student_id = 3;

-- Undo the change:
ROLLBACK;


-- =====================================================
-- 17. Transaction with COMMIT
-- =====================================================

START TRANSACTION;

UPDATE students
SET city = 'Mumbai'
WHERE student_id = 3;

-- Save the change:
COMMIT;


-- =====================================================
-- 18. Final Data
-- =====================================================

SELECT *
FROM students;
