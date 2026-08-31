-- ============================================================
-- MODULE 15: INDEXES
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1

DROP TABLE IF EXISTS practice_index_students;

CREATE TABLE practice_index_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    age INT
);


-- Exercise 2

INSERT INTO practice_index_students
    (student_id, first_name, last_name, city, age)
VALUES
    (1, 'Rahul', 'Sharma', 'Delhi', 20),
    (2, 'Priya', 'Singh', 'Mumbai', 21),
    (3, 'Aman', 'Verma', 'Jaipur', 19),
    (4, 'Neha', 'Gupta', 'Pune', 22),
    (5, 'Arjun', 'Mehta', 'Delhi', 20);


-- Exercise 3

CREATE INDEX idx_practice_students_city
ON practice_index_students(city);


-- Exercise 4

SHOW INDEX FROM practice_index_students;


-- Exercise 5

SELECT *
FROM practice_index_students
WHERE city = 'Delhi';


-- Exercise 6

EXPLAIN
SELECT *
FROM practice_index_students
WHERE city = 'Delhi';


-- Exercise 7

CREATE INDEX idx_practice_students_last_name
ON practice_index_students(last_name);


-- Exercise 8

DROP INDEX idx_practice_students_last_name
ON practice_index_students;


-- Exercise 9

DROP TABLE IF EXISTS practice_users;

CREATE TABLE practice_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100)
);

SHOW INDEX FROM practice_users;


-- Exercise 10

-- A PRIMARY KEY is already indexed automatically.
-- Creating another ordinary index on the same column
-- would usually be redundant.


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11

CREATE INDEX idx_practice_students_age
ON practice_index_students(age);


-- Exercise 12

SELECT *
FROM practice_index_students
WHERE age BETWEEN 18 AND 21;


-- Exercise 13

EXPLAIN
SELECT *
FROM practice_index_students
WHERE age BETWEEN 18 AND 21;


-- Exercise 14

CREATE INDEX idx_practice_students_city_age
ON practice_index_students(city, age);


-- Exercise 15

SELECT *
FROM practice_index_students
WHERE city = 'Delhi'
  AND age = 20;


-- Exercise 16

SELECT *
FROM practice_index_students
WHERE city = 'Delhi';


-- Exercise 17

SELECT *
FROM practice_index_students
WHERE age = 20;

-- The composite index is ordered as:
--
-- city, age
--
-- Therefore, city is the leading column.
-- A separate age index may be more appropriate for
-- queries that frequently search only by age.


-- Exercise 18

CREATE INDEX idx_practice_students_last_name_search
ON practice_index_students(last_name);

SELECT *
FROM practice_index_students
WHERE last_name LIKE 'Sh%';


-- Exercise 19

SELECT *
FROM practice_index_students
WHERE last_name LIKE '%ma';

-- A leading wildcard prevents the normal B-tree index
-- from efficiently identifying the starting point of
-- the search.


-- Exercise 20

DROP TABLE IF EXISTS practice_students_fk;
DROP TABLE IF EXISTS practice_departments;

CREATE TABLE practice_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE practice_students_fk (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,

    CONSTRAINT fk_practice_student_department
        FOREIGN KEY (department_id)
        REFERENCES practice_departments(department_id)
);

CREATE INDEX idx_practice_students_fk_department
ON practice_students_fk(department_id);


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21

DROP TABLE IF EXISTS practice_orders;

CREATE TABLE practice_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0)
);


-- Exercise 22

CREATE INDEX idx_practice_orders_customer
ON practice_orders(customer_id);


-- Exercise 23

CREATE INDEX idx_practice_orders_customer_status
ON practice_orders(customer_id, status);


-- Exercise 24

EXPLAIN
SELECT *
FROM practice_orders
WHERE customer_id = 10
  AND status = 'Completed';


-- Exercise 25

CREATE INDEX idx_practice_orders_customer_date
ON practice_orders(customer_id, order_date DESC);


-- Exercise 26

EXPLAIN
SELECT *
FROM practice_orders
WHERE customer_id = 10
ORDER BY order_date DESC
LIMIT 5;


-- Exercise 27

CREATE INDEX idx_practice_students_city_first_name
ON practice_index_students(city, first_name);

SELECT first_name
FROM practice_index_students
WHERE city = 'Delhi';


-- Exercise 28

-- A covering index contains enough information for a query
-- to be answered from the index without needing to retrieve
-- additional columns from the table.


-- Exercise 29

SHOW INDEX FROM practice_index_students;


-- Exercise 30

SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE,
    SEQ_IN_INDEX,
    CARDINALITY
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'practice_index_students'
ORDER BY
    INDEX_NAME,
    SEQ_IN_INDEX;


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31

DROP TABLE IF EXISTS practice_employees;

CREATE TABLE practice_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    salary DECIMAL(10,2),
    status VARCHAR(20)
);

CREATE INDEX idx_practice_employees_department_status
ON practice_employees(department_id, status);


-- Exercise 32

-- INDEX(department_id, status) is ordered first by
-- department_id and then by status.
--
-- INDEX(status, department_id) has the opposite order.
--
-- Composite index order affects which queries can use
-- the leading portion of the index efficiently.


-- Exercise 33

DROP TABLE IF EXISTS practice_long_text;

CREATE TABLE practice_long_text (
    record_id INT PRIMARY KEY,
    description VARCHAR(500)
);

CREATE INDEX idx_practice_long_text_prefix
ON practice_long_text(description(20));


-- Exercise 34

CREATE INDEX idx_practice_employees_salary_desc
ON practice_employees(salary DESC);


-- Exercise 35

CREATE INDEX idx_practice_employees_department_salary
ON practice_employees(department_id ASC, salary DESC);


-- Exercise 36

-- Indexing every column is usually inefficient because
-- indexes consume storage and must be maintained when
-- rows are inserted, updated, or deleted.
--
-- Indexes should support real query patterns.


-- Exercise 37

-- INSERT, UPDATE, and DELETE operations may become more
-- expensive because MySQL must maintain affected indexes.


-- Exercise 38

-- A primary-key index is associated with the table's
-- primary key.
--
-- In InnoDB, the primary key is the clustered index.
--
-- Secondary indexes are additional indexes created for
-- other columns or column combinations.


-- Exercise 39

-- Selectivity describes how effectively an index
-- distinguishes between rows.
--
-- A column containing many distinct values can often
-- be more selective than a column containing only a few
-- possible values.


-- Exercise 40

-- A column containing only two possible values may match
-- a large percentage of the table.
--
-- In that situation, using the index may not provide
-- enough benefit compared with another access strategy.
--
-- However, the actual usefulness depends on table size,
-- data distribution, and query patterns.


-- ============================================================
-- PERFORMANCE PRACTICE
-- ============================================================

-- Exercise 41

DROP TABLE IF EXISTS performance_students;

CREATE TABLE performance_students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(150) NOT NULL
);

INSERT INTO performance_students
    (first_name, city, email)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 1000
)
SELECT
    CONCAT('Student', n),
    CASE
        WHEN MOD(n, 4) = 0 THEN 'Delhi'
        WHEN MOD(n, 4) = 1 THEN 'Mumbai'
        WHEN MOD(n, 4) = 2 THEN 'Pune'
        ELSE 'Jaipur'
    END,
    CONCAT('student', n, '@example.com')
FROM numbers;


-- Exercise 42

SELECT *
FROM performance_students
WHERE email = 'student500@example.com';


-- Exercise 43

EXPLAIN
SELECT *
FROM performance_students
WHERE email = 'student500@example.com';


-- Exercise 44

CREATE INDEX idx_performance_students_email
ON performance_students(email);


-- Exercise 45

EXPLAIN
SELECT *
FROM performance_students
WHERE email = 'student500@example.com';


-- Exercise 46

SELECT *
FROM performance_students
WHERE city = 'Delhi'
  AND student_id > 500;


-- Exercise 47

CREATE INDEX idx_performance_students_city_id
ON performance_students(city, student_id);


-- Exercise 48

EXPLAIN
SELECT *
FROM performance_students
WHERE city = 'Delhi'
  AND student_id > 500;


-- Exercise 49

SHOW INDEX FROM performance_students;

DROP INDEX idx_performance_students_city_id
ON performance_students;

SHOW INDEX FROM performance_students;


-- Exercise 50

-- The city + student_id index was removed here because
-- this example treats it as an index that is no longer
-- required for the demonstrated workload.
--
-- In a real application, an index should only be removed
-- after checking actual query usage and performance.
