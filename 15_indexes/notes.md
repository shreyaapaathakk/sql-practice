# Module 15 — Indexes

This module introduces database indexes and query performance without jumping too quickly into advanced optimization. It builds directly on the constraints and table-design concepts from Module 14.

## Repository structure

```text
sql-practice/
└── 15_indexes/
    ├── notes.md
    ├── examples.sql
    ├── practice.sql
    ├── solutions.sql
    └── challenge.sql
```

---

## `15_indexes/notes.md`

````markdown
# Module 15 — Indexes

## Overview

Indexes are database structures that help MySQL find rows more efficiently.

Without an appropriate index, MySQL may need to examine many rows to find the data requested by a query.

An index can make searches, filtering, sorting, and joins significantly faster when used appropriately.

However, indexes are not free. They require storage and can make INSERT, UPDATE, and DELETE operations more expensive because the index must also be maintained.

This module uses MySQL 8.0+ syntax.

---

# 1. What Is an Index?

An index is a data structure associated with one or more table columns.

For example:

```sql
CREATE INDEX idx_students_city
ON students(city);
````

This creates an index on the `city` column.

A query such as:

```sql
SELECT *
FROM students
WHERE city = 'Delhi';
```

may benefit from this index.

---

# 2. Why Do We Need Indexes?

Suppose a table contains millions of rows.

Without a useful index, MySQL may need to examine a large number of rows to find matching records.

An index can help MySQL locate relevant rows more efficiently.

Conceptually:

```text
Without index:

Table
 ↓
Check many rows
 ↓
Find matching rows


With index:

Index
 ↓
Locate matching values
 ↓
Access required rows
```

The exact execution strategy is determined by MySQL's optimizer.

---

# 3. Indexes and Performance

Indexes are primarily used to improve read performance.

They can help queries involving:

* WHERE
* JOIN
* ORDER BY
* GROUP BY
* UNIQUE checks
* range conditions

However, adding an index does not guarantee that every query will become faster.

MySQL decides whether an index is useful.

---

# 4. Creating an Index

Basic syntax:

```sql
CREATE INDEX index_name
ON table_name(column_name);
```

Example:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

---

# 5. Index Naming

Use meaningful names.

For example:

```text
idx_students_city
idx_students_last_name
idx_orders_customer_id
idx_products_price
```

A common naming convention is:

```text
idx_table_column
```

Meaning:

```text
idx = index
table = table name
column = indexed column
```

---

# 6. Single-Column Index

An index can contain one column.

Example:

```sql
CREATE INDEX idx_students_last_name
ON students(last_name);
```

This can help queries such as:

```sql
SELECT *
FROM students
WHERE last_name = 'Sharma';
```

---

# 7. Multiple Indexes

A table can have multiple indexes.

Example:

```sql
CREATE INDEX idx_students_city
ON students(city);

CREATE INDEX idx_students_last_name
ON students(last_name);
```

This allows MySQL to consider different indexes for different queries.

Do not automatically create an index for every column.

---

# 8. UNIQUE Index

A UNIQUE constraint creates a unique index to enforce uniqueness.

For example:

```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```

The UNIQUE constraint prevents duplicate email values.

You can also explicitly create a unique index:

```sql
CREATE UNIQUE INDEX idx_users_email
ON users(email);
```

A unique index prevents duplicate non-NULL values.

---

# 9. PRIMARY KEY and Indexes

A PRIMARY KEY is indexed automatically in MySQL.

For example:

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50)
);
```

MySQL automatically creates the primary-key index.

Therefore, you normally do not need:

```sql
CREATE INDEX idx_students_id
ON students(student_id);
```

because the primary key is already indexed.

---

# 10. UNIQUE Constraints and Indexes

A UNIQUE constraint is also backed by an index.

Example:

```sql
email VARCHAR(100) UNIQUE
```

provides uniqueness enforcement and an index.

This is one reason constraints and indexes are closely related.

---

# 11. SHOW INDEX

Use:

```sql
SHOW INDEX FROM students;
```

This displays information about indexes on the table.

Useful information includes:

* index name
* indexed columns
* uniqueness
* column order
* cardinality

---

# 12. Understanding SHOW INDEX

Important columns include:

```text
Key_name
Column_name
Non_unique
Seq_in_index
Cardinality
```

`Key_name` is the name of the index.

`Column_name` identifies the indexed column.

`Non_unique` indicates whether duplicate values are allowed.

`Seq_in_index` shows the position of a column inside a multi-column index.

---

# 13. Dropping an Index

Use:

```sql
DROP INDEX index_name
ON table_name;
```

Example:

```sql
DROP INDEX idx_students_city
ON students;
```

Be careful when dropping indexes because queries may become slower afterward.

---

# 14. ALTER TABLE and Indexes

You can also create an index using `ALTER TABLE`.

```sql
ALTER TABLE students
ADD INDEX idx_students_city (city);
```

This is equivalent in purpose to:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

---

# 15. Composite Index

A composite index contains multiple columns.

Example:

```sql
CREATE INDEX idx_students_city_age
ON students(city, age);
```

The index is ordered according to:

```text
city
age
```

This ordering matters.

---

# 16. Column Order in Composite Indexes

Consider:

```sql
CREATE INDEX idx_students_city_age
ON students(city, age);
```

This can be particularly useful for queries filtering by:

```sql
WHERE city = 'Delhi'
```

and:

```sql
WHERE city = 'Delhi'
  AND age = 20
```

The first column is especially important.

---

# 17. The Leftmost Principle

For an index:

```sql
(city, age)
```

MySQL can generally make effective use of the index when a query uses the leading column:

```text
city
```

or the combination:

```text
city + age
```

But a query using only:

```text
age
```

does not generally get the same benefit from this composite index.

Therefore:

```text
(city, age)
```

is different from:

```text
(age, city)
```

---

# 18. Choosing Composite Index Order

Suppose queries frequently use:

```sql
WHERE department_id = ?
AND status = ?
```

A possible index is:

```sql
CREATE INDEX idx_students_department_status
ON students(department_id, status);
```

The best column order depends on the actual workload and query patterns.

Do not choose index order only based on which column looks more important.

---

# 19. Indexes and WHERE

Indexes are commonly useful for filtering.

Example:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

Query:

```sql
SELECT *
FROM students
WHERE city = 'Mumbai';
```

MySQL may use the index to locate matching rows.

---

# 20. Indexes and Range Conditions

Indexes can also help range searches.

Example:

```sql
CREATE INDEX idx_students_age
ON students(age);
```

Query:

```sql
SELECT *
FROM students
WHERE age BETWEEN 18 AND 21;
```

An index may help MySQL locate the relevant range.

---

# 21. Indexes and ORDER BY

Indexes can sometimes help with sorting.

Example:

```sql
CREATE INDEX idx_students_age
ON students(age);
```

Query:

```sql
SELECT *
FROM students
ORDER BY age;
```

Depending on the query and execution plan, MySQL may use the index to avoid or reduce sorting work.

---

# 22. Indexes and LIMIT

Indexes can be especially useful when combined with ordering and LIMIT.

Example:

```sql
CREATE INDEX idx_students_age
ON students(age);
```

Query:

```sql
SELECT *
FROM students
ORDER BY age
LIMIT 5;
```

An appropriate index may allow MySQL to find the first required rows efficiently.

---

# 23. Indexes and JOIN

Foreign-key columns are common candidates for indexes.

Example:

```sql
CREATE INDEX idx_students_department
ON students(department_id);
```

Then a join such as:

```sql
SELECT
    s.first_name,
    d.department_name
FROM students AS s
JOIN departments AS d
    ON s.department_id = d.department_id;
```

may benefit from the index.

---

# 24. Foreign Keys and Indexes

In MySQL, indexes are important for foreign-key relationships.

For example:

```sql
department_id INT
```

may be indexed when it is used as a foreign key.

MySQL requires suitable indexes for foreign-key enforcement, and InnoDB can automatically create a required index when necessary.

Even so, understanding the indexing of foreign-key columns is important for query performance.

---

# 25. EXPLAIN

`EXPLAIN` helps you understand how MySQL plans to execute a query.

Example:

```sql
EXPLAIN
SELECT *
FROM students
WHERE city = 'Delhi';
```

This can show information about:

* possible indexes
* chosen index
* estimated rows
* access type
* execution strategy

---

# 26. EXPLAIN Is a Learning Tool

When learning indexes, compare:

```sql
EXPLAIN
SELECT *
FROM students
WHERE city = 'Delhi';
```

before and after creating:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

With a very small table, MySQL may still choose not to use the index.

That is normal.

Indexes become much more useful when tables contain significant amounts of data and the index is selective enough.

---

# 27. EXPLAIN ANALYZE

MySQL 8.0 also provides:

```sql
EXPLAIN ANALYZE
```

Example:

```sql
EXPLAIN ANALYZE
SELECT *
FROM students
WHERE city = 'Delhi';
```

Unlike ordinary EXPLAIN, it executes the statement and provides actual execution information.

Use it carefully, especially with statements that modify data.

---

# 28. Selectivity

Selectivity describes how effectively an index distinguishes rows.

Suppose a table has:

```text
1,000,000 rows
```

and a column contains only:

```text
Active
Inactive
```

An index on that column may not always be highly selective.

But an email column where almost every value is different can be highly selective.

High-selectivity columns are often useful index candidates.

---

# 29. Cardinality

Cardinality describes the approximate number of distinct values represented by an index.

You can see cardinality through:

```sql
SHOW INDEX FROM students;
```

Higher cardinality generally means more distinct values.

However, cardinality alone does not determine whether an index is useful.

---

# 30. Low-Cardinality Columns

Columns with very few possible values may be poor standalone index candidates.

For example:

```text
gender
status
is_active
```

may have relatively few distinct values.

That does not mean these columns should never be indexed.

Their usefulness depends on:

* table size
* data distribution
* query patterns
* combinations with other columns

---

# 31. Over-Indexing

Creating too many indexes can cause problems.

Every index:

* consumes storage
* requires maintenance
* can slow INSERT
* can slow UPDATE
* can slow DELETE

For example, creating separate indexes on every column is usually not a good design.

Indexes should support real query patterns.

---

# 32. Indexes and INSERT

When a row is inserted, MySQL may need to update multiple indexes.

For example:

```text
Table
+ Index 1
+ Index 2
+ Index 3
+ Index 4
```

The more indexes that need maintenance, the more work an INSERT can require.

---

# 33. Indexes and UPDATE

If an indexed column changes, MySQL may need to update the corresponding index structure.

For example:

```sql
UPDATE students
SET city = 'Pune'
WHERE student_id = 1;
```

If `city` is indexed, the index must reflect the change.

---

# 34. Indexes and DELETE

Deleting rows can also require index maintenance.

Therefore, indexes are a trade-off:

```text
More indexes
    ↓
Potentially faster reads
    ↓
More storage and write overhead
```

---

# 35. Functions and Indexes

Be careful when applying functions to indexed columns.

For example:

```sql
SELECT *
FROM students
WHERE UPPER(city) = 'DELHI';
```

Depending on the situation, applying a function to the indexed column can make it harder for MySQL to use a normal index efficiently.

A query such as:

```sql
WHERE city = 'Delhi'
```

is generally more straightforward for a normal index.

---

# 36. Leading Wildcards

A query such as:

```sql
WHERE last_name LIKE 'Sha%'
```

may be able to use an index on `last_name`.

But:

```sql
WHERE last_name LIKE '%harma'
```

starts with a wildcard.

A normal B-tree index generally cannot efficiently use the leading `%` to search from the beginning of the indexed value.

This is an important practical distinction.

---

# 37. Prefix Searches

Suppose:

```sql
CREATE INDEX idx_students_last_name
ON students(last_name);
```

A query such as:

```sql
SELECT *
FROM students
WHERE last_name LIKE 'Sh%';
```

can potentially benefit from the index.

This is different from:

```sql
WHERE last_name LIKE '%ha%';
```

---

# 38. Indexing a Column Used in Sorting

Suppose the application frequently executes:

```sql
SELECT *
FROM students
ORDER BY last_name;
```

An index on:

```sql
last_name
```

may help.

However, the optimizer decides whether using the index is actually cheaper.

---

# 39. Indexing for Common Queries

A practical approach is:

1. Identify important queries.
2. Examine their WHERE conditions.
3. Examine JOIN conditions.
4. Examine ORDER BY and GROUP BY.
5. Use EXPLAIN.
6. Add indexes where appropriate.
7. Test again.

Do not design indexes in isolation from actual queries.

---

# 40. Duplicate and Redundant Indexes

Avoid unnecessary duplicate indexes.

For example:

```sql
CREATE INDEX idx_city
ON students(city);

CREATE INDEX idx_city_again
ON students(city);
```

These indexes provide essentially the same indexing purpose and waste resources.

---

# 41. Composite Index vs Multiple Single Indexes

Consider:

```sql
CREATE INDEX idx_city_age
ON students(city, age);
```

This is not always equivalent to:

```sql
CREATE INDEX idx_city
ON students(city);

CREATE INDEX idx_age
ON students(age);
```

They support different query patterns.

A composite index specifically represents the ordered combination of columns.

---

# 42. Covering Indexes

An index may sometimes contain all the columns needed by a query.

For example:

```sql
CREATE INDEX idx_students_city_name
ON students(city, first_name);
```

A query such as:

```sql
SELECT first_name
FROM students
WHERE city = 'Delhi';
```

may be able to retrieve the required information directly from the index.

This is commonly called a covering index.

Do not create covering indexes unnecessarily.

---

# 43. Indexes and NULL

Indexes can contain NULL values.

For example:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

Rows where `city` is NULL can still be represented in the index.

Queries involving NULL should use:

```sql
WHERE city IS NULL
```

rather than:

```sql
WHERE city = NULL
```

---

# 44. Indexes Do Not Fix Every Slow Query

A slow query may be caused by:

* inefficient SQL
* missing indexes
* inappropriate indexes
* too many rows
* expensive joins
* poor schema design
* functions on columns
* large result sets
* sorting or grouping
* outdated statistics

Indexes are one performance tool, not a universal solution.

---

# 45. Indexing Strategy

A practical indexing strategy is:

```text
Start with correct SQL
        ↓
Identify important queries
        ↓
Use EXPLAIN
        ↓
Identify bottlenecks
        ↓
Add appropriate indexes
        ↓
Test again
```

This is better than blindly adding indexes.

---

# 46. Common Index Candidates

Common candidates include:

* primary keys
* unique identifiers
* foreign keys
* frequently searched columns
* columns used in common JOIN conditions
* columns used for common sorting
* combinations frequently used together in filtering

---

# 47. Columns That May Not Need Indexes

Do not automatically index:

* every column
* rarely searched columns
* tiny tables
* columns with very low selectivity
* columns that are never used in important queries

The correct choice depends on workload.

---

# 48. Index and Constraint Relationship

Some constraints automatically involve indexes.

For example:

```sql
PRIMARY KEY
```

and:

```sql
UNIQUE
```

are backed by indexes.

Therefore, adding another identical index may be unnecessary.

---

# 49. Clustered Index Concept

In InnoDB, the primary key is used as the clustered index.

The table's row data is organized around the primary-key index.

This makes primary-key design especially important in InnoDB tables.

Secondary indexes contain their indexed values along with the primary-key value used to locate the corresponding row.

This is an important concept for understanding InnoDB performance.

---

# 50. Secondary Index

An index other than the primary key is generally a secondary index.

Example:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

Here:

```text
PRIMARY KEY → clustered index
city index  → secondary index
```

The exact physical implementation is handled by InnoDB.

---

# 51. Prefix Indexes

MySQL allows indexing a prefix of some string columns.

Example:

```sql
CREATE INDEX idx_email_prefix
ON users(email(20));
```

This indexes only the first 20 characters.

Prefix indexes can reduce index size for very long string columns.

However, they may provide less selectivity than indexing the full value.

---

# 52. Descending Indexes

MySQL 8.0 supports descending index definitions.

Example:

```sql
CREATE INDEX idx_students_age_desc
ON students(age DESC);
```

Descending indexes can be useful for workloads involving descending sort order.

However, always test whether the index provides a meaningful benefit.

---

# 53. Multiple Columns With Different Directions

MySQL also supports:

```sql
CREATE INDEX idx_students_city_age
ON students(city ASC, age DESC);
```

This can support certain ordering patterns.

Again, query patterns should drive the index design.

---

# 54. Removing an Index

Use:

```sql
DROP INDEX idx_students_city
ON students;
```

Before removing an index from a production database, verify that important queries do not depend on it for acceptable performance.

---

# 55. Practical Workflow

When optimizing a query:

```sql
EXPLAIN
SELECT *
FROM students
WHERE city = 'Delhi';
```

Then consider whether:

```sql
CREATE INDEX idx_students_city
ON students(city);
```

would help.

Run EXPLAIN again and compare the execution plan.

---

# 56. Key Takeaways

By the end of this module, you should understand:

* what indexes are
* why indexes improve query performance
* how to create indexes
* how to drop indexes
* how to inspect indexes
* primary-key indexes
* unique indexes
* single-column indexes
* composite indexes
* column order in composite indexes
* the leftmost principle
* indexes and WHERE
* indexes and ORDER BY
* indexes and JOIN
* indexes and LIMIT
* EXPLAIN
* EXPLAIN ANALYZE
* selectivity
* cardinality
* over-indexing
* write overhead
* covering indexes
* secondary indexes
* InnoDB clustered indexes
* prefix indexes
* descending indexes
* practical index-design strategy
