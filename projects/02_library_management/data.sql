-- ============================================================
-- Library Management System
-- File: data.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

USE library_management;

-- ============================================================
-- 1. Categories
-- ============================================================

INSERT INTO categories
    (category_name, description)
VALUES
    ('Technology', 'Programming, databases, software and technology'),
    ('Science', 'Physics, mathematics and natural sciences'),
    ('Business', 'Management, finance and entrepreneurship'),
    ('Fiction', 'Novels and fictional literature'),
    ('History', 'Historical events and civilizations'),
    ('Biography', 'Biographies and autobiographies'),
    ('Self Development', 'Personal growth and productivity'),
    ('Academic', 'Academic and educational reference books');

-- ============================================================
-- 2. Publishers
-- ============================================================

INSERT INTO publishers
    (publisher_name, city, country)
VALUES
    ('TechPress Publishing', 'Bengaluru', 'India'),
    ('Global Academic Press', 'New Delhi', 'India'),
    ('Knowledge House', 'Mumbai', 'India'),
    ('Modern Books Ltd', 'London', 'United Kingdom'),
    ('Scholars Publishing', 'New York', 'United States'),
    ('Literary World', 'Delhi', 'India');

-- ============================================================
-- 3. Authors
-- ============================================================

INSERT INTO authors
    (first_name, last_name, country, birth_year)
VALUES
    ('Robert', 'Martin', 'United States', 1952),
    ('Andrew', 'Tanenbaum', 'United States', 1944),
    ('Thomas', 'Connolly', 'United Kingdom', 1952),
    ('Raghu', 'Ramakrishnan', 'India', 1960),
    ('James', 'Clear', 'United States', 1986),
    ('Yuval', 'Harari', 'Israel', 1976),
    ('George', 'Orwell', 'United Kingdom', 1903),
    ('Jane', 'Austen', 'United Kingdom', 1775),
    ('Walter', 'Isaacson', 'United States', 1952),
    ('Stephen', 'Hawking', 'United Kingdom', 1942),
    ('Peter', 'Drucker', 'Austria', 1909),
    ('Daniel', 'Kahneman', 'Israel', 1934),
    ('Martin', 'Kleppmann', 'United Kingdom', 1978),
    ('Eric', 'Evans', 'United States', 1961),
    ('Charles', 'Petzold', 'United States', 1953);

-- ============================================================
-- 4. Books
-- ============================================================

INSERT INTO books
    (
        isbn,
        title,
        category_id,
        publisher_id,
        publication_year,
        total_copies,
        available_copies
    )
VALUES
    ('978001000001', 'Clean Code', 1, 1, 2008, 5, 3),
    ('978001000002', 'Computer Networks', 1, 2, 2011, 4, 3),
    ('978001000003', 'Database Systems', 8, 2, 2015, 6, 4),
    ('978001000004', 'Database Management', 1, 1, 2018, 5, 4),
    ('978001000005', 'Atomic Habits', 7, 3, 2018, 5, 3),
    ('978001000006', 'Sapiens', 5, 4, 2015, 4, 3),
    ('978001000007', '1984', 4, 6, 1949, 5, 4),
    ('978001000008', 'Pride and Prejudice', 4, 6, 1813, 4, 3),
    ('978001000009', 'Steve Jobs', 6, 5, 2011, 4, 3),
    ('978001000010', 'A Brief History of Time', 2, 4, 1988, 4, 3),
    ('978001000011', 'The Effective Executive', 3, 3, 1967, 3, 2),
    ('978001000012', 'Thinking, Fast and Slow', 3, 5, 2011, 4, 3),
    ('978001000013', 'Designing Data-Intensive Applications', 1, 1, 2017, 5, 3),
    ('978001000014', 'Domain-Driven Design', 1, 1, 2003, 3, 2),
    ('978001000015', 'Code: The Hidden Language', 1, 3, 2000, 3, 3),
    ('978001000016', 'World History Encyclopedia', 5, 2, 2020, 3, 3),
    ('978001000017', 'Modern Physics', 2, 2, 2019, 4, 4),
    ('978001000018', 'Business Strategy Essentials', 3, 3, 2021, 3, 3);

-- ============================================================
-- 5. Book Authors
-- ============================================================

INSERT INTO book_authors
    (book_id, author_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (3, 4),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11),
    (12, 12),
    (13, 13),
    (14, 14),
    (15, 15),
    (16, 6),
    (17, 10),
    (18, 11);

-- ============================================================
-- 6. Members
-- ============================================================

INSERT INTO members
    (
        first_name,
        last_name,
        email,
        phone,
        membership_date,
        membership_status
    )
VALUES
    ('Aarav', 'Sharma', 'aarav.library@example.com', '9876500001', '2023-01-15', 'Active'),
    ('Ananya', 'Patel', 'ananya.library@example.com', '9876500002', '2023-02-20', 'Active'),
    ('Rohan', 'Verma', 'rohan.library@example.com', '9876500003', '2023-03-10', 'Active'),
    ('Priya', 'Mehta', 'priya.library@example.com', '9876500004', '2023-04-05', 'Active'),
    ('Arjun', 'Singh', 'arjun.library@example.com', '9876500005', '2023-05-12', 'Active'),
    ('Sneha', 'Gupta', 'sneha.library@example.com', '9876500006', '2023-06-18', 'Active'),
    ('Vikram', 'Joshi', 'vikram.library@example.com', '9876500007', '2023-07-22', 'Suspended'),
    ('Kavya', 'Nair', 'kavya.library@example.com', '9876500008', '2023-08-14', 'Active'),
    ('Rahul', 'Desai', 'rahul.library@example.com', '9876500009', '2023-09-01', 'Active'),
    ('Ishita', 'Rao', 'ishita.library@example.com', '9876500010', '2023-10-11', 'Active'),
    ('Aditya', 'Kapoor', 'aditya.library@example.com', '9876500011', '2024-01-15', 'Active'),
    ('Meera', 'Iyer', 'meera.library@example.com', '9876500012', '2024-02-10', 'Inactive');

-- ============================================================
-- 7. Loans
-- ============================================================

INSERT INTO loans
    (
        book_id,
        member_id,
        issue_date,
        due_date,
        return_date
    )
VALUES
    -- Returned loans
    (1, 1, '2024-01-05', '2024-01-19', '2024-01-17'),
    (5, 2, '2024-01-10', '2024-01-24', '2024-01-22'),
    (6, 3, '2024-02-01', '2024-02-15', '2024-02-14'),
    (7, 4, '2024-02-10', '2024-02-24', '2024-02-20'),
    (8, 5, '2024-03-01', '2024-03-15', '2024-03-16'),
    (9, 6, '2024-03-05', '2024-03-19', '2024-03-18'),
    (10, 7, '2024-03-12', '2024-03-26', '2024-03-30'),
    (11, 8, '2024-04-01', '2024-04-15', '2024-04-13'),
    (12, 9, '2024-04-08', '2024-04-22', '2024-04-20'),
    (13, 10, '2024-04-15', '2024-04-29', '2024-04-28'),
    (14, 11, '2024-05-01', '2024-05-15', '2024-05-14'),
    (15, 12, '2024-05-05', '2024-05-19', '2024-05-18'),

    -- More historical loans
    (1, 2, '2024-05-10', '2024-05-24', '2024-05-22'),
    (1, 3, '2024-06-01', '2024-06-15', '2024-06-14'),
    (2, 4, '2024-06-05', '2024-06-19', '2024-06-17'),
    (3, 5, '2024-06-10', '2024-06-24', '2024-06-23'),
    (5, 6, '2024-07-01', '2024-07-15', '2024-07-13'),
    (7, 8, '2024-07-05', '2024-07-19', '2024-07-18'),
    (9, 9, '2024-07-10', '2024-07-24', '2024-07-22'),
    (13, 10, '2024-08-01', '2024-08-15', '2024-08-13'),
    (1, 11, '2024-08-05', '2024-08-19', '2024-08-18'),
    (6, 12, '2024-08-10', '2024-08-24', '2024-08-21'),

    -- Current unreturned loans
    (1, 1, '2025-01-05', '2025-01-19', NULL),
    (2, 2, '2025-01-08', '2025-01-22', NULL),
    (5, 3, '2025-01-10', '2025-01-24', NULL),
    (7, 4, '2025-01-12', '2025-01-26', NULL),
    (13, 5, '2025-01-15', '2025-01-29', NULL),
    (10, 6, '2025-01-18', '2025-02-01', NULL),
    (3, 8, '2025-01-20', '2025-02-03', NULL),
    (12, 9, '2025-01-22', '2025-02-05', NULL);

-- ============================================================
-- 8. Fines
-- ============================================================

INSERT INTO fines
    (
        loan_id,
        fine_amount,
        payment_status,
        paid_date
    )
VALUES
    (5, 50.00, 'Paid', '2024-03-20'),
    (7, 100.00, 'Unpaid', NULL),
    (15, 40.00, 'Paid', '2024-06-20'),
    (18, 25.00, 'Paid', '2024-07-01'),
    (27, 75.00, 'Unpaid', NULL),
    (29, 50.00, 'Unpaid', NULL);

-- ============================================================
-- Verification
-- ============================================================

SELECT COUNT(*) AS total_categories
FROM categories;

SELECT COUNT(*) AS total_publishers
FROM publishers;

SELECT COUNT(*) AS total_authors
FROM authors;

SELECT COUNT(*) AS total_books
FROM books;

SELECT COUNT(*) AS total_members
FROM members;

SELECT COUNT(*) AS total_loans
FROM loans;

SELECT COUNT(*) AS total_fines
FROM fines;
