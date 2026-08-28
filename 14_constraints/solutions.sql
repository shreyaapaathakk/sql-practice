-- ============================================================
-- MODULE 14: CONSTRAINTS
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1

DROP TABLE IF EXISTS practice_students;

CREATE TABLE practice_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50)
);


-- Exercise 2

DROP TABLE IF EXISTS practice_users;

CREATE TABLE practice_users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100) UNIQUE
);


-- Exercise 3

DROP TABLE IF EXISTS practice_students_required;

CREATE TABLE practice_students_required (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO practice_students_required
    (student_id, first_name, city)
VALUES
    (1, 'Rahul', 'Delhi');


-- Exercise 4

DROP TABLE IF EXISTS practice_courses;

CREATE TABLE practice_courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    status VARCHAR(20) DEFAULT 'Active'
);


-- Exercise 5

INSERT INTO practice_courses
    (course_id, course_name)
VALUES
    (1, 'SQL Fundamentals');

SELECT *
FROM practice_courses;


-- Exercise 6

DROP TABLE IF EXISTS practice_exams;

CREATE TABLE practice_exams (
    exam_id INT PRIMARY KEY,
    marks INT CHECK (marks BETWEEN 0 AND 100)
);


-- Exercise 7

DROP TABLE IF EXISTS practice_employees;

CREATE TABLE practice_employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    age INT,

    CONSTRAINT chk_practice_employee_age
        CHECK (age >= 18)
);


-- Exercise 8

DROP TABLE IF EXISTS practice_enrollments;

CREATE TABLE practice_enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,

    PRIMARY KEY (student_id, course_id)
);


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 9

DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);


-- Exercise 10

DROP TABLE IF EXISTS students_constraints;

CREATE TABLE students_constraints (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    department_id INT,

    CONSTRAINT fk_constraints_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


-- Exercise 11

INSERT INTO departments
    (department_id, department_name)
VALUES
    (1, 'Computer Science'),
    (2, 'Mathematics'),
    (3, 'Physics');


-- Exercise 12

INSERT INTO students_constraints
    (student_id, first_name, department_id)
VALUES
    (1, 'Rahul', 1),
    (2, 'Priya', 2),
    (3, 'Aman', 3);


-- Exercise 13

-- This should fail because department 99 does not exist.

-- INSERT INTO students_constraints
--     (student_id, first_name, department_id)
-- VALUES
--     (4, 'Neha', 99);


-- Exercise 14

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price >= 0),
    quantity INT CHECK (quantity >= 0)
);


-- Exercise 15

DROP TABLE IF EXISTS users_constraints;

CREATE TABLE users_constraints (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    status VARCHAR(20) DEFAULT 'Active'
);


-- Exercise 16

INSERT INTO users_constraints
    (username, email)
VALUES
    ('rahul01', 'rahul@example.com'),
    ('priya01', 'priya@example.com'),
    ('aman01', 'aman@example.com');

SELECT *
FROM users_constraints;


-- Exercise 17

DROP TABLE IF EXISTS named_constraint_students;

CREATE TABLE named_constraint_students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    age INT,

    CONSTRAINT chk_named_student_age
        CHECK (age >= 16)
);


-- Exercise 18

SHOW CREATE TABLE named_constraint_students;


-- Exercise 19

SELECT
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'named_constraint_students';


-- Exercise 20

-- PRIMARY KEY identifies the row and cannot be NULL.
--
-- UNIQUE prevents duplicate values.
--
-- A table can have one PRIMARY KEY but multiple UNIQUE
-- constraints.


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21

DROP TABLE IF EXISTS students_hard;
DROP TABLE IF EXISTS departments_hard;

CREATE TABLE departments_hard (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE students_hard (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,

    CONSTRAINT fk_hard_department
        FOREIGN KEY (department_id)
        REFERENCES departments_hard(department_id)
);


-- Exercise 22

ALTER TABLE students_hard
ADD CONSTRAINT chk_hard_student_id
CHECK (student_id > 0);


-- Exercise 23

ALTER TABLE students_hard
ADD COLUMN status VARCHAR(20) DEFAULT 'Active';


-- Exercise 24

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
        CHECK (total_amount >= 0)
);


-- Exercise 25

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2)
        CHECK (total_amount >= 0),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- Exercise 26

DROP TABLE IF EXISTS set_null_orders;
DROP TABLE IF EXISTS set_null_customers;

CREATE TABLE set_null_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE set_null_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,

    CONSTRAINT fk_set_null_customer
        FOREIGN KEY (customer_id)
        REFERENCES set_null_customers(customer_id)
        ON DELETE SET NULL
);

INSERT INTO set_null_customers
    (customer_id, customer_name)
VALUES
    (1, 'Rahul');

INSERT INTO set_null_orders
    (order_id, customer_id)
VALUES
    (101, 1);

DELETE FROM set_null_customers
WHERE customer_id = 1;

SELECT *
FROM set_null_orders;


-- Exercise 27

DROP TABLE IF EXISTS cascade_orders;
DROP TABLE IF EXISTS cascade_customers;

CREATE TABLE cascade_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL
);

CREATE TABLE cascade_orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,

    CONSTRAINT fk_cascade_customer
        FOREIGN KEY (customer_id)
        REFERENCES cascade_customers(customer_id)
        ON DELETE CASCADE
);

INSERT INTO cascade_customers
    (customer_id, customer_name)
VALUES
    (1, 'Priya');

INSERT INTO cascade_orders
    (order_id, customer_id)
VALUES
    (101, 1),
    (102, 1);

DELETE FROM cascade_customers
WHERE customer_id = 1;

SELECT *
FROM cascade_orders;


-- Exercise 28

DROP TABLE IF EXISTS course_enrollments;

CREATE TABLE course_enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,

    PRIMARY KEY (student_id, course_id)
);


-- Exercise 29

DROP TABLE IF EXISTS employees_complete;

CREATE TABLE employees_complete (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    salary DECIMAL(10,2) CHECK (salary >= 0),
    status VARCHAR(20) DEFAULT 'Active'
);


-- Exercise 30

DROP TABLE IF EXISTS library_books;

CREATE TABLE library_books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    status VARCHAR(20) DEFAULT 'Available',

    CONSTRAINT chk_book_status
        CHECK (status IN ('Available', 'Issued', 'Reserved'))
);


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31

DROP TABLE IF EXISTS university_enrollments;
DROP TABLE IF EXISTS university_courses;
DROP TABLE IF EXISTS university_students;
DROP TABLE IF EXISTS university_departments;

CREATE TABLE university_departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE university_students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,

    CONSTRAINT fk_university_student_department
        FOREIGN KEY (department_id)
        REFERENCES university_departments(department_id)
);

CREATE TABLE university_courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,

    CONSTRAINT fk_university_course_department
        FOREIGN KEY (department_id)
        REFERENCES university_departments(department_id)
);

CREATE TABLE university_enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT (CURRENT_DATE),

    PRIMARY KEY (student_id, course_id),

    CONSTRAINT fk_university_enrollment_student
        FOREIGN KEY (student_id)
        REFERENCES university_students(student_id),

    CONSTRAINT fk_university_enrollment_course
        FOREIGN KEY (course_id)
        REFERENCES university_courses(course_id)
);


-- Exercise 32
--
-- Already implemented using:
--
-- email VARCHAR(100) UNIQUE


-- Exercise 33
--
-- Already implemented using:
--
-- price DECIMAL(10,2) CHECK (price >= 0)


-- Exercise 34

ALTER TABLE university_enrollments
ADD CONSTRAINT chk_enrollment_student
CHECK (student_id > 0);

ALTER TABLE university_enrollments
ADD CONSTRAINT chk_enrollment_course
CHECK (course_id > 0);


-- Exercise 35
--
-- enrollment_date was defined as:
--
-- enrollment_date DATE DEFAULT (CURRENT_DATE)


-- Exercise 36

DROP TABLE IF EXISTS status_constraint_example;

CREATE TABLE status_constraint_example (
    id INT PRIMARY KEY,
    status VARCHAR(20),

    CONSTRAINT chk_status
        CHECK (
            status IN ('Active', 'Inactive', 'Graduated')
        )
);


-- Exercise 37
--
-- Foreign keys prevent child rows from referencing
-- parent records that do not exist.
--
-- This prevents orphan references.


-- Exercise 38
--
-- ON DELETE SET NULL is useful when the child record
-- should remain after the parent is removed.
--
-- Example:
--
-- A student may remain in the database even if
-- their department is removed.
--
-- The department_id can become NULL.


-- Exercise 39
--
-- ON DELETE CASCADE can be dangerous because deleting
-- one parent row can automatically delete many related
-- child rows.


-- Exercise 40

DROP TABLE IF EXISTS complete_student_design;
DROP TABLE IF EXISTS complete_departments;

CREATE TABLE complete_departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE complete_student_design (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 16),
    status VARCHAR(20) DEFAULT 'Active',
    department_id INT,

    CONSTRAINT fk_complete_student_department
        FOREIGN KEY (department_id)
        REFERENCES complete_departments(department_id)
);
