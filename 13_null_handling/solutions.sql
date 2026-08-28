-- ============================================================
-- MODULE 13: NULL HANDLING
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- EASY
-- ============================================================

-- Exercise 1

SELECT *
FROM student_details
WHERE phone IS NULL;


-- Exercise 2

SELECT *
FROM student_details
WHERE phone IS NOT NULL;


-- Exercise 3

SELECT *
FROM student_details
WHERE email IS NULL;


-- Exercise 4

SELECT *
FROM student_details
WHERE scholarship IS NULL;


-- Exercise 5

SELECT
    COUNT(*) AS total_students
FROM student_details;


-- Exercise 6

SELECT
    COUNT(phone) AS students_with_phone
FROM student_details;


-- Exercise 7

SELECT
    COUNT(email) AS students_with_email
FROM student_details;


-- Exercise 8

SELECT
    student_id,
    COALESCE(
        phone,
        'Not Provided'
    ) AS phone
FROM student_details;


-- Exercise 9

SELECT
    student_id,
    IFNULL(
        scholarship,
        0
    ) AS scholarship
FROM student_details;


-- Exercise 10

SELECT *
FROM student_details
WHERE phone IS NOT NULL
  AND email IS NOT NULL;


-- ============================================================
-- MEDIUM
-- ============================================================

-- Exercise 11

SELECT *
FROM student_details
WHERE phone IS NULL
  AND email IS NULL;


-- Exercise 12

SELECT *
FROM student_details
WHERE phone IS NOT NULL
   OR email IS NOT NULL;


-- Exercise 13

SELECT
    COUNT(*) - COUNT(phone) AS students_without_phone
FROM student_details;


-- Exercise 14

SELECT
    COUNT(*) - COUNT(email) AS students_without_email
FROM student_details;


-- Exercise 15

SELECT
    (COUNT(*) - COUNT(phone)) * 100.0 / COUNT(*)
        AS missing_phone_percentage
FROM student_details;


-- Exercise 16

SELECT
    SUM(scholarship) AS total_scholarship
FROM student_details;


-- Exercise 17

SELECT
    AVG(scholarship) AS average_scholarship
FROM student_details;


-- Exercise 18

SELECT
    MIN(scholarship) AS minimum_scholarship,
    MAX(scholarship) AS maximum_scholarship
FROM student_details;


-- Exercise 19

SELECT
    student_id,
    CASE
        WHEN phone IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS phone_status
FROM student_details;


-- Exercise 20

SELECT
    student_id,
    COALESCE(
        phone,
        email,
        'No Contact Information'
    ) AS contact
FROM student_details;


-- ============================================================
-- HARD
-- ============================================================

-- Exercise 21

SELECT *
FROM student_details
WHERE mentor IS NULL;


-- Exercise 22

SELECT DISTINCT
    mentor
FROM student_details;


-- Exercise 23

SELECT
    mentor,
    COUNT(*) AS student_count
FROM student_details
GROUP BY mentor;


-- Exercise 24

SELECT
    student_id,
    COALESCE(
        scholarship,
        0
    ) AS scholarship
FROM student_details;


-- Exercise 25

SELECT
    student_id,
    NULLIF(
        scholarship,
        0
    ) AS scholarship
FROM student_details;


-- Exercise 26

SELECT *
FROM student_details
WHERE email IS NULL
   OR email = '';


-- Exercise 27

SELECT
    student_id,
    NULLIF(
        email,
        ''
    ) AS cleaned_email
FROM student_details;


-- Exercise 28

SELECT
    student_id,
    COALESCE(
        NULLIF(email, ''),
        'Not Provided'
    ) AS cleaned_email
FROM student_details;


-- Exercise 29

SELECT
    COUNT(*) AS total_students,
    COUNT(email) AS students_with_email,
    COUNT(*) - COUNT(email) AS students_without_email,
    COUNT(phone) AS students_with_phone,
    COUNT(*) - COUNT(phone) AS students_without_phone
FROM student_details;


-- Exercise 30

SELECT *
FROM student_details
ORDER BY
    scholarship IS NULL,
    scholarship DESC;


-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- Exercise 31

SELECT
    student_id,
    CASE
        WHEN scholarship IS NULL
            THEN 'Not Recorded'
        WHEN scholarship = 0
            THEN 'No Scholarship'
        ELSE 'Scholarship Available'
    END AS scholarship_status
FROM student_details;


-- Exercise 32

SELECT
    student_id,
    CASE
        WHEN phone IS NOT NULL
         AND email IS NOT NULL
            THEN 'Complete'
        WHEN phone IS NOT NULL
          OR email IS NOT NULL
            THEN 'Partial'
        ELSE 'Missing'
    END AS contact_status
FROM student_details;


-- Exercise 33

SELECT
    SUM(
        CASE
            WHEN phone IS NOT NULL
             AND email IS NOT NULL
                THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(*) AS complete_contact_percentage
FROM student_details;


-- Exercise 34

SELECT
    student_id,
    scholarship
FROM student_details
WHERE scholarship > 3000
   OR scholarship IS NULL;


-- Exercise 35

SELECT
    student_id,
    email,
    phone,
    COALESCE(
        phone,
        email,
        'No Contact'
    ) AS preferred_contact
FROM student_details;


-- Exercise 36

SELECT *
FROM student_details
WHERE mentor IS NULL
  AND (
      phone IS NOT NULL
      OR email IS NOT NULL
  );


-- Exercise 37

SELECT
    COUNT(*) AS total_students,
    COUNT(scholarship) AS total_scholarship_records,
    COUNT(*) - COUNT(scholarship)
        AS missing_scholarship_records
FROM student_details;


-- Exercise 38

SELECT
    student_id,
    scholarship,
    COALESCE(
        scholarship,
        0
    ) AS scholarship_amount
FROM student_details;


-- Exercise 39

SELECT
    student_id,
    email AS original_email,
    COALESCE(
        NULLIF(email, ''),
        'Not Provided'
    ) AS cleaned_email
FROM student_details;


-- Exercise 40

SELECT
    student_id,

    CASE
        WHEN email IS NULL
            THEN 'Missing'
        ELSE 'Available'
    END AS email_status,

    CASE
        WHEN phone IS NULL
            THEN 'Missing'
        ELSE 'Available'
    END AS phone_status,

    CASE
        WHEN scholarship IS NULL
            THEN 'Missing'
        ELSE 'Available'
    END AS scholarship_status,

    CASE
        WHEN mentor IS NULL
            THEN 'Missing'
        ELSE 'Available'
    END AS mentor_status

FROM student_details;
