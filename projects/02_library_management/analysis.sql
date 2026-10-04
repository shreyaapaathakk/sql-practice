-- ============================================================
-- Library Management System
-- File: analysis.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

USE library_management;

-- ============================================================
-- 1. MOST BORROWED BOOKS
-- ============================================================

SELECT
    b.book_id,
    b.title,
    COUNT(l.loan_id) AS times_borrowed
FROM books AS b
LEFT JOIN loans AS l
    ON b.book_id = l.book_id
GROUP BY
    b.book_id,
    b.title
ORDER BY times_borrowed DESC;


-- ============================================================
-- 2. MOST ACTIVE MEMBERS
-- ============================================================

SELECT
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    COUNT(l.loan_id) AS total_loans
FROM members AS m
INNER JOIN loans AS l
    ON m.member_id = l.member_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name
ORDER BY total_loans DESC;


-- ============================================================
-- 3. CATEGORY BORROWING ANALYSIS
-- ============================================================

SELECT
    c.category_name,
    COUNT(l.loan_id) AS total_loans,
    COUNT(DISTINCT l.member_id) AS unique_members,
    COUNT(DISTINCT l.book_id) AS unique_books
FROM categories AS c
LEFT JOIN books AS b
    ON c.category_id = b.category_id
LEFT JOIN loans AS l
    ON b.book_id = l.book_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_loans DESC;


-- ============================================================
-- 4. AUTHOR POPULARITY
-- ============================================================

SELECT
    a.author_id,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    COUNT(l.loan_id) AS total_borrowings
FROM authors AS a
LEFT JOIN book_authors AS ba
    ON a.author_id = ba.author_id
LEFT JOIN loans AS l
    ON ba.book_id = l.book_id
GROUP BY
    a.author_id,
    a.first_name,
    a.last_name
ORDER BY total_borrowings DESC;


-- ============================================================
-- 5. CURRENTLY BORROWED BOOKS
-- ============================================================

SELECT
    l.loan_id,
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    l.issue_date,
    l.due_date
FROM loans AS l
INNER JOIN books AS b
    ON l.book_id = b.book_id
INNER JOIN members AS m
    ON l.member_id = m.member_id
WHERE l.return_date IS NULL
ORDER BY l.due_date;


-- ============================================================
-- 6. OVERDUE BOOKS
--
-- This query uses a fixed reference date so the project
-- produces reproducible results.
-- ============================================================

SET @analysis_date = '2025-02-10';

SELECT
    l.loan_id,
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    l.due_date,
    DATEDIFF(@analysis_date, l.due_date) AS days_overdue
FROM loans AS l
INNER JOIN books AS b
    ON l.book_id = b.book_id
INNER JOIN members AS m
    ON l.member_id = m.member_id
WHERE l.return_date IS NULL
  AND l.due_date < @analysis_date
ORDER BY days_overdue DESC;


-- ============================================================
-- 7. MEMBERS WITH OVERDUE BOOKS
-- ============================================================

SELECT DISTINCT
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    m.email
FROM members AS m
INNER JOIN loans AS l
    ON m.member_id = l.member_id
WHERE l.return_date IS NULL
  AND l.due_date < @analysis_date
ORDER BY member_name;


-- ============================================================
-- 8. AVERAGE BORROWING DURATION
-- ============================================================

SELECT
    ROUND(
        AVG(DATEDIFF(return_date, issue_date)),
        2
    ) AS average_borrowing_days
FROM loans
WHERE return_date IS NOT NULL;


-- ============================================================
-- 9. AVERAGE BORROWING DURATION BY CATEGORY
-- ============================================================

SELECT
    c.category_name,
    ROUND(
        AVG(DATEDIFF(l.return_date, l.issue_date)),
        2
    ) AS average_borrowing_days
FROM categories AS c
INNER JOIN books AS b
    ON c.category_id = b.category_id
INNER JOIN loans AS l
    ON b.book_id = l.book_id
WHERE l.return_date IS NOT NULL
GROUP BY
    c.category_id,
    c.category_name
ORDER BY average_borrowing_days DESC;


-- ============================================================
-- 10. BOOKS THAT HAVE NEVER BEEN BORROWED
-- ============================================================

SELECT
    b.book_id,
    b.title
FROM books AS b
LEFT JOIN loans AS l
    ON b.book_id = l.book_id
WHERE l.loan_id IS NULL
ORDER BY b.title;


-- ============================================================
-- 11. MEMBER FINE SUMMARY
-- ============================================================

SELECT
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    COALESCE(SUM(f.fine_amount), 0) AS total_fines,
    COALESCE(
        SUM(
            CASE
                WHEN f.payment_status = 'Paid'
                THEN f.fine_amount
                ELSE 0
            END
        ),
        0
    ) AS paid_fines,
    COALESCE(
        SUM(
            CASE
                WHEN f.payment_status = 'Unpaid'
                THEN f.fine_amount
                ELSE 0
            END
        ),
        0
    ) AS unpaid_fines
FROM members AS m
LEFT JOIN loans AS l
    ON m.member_id = l.member_id
LEFT JOIN fines AS f
    ON l.loan_id = f.loan_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name
ORDER BY unpaid_fines DESC;


-- ============================================================
-- 12. TOP 5 MOST BORROWED BOOKS
-- ============================================================

SELECT
    b.title,
    COUNT(l.loan_id) AS borrow_count
FROM books AS b
INNER JOIN loans AS l
    ON b.book_id = l.book_id
GROUP BY
    b.book_id,
    b.title
ORDER BY borrow_count DESC
LIMIT 5;


-- ============================================================
-- 13. RANK BOOKS BY BORROWING FREQUENCY
-- ============================================================

WITH book_borrowings AS (
    SELECT
        b.book_id,
        b.title,
        COUNT(l.loan_id) AS borrow_count
    FROM books AS b
    LEFT JOIN loans AS l
        ON b.book_id = l.book_id
    GROUP BY
        b.book_id,
        b.title
)

SELECT
    book_id,
    title,
    borrow_count,
    RANK() OVER (
        ORDER BY borrow_count DESC
    ) AS popularity_rank
FROM book_borrowings
ORDER BY popularity_rank;


-- ============================================================
-- 14. RANK BOOKS WITHIN EACH CATEGORY
-- ============================================================

WITH book_borrowings AS (
    SELECT
        b.book_id,
        b.title,
        b.category_id,
        COUNT(l.loan_id) AS borrow_count
    FROM books AS b
    LEFT JOIN loans AS l
        ON b.book_id = l.book_id
    GROUP BY
        b.book_id,
        b.title,
        b.category_id
)

SELECT
    bb.title,
    c.category_name,
    bb.borrow_count,
    RANK() OVER (
        PARTITION BY bb.category_id
        ORDER BY bb.borrow_count DESC
    ) AS category_rank
FROM book_borrowings AS bb
INNER JOIN categories AS c
    ON bb.category_id = c.category_id
ORDER BY
    c.category_name,
    category_rank;


-- ============================================================
-- 15. TOP BOOK IN EACH CATEGORY
-- ============================================================

WITH book_borrowings AS (
    SELECT
        b.book_id,
        b.title,
        b.category_id,
        COUNT(l.loan_id) AS borrow_count
    FROM books AS b
    LEFT JOIN loans AS l
        ON b.book_id = l.book_id
    GROUP BY
        b.book_id,
        b.title,
        b.category_id
),

ranked_books AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY category_id
            ORDER BY borrow_count DESC
        ) AS category_rank
    FROM book_borrowings
)

SELECT
    rb.title,
    c.category_name,
    rb.borrow_count
FROM ranked_books AS rb
INNER JOIN categories AS c
    ON rb.category_id = c.category_id
WHERE rb.category_rank = 1
ORDER BY c.category_name;


-- ============================================================
-- 16. MONTHLY BORROWING TRENDS
-- ============================================================

SELECT
    YEAR(issue_date) AS loan_year,
    MONTH(issue_date) AS loan_month,
    COUNT(*) AS total_loans
FROM loans
GROUP BY
    YEAR(issue_date),
    MONTH(issue_date)
ORDER BY
    loan_year,
    loan_month;


-- ============================================================
-- 17. MEMBER ACTIVITY RANKING
-- ============================================================

WITH member_activity AS (
    SELECT
        m.member_id,
        CONCAT(m.first_name, ' ', m.last_name) AS member_name,
        COUNT(l.loan_id) AS total_loans
    FROM members AS m
    LEFT JOIN loans AS l
        ON m.member_id = l.member_id
    GROUP BY
        m.member_id,
        m.first_name,
        m.last_name
)

SELECT
    member_id,
    member_name,
    total_loans,
    DENSE_RANK() OVER (
        ORDER BY total_loans DESC
    ) AS activity_rank
FROM member_activity
ORDER BY activity_rank;


-- ============================================================
-- 18. MEMBER ACTIVITY CATEGORY
-- ============================================================

WITH member_activity AS (
    SELECT
        m.member_id,
        CONCAT(m.first_name, ' ', m.last_name) AS member_name,
        COUNT(l.loan_id) AS total_loans
    FROM members AS m
    LEFT JOIN loans AS l
        ON m.member_id = l.member_id
    GROUP BY
        m.member_id,
        m.first_name,
        m.last_name
)

SELECT
    member_id,
    member_name,
    total_loans,
    CASE
        WHEN total_loans >= 5 THEN 'Highly Active'
        WHEN total_loans >= 3 THEN 'Active'
        WHEN total_loans >= 1 THEN 'Occasional'
        ELSE 'Inactive'
    END AS activity_category
FROM member_activity
ORDER BY total_loans DESC;


-- ============================================================
-- 19. AVAILABLE INVENTORY BY CATEGORY
-- ============================================================

SELECT
    c.category_name,
    SUM(b.total_copies) AS total_copies,
    SUM(b.available_copies) AS available_copies,
    SUM(b.total_copies - b.available_copies) AS borrowed_copies
FROM categories AS c
INNER JOIN books AS b
    ON c.category_id = b.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY borrowed_copies DESC;


-- ============================================================
-- 20. BOOK AVAILABILITY STATUS
-- ============================================================

SELECT
    book_id,
    title,
    total_copies,
    available_copies,
    total_copies - available_copies AS borrowed_copies,

    CASE
        WHEN available_copies = 0 THEN 'Unavailable'
        WHEN available_copies < total_copies THEN 'Partially Available'
        ELSE 'Fully Available'
    END AS availability_status

FROM books
ORDER BY title;


-- ============================================================
-- 21. AUTHORS WITH MORE THAN ONE BOOK
-- ============================================================

SELECT
    a.author_id,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name,
    COUNT(ba.book_id) AS book_count
FROM authors AS a
INNER JOIN book_authors AS ba
    ON a.author_id = ba.author_id
GROUP BY
    a.author_id,
    a.first_name,
    a.last_name
HAVING COUNT(ba.book_id) > 1
ORDER BY book_count DESC;


-- ============================================================
-- 22. MEMBER BORROWING SUMMARY
-- ============================================================

SELECT
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,

    COUNT(l.loan_id) AS total_loans,

    COUNT(
        CASE
            WHEN l.return_date IS NULL
            THEN 1
        END
    ) AS current_loans,

    COUNT(
        CASE
            WHEN l.return_date IS NOT NULL
            THEN 1
        END
    ) AS returned_loans

FROM members AS m
LEFT JOIN loans AS l
    ON m.member_id = l.member_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name
ORDER BY total_loans DESC;


-- ============================================================
-- 23. OVERDUE RISK REPORT
-- ============================================================

SELECT
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    l.due_date,
    DATEDIFF(@analysis_date, l.due_date) AS days_overdue,

    CASE
        WHEN DATEDIFF(@analysis_date, l.due_date) > 14
            THEN 'High Risk'
        WHEN DATEDIFF(@analysis_date, l.due_date) > 7
            THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS overdue_risk

FROM loans AS l
INNER JOIN members AS m
    ON l.member_id = m.member_id
INNER JOIN books AS b
    ON l.book_id = b.book_id
WHERE l.return_date IS NULL
  AND l.due_date < @analysis_date
ORDER BY days_overdue DESC;


-- ============================================================
-- 24. LIBRARY SUMMARY
-- ============================================================

SELECT
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT SUM(total_copies) FROM books) AS total_copies,
    (SELECT SUM(available_copies) FROM books) AS available_copies,
    (
        SELECT COUNT(*)
        FROM loans
        WHERE return_date IS NULL
    ) AS currently_borrowed,
    (SELECT COUNT(*) FROM members) AS total_members,
    (
        SELECT COUNT(*)
        FROM members
        WHERE membership_status = 'Active'
    ) AS active_members,
    (
        SELECT COALESCE(SUM(fine_amount), 0)
        FROM fines
    ) AS total_fines,
    (
        SELECT COALESCE(SUM(fine_amount), 0)
        FROM fines
        WHERE payment_status = 'Unpaid'
    ) AS unpaid_fines;
