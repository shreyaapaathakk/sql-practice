sql
-- ============================================================
-- Student Database Management System
-- File: schema.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS student_database;

USE student_database;

-- ============================================================
-- 1. Departments
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    building VARCHAR(100),
    budget DECIMAL(12, 2) DEFAULT 0.00
);

-- ============================================================
-- 2. Students
-- ============================================================

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    department_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    graduation_year YEAR,

    CONSTRAINT fk_students_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ============================================================
-- 3. Instructors
-- ============================================================

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,

    CONSTRAINT fk_instructors_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ============================================================
-- 4. Courses
-- ============================================================

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    credits INT NOT NULL,
    department_id INT NOT NULL,
    instructor_id INT,

    CONSTRAINT chk_course_credits
        CHECK (credits BETWEEN 1 AND 6),

    CONSTRAINT fk_courses_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_courses_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES instructors(instructor_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- ============================================================
-- 5. Enrollments
-- ============================================================

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    semester VARCHAR(30) NOT NULL,
    academic_year YEAR NOT NULL,

    CONSTRAINT uq_student_course_semester
        UNIQUE (student_id, course_id, semester, academic_year),

    CONSTRAINT fk_enrollments_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_enrollments_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================================
-- 6. Exams
-- ============================================================

CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    exam_name VARCHAR(100) NOT NULL,
    exam_date DATE NOT NULL,
    maximum_marks DECIMAL(5, 2) NOT NULL DEFAULT 100.00,

    CONSTRAINT chk_maximum_marks
        CHECK (maximum_marks > 0),

    CONSTRAINT fk_exams_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================================
-- 7. Results
-- ============================================================

CREATE TABLE results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    marks_obtained DECIMAL(5, 2) NOT NULL,
    grade CHAR(2),

    CONSTRAINT chk_marks_obtained
        CHECK (marks_obtained >= 0 AND marks_obtained <= 100),

    CONSTRAINT uq_student_exam
        UNIQUE (student_id, exam_id),

    CONSTRAINT fk_results_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_results_exam
        FOREIGN KEY (exam_id)
        REFERENCES exams(exam_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================================
-- Verify tables
-- ============================================================

SHOW TABLES;
