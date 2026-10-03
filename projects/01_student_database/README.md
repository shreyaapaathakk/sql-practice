# Student Database Management System

A practical MySQL project for managing students, departments, courses, instructors, enrollments, exams, and academic results.

This project is designed to demonstrate how SQL can be used to build and analyze a realistic academic database.

## Project Objectives

The project focuses on:

- Designing a relational database
- Creating related tables
- Applying primary and foreign keys
- Maintaining referential integrity
- Inserting realistic sample data
- Writing multi-table JOIN queries
- Using aggregate functions
- Analyzing student performance
- Using subqueries and CTEs
- Using window functions for rankings
- Working with dates
- Identifying academic trends and patterns

## Database

**SQL Dialect:** MySQL 8.0+

## Entities

The database contains the following main entities:

- Departments
- Students
- Instructors
- Courses
- Enrollments
- Exams
- Results

## Relationships

```text
Departments
    │
    ├── Students
    │
    ├── Instructors
    │
    └── Courses
             │
             └── Enrollments
                      │
                      └── Students

Courses
    │
    └── Exams
             │
             └── Results
                      │
                      └── Students
````

## Main Questions Answered

The project will answer questions such as:

1. How many students are enrolled in each department?
2. What courses are available?
3. Which students are enrolled in each course?
4. What is each student's average score?
5. Who are the top-performing students?
6. Which courses have the highest average scores?
7. Which students have failed courses?
8. Which departments have the strongest academic performance?
9. Which students are enrolled in the most courses?
10. How many students are taught by each instructor?
11. What is the pass rate for each course?
12. How do students rank within their department?
13. Which students are at academic risk?
14. What is the average score for each department?
15. Which courses have unusually low performance?

## Project Files

### `schema.sql`

Creates the database tables and relationships.

### `data.sql`

Inserts realistic sample data.

### `queries.sql`

Contains fundamental SQL queries for exploring the database.

### `analysis.sql`

Contains more advanced academic analysis using:

* JOINs
* GROUP BY
* HAVING
* Subqueries
* CTEs
* Window functions
* CASE expressions
* Date functions

### `challenge.sql`

Contains additional business-style SQL problems to solve independently.

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
* Aggregate functions
* CASE
* Subqueries
* Common Table Expressions
* Window functions
* Ranking
* Date functions
* Conditional aggregation

## How to Run

Run the files in this order:

```text
1. schema.sql
2. data.sql
3. queries.sql
4. analysis.sql
5. challenge.sql
```

Open MySQL Workbench, MySQL Shell, or another MySQL-compatible client and execute the SQL files.

## Portfolio Skills

This project demonstrates practical SQL skills that are useful for:

* Data analysis
* Database development
* Business intelligence
* Reporting
* Backend development
* SQL interviews

---
