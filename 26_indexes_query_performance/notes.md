# Module 26: Indexes & Query Performance

Indexes are one of the most important tools for improving database query performance. They allow the database to find rows more efficiently instead of scanning every row in a table.

However, indexes are not automatically beneficial for every query. They consume storage, increase the cost of `INSERT`, `UPDATE`, and `DELETE` operations, and can sometimes be ignored by the query optimizer.

This module focuses on understanding indexes, creating and managing them, analyzing query execution plans, and writing queries that perform efficiently.

---

## 1. What Is an Index?

An index is a database structure that helps MySQL locate rows more efficiently.

Without an appropriate index, MySQL may need to examine many rows to find matching records.

For example:

```sql
SELECT *
FROM employees
WHERE email = 'amit@example.com';
```

If `email` is not indexed, MySQL may need to scan the table.

With an index:

```sql
CREATE INDEX idx_employees_email
ON employees(email);
```

MySQL can often locate matching rows much more efficiently.

---

## 2. Why Indexes Are Important

Consider a table containing one million customers.

A query such as:

```sql
SELECT *
FROM customers
WHERE email = 'user@example.com';
```

may require MySQL to examine many rows if there is no suitable index.

An index on `email` can significantly reduce the amount of data MySQL needs to examine.

Indexes are especially useful for columns frequently used in:

* `WHERE`
* `JOIN`
* `ORDER BY`
* `GROUP BY`
* Unique lookups

---

## 3. How an Index Works

Conceptually, an index works like the index of a book.

Instead of reading every page to find a topic, you can use the book's index to locate the relevant page.

Database indexes similarly maintain searchable structures that help locate table rows.

A simplified idea is:

```text
Query
  |
  v
Index
  |
  v
Matching rows
```

Without a suitable index:

```text
Query
  |
  v
Scan many table rows
  |
  v
Find matches
```

---

## 4. B-Tree Indexes

A common type of index used by MySQL's InnoDB engine is the B-tree-based index.

B-tree indexes are useful for many types of searches, including:

```sql
=
>
<
>=
<=
BETWEEN
ORDER BY
```

For example:

```sql
CREATE INDEX idx_products_price
ON products(price);
```

This can help queries such as:

```sql
SELECT *
FROM products
WHERE price > 5000;
```

---

## 5. Primary Key Index

A primary key automatically has an index.

Example:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);
```

The primary key provides an index on:

```text
customer_id
```

Therefore, you normally do not need to separately create another index on the primary key.

---

## 6. Unique Index

A unique index prevents duplicate values while also providing an index.

Example:

```sql
CREATE UNIQUE INDEX idx_customers_email
ON customers(email);
```

Now duplicate email addresses are not allowed.

A unique constraint can also be defined directly:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE
);
```

---

## 7. Creating an Index

The basic syntax is:

```sql
CREATE INDEX index_name
ON table_name(column_name);
```

Example:

```sql
CREATE INDEX idx_customers_name
ON customers(name);
```

---

## 8. Dropping an Index

An index can be removed using:

```sql
DROP INDEX index_name
ON table_name;
```

Example:

```sql
DROP INDEX idx_customers_name
ON customers;
```

The primary key requires different syntax because it is part of the table definition:

```sql
ALTER TABLE customers
DROP PRIMARY KEY;
```

Do not use this casually because removing a primary key can have significant consequences.

---

## 9. Viewing Indexes

Use:

```sql
SHOW INDEX FROM customers;
```

This displays information about indexes defined on the table.

You can also inspect the table definition:

```sql
SHOW CREATE TABLE customers;
```

---

## 10. Index Names

Use descriptive index names.

For example:

```text
idx_customers_email
idx_orders_customer_id
idx_products_price
idx_employees_department_id
```

A common naming pattern is:

```text
idx_<table>_<column>
```

For composite indexes, include the relevant columns:

```text
idx_orders_customer_status
```

---

## 11. Single-Column Index

A single-column index contains one column.

Example:

```sql
CREATE INDEX idx_orders_status
ON orders(status);
```

It may help:

```sql
SELECT *
FROM orders
WHERE status = 'Pending';
```

However, whether the optimizer actually uses it depends on the data distribution and query.

---

## 12. Composite Index

A composite index contains multiple columns.

Example:

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);
```

This index can be useful for queries involving:

```sql
WHERE customer_id = 10
```

and:

```sql
WHERE customer_id = 10
AND status = 'Pending'
```

The order of columns matters.

---

## 13. Column Order in Composite Indexes

Consider:

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);
```

The index is organized primarily by:

```text
customer_id
```

and then by:

```text
status
```

Therefore, it is generally more useful for:

```sql
WHERE customer_id = 10
```

than for:

```sql
WHERE status = 'Pending'
```

This is related to the **leftmost-prefix principle**.

---

## 14. Leftmost-Prefix Principle

For:

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);
```

The index can generally support searches involving:

```text
customer_id
```

or:

```text
customer_id + status
```

But a query using only:

```text
status
```

does not generally get the same benefit from this composite index.

This is one of the most important concepts when designing composite indexes.

---

## 15. Choosing Column Order

Suppose you frequently run:

```sql
SELECT *
FROM orders
WHERE customer_id = 10
AND status = 'Pending';
```

An index such as:

```sql
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, status);
```

may be appropriate.

If your common query pattern is instead based around:

```sql
WHERE status = 'Pending'
AND customer_id = 10
```

the SQL condition order itself does not determine index column order. The index should be designed around the workload and access patterns.

---

## 16. Index Selectivity

Selectivity describes how effectively a column distinguishes rows.

A column with many distinct values often has higher selectivity.

For example:

```text
email
customer_id
order_id
```

typically have high uniqueness.

A column such as:

```text
gender
status
boolean_flag
```

may have relatively low selectivity.

Low-selectivity columns are not automatically useless as indexes, but their usefulness depends heavily on the data and query workload.

---

## 17. High-Selectivity Example

Suppose a table contains:

```text
1,000,000 customers
```

and almost every customer has a different email.

An index on:

```sql
email
```

can be highly effective for:

```sql
WHERE email = 'user@example.com'
```

because the condition identifies very few rows.

---

## 18. Low-Selectivity Example

Suppose a table contains one million orders and:

```text
900,000 orders = 'Completed'
100,000 orders = other statuses
```

An index only on:

```sql
status
```

may not provide a dramatic improvement for:

```sql
WHERE status = 'Completed'
```

because a large portion of the table still matches.

The optimizer may decide that scanning the table is cheaper.

---

## 19. The Query Optimizer

MySQL includes a query optimizer that determines how a query should be executed.

It considers factors such as:

* Available indexes
* Estimated number of matching rows
* Join strategies
* Sorting requirements
* Filtering conditions
* Table statistics
* Cost of different execution plans

You should therefore not assume that creating an index guarantees its use.

---

# 20. EXPLAIN

`EXPLAIN` is one of the most important tools for analyzing query performance.

Example:

```sql
EXPLAIN
SELECT *
FROM customers
WHERE email = 'amit@example.com';
```

It shows information about how MySQL intends to execute the query.

---

## 21. Important EXPLAIN Columns

Common `EXPLAIN` columns include:

| Column          | Meaning                                    |
| --------------- | ------------------------------------------ |
| `id`            | Query block identifier                     |
| `select_type`   | Type of query block                        |
| `table`         | Table being accessed                       |
| `type`          | Access method                              |
| `possible_keys` | Indexes MySQL may consider                 |
| `key`           | Index MySQL plans to use                   |
| `key_len`       | Length of the index portion used           |
| `ref`           | Columns/constants compared with the index  |
| `rows`          | Estimated rows examined                    |
| `filtered`      | Estimated percentage passing the condition |
| `Extra`         | Additional execution information           |

---

## 22. EXPLAIN Access Types

The `type` column is particularly useful.

Examples include:

```text
const
eq_ref
ref
range
index
ALL
```

Generally, highly selective access methods are preferable to scanning the entire table, although the best choice depends on the query.

---

## 23. Full Table Scan

A full table scan is commonly represented by:

```text
ALL
```

Example:

```sql
EXPLAIN
SELECT *
FROM customers
WHERE name = 'Amit';
```

If there is no useful index on `name`, MySQL may examine the entire table.

This can become expensive for large tables.

---

## 24. Index Lookup

Suppose we create:

```sql
CREATE INDEX idx_customers_email
ON customers(email);
```

Then:

```sql
EXPLAIN
SELECT *
FROM customers
WHERE email = 'amit@example.com';
```

may show:

```text
key = idx_customers_email
```

indicating that the optimizer selected the index.

---

## 25. possible_keys vs key

These two columns are easy to confuse.

`possible_keys` represents indexes that MySQL considers potentially useful.

`key` represents the index MySQL actually chooses.

For example:

```text
possible_keys: idx_email, idx_name
key: idx_email
```

This means MySQL considered both indexes but selected `idx_email`.

---

## 26. EXPLAIN ANALYZE

MySQL also supports:

```sql
EXPLAIN ANALYZE
```

Example:

```sql
EXPLAIN ANALYZE
SELECT *
FROM customers
WHERE email = 'amit@example.com';
```

Unlike ordinary `EXPLAIN`, `EXPLAIN ANALYZE` executes the query and provides actual execution information alongside estimates.

This makes it useful when investigating differences between estimated and actual performance.

---

## 27. EXPLAIN Is Not Just About Indexes

Use `EXPLAIN` to investigate:

* Full table scans
* Join strategies
* Index usage
* Estimated rows
* Sorting
* Temporary tables
* Filtering
* Query execution plans

Do not focus only on the `key` column.

The entire execution plan matters.

---

## 28. Indexes and WHERE

Indexes are commonly used to improve filtering.

Example:

```sql
CREATE INDEX idx_employees_department
ON employees(department_id);
```

Query:

```sql
SELECT *
FROM employees
WHERE department_id = 5;
```

---

## 29. Indexes and JOIN

Indexes can be very important for joins.

Example:

```sql
SELECT o.order_id, c.name
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;
```

An index on:

```sql
orders(customer_id)
```

may improve access to matching orders.

Primary and foreign-key-related access patterns should be considered when designing indexes.

---

## 30. Indexes and ORDER BY

Indexes can sometimes help avoid expensive sorting.

Example:

```sql
CREATE INDEX idx_products_price
ON products(price);
```

Query:

```sql
SELECT *
FROM products
ORDER BY price;
```

Depending on the execution plan and query structure, MySQL may be able to use the index to retrieve rows in the required order.

---

## 31. Indexes and GROUP BY

Indexes may also help some grouping operations.

Example:

```sql
CREATE INDEX idx_orders_customer
ON orders(customer_id);
```

Query:

```sql
SELECT customer_id, COUNT(*)
FROM orders
GROUP BY customer_id;
```

Whether the index improves the query depends on the table, query, statistics, and execution plan.

Always verify with `EXPLAIN`.

---

## 32. Covering Index

A covering index contains all columns required by a query.

Suppose:

```sql
CREATE INDEX idx_customers_email_name
ON customers(email, name);
```

A query such as:

```sql
SELECT email, name
FROM customers
WHERE email = 'amit@example.com';
```

may be satisfied using only the index.

This can reduce the need to access the underlying table.

---

## 33. Index-Only Access

When the required data can be obtained directly from an index, fewer table accesses may be necessary.

This can improve performance for suitable queries.

However, whether MySQL uses an index-only strategy depends on the actual execution plan.

---

## 34. Functions on Indexed Columns

Applying a function to an indexed column can prevent efficient use of a normal index.

For example:

```sql
SELECT *
FROM customers
WHERE LOWER(email) = 'amit@example.com';
```

Even if `email` is indexed, the expression may prevent the optimizer from using the index in the most effective way.

Whenever possible, write predicates that allow the indexed column to be used directly.

---

## 35. Avoid Unnecessary Functions

Instead of transforming the indexed column:

```sql
WHERE YEAR(order_date) = 2026
```

a range predicate can often be more index-friendly:

```sql
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01'
```

The exact approach depends on the required semantics.

---

## 36. Leading Wildcards

A query such as:

```sql
WHERE name LIKE '%amit'
```

can be difficult for a normal B-tree index to optimize because the pattern begins with a wildcard.

A prefix search:

```sql
WHERE name LIKE 'amit%'
```

is generally more compatible with normal B-tree index usage.

---

## 37. Over-Indexing

Having too many indexes is not always beneficial.

Every index consumes:

* Disk space
* Memory/cache resources
* Maintenance work

Indexes also need to be updated when rows are inserted, updated, or deleted.

Therefore, unnecessary indexes can slow down write-heavy workloads.

---

## 38. Indexes and INSERT

When inserting a row, MySQL may need to update multiple indexes.

For example, a table with five indexes can require more index maintenance than a table with one index.

This means indexes represent a trade-off:

```text
Faster reads
      ↕
More write overhead
```

---

## 39. Indexes and UPDATE

If an indexed column changes:

```sql
UPDATE customers
SET email = 'new@example.com'
WHERE customer_id = 1;
```

MySQL may need to update the relevant index structure.

Updates to non-indexed columns generally do not require updating that particular index.

---

## 40. Indexes and DELETE

Deleting rows also requires maintaining indexes.

```sql
DELETE FROM customers
WHERE customer_id = 1;
```

Relevant index entries must be removed.

---

## 41. Composite Index Strategy

When designing a composite index, consider the query patterns.

For example:

```sql
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);
```

This can be useful for queries such as:

```sql
WHERE customer_id = 10
```

and:

```sql
WHERE customer_id = 10
AND order_date >= '2026-01-01'
```

The order should be chosen based on actual access patterns, not arbitrary preference.

---

## 42. Avoid Duplicate Indexes

Do not create redundant indexes without a reason.

For example:

```sql
INDEX(customer_id)
INDEX(customer_id, status)
```

The second index already begins with `customer_id`, so the first index may be redundant depending on the workload.

However, redundancy must be evaluated against actual queries and performance requirements before removing anything.

---

## 43. Index Cardinality

Cardinality represents the estimated number of distinct values in an index.

You can inspect index information with:

```sql
SHOW INDEX FROM customers;
```

The `Cardinality` column provides useful statistics.

Higher cardinality often means an index can distinguish rows more effectively.

---

## 44. Index Statistics

MySQL maintains statistics that help the optimizer estimate query costs.

These statistics can influence which execution plan MySQL chooses.

Because estimates are involved, actual performance should be verified rather than assumed.

---

## 45. ANALYZE TABLE

You can update table and index statistics using:

```sql
ANALYZE TABLE customers;
```

This can be useful when optimizer statistics need to be refreshed.

---

## 46. Query Performance Is More Than Indexes

Indexes are important, but they are only one part of performance optimization.

Other factors include:

* Query design
* Data volume
* Joins
* Sorting
* Aggregation
* Network transfer
* Hardware
* Memory
* Storage
* Database configuration
* Table design

Do not add indexes blindly.

---

## 47. Avoid SELECT *

For large or frequently executed queries, explicitly selecting required columns can reduce unnecessary data transfer.

Instead of:

```sql
SELECT *
FROM customers
WHERE customer_id = 10;
```

consider:

```sql
SELECT customer_id, name, email
FROM customers
WHERE customer_id = 10;
```

This can also make covering-index opportunities easier to identify.

---

## 48. Filter Early

When possible, reduce the number of rows processed by a query.

For example:

```sql
SELECT *
FROM orders
WHERE customer_id = 10
  AND status = 'Completed';
```

An appropriate index can make this filtering more efficient.

---

## 49. Index Design Should Follow Workload

There is no universal rule such as:

> "Index every column used in WHERE."

Instead, examine:

* Frequently executed queries
* Query frequency
* Table size
* Selectivity
* Read/write ratio
* Join patterns
* Sorting requirements
* Grouping requirements
* Actual execution plans

Index design should be based on real workload characteristics.

---

## 50. A Basic Optimization Workflow

A practical performance investigation can follow this process:

```text
1. Identify a slow query
        ↓
2. Run EXPLAIN
        ↓
3. Examine execution plan
        ↓
4. Identify expensive operations
        ↓
5. Consider query/index changes
        ↓
6. Test the modified query
        ↓
7. Use EXPLAIN again
        ↓
8. Compare actual performance
```

---

## 51. Example Optimization Workflow

Start with:

```sql
SELECT *
FROM customers
WHERE email = 'amit@example.com';
```

Check:

```sql
EXPLAIN
SELECT *
FROM customers
WHERE email = 'amit@example.com';
```

If there is no suitable index and the table is large:

```sql
CREATE INDEX idx_customers_email
ON customers(email);
```

Then check again:

```sql
EXPLAIN
SELECT *
FROM customers
WHERE email = 'amit@example.com';
```

The goal is not simply to create an index. The goal is to verify whether the execution plan and actual performance improve.

---

## 52. Indexing Foreign-Key Columns

Foreign-key columns are frequently used in joins.

For example:

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
```

An index on `customer_id` can be useful for common access patterns involving orders and customers.

Design should still be based on actual queries and workload.

---

## 53. Indexes on Large Tables

Indexes become increasingly important as tables grow.

A query that appears fast on:

```text
1,000 rows
```

may become expensive on:

```text
10,000,000 rows
```

Performance should therefore be considered with realistic data volumes.

---

## 54. Index Trade-Off

Indexes provide a trade-off:

```text
             INDEX
               |
       ┌───────┴────────┐
       ↓                ↓
 Faster reads       Write overhead
       ↓                ↓
 Less row scanning  More maintenance
```

The best database design balances read performance and write performance.

---

## 55. Common Index Mistakes

### Mistake 1: Indexing every column

More indexes are not automatically better.

### Mistake 2: Ignoring composite index order

The order of columns matters.

### Mistake 3: Never checking EXPLAIN

Do not assume an index is being used.

### Mistake 4: Creating duplicate indexes

Redundant indexes increase maintenance cost.

### Mistake 5: Ignoring write performance

Indexes improve some reads but add write overhead.

### Mistake 6: Using functions unnecessarily

Expressions on indexed columns can make index usage less effective.

### Mistake 7: Optimizing without measuring

Always compare actual execution behavior before and after changes.

---

## 56. Useful Commands

Create an index:

```sql
CREATE INDEX idx_name
ON table_name(column_name);
```

Create a unique index:

```sql
CREATE UNIQUE INDEX idx_name
ON table_name(column_name);
```

Create a composite index:

```sql
CREATE INDEX idx_name
ON table_name(column1, column2);
```

Drop an index:

```sql
DROP INDEX idx_name
ON table_name;
```

View indexes:

```sql
SHOW INDEX FROM table_name;
```

Analyze a query:

```sql
EXPLAIN
SELECT ...
```

Analyze actual execution:

```sql
EXPLAIN ANALYZE
SELECT ...
```

Refresh optimizer statistics:

```sql
ANALYZE TABLE table_name;
```

---

# 57. Key Concepts to Remember

The most important concepts from this module are:

1. Indexes help MySQL locate rows efficiently.
2. Primary keys automatically have indexes.
3. Unique indexes enforce uniqueness and support efficient lookups.
4. Composite indexes contain multiple columns.
5. Column order matters in composite indexes.
6. The leftmost-prefix principle is important for composite indexes.
7. Selectivity affects index usefulness.
8. The optimizer decides whether an index should be used.
9. `EXPLAIN` helps analyze query execution plans.
10. `EXPLAIN ANALYZE` provides actual execution information.
11. Too many indexes can hurt write performance.
12. Functions and leading wildcards can make normal indexes less effective.
13. Covering indexes can reduce table access.
14. Index design should follow actual workload.
15. Performance optimization should be measured rather than assumed.

---

# 58. Final Takeaway

The purpose of indexing is not simply to make every query use an index.

The real goal is to make the database perform the required workload efficiently.

A good performance mindset is:

```text
Write the query
      ↓
Measure it
      ↓
EXPLAIN it
      ↓
Understand the plan
      ↓
Optimize query/index design
      ↓
Measure again
```

Indexes are powerful, but they should be used deliberately.

The most important practical habit from this module is:

```sql
EXPLAIN
SELECT ...;
```

Before changing the database design, understand how MySQL is actually executing the query.
