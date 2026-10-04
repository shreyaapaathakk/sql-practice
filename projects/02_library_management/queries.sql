-- ============================================================
-- Library Management System
-- File: queries.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

USE library_management;

-- ============================================================
-- SECTION 1: BASIC RETRIEVAL
-- ============================================================

-- 1. Display all books.

SELECT *
FROM books;


-- 2. Display all active members.

SELECT
    member_id,
    first_name,
    last_name,
    email,
    membership_date
FROM members
WHERE membership_status = 'Active';


-- 3. Display all categories.

SELECT *
FROM categories;


-- 4. Display books ordered alphabetically.

SELECT
    book_id,
    title,
    publication_year,
    total_copies,
    available_copies
FROM books
ORDER BY title;


-- 5. Display books published after 2015.

SELECT
    title,
    publication_year
FROM books
WHERE publication_year > 2015
ORDER BY publication_year DESC;


-- ============================================================
-- SECTION 2: BOOK INFORMATION
-- ============================================================

-- 6. Display books with their category.

SELECT
    b.book_id,
    b.title,
    c.category_name
FROM books AS b
INNER JOIN categories AS c
    ON b.category_id = c.category_id
ORDER BY b.title;


-- 7. Display books with their publishers.

SELECT
    b.title,
    p.publisher_name,
    p.city,
    p.country
FROM books AS b
LEFT JOIN publishers AS p
    ON b.publisher_id = p.publisher_id;


-- 8. Display books with their authors.

SELECT
    b.title,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name
FROM books AS b
INNER JOIN book_authors AS ba
    ON b.book_id = ba.book_id
INNER JOIN authors AS a
    ON ba.author_id = a.author_id
ORDER BY b.title;


-- 9. Display books with category and author.

SELECT
    b.title,
    c.category_name,
    CONCAT(a.first_name, ' ', a.last_name) AS author_name
FROM books AS b
INNER JOIN categories AS c
    ON b.category_id = c.category_id
INNER JOIN book_authors AS ba
    ON b.book_id = ba.book_id
INNER JOIN authors AS a
    ON ba.author_id = a.author_id
ORDER BY b.title;


-- ============================================================
-- SECTION 3: MEMBERS
-- ============================================================

-- 10. Display members alphabetically.

SELECT
    member_id,
    CONCAT(first_name, ' ', last_name) AS member_name,
    email,
    membership_status
FROM members
ORDER BY last_name, first_name;


-- 11. Find members who joined in 2023.

SELECT
    member_id,
    CONCAT(first_name, ' ', last_name) AS member_name,
    membership_date
FROM members
WHERE YEAR(membership_date) = 2023
ORDER BY membership_date;


-- 12. Find suspended members.

SELECT
    member_id,
    CONCAT(first_name, ' ', last_name) AS member_name,
    membership_status
FROM members
WHERE membership_status = 'Suspended';


-- ============================================================
-- SECTION 4: LOANS
-- ============================================================

-- 13. Display all loans with member and book information.

SELECT
    l.loan_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    l.issue_date,
    l.due_date,
    l.return_date
FROM loans AS l
INNER JOIN members AS m
    ON l.member_id = m.member_id
INNER JOIN books AS b
    ON l.book_id = b.book_id
ORDER BY l.issue_date;


-- 14. Display currently borrowed books.

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


-- 15. Display returned books.

SELECT
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    l.issue_date,
    l.return_date
FROM loans AS l
INNER JOIN books AS b
    ON l.book_id = b.book_id
INNER JOIN members AS m
    ON l.member_id = m.member_id
WHERE l.return_date IS NOT NULL
ORDER BY l.return_date DESC;


-- 16. Find books that were returned late.

SELECT
    l.loan_id,
    b.title,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    l.due_date,
    l.return_date,
    DATEDIFF(l.return_date, l.due_date) AS days_late
FROM loans AS l
INNER JOIN books AS b
    ON l.book_id = b.book_id
INNER JOIN members AS m
    ON l.member_id = m.member_id
WHERE l.return_date > l.due_date
ORDER BY days_late DESC;


-- ============================================================
-- SECTION 5: SEARCH
-- ============================================================

-- 17. Find books containing the word "Database".

SELECT
    book_id,
    title
FROM books
WHERE title LIKE '%Database%';


-- 18. Find authors from the United States.

SELECT
    author_id,
    CONCAT(first_name, ' ', last_name) AS author_name
FROM authors
WHERE country = 'United States';


-- 19. Find books with at least two available copies.

SELECT
    title,
    total_copies,
    available_copies
FROM books
WHERE available_copies >= 2
ORDER BY available_copies DESC;


-- ============================================================
-- SECTION 6: AGGREGATION
-- ============================================================

-- 20. Count the total number of books.

SELECT COUNT(*) AS total_books
FROM books;


-- 21. Count books by category.

SELECT
    c.category_name,
    COUNT(b.book_id) AS book_count
FROM categories AS c
LEFT JOIN books AS b
    ON c.category_id = b.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY book_count DESC;


-- 22. Count books by publisher.

SELECT
    p.publisher_name,
    COUNT(b.book_id) AS book_count
FROM publishers AS p
LEFT JOIN books AS b
    ON p.publisher_id = b.publisher_id
GROUP BY
    p.publisher_id,
    p.publisher_name
ORDER BY book_count DESC;


-- 23. Count loans by member.

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
ORDER BY total_loans DESC;


-- 24. Count loans by book.

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
-- SECTION 7: FINES
-- ============================================================

-- 25. Display all fines.

SELECT
    f.fine_id,
    f.loan_id,
    f.fine_amount,
    f.payment_status,
    f.paid_date
FROM fines AS f;


-- 26. Display unpaid fines.

SELECT
    f.fine_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    b.title,
    f.fine_amount,
    f.payment_status
FROM fines AS f
INNER JOIN loans AS l
    ON f.loan_id = l.loan_id
INNER JOIN members AS m
    ON l.member_id = m.member_id
INNER JOIN books AS b
    ON l.book_id = b.book_id
WHERE f.payment_status = 'Unpaid'
ORDER BY f.fine_amount DESC;


-- 27. Calculate total fines.

SELECT
    ROUND(SUM(fine_amount), 2) AS total_fines
FROM fines;


-- 28. Calculate total unpaid fines.

SELECT
    ROUND(SUM(fine_amount), 2) AS unpaid_fines
FROM fines
WHERE payment_status = 'Unpaid';


-- ============================================================
-- SECTION 8: GROUP BY AND HAVING
-- ============================================================

-- 29. Find members who borrowed more than two books.

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
HAVING COUNT(l.loan_id) > 2
ORDER BY total_loans DESC;


-- 30. Find books borrowed more than once.

SELECT
    b.book_id,
    b.title,
    COUNT(l.loan_id) AS borrow_count
FROM books AS b
INNER JOIN loans AS l
    ON b.book_id = l.book_id
GROUP BY
    b.book_id,
    b.title
HAVING COUNT(l.loan_id) > 1
ORDER BY borrow_count DESC;
