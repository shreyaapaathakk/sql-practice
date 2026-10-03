-- ============================================================
-- Student Database Management System
-- File: data.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

USE student_database;

-- ============================================================
-- 1. Departments
-- ============================================================

INSERT INTO departments
    (department_name, building, budget)
VALUES
    ('Computer Science', 'Technology Block', 2500000.00),
    ('Business Administration', 'Management Block', 1800000.00),
    ('Mathematics', 'Science Block', 1500000.00),
    ('Physics', 'Science Block', 1700000.00),
    ('English', 'Humanities Block', 1200000.00);

-- ============================================================
-- 2. Students
-- ============================================================

INSERT INTO students
    (
        first_name,
        last_name,
        email,
        date_of_birth,
        gender,
        department_id,
        enrollment_date,
        graduation_year
    )
VALUES
    ('Aarav', 'Sharma', 'aarav.sharma@example.com', '2004-03-15', 'Male', 1, '2022-07-15', 2026),
    ('Ananya', 'Patel', 'ananya.patel@example.com', '2003-08-21', 'Female', 1, '2021-07-20', 2025),
    ('Rohan', 'Verma', 'rohan.verma@example.com', '2004-01-10', 'Male', 2, '2022-07-18', 2026),
    ('Priya', 'Mehta', 'priya.mehta@example.com', '2003-11-05', 'Female', 2, '2021-07-22', 2025),
    ('Arjun', 'Singh', 'arjun.singh@example.com', '2004-06-17', 'Male', 3, '2022-07-19', 2026),
    ('Sneha', 'Gupta', 'sneha.gupta@example.com', '2003-09-12', 'Female', 3, '2021-07-16', 2025),
    ('Vikram', 'Joshi', 'vikram.joshi@example.com', '2004-02-25', 'Male', 4, '2022-07-21', 2026),
    ('Kavya', 'Nair', 'kavya.nair@example.com', '2003-12-30', 'Female', 5, '2021-07-25', 2025),
    ('Rahul', 'Desai', 'rahul.desai@example.com', '2004-05-08', 'Male', 1, '2022-07-17', 2026),
    ('Ishita', 'Rao', 'ishita.rao@example.com', '2003-07-14', 'Female', 2, '2021-07-23', 2025),
    ('Aditya', 'Kapoor', 'aditya.kapoor@example.com', '2004-04-18', 'Male', 1, '2022-07-26', 2026),
    ('Meera', 'Iyer', 'meera.iyer@example.com', '2003-10-09', 'Female', 5, '2021-07-28', 2025);

-- ============================================================
-- 3. Instructors
-- ============================================================

INSERT INTO instructors
    (
        first_name,
        last_name,
        email,
        department_id,
        hire_date
    )
VALUES
    ('Rajesh', 'Kumar', 'rajesh.kumar@example.com', 1, '2015-06-15'),
    ('Neha', 'Malhotra', 'neha.malhotra@example.com', 1, '2018-08-01'),
    ('Amit', 'Shah', 'amit.shah@example.com', 2, '2016-07-10'),
    ('Pooja', 'Agarwal', 'pooja.agarwal@example.com', 2, '2019-01-15'),
    ('Sanjay', 'Mishra', 'sanjay.mishra@example.com', 3, '2014-09-20'),
    ('Deepa', 'Menon', 'deepa.menon@example.com', 4, '2017-05-12'),
    ('Kiran', 'Thomas', 'kiran.thomas@example.com', 5, '2013-08-18'),
    ('Nitin', 'Bose', 'nitin.bose@example.com', 1, '2020-01-10');

-- ============================================================
-- 4. Courses
-- ============================================================

INSERT INTO courses
    (
        course_code,
        course_name,
        credits,
        department_id,
        instructor_id
    )
VALUES
    ('CS101', 'Introduction to Programming', 4, 1, 1),
    ('CS201', 'Database Management Systems', 4, 1, 2),
    ('CS301', 'Data Structures and Algorithms', 4, 1, 8),
    ('BA101', 'Principles of Management', 3, 2, 3),
    ('BA201', 'Financial Management', 4, 2, 4),
    ('MA101', 'Calculus', 4, 3, 5),
    ('MA201', 'Statistics', 4, 3, 5),
    ('PH101', 'Classical Physics', 4, 4, 6),
    ('EN101', 'Academic Writing', 3, 5, 7),
    ('EN201', 'English Literature', 3, 5, 7);

-- ============================================================
-- 5. Enrollments
-- ============================================================

INSERT INTO enrollments
    (
        student_id,
        course_id,
        enrollment_date,
        semester,
        academic_year
    )
VALUES
    -- Aarav
    (1, 1, '2024-07-15', 'Semester 1', 2024),
    (1, 2, '2024-07-15', 'Semester 1', 2024),
    (1, 3, '2025-01-10', 'Semester 2', 2025),
    (1, 7, '2025-01-10', 'Semester 2', 2025),

    -- Ananya
    (2, 1, '2024-07-15', 'Semester 1', 2024),
    (2, 2, '2024-07-15', 'Semester 1', 2024),
    (2, 3, '2025-01-10', 'Semester 2', 2025),
    (2, 9, '2025-01-10', 'Semester 2', 2025),

    -- Rohan
    (3, 4, '2024-07-18', 'Semester 1', 2024),
    (3, 5, '2024-07-18', 'Semester 1', 2024),
    (3, 6, '2025-01-10', 'Semester 2', 2025),

    -- Priya
    (4, 4, '2024-07-22', 'Semester 1', 2024),
    (4, 5, '2024-07-22', 'Semester 1', 2024),
    (4, 6, '2025-01-10', 'Semester 2', 2025),
    (4, 9, '2025-01-10', 'Semester 2', 2025),

    -- Arjun
    (5, 6, '2024-07-19', 'Semester 1', 2024),
    (5, 7, '2024-07-19', 'Semester 1', 2024),
    (5, 8, '2025-01-10', 'Semester 2', 2025),

    -- Sneha
    (6, 6, '2024-07-16', 'Semester 1', 2024),
    (6, 7, '2024-07-16', 'Semester 1', 2024),
    (6, 9, '2025-01-10', 'Semester 2', 2025),

    -- Vikram
    (7, 8, '2024-07-21', 'Semester 1', 2024),
    (7, 6, '2024-07-21', 'Semester 1', 2024),

    -- Kavya
    (8, 9, '2024-07-25', 'Semester 1', 2024),
    (8, 10, '2024-07-25', 'Semester 1', 2024),
    (8, 4, '2025-01-10', 'Semester 2', 2025),

    -- Rahul
    (9, 1, '2024-07-17', 'Semester 1', 2024),
    (9, 2, '2024-07-17', 'Semester 1', 2024),
    (9, 3, '2025-01-10', 'Semester 2', 2025),

    -- Ishita
    (10, 4, '2024-07-23', 'Semester 1', 2024),
    (10, 5, '2024-07-23', 'Semester 1', 2024),
    (10, 9, '2025-01-10', 'Semester 2', 2025),

    -- Aditya
    (11, 1, '2024-07-26', 'Semester 1', 2024),
    (11, 2, '2024-07-26', 'Semester 1', 2024),
    (11, 3, '2025-01-10', 'Semester 2', 2025),

    -- Meera
    (12, 9, '2024-07-28', 'Semester 1', 2024),
    (12, 10, '2024-07-28', 'Semester 1', 2024);

-- ============================================================
-- 6. Exams
-- ============================================================

INSERT INTO exams
    (
        course_id,
        exam_name,
        exam_date,
        maximum_marks
    )
VALUES
    (1, 'Programming Final Exam', '2024-12-10', 100),
    (2, 'Database Final Exam', '2024-12-12', 100),
    (3, 'Algorithms Final Exam', '2025-05-15', 100),
    (4, 'Management Final Exam', '2024-12-09', 100),
    (5, 'Financial Management Final Exam', '2024-12-11', 100),
    (6, 'Calculus Final Exam', '2025-05-12', 100),
    (7, 'Statistics Final Exam', '2025-05-14', 100),
    (8, 'Physics Final Exam', '2025-05-16', 100),
    (9, 'Academic Writing Final Exam', '2025-05-13', 100),
    (10, 'English Literature Final Exam', '2024-12-13', 100);

-- ============================================================
-- 7. Results
-- ============================================================

INSERT INTO results
    (
        student_id,
        exam_id,
        marks_obtained,
        grade
    )
VALUES
    -- Aarav
    (1, 1, 88, 'A'),
    (1, 2, 92, 'A+'),
    (1, 3, 85, 'A'),
    (1, 7, 78, 'B+'),

    -- Ananya
    (2, 1, 95, 'A+'),
    (2, 2, 91, 'A+'),
    (2, 3, 89, 'A'),
    (2, 9, 94, 'A+'),

    -- Rohan
    (3, 4, 76, 'B+'),
    (3, 5, 82, 'A'),
    (3, 6, 74, 'B'),

    -- Priya
    (4, 4, 91, 'A+'),
    (4, 5, 88, 'A'),
    (4, 6, 93, 'A+'),
    (4, 9, 90, 'A+'),

    -- Arjun
    (5, 6, 68, 'B'),
    (5, 7, 72, 'B'),
    (5, 8, 80, 'A'),

    -- Sneha
    (6, 6, 84, 'A'),
    (6, 7, 87, 'A'),
    (6, 9, 91, 'A+'),

    -- Vikram
    (7, 8, 63, 'C'),
    (7, 6, 58, 'C'),

    -- Kavya
    (8, 9, 86, 'A'),
    (8, 10, 90, 'A+'),
    (8, 4, 81, 'A'),

    -- Rahul
    (9, 1, 72, 'B'),
    (9, 2, 65, 'B'),
    (9, 3, 70, 'B'),

    -- Ishita
    (10, 4, 79, 'B+'),
    (10, 5, 83, 'A'),
    (10, 9, 88, 'A'),

    -- Aditya
    (11, 1, 67, 'B'),
    (11, 2, 73, 'B+'),
    (11, 3, 69, 'B'),

    -- Meera
    (12, 9, 92, 'A+'),
    (12, 10, 89, 'A');

-- ============================================================
-- Verify inserted data
-- ============================================================

SELECT COUNT(*) AS total_departments
FROM departments;

SELECT COUNT(*) AS total_students
FROM students;

SELECT COUNT(*) AS total_instructors
FROM instructors;

SELECT COUNT(*) AS total_courses
FROM courses;

SELECT COUNT(*) AS total_enrollments
FROM enrollments;

SELECT COUNT(*) AS total_exams
FROM exams;

SELECT COUNT(*) AS total_results
FROM results;
