
## `13_null_handling/examples.sql`

```sql
-- ============================================================
-- MODULE 13: NULL HANDLING
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. CREATE TABLE
-- ============================================================

DROP TABLE IF EXISTS student_details;

CREATE TABLE student_details (
    student_id INT PRIMARY KEY,
    email VARCHAR(100),
    phone VARCHAR(20),
    scholarship DECIMAL(10,2),
    mentor VARCHAR(100)
);


-- ============================================================
-- 2. INSERT SAMPLE DATA
-- ============================================================

INSERT INTO student_details
    (student_id, email, phone, scholarship, mentor)
VALUES
    (1, 'rahul@example.com', NULL, 5000.00, 'Anita'),
    (2, NULL, '9876543210', NULL, 'Ravi'),
    (3, 'aman@example.com', NULL, 3000.00, NULL),
    (4, NULL, '9123456780', 0.00, 'Anita'),
    (5, 'neha@example.com', '9988776655', NULL, NULL);


-- ============================================================
-- 3. VIEW DATA
-- ============================================================

SELECT *
FROM student_details;


-- ============================================================
-- 4. IS NULL
-- ============================================================

SELECT *
FROM student_details
WHERE phone IS NULL;


-- ============================================================
-- 5. IS NOT NULL
-- ============================================================

SELECT *
FROM student_details
WHERE phone IS NOT NULL;


-- ============================================================
-- 6. NULL IN CALCULATIONS
-- ============================================================

SELECT
    student_id,
    scholarship,
    scholarship + 1000 AS increased_scholarship
FROM student_details;


-- ============================================================
-- 7. COALESCE()
-- ============================================================

SELECT
    student_id,
    COALESCE(
        phone,
        'Not Provided'
    ) AS phone
FROM student_details;


-- ============================================================
-- 8. COALESCE() WITH MULTIPLE FALLBACKS
-- ============================================================

SELECT
    student_id,
    COALESCE(
        phone,
        email,
        'No Contact Information'
    ) AS preferred_contact
FROM student_details;


-- ============================================================
-- 9. IFNULL()
-- ============================================================

SELECT
    student_id,
    IFNULL(
        scholarship,
        0
    ) AS scholarship_amount
FROM student_details;


-- ============================================================
-- 10. NULLIF()
-- ============================================================

SELECT
    NULLIF(10, 10) AS result;


SELECT
    NULLIF(10, 20) AS result;


-- ============================================================
-- 11. NULLIF() FOR DATA CLEANING
-- ============================================================

SELECT
    student_id,
    scholarship,
    NULLIF(
        scholarship,
        0
    ) AS cleaned_scholarship
FROM student_details;


-- ============================================================
-- 12. COUNT(*) VS COUNT(column)
-- ============================================================

SELECT
    COUNT(*) AS total_students,
    COUNT(phone) AS students_with_phone,
    COUNT(email) AS students_with_email,
    COUNT(scholarship) AS students_with_scholarship
FROM student_details;


-- ============================================================
-- 13. MISSING PHONE COUNT
-- ============================================================

SELECT
    COUNT(*) - COUNT(phone) AS students_without_phone
FROM student_details;


-- ============================================================
-- 14. MISSING EMAIL COUNT
-- ============================================================

SELECT
    COUNT(*) - COUNT(email) AS students_without_email
FROM student_details;


-- ============================================================
-- 15. MISSING PHONE PERCENTAGE
-- ============================================================

SELECT
    COUNT(*) AS total_students,
    COUNT(*) - COUNT(phone) AS missing_phone,
    (COUNT(*) - COUNT(phone)) * 100.0 / COUNT(*) AS missing_percentage
FROM student_details;


-- ============================================================
-- 16. SUM() AND NULL
-- ============================================================

SELECT
    SUM(scholarship) AS total_scholarship
FROM student_details;


-- ============================================================
-- 17. AVG() AND NULL
-- ============================================================

SELECT
    AVG(scholarship) AS average_scholarship
FROM student_details;


-- ============================================================
-- 18. MIN() AND MAX() AND NULL
-- ============================================================

SELECT
    MIN(scholarship) AS minimum_scholarship,
    MAX(scholarship) AS maximum_scholarship
FROM student_details;


-- ============================================================
-- 19. TREAT NULL AS ZERO
-- ============================================================

SELECT
    student_id,
    scholarship,
    COALESCE(
        scholarship,
        0
    ) AS scholarship_for_report
FROM student_details;


-- ============================================================
-- 20. NULL WITH CASE
-- ============================================================

SELECT
    student_id,
    CASE
        WHEN phone IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS phone_status
FROM student_details;


-- ============================================================
-- 21. COMPLETE CONTACT INFORMATION
-- ============================================================

SELECT *
FROM student_details
WHERE phone IS NOT NULL
  AND email IS NOT NULL;


-- ============================================================
-- 22. AT LEAST ONE CONTACT METHOD
-- ============================================================

SELECT *
FROM student_details
WHERE phone IS NOT NULL
   OR email IS NOT NULL;


-- ============================================================
-- 23. MISSING AT LEAST ONE CONTACT METHOD
-- ============================================================

SELECT *
FROM student_details
WHERE phone IS NULL
   OR email IS NULL;


-- ============================================================
-- 24. NULL AND GROUP BY
-- ============================================================

SELECT
    mentor,
    COUNT(*) AS student_count
FROM student_details
GROUP BY mentor;


-- ============================================================
-- 25. DISTINCT WITH NULL
-- ============================================================

SELECT DISTINCT
    mentor
FROM student_details;


-- ============================================================
-- 26. SORT NON-NULL VALUES FIRST
-- ============================================================

SELECT *
FROM student_details
ORDER BY
    scholarship IS NULL,
    scholarship ASC;


-- ============================================================
-- 27. FIND NULL OR EMPTY EMAIL
-- ============================================================

SELECT *
FROM student_details
WHERE email IS NULL
   OR email = '';


-- ============================================================
-- 28. CONVERT EMPTY STRING TO NULL
-- ============================================================

SELECT
    student_id,
    NULLIF(
        email,
        ''
    ) AS cleaned_email
FROM student_details;


-- ============================================================
-- 29. CLEAN AND REPLACE
-- ============================================================

SELECT
    student_id,
    COALESCE(
        NULLIF(email, ''),
        'Not Provided'
    ) AS cleaned_email
FROM student_details;


-- ============================================================
-- 30. PROTECT AGAINST DIVISION BY ZERO
-- ============================================================

SELECT
    1000 / NULLIF(0, 0) AS safe_division;


-- ============================================================
-- 31. DATA QUALITY REPORT
-- ============================================================

SELECT
    COUNT(*) AS total_students,
    COUNT(email) AS students_with_email,
    COUNT(phone) AS students_with_phone,
    COUNT(scholarship) AS students_with_scholarship,
    COUNT(*) - COUNT(email) AS missing_email,
    COUNT(*) - COUNT(phone) AS missing_phone,
    COUNT(*) - COUNT(scholarship) AS missing_scholarship
FROM student_details;


-- ============================================================
-- 32. READABLE CONTACT REPORT
-- ============================================================

SELECT
    student_id,
    COALESCE(
        phone,
        email,
        'No Contact Information'
    ) AS contact_information
FROM student_details;


-- ============================================================
-- 33. COMPLETE NULL ANALYSIS
-- ============================================================

SELECT
    student_id,
    CASE
        WHEN email IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS email_status,
    CASE
        WHEN phone IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS phone_status,
    CASE
        WHEN scholarship IS NULL THEN 'Missing'
        ELSE 'Available'
    END AS scholarship_status
FROM student_details;
