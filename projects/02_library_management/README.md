# Project 2 — Library Management System

We’ll keep the same professional structure as the Student Database project, but make this one more focused on **real-world library operations**: books, authors, members, borrowing, returns, and fines.

## Project Structure

```text
projects/
└── 02_library_management/
    ├── README.md
    ├── schema.sql
    ├── data.sql
    ├── queries.sql
    ├── analysis.sql
    └── challenge.sql
```

I’ll start with the first two files so the project remains easy to copy into GitHub.

---

# `projects/02_library_management/README.md`

````markdown
# Library Management System

A practical MySQL project for managing a library's books, authors, categories, members, borrowing activity, returns, and fines.

This project demonstrates how SQL can be used to build and analyze a realistic library management system.

## Project Objectives

The project focuses on:

- Designing a relational library database
- Managing books and authors
- Managing library members
- Tracking book borrowing and returns
- Recording overdue books
- Managing fines
- Analyzing borrowing patterns
- Identifying popular books and authors
- Analyzing member activity
- Using SQL for operational and business-style reporting

## Database

**SQL Dialect:** MySQL 8.0+

## Main Entities

The database contains the following entities:

- Authors
- Categories
- Publishers
- Books
- Book Authors
- Members
- Loans
- Fines

## Database Relationships

```text
Authors
    │
    └── Book Authors ─── Books ─── Categories
                              │
                              └── Publishers

Members
    │
    └── Loans ─── Books
          │
          └── Fines
````

The `book_authors` table handles the many-to-many relationship between books and authors because one book can have multiple authors and one author can write multiple books.

## Main Questions Answered

The project will answer questions such as:

1. How many books are available?
2. How many books are currently borrowed?
3. Which books are most frequently borrowed?
4. Which authors are most popular?
5. Which categories have the highest borrowing activity?
6. Which members borrow the most books?
7. Which books are currently overdue?
8. Which members have overdue books?
9. How much has each member paid in fines?
10. What is the total outstanding fine amount?
11. Which books have never been borrowed?
12. What is the average borrowing duration?
13. What are the monthly borrowing trends?
14. Which category has the highest number of books?
15. Which members are the most active library users?

## Project Files

### `README.md`

Documents the project, database design, objectives, and SQL concepts.

### `schema.sql`

Creates the database tables, keys, constraints, and relationships.

### `data.sql`

Inserts realistic sample library data.

### `queries.sql`

Contains basic and intermediate SQL queries for exploring the library database.

### `analysis.sql`

Contains advanced library analysis using:

* JOINs
* GROUP BY
* HAVING
* CASE
* Subqueries
* CTEs
* Window functions
* Date functions
* Conditional aggregation

### `challenge.sql`

Contains advanced problems designed to simulate real-world SQL tasks.

## Important Business Rules

The project uses the following rules:

* A book can have multiple authors.
* An author can write multiple books.
* A member can borrow multiple books.
* A book can be borrowed many times over its lifetime.
* A loan has an issue date and a due date.
* A returned loan has a return date.
* An unreturned loan has a `NULL` return date.
* A fine can be associated with a loan.
* Overdue status is determined using the due date and return date.
* A book currently associated with an unreturned loan is considered unavailable.

## SQL Concepts Demonstrated

* CREATE DATABASE
* CREATE TABLE
* PRIMARY KEY
* FOREIGN KEY
* UNIQUE
* NOT NULL
* CHECK
* INSERT
* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* INNER JOIN
* LEFT JOIN
* Many-to-many relationships
* Aggregate functions
* CASE expressions
* Date functions
* Subqueries
* CTEs
* Window functions
* Ranking
* Conditional aggregation

## How to Run

Execute the files in this order:

```text
1. schema.sql
2. data.sql
3. queries.sql
4. analysis.sql
5. challenge.sql
```

Use MySQL Workbench, MySQL Shell, or another MySQL 8.0+ compatible client.

## Portfolio Skills

This project demonstrates practical SQL skills useful for:

* Database development
* Data analysis
* Business intelligence
* Reporting
* Backend development
* Library and inventory systems
* SQL interviews
