-- =====================================================
-- Module 02 : Databases & Tables
-- File       : solutions.sql
-- SQL Dialect: MySQL 8.0+
-- =====================================================


-- =====================================================
-- 🟢 EASY
-- =====================================================

-- -----------------------------------------------------
-- Question 1
-- Create a database named `library`.
-- -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS library;


-- -----------------------------------------------------
-- Question 2
-- Select the `library` database.
-- -----------------------------------------------------

USE library;


-- -----------------------------------------------------
-- Question 3
-- Display all databases.
-- -----------------------------------------------------

SHOW DATABASES;


-- -----------------------------------------------------
-- Question 4
-- Create the books table.
-- -----------------------------------------------------

CREATE TABLE books (
    book_id INT,
    title VARCHAR(150),
    author VARCHAR(100),
    price DECIMAL(8, 2),
    published_date DATE
);


-- -----------------------------------------------------
-- Question 5
-- Display all tables.
-- -----------------------------------------------------

SHOW TABLES;


-- -----------------------------------------------------
-- Question 6
-- Display the structure of books.
-- -----------------------------------------------------

DESCRIBE books;


-- =====================================================
-- 🟡 MEDIUM
-- =====================================================

-- -----------------------------------------------------
-- Question 7
-- Add ISBN.
-- -----------------------------------------------------

ALTER TABLE books
ADD isbn VARCHAR(20);


-- -----------------------------------------------------
-- Question 8
-- Add publisher.
-- -----------------------------------------------------

ALTER TABLE books
ADD publisher VARCHAR(100);


-- -----------------------------------------------------
-- Question 9
-- Change author to VARCHAR(150).
-- -----------------------------------------------------

ALTER TABLE books
MODIFY COLUMN author VARCHAR(150);


-- -----------------------------------------------------
-- Question 10
-- Rename publisher.
-- -----------------------------------------------------

ALTER TABLE books
RENAME COLUMN publisher TO publisher_name;


-- -----------------------------------------------------
-- Question 11
-- Remove ISBN.
-- -----------------------------------------------------

ALTER TABLE books
DROP COLUMN isbn;


-- -----------------------------------------------------
-- Question 12
-- Display the CREATE TABLE statement.
-- -----------------------------------------------------

SHOW CREATE TABLE books;


-- =====================================================
-- 🔴 HARD
-- =====================================================

-- -----------------------------------------------------
-- Question 13
-- Create members table.
-- -----------------------------------------------------

CREATE TABLE members (
    member_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    registration_date DATE
);


-- -----------------------------------------------------
-- Question 14
-- Rename members to library_members.
-- -----------------------------------------------------

RENAME TABLE members TO library_members;


-- -----------------------------------------------------
-- Question 15
-- Rename library_members back to members.
-- -----------------------------------------------------

RENAME TABLE library_members TO members;


-- -----------------------------------------------------
-- Question 16
-- Create temporary borrowed_books table.
-- -----------------------------------------------------

CREATE TEMPORARY TABLE borrowed_books (
    book_id INT,
    member_id INT,
    borrowed_date DATE
);


-- -----------------------------------------------------
-- Question 17
-- Remove all records while keeping the table structure.
-- -----------------------------------------------------

TRUNCATE TABLE borrowed_books;


-- -----------------------------------------------------
-- Question 18
-- Permanently remove the temporary table.
-- -----------------------------------------------------

DROP TABLE borrowed_books;


-- =====================================================
-- 🏆 CHALLENGE PREVIEW
-- =====================================================

-- Create the online_store database.

CREATE DATABASE IF NOT EXISTS online_store;

USE online_store;


-- Create the products table.

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(150),
    category VARCHAR(100),
    price DECIMAL(10, 2),
    stock_quantity INT,
    created_at DATE
);


-- Inspect the table.

DESCRIBE products;
