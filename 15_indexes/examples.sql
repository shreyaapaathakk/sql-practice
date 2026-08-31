
---

## `15_indexes/examples.sql`

```sql
-- ============================================================
-- MODULE 15: INDEXES
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. CREATE A SAMPLE TABLE
-- ============================================================

DROP TABLE IF EXISTS index_students;

CREATE TABLE index_students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    city VARCHAR(50),
    email VARCHAR(100) UNIQUE
);

INSERT INTO index_students
    (first_name, last_name, age, city, email)
VALUES
    ('Rahul', 'Sharma', 20, 'Delhi', 'rahul@example.com'),
    ('Priya', 'Singh', 21, 'Mumbai', 'priya@example.com'),
    ('Aman', 'Verma', 19, 'Jaipur', 'aman@example.com'),
    ('Neha', 'Gupta', 22, 'Pune', 'neha@example.com'),
    ('Arjun', 'Mehta', 20, 'Lucknow', 'arjun@example.com'),
    ('Kavya', 'Shah', 21, 'Delhi', 'kavya@example.com'),
    ('Rohan', 'Patel', 23, 'Mumbai', 'rohan@example.com'),
    ('Ananya', 'Das', 20, 'Kolkata', 'ananya@example.com');

SELECT *
FROM index_students;


-- ============================================================
-- 2. PRIMARY KEY INDEX
-- ============================================================

SHOW INDEX FROM index_students;


-- ============================================================
-- 3. CREATE A SINGLE-COLUMN INDEX
-- ============================================================

CREATE INDEX idx_index_students_city
ON index_students(city);

SHOW INDEX FROM index_students;


-- ============================================================
-- 4. QUERY USING AN INDEXED COLUMN
-- ============================================================

SELECT *
FROM index_students
WHERE city = 'Delhi';


-- ============================================================
-- 5. EXPLAIN
-- ============================================================

EXPLAIN
SELECT *
FROM index_students
WHERE city = 'Delhi';


-- ============================================================
-- 6. INDEX ON LAST NAME
-- ============================================================

CREATE INDEX idx_index_students_last_name
ON index_students(last_name);

SELECT *
FROM index_students
WHERE last_name = 'Sharma';

EXPLAIN
SELECT *
FROM index_students
WHERE last_name = 'Sharma';


-- ============================================================
-- 7. INDEX AND RANGE SEARCH
-- ============================================================

CREATE INDEX idx_index_students_age
ON index_students(age);

SELECT *
FROM index_students
WHERE age BETWEEN 20 AND 22;

EXPLAIN
SELECT *
FROM index_students
WHERE age BETWEEN 20 AND 22;


-- ============================================================
-- 8. INDEX AND ORDER BY
-- ============================================================

SELECT *
FROM index_students
ORDER BY age;


-- ============================================================
-- 9. INDEX AND LIMIT
-- ============================================================

SELECT *
FROM index_students
ORDER BY age
LIMIT 3;


-- ============================================================
-- 10. COMPOSITE INDEX
-- ============================================================

CREATE INDEX idx_index_students_city_age
ON index_students(city, age);

SHOW INDEX FROM index_students;


-- ============================================================
-- 11. COMPOSITE INDEX — FIRST COLUMN
-- ============================================================

SELECT *
FROM index_students
WHERE city = 'Delhi';


-- ============================================================
-- 12. COMPOSITE INDEX — BOTH COLUMNS
-- ============================================================

SELECT *
FROM index_students
WHERE city = 'Delhi'
  AND age = 20;


-- ============================================================
-- 13. SECOND COLUMN ONLY
-- ============================================================

-- This query does not generally receive the same
-- benefit from an index whose order is (city, age).

SELECT *
FROM index_students
WHERE age = 20;


-- ============================================================
-- 14. PREFIX LIKE SEARCH
-- ============================================================

SELECT *
FROM index_students
WHERE last_name LIKE 'Sh%';


-- ============================================================
-- 15. LEADING WILDCARD
-- ============================================================

SELECT *
FROM index_students
WHERE last_name LIKE '%ma';


-- ============================================================
-- 16. UNIQUE INDEX
-- ============================================================

DROP TABLE IF EXISTS index_users;

CREATE TABLE index_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE UNIQUE INDEX idx_index_users_username
ON index_users(username);

INSERT INTO index_users
    (user_id, username, email)
VALUES
    (1, 'rahul01', 'rahul@example.com'),
    (2, 'priya01', 'priya@example.com');

SELECT *
FROM index_users;

SHOW INDEX FROM index_users;


-- The following should fail because username must be unique.

-- INSERT INTO index_users
--     (user_id, username, email)
-- VALUES
--     (3, 'rahul01', 'another@example.com');


-- ============================================================
-- 17. PRIMARY KEY DOES NOT NEED A SECOND INDEX
-- ============================================================

-- student_id is already indexed because it is the PRIMARY KEY.

SHOW INDEX FROM index_students;


-- ============================================================
-- 18. FOREIGN KEY EXAMPLE
-- ============================================================

DROP TABLE IF EXISTS index_students_fk;
DROP TABLE IF EXISTS index_departments;

CREATE TABLE index_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO index_departments
    (department_id, department_name)
VALUES
    (1, 'Computer Science'),
    (2, 'Mathematics'),
    (3, 'Physics');

CREATE TABLE index_students_fk (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,

    CONSTRAINT fk_index_student_department
        FOREIGN KEY (department_id)
        REFERENCES index_departments(department_id)
);

INSERT INTO index_students_fk
    (student_id, first_name, department_id)
VALUES
    (1, 'Rahul', 1),
    (2, 'Priya', 2),
    (3, 'Aman', 1);

SHOW INDEX FROM index_students_fk;


-- ============================================================
-- 19. JOIN WITH FOREIGN KEY COLUMN
-- ============================================================

SELECT
    s.first_name,
    d.department_name
FROM index_students_fk AS s
JOIN index_departments AS d
    ON s.department_id = d.department_id;


-- ============================================================
-- 20. EXPLAIN A JOIN
-- ============================================================

EXPLAIN
SELECT
    s.first_name,
    d.department_name
FROM index_students_fk AS s
JOIN index_departments AS d
    ON s.department_id = d.department_id;


-- ============================================================
-- 21. EXPLICIT INDEX ON FOREIGN KEY COLUMN
-- ============================================================

CREATE INDEX idx_index_students_department
ON index_students_fk(department_id);

SHOW INDEX FROM index_students_fk;


-- ============================================================
-- 22. COVERING INDEX EXAMPLE
-- ============================================================

CREATE INDEX idx_index_students_city_first_name
ON index_students(city, first_name);

SELECT first_name
FROM index_students
WHERE city = 'Delhi';


-- ============================================================
-- 23. EXPLAIN COVERING INDEX QUERY
-- ============================================================

EXPLAIN
SELECT first_name
FROM index_students
WHERE city = 'Delhi';


-- ============================================================
-- 24. DESCENDING INDEX
-- ============================================================

CREATE INDEX idx_index_students_age_desc
ON index_students(age DESC);

SHOW INDEX FROM index_students;


-- ============================================================
-- 25. MULTI-COLUMN ASC/DESC INDEX
-- ============================================================

CREATE INDEX idx_index_students_city_age_direction
ON index_students(city ASC, age DESC);

SHOW INDEX FROM index_students;


-- ============================================================
-- 26. PREFIX INDEX
-- ============================================================

DROP TABLE IF EXISTS index_contacts;

CREATE TABLE index_contacts (
    contact_id INT PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

CREATE INDEX idx_index_contacts_email_prefix
ON index_contacts(email(20));

SHOW INDEX FROM index_contacts;


-- ============================================================
-- 27. IS NULL WITH AN INDEXED COLUMN
-- ============================================================

INSERT INTO index_students
    (first_name, last_name, age, city, email)
VALUES
    ('Vikram', 'Kumar', 24, NULL, 'vikram@example.com');

SELECT *
FROM index_students
WHERE city IS NULL;


-- ============================================================
-- 28. EXPLAIN ANALYZE
-- ============================================================

EXPLAIN ANALYZE
SELECT *
FROM index_students
WHERE city = 'Delhi';


-- ============================================================
-- 29. DROP AN INDEX
-- ============================================================

DROP INDEX idx_index_students_last_name
ON index_students;

SHOW INDEX FROM index_students;


-- ============================================================
-- 30. CREATE INDEX USING ALTER TABLE
-- ============================================================

ALTER TABLE index_students
ADD INDEX idx_index_students_first_name (first_name);

SHOW INDEX FROM index_students;


-- ============================================================
-- 31. DROP INDEX USING ALTER TABLE
-- ============================================================

ALTER TABLE index_students
DROP INDEX idx_index_students_first_name;

SHOW INDEX FROM index_students;


-- ============================================================
-- 32. INFORMATION_SCHEMA INDEX METADATA
-- ============================================================

SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE,
    SEQ_IN_INDEX
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'index_students'
ORDER BY
    INDEX_NAME,
    SEQ_IN_INDEX;


-- ============================================================
-- 33. TEST A COMPOSITE INDEX
-- ============================================================

EXPLAIN
SELECT *
FROM index_students
WHERE city = 'Mumbai'
  AND age = 21;


-- ============================================================
-- 34. TEST ONLY THE SECOND COLUMN
-- ============================================================

EXPLAIN
SELECT *
FROM index_students
WHERE age = 21;


-- ============================================================
-- 35. MULTIPLE FILTER CONDITIONS
-- ============================================================

SELECT *
FROM index_students
WHERE city = 'Delhi'
  AND age >= 20
ORDER BY age DESC
LIMIT 5;

EXPLAIN
SELECT *
FROM index_students
WHERE city = 'Delhi'
  AND age >= 20
ORDER BY age DESC
LIMIT 5;
