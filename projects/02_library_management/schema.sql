sql
-- ============================================================
-- Library Management System
-- File: schema.sql
-- SQL Dialect: MySQL 8.0+
-- ============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS library_management;

USE library_management;

-- ============================================================
-- 1. Categories
-- ============================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- ============================================================
-- 2. Publishers
-- ============================================================

CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(100),
    country VARCHAR(100)
);

-- ============================================================
-- 3. Authors
-- ============================================================

CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    country VARCHAR(100),
    birth_year YEAR
);

-- ============================================================
-- 4. Books
-- ============================================================

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    category_id INT NOT NULL,
    publisher_id INT,
    publication_year YEAR,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,

    CONSTRAINT chk_total_copies
        CHECK (total_copies > 0),

    CONSTRAINT chk_available_copies
        CHECK (
            available_copies >= 0
            AND available_copies <= total_copies
        ),

    CONSTRAINT fk_books_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_books_publisher
        FOREIGN KEY (publisher_id)
        REFERENCES publishers(publisher_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- ============================================================
-- 5. Book Authors
-- Many-to-many relationship between books and authors
-- ============================================================

CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,

    PRIMARY KEY (book_id, author_id),

    CONSTRAINT fk_book_authors_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_book_authors_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================================
-- 6. Members
-- ============================================================

CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    membership_date DATE NOT NULL,
    membership_status ENUM('Active', 'Inactive', 'Suspended')
        NOT NULL DEFAULT 'Active'
);

-- ============================================================
-- 7. Loans
-- ============================================================

CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,

    CONSTRAINT chk_due_date
        CHECK (due_date >= issue_date),

    CONSTRAINT chk_return_date
        CHECK (
            return_date IS NULL
            OR return_date >= issue_date
        ),

    CONSTRAINT fk_loans_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_loans_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ============================================================
-- 8. Fines
-- ============================================================

CREATE TABLE fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT NOT NULL UNIQUE,
    fine_amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    payment_status ENUM('Paid', 'Unpaid', 'Waived')
        NOT NULL DEFAULT 'Unpaid',
    paid_date DATE NULL,

    CONSTRAINT chk_fine_amount
        CHECK (fine_amount >= 0),

    CONSTRAINT fk_fines_loan
        FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- ============================================================
-- Verify tables
-- ============================================================

SHOW TABLES;
