
---

# `10_case_expressions/examples.sql`

```sql
-- ============================================================
-- MODULE 10: CASE EXPRESSIONS
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

USE school;


-- ============================================================
-- 1. BASIC CASE
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS age_group
FROM students;


-- ============================================================
-- 2. MULTIPLE CONDITIONS
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age < 20 THEN 'Teen'
        WHEN age < 22 THEN 'Young Adult'
        ELSE 'Adult'
    END AS age_group
FROM students;


-- ============================================================
-- 3. CASE WITH ELSE
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN '21 or Older'
        ELSE 'Under 21'
    END AS age_category
FROM students;


-- ============================================================
-- 4. SIMPLE CASE
-- ============================================================

SELECT
    first_name,
    city,
    CASE city
        WHEN 'Delhi' THEN 'North'
        WHEN 'Mumbai' THEN 'West'
        WHEN 'Pune' THEN 'West'
        ELSE 'Other'
    END AS region
FROM students;


-- ============================================================
-- 5. SEARCHED CASE
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN 'Older Student'
        WHEN age >= 20 THEN '20-Year-Old'
        ELSE 'Younger Student'
    END AS category
FROM students;


-- ============================================================
-- 6. CASE WITH AND
-- ============================================================

SELECT
    first_name,
    age,
    city,
    CASE
        WHEN age >= 20 AND city = 'Delhi'
            THEN 'Delhi Student 20+'
        ELSE 'Other'
    END AS category
FROM students;


-- ============================================================
-- 7. CASE WITH OR
-- ============================================================

SELECT
    first_name,
    city,
    CASE
        WHEN city = 'Delhi' OR city = 'Mumbai'
            THEN 'Major City'
        ELSE 'Other City'
    END AS city_type
FROM students;


-- ============================================================
-- 8. CASE WITH IN
-- ============================================================

SELECT
    first_name,
    city,
    CASE
        WHEN city IN ('Delhi', 'Mumbai', 'Pune')
            THEN 'Selected City'
        ELSE 'Other City'
    END AS city_group
FROM students;


-- ============================================================
-- 9. CASE WITH BETWEEN
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age BETWEEN 19 AND 20 THEN '19-20'
        WHEN age BETWEEN 21 AND 22 THEN '21-22'
        ELSE 'Other'
    END AS age_range
FROM students;


-- ============================================================
-- 10. CASE WITH NULL
-- ============================================================

SELECT
    first_name,
    city,
    CASE
        WHEN city IS NULL THEN 'City Unknown'
        ELSE city
    END AS city_display
FROM students;


-- ============================================================
-- 11. CASE IN ORDER BY
-- ============================================================

SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE city
        WHEN 'Delhi' THEN 1
        WHEN 'Mumbai' THEN 2
        WHEN 'Pune' THEN 3
        ELSE 4
    END;


-- ============================================================
-- 12. PRIORITY SORTING
-- ============================================================

SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE
        WHEN city = 'Delhi' THEN 1
        WHEN city = 'Mumbai' THEN 2
        ELSE 3
    END,
    first_name;


-- ============================================================
-- 13. CASE WITH ARITHMETIC
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age >= 21 THEN age + 1
        ELSE age
    END AS adjusted_age
FROM students;


-- ============================================================
-- 14. MULTIPLE CASE EXPRESSIONS
-- ============================================================

SELECT
    first_name,
    age,
    city,

    CASE
        WHEN age >= 21 THEN 'Older'
        ELSE 'Younger'
    END AS age_category,

    CASE
        WHEN city IN ('Delhi', 'Mumbai')
            THEN 'Major City'
        ELSE 'Other City'
    END AS city_category

FROM students;


-- ============================================================
-- 15. CONDITIONAL COUNT
-- ============================================================

SELECT
    COUNT(
        CASE
            WHEN age >= 21 THEN 1
        END
    ) AS students_21_plus
FROM students;


-- ============================================================
-- 16. CONDITIONAL SUM
-- ============================================================

SELECT
    SUM(
        CASE
            WHEN age >= 21 THEN 1
            ELSE 0
        END
    ) AS students_21_plus
FROM students;


-- ============================================================
-- 17. CASE WITH GROUP BY
-- ============================================================

SELECT
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END AS age_group,
    COUNT(*) AS student_count
FROM students
GROUP BY
    CASE
        WHEN age >= 21 THEN '21+'
        ELSE 'Under 21'
    END;


-- ============================================================
-- 18. CASE WITH SUBQUERY
-- ============================================================

SELECT
    first_name,
    age,
    CASE
        WHEN age > (
            SELECT AVG(age)
            FROM students
        )
        THEN 'Above Average'
        ELSE 'Average or Below'
    END AS age_status
FROM students;


-- ============================================================
-- 19. CASE WITH ORDER BY AND LIMIT
-- ============================================================

SELECT
    first_name,
    city
FROM students
ORDER BY
    CASE
        WHEN city = 'Delhi' THEN 1
        WHEN city = 'Mumbai' THEN 2
        ELSE 3
    END,
    first_name
LIMIT 3;


-- ============================================================
-- 20. REAL-WORLD STYLE REPORT
-- ============================================================

SELECT
    first_name,
    last_name,
    age,
    city,
    CASE
        WHEN age >= 21 THEN 'Senior Student'
        WHEN age >= 20 THEN 'Intermediate Student'
        ELSE 'Junior Student'
    END AS student_level
FROM students
ORDER BY
    student_level,
    first_name;
