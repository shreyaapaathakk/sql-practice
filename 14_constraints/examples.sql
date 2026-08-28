
## `14_constraints/examples.sql`

```sql
-- ============================================================
-- MODULE 14: CONSTRAINTS
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. PRIMARY KEY
-- ============================================================

DROP TABLE IF EXISTS constraint_students;

CREATE TABLE constraint_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO constraint_students
    (student_id, first_name, last_name)
VALUES
    (1, 'Rahul', 'Sharma'),
    (2, 'Priya', 'Singh');

SELECT *
FROM constraint_students;


-- ============================================================
-- 2. PRIMARY KEY PREVENTS DUPLICATES
-- ============================================================

-- The following statement should fail because
-- student_id 1 already exists.

-- INSERT INTO constraint_students
-- VALUES (1, 'Aman', 'Verma');


-- ============================================================
-- 3. PRIMARY KEY CANNOT BE NULL
-- ============================================================

-- The following statement should fail.

-- INSERT INTO constraint_students
-- VALUES (NULL, 'Neha', 'Gupta');


-- ============================================================
-- 4. NOT NULL
-- ============================================================

DROP TABLE IF EXISTS required_students;

CREATE TABLE required_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO required_students
    (student_id, first_name, city)
VALUES
    (1, 'Rahul', 'Delhi');

SELECT *
FROM required_students;


-- ============================================================
-- 5. UNIQUE
-- ============================================================

DROP TABLE IF EXISTS unique_users;

CREATE TABLE unique_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO unique_users
    (user_id, username, email)
VALUES
    (1, 'rahul01', 'rahul@example.com'),
    (2, 'priya01', 'priya@example.com');

SELECT *
FROM unique_users;


-- The following should fail because the email is duplicated.

-- INSERT INTO unique_users
--     (user_id, username, email)
-- VALUES
--     (3, 'aman01', 'rahul@example.com');


-- ============================================================
-- 6. DEFAULT
-- ============================================================

DROP TABLE IF EXISTS default_students;

CREATE TABLE default_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);

INSERT INTO default_students
    (student_id, first_name)
VALUES
    (1, 'Rahul');

INSERT INTO default_students
    (student_id, first_name, status)
VALUES
    (2, 'Priya', 'Inactive');

SELECT *
FROM default_students;


-- ============================================================
-- 7. CHECK
-- ============================================================

DROP TABLE IF EXISTS checked_students;

CREATE TABLE checked_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    age INT CHECK (age >= 16)
);

INSERT INTO checked_students
    (student_id, first_name, age)
VALUES
    (1, 'Rahul', 20),
    (2, 'Priya', 21);

SELECT *
FROM checked_students;


-- The following should fail.

-- INSERT INTO checked_students
-- VALUES (3, 'Aman', 12);


-- ============================================================
-- 8. CHECK WITH RANGE
-- ============================================================

DROP TABLE IF EXISTS exam_results;

CREATE TABLE exam_results (
    exam_id INT PRIMARY KEY,
    student_id INT,
    marks INT CHECK (marks BETWEEN 0 AND 100)
);

INSERT INTO exam_results
    (exam_id, student_id, marks)
VALUES
    (1, 1, 85),
    (2, 2, 92);

SELECT *
FROM exam_results;


-- ============================================================
-- 9. NAMED CHECK CONSTRAINT
-- ============================================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10,2),

    CONSTRAINT chk_employee_age
        CHECK (age >= 18),

    CONSTRAINT chk_employee_salary
        CHECK (salary >= 0)
);

INSERT INTO employees
    (employee_id, employee_name, age, salary)
VALUES
    (1, 'Anita', 28, 45000),
    (2, 'Ravi', 32, 55000);

SELECT *
FROM employees;


-- ============================================================
-- 10. CREATE PARENT TABLE
-- ============================================================

DROP TABLE IF EXISTS constraint_students_fk;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO departments
    (department_id, department_name)
VALUES
    (1, 'Computer Science'),
    (2, 'Mathematics'),
    (3, 'Physics');

SELECT *
FROM departments;


-- ============================================================
-- 11. CREATE CHILD TABLE WITH FOREIGN KEY
-- ============================================================

CREATE TABLE constraint_students_fk (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,

    CONSTRAINT fk_student_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO constraint_students_fk
    (student_id, first_name, department_id)
VALUES
    (1, 'Rahul', 1),
    (2, 'Priya', 2),
    (3, 'Aman', NULL);

SELECT *
FROM constraint_students_fk;


-- ============================================================
-- 12. INVALID FOREIGN KEY
-- ============================================================

-- Department 99 does not exist.
-- The following should fail.

-- INSERT INTO constraint_students_fk
--     (student_id, first_name, department_id)
-- VALUES
--     (4, 'Neha', 99);


-- ============================================================
-- 13. FOREIGN KEY WITH NOT NULL
-- ============================================================

DROP TABLE IF EXISTS required_department_students;

CREATE TABLE required_department_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO required_department_students
    (student_id, first_name, department_id)
VALUES
    (1, 'Arjun', 3);


-- ============================================================
-- 14. ON DELETE SET NULL
-- ============================================================

DROP TABLE IF EXISTS set_null_students;

CREATE TABLE set_null_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,

    CONSTRAINT fk_set_null_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE SET NULL
);

INSERT INTO set_null_students
    (student_id, first_name, department_id)
VALUES
    (1, 'Neha', 1);

SELECT *
FROM set_null_students;


-- ============================================================
-- 15. ON DELETE CASCADE
-- ============================================================

DROP TABLE IF EXISTS cascade_students;

CREATE TABLE cascade_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,

    CONSTRAINT fk_cascade_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE CASCADE
);

INSERT INTO cascade_students
    (student_id, first_name, department_id)
VALUES
    (1, 'Student A', 2),
    (2, 'Student B', 2);

SELECT *
FROM cascade_students;


-- Do not execute this unless you intentionally want to
-- demonstrate cascading deletion.
--
-- DELETE FROM departments
-- WHERE department_id = 2;


-- ============================================================
-- 16. AUTO_INCREMENT
-- ============================================================

DROP TABLE IF EXISTS auto_students;

CREATE TABLE auto_students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO auto_students
    (first_name, city)
VALUES
    ('Rahul', 'Delhi'),
    ('Priya', 'Mumbai'),
    ('Aman', 'Jaipur');

SELECT *
FROM auto_students;


-- ============================================================
-- 17. MULTIPLE CONSTRAINTS
-- ============================================================

DROP TABLE IF EXISTS complete_students;

CREATE TABLE complete_students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 16),
    status VARCHAR(20) DEFAULT 'Active',
    department_id INT,

    CONSTRAINT fk_complete_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO complete_students
    (first_name, email, age, department_id)
VALUES
    ('Rahul', 'rahul@example.com', 20, 1),
    ('Priya', 'priya@example.com', 21, 2);

SELECT *
FROM complete_students;


-- ============================================================
-- 18. INSPECT TABLE DEFINITION
-- ============================================================

SHOW CREATE TABLE complete_students;


-- ============================================================
-- 19. VIEW CONSTRAINT METADATA
-- ============================================================

SELECT
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'complete_students';


-- ============================================================
-- 20. COMPOSITE PRIMARY KEY
-- ============================================================

DROP TABLE IF EXISTS enrollments;

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,

    PRIMARY KEY (student_id, course_id)
);

INSERT INTO enrollments
    (student_id, course_id, enrollment_date)
VALUES
    (1, 101, '2026-01-10'),
    (1, 102, '2026-01-11'),
    (2, 101, '2026-01-12');

SELECT *
FROM enrollments;


-- ============================================================
-- 21. CHECK WITH IN
-- ============================================================

DROP TABLE IF EXISTS status_students;

CREATE TABLE status_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    status VARCHAR(20),

    CONSTRAINT chk_student_status
        CHECK (status IN ('Active', 'Inactive', 'Graduated'))
);

INSERT INTO status_students
    (student_id, first_name, status)
VALUES
    (1, 'Rahul', 'Active'),
    (2, 'Priya', 'Graduated');

SELECT *
FROM status_students;
