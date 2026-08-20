-- =====================================================
-- Module 03 : INSERT, UPDATE & DELETE
-- File       : solutions.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================

USE school;


-- =====================================================
-- 🟢 INSERT — EASY
-- =====================================================

-- Question 1

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES (
    6,
    'Riya',
    'Patel',
    20,
    'Surat'
);


-- Question 2

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES
    (7, 'Karan', 'Mehta', 21, 'Delhi'),
    (8, 'Ananya', 'Sharma', 20, 'Mumbai');


-- Question 3

INSERT INTO students (
    student_id,
    first_name,
    age
)
VALUES (
    9,
    'Karan',
    21
);


-- =====================================================
-- 🟡 UPDATE — MEDIUM
-- =====================================================

-- Question 4

UPDATE students
SET city = 'Varanasi'
WHERE student_id = 1;


-- Question 5

UPDATE students
SET
    age = 22,
    city = 'Pune'
WHERE student_id = 2;


-- Question 6

UPDATE students
SET city = 'Delhi'
WHERE city = 'Lucknow';


-- Question 7

UPDATE students
SET age = age + 1
WHERE student_id = 3;


-- =====================================================
-- 🟡 DELETE — MEDIUM
-- =====================================================

-- Question 8

DELETE FROM students
WHERE student_id = 9;


-- Question 9

DELETE FROM students
WHERE age < 20;


-- Question 10

DELETE FROM students
WHERE city = 'Jaipur';


-- =====================================================
-- 🔴 MIXED PRACTICE
-- =====================================================

-- Question 11

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES (
    10,
    'Ananya',
    'Sharma',
    21,
    'Mumbai'
);


-- Question 12

UPDATE students
SET city = 'Delhi'
WHERE student_id = 10;


-- Question 13

DELETE FROM students
WHERE student_id = 10;


-- Question 14

INSERT INTO students (
    student_id,
    first_name,
    last_name,
    age,
    city
)
VALUES
    (11, 'Aarav', 'Singh', 20, 'Delhi'),
    (12, 'Meera', 'Gupta', 21, 'Pune'),
    (13, 'Vikas', 'Verma', 22, 'Mumbai');


-- Question 15

UPDATE students
SET city = 'Pune'
WHERE city = 'Mumbai';


-- =====================================================
-- 🏆 TRANSACTION PRACTICE
-- =====================================================

-- Question 16

START TRANSACTION;

UPDATE students
SET city = 'Mumbai'
WHERE student_id = 1;

ROLLBACK;


-- Question 17

START TRANSACTION;

UPDATE students
SET city = 'Delhi'
WHERE student_id = 2;

COMMIT;


-- =====================================================
-- ⚠️ SAFETY PRACTICE
-- =====================================================

-- Question 18

SELECT *
FROM students
WHERE age = 20;


-- Question 19

SELECT *
FROM students
WHERE city = 'Jaipur';


-- Question 20

-- Without a WHERE clause, the following UPDATE would
-- modify every record in the students table.

-- UPDATE students
-- SET city = 'Delhi';
