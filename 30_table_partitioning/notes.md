# Module 30 — Table Partitioning in MySQL

## Overview

Table partitioning is a database technique that divides a large logical table into smaller physical partitions while allowing applications to continue querying it as a single table.

Partitioning is especially useful for very large tables where data can be naturally divided by date, category, region, or another partitioning key.

MySQL supports several partitioning strategies, including:

- RANGE
- RANGE COLUMNS
- LIST
- LIST COLUMNS
- HASH
- KEY

Partitioning can improve manageability and, when queries allow partition pruning, reduce the amount of data MySQL needs to examine.

However, partitioning is not automatically a performance optimization for every workload. Proper indexing, query design, table structure, and workload characteristics remain important.

---

# 1. What Is Table Partitioning?

Normally, a table stores all of its rows as one logical dataset.

For example:

```sql
CREATE TABLE orders (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, order_date)
);
````

If the table contains hundreds of millions of orders, managing the entire table can become increasingly difficult.

Partitioning allows the table to be divided into smaller partitions.

For example:

```text
orders
│
├── p2024
├── p2025
├── p2026
└── p_future
```

The application still queries:

```sql
SELECT *
FROM orders;
```

MySQL determines which physical partitions contain the relevant rows.

---

# 2. Logical Table vs Physical Partitions

A partitioned table is still treated as one logical table.

For example:

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';
```

The application does not need to query a table called `orders_2026`.

Instead, MySQL manages the underlying partitions.

This provides a useful combination:

* One logical table for application queries
* Multiple physical partitions for storage and maintenance

---

# 3. Why Use Partitioning?

Partitioning can be useful when a table is very large and has a natural partitioning strategy.

Common reasons include:

### 3.1 Partition Pruning

If a query specifies the partitioning key, MySQL may only need to examine relevant partitions.

For example:

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';
```

If the table is partitioned by year, MySQL may scan only the relevant partition.

This is called **partition pruning**.

---

### 3.2 Easier Data Lifecycle Management

Suppose an application stores several years of event data.

Instead of deleting millions of old rows individually:

```sql
DELETE FROM events
WHERE event_date < '2023-01-01';
```

a partitioned design may allow an entire old partition to be dropped.

```sql
ALTER TABLE events
DROP PARTITION p2022;
```

Dropping a partition removes the data contained in that partition.

Therefore, `DROP PARTITION` must be treated as a destructive data operation.

---

### 3.3 Managing Large Tables

Partitioning can make very large tables easier to organize.

Typical examples include:

* Application logs
* Events
* Orders
* Sensor readings
* Financial transactions
* Audit records
* Historical records

---

# 4. Partitioning Is Not the Same as Indexing

Partitioning and indexing solve different problems.

### Partitioning

Divides the table into physical partitions.

```text
Large table
    │
    ├── Partition A
    ├── Partition B
    ├── Partition C
    └── Partition D
```

### Indexing

Creates data structures that help MySQL locate rows efficiently.

```text
Table
 │
 └── Index
       ├── value → row
       ├── value → row
       └── value → row
```

A partitioned table can still require indexes.

For example:

```sql
CREATE INDEX idx_customer
ON orders(customer_id);
```

Partitioning should not be treated as a replacement for proper indexing.

---

# 5. Horizontal Partitioning

MySQL table partitioning is primarily a form of **horizontal partitioning**.

Horizontal partitioning divides rows rather than columns.

For example:

```text
Original table

order_id | order_date | amount
---------+------------+-------
1        | 2024-05-01 | 100
2        | 2025-02-10 | 200
3        | 2026-03-15 | 300
```

Could become:

```text
p2024
1 | 2024-05-01 | 100

p2025
2 | 2025-02-10 | 200

p2026
3 | 2026-03-15 | 300
```

The logical table remains the same.

---

# 6. Partition Key

A **partition key** determines which partition receives a row.

For example:

```sql
PARTITION BY RANGE COLUMNS (order_date)
```

Here:

```text
order_date
```

is the partitioning column.

A good partition key usually has a meaningful relationship with:

* Query patterns
* Data lifecycle
* Data distribution
* Maintenance requirements

For example, date-based partitioning is common for historical event data.

---

# 7. RANGE Partitioning

`RANGE` partitioning assigns rows to partitions according to ranges of a partitioning expression.

Example:

```sql
CREATE TABLE orders (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, order_date)
)
PARTITION BY RANGE (YEAR(order_date)) (
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);
```

The partitions represent:

```text
p2024      → YEAR(order_date) < 2025
p2025      → YEAR(order_date) < 2026
p2026      → YEAR(order_date) < 2027
p_future   → everything else
```

---

# 8. RANGE Boundaries

RANGE partitions use upper boundaries.

Consider:

```sql
PARTITION p2025 VALUES LESS THAN (2026)
```

This includes values:

```text
2025
```

but not:

```text
2026
```

The next partition handles those values.

Understanding boundary conditions is important when designing RANGE partitions.

---

# 9. RANGE COLUMNS

`RANGE COLUMNS` allows partitioning directly using column values.

For date-based partitioning, it is often easier to understand than expressions such as:

```sql
YEAR(order_date)
```

Example:

```sql
CREATE TABLE orders (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, order_date)
)
PARTITION BY RANGE COLUMNS (order_date) (
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);
```

This directly expresses the date boundaries.

---

# 10. Why RANGE COLUMNS Is Useful

For date and other ordered-column partitioning, `RANGE COLUMNS` can make the partition definition easier to understand.

For example:

```sql
PARTITION p2026
VALUES LESS THAN ('2027-01-01')
```

is immediately understandable.

It also avoids needing to transform the date through an expression such as:

```sql
YEAR(order_date)
```

---

# 11. MAXVALUE

`MAXVALUE` represents values greater than or equal to all other partition boundaries.

Example:

```sql
PARTITION p_future
VALUES LESS THAN (MAXVALUE)
```

This is commonly used as a catch-all partition.

For example:

```text
p2024      → 2024
p2025      → 2025
p2026      → 2026
p_future   → 2027 and later
```

A `MAXVALUE` partition requires special consideration when adding future RANGE partitions.

---

# 12. LIST Partitioning

`LIST` partitioning assigns rows based on discrete values.

Example:

```sql
CREATE TABLE sales (
    sale_id BIGINT NOT NULL,
    region_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (sale_id, region_id)
)
PARTITION BY LIST (region_id) (
    PARTITION p_north VALUES IN (1, 2),
    PARTITION p_south VALUES IN (3, 4),
    PARTITION p_west VALUES IN (5, 6),
    PARTITION p_east VALUES IN (7, 8)
);
```

Rows with:

```text
region_id = 1 or 2
```

go to:

```text
p_north
```

---

# 13. LIST COLUMNS

`LIST COLUMNS` can be used directly with column values, including string values.

Example:

```sql
CREATE TABLE customers (
    customer_id BIGINT NOT NULL,
    region VARCHAR(30) NOT NULL,
    PRIMARY KEY (customer_id, region)
)
PARTITION BY LIST COLUMNS (region) (
    PARTITION p_north VALUES IN ('North'),
    PARTITION p_south VALUES IN ('South'),
    PARTITION p_west VALUES IN ('West'),
    PARTITION p_east VALUES IN ('East')
);
```

This can make categorical partitioning easier to read.

---

# 14. HASH Partitioning

`HASH` partitioning distributes rows across partitions using a hash calculation.

Example:

```sql
CREATE TABLE customer_events (
    event_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    event_data VARCHAR(255),
    PRIMARY KEY (event_id, customer_id)
)
PARTITION BY HASH (customer_id)
PARTITIONS 4;
```

MySQL distributes rows across four partitions.

Conceptually:

```text
customer_id
     │
     ▼
  HASH()
     │
     ├── Partition 0
     ├── Partition 1
     ├── Partition 2
     └── Partition 3
```

HASH partitioning is useful when the goal is to distribute rows rather than create meaningful ranges.

---

# 15. KEY Partitioning

`KEY` partitioning uses MySQL's internal key-based partitioning mechanism.

Example:

```sql
CREATE TABLE customer_events (
    event_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    event_data VARCHAR(255),
    PRIMARY KEY (event_id, customer_id)
)
PARTITION BY KEY (customer_id)
PARTITIONS 4;
```

A table can also use:

```sql
PARTITION BY KEY()
PARTITIONS 4;
```

When designing KEY partitioning, understand which columns MySQL uses for the partitioning key and verify the resulting behavior.

---

# 16. Choosing a Partitioning Strategy

A simplified decision guide:

| Strategy      | Typical Use                          |
| ------------- | ------------------------------------ |
| RANGE         | Numeric or expression-based ranges   |
| RANGE COLUMNS | Dates and ordered columns            |
| LIST          | Specific discrete values             |
| LIST COLUMNS  | Categories or strings                |
| HASH          | Evenly distributing rows             |
| KEY           | MySQL-managed key-based distribution |

For many historical-data workloads, RANGE or RANGE COLUMNS is a natural starting point.

---

# 17. Partition Pruning

Partition pruning occurs when MySQL can determine that some partitions cannot contain rows matching a query.

Suppose a table is partitioned by:

```sql
PARTITION BY RANGE COLUMNS (order_date)
```

and contains:

```text
p2024
p2025
p2026
p2027
```

A query such as:

```sql
SELECT *
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';
```

may allow MySQL to access only:

```text
p2026
```

instead of scanning every partition.

This can reduce the amount of data examined.

---

# 18. Partition Pruning Depends on Query Design

Partitioning does not guarantee pruning.

For example, a query that does not constrain the partition key may need to examine many or all partitions:

```sql
SELECT *
FROM orders
WHERE customer_id = 1001;
```

If the table is partitioned by `order_date`, MySQL may need to inspect multiple partitions.

Therefore, partitioning should be designed around actual workload patterns.

---

# 19. Partitioning and Indexes

Partitioned tables can still use indexes.

For example:

```sql
CREATE INDEX idx_customer_id
ON orders(customer_id);
```

The index helps locate rows within the relevant partition(s).

Think of the process as:

```text
Query
  │
  ├── Partition pruning
  │        ↓
  │   Relevant partitions
  │        ↓
  └── Index lookup
           ↓
        Matching rows
```

Partitioning and indexing can complement each other.

---

# 20. Primary Key and Unique Key Requirements

MySQL has an important partitioning rule:

**Every column used in the partitioning expression must be included in every unique key on the table, including the primary key.**

For example, this design can cause a problem:

```sql
PRIMARY KEY (order_id)
```

with:

```sql
PARTITION BY RANGE COLUMNS (order_date)
```

because `order_date` is not part of the primary key.

A compatible design could be:

```sql
PRIMARY KEY (order_id, order_date)
```

This rule is extremely important when designing partitioned tables.

Always verify the partitioning and unique-key combination before implementing the table.

---

# 21. Time-Based Partitioning

Time-based partitioning is one of the most practical uses of MySQL partitioning.

For example:

```text
p2024
p2025
p2026
p2027
```

A large events table might use:

```sql
PARTITION BY RANGE COLUMNS (event_date)
```

This can provide:

* Time-based partition pruning
* Easier archival
* Easier deletion of old data
* More manageable historical data

---

# 22. Monthly Partitioning

Large event tables may require monthly partitions.

For example:

```text
p2026_01
p2026_02
p2026_03
p2026_04
...
```

This can be useful when:

* Data volume is extremely high
* Queries frequently target short date ranges
* Data is regularly archived or removed

However, creating too many partitions can introduce administrative and operational overhead.

Partition granularity should be based on actual requirements.

---

# 23. Querying a Partitioned Table

Applications normally query a partitioned table just like a regular table.

Example:

```sql
SELECT
    order_id,
    order_date,
    total_amount
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';
```

The application does not need to specify the physical partition.

---

# 24. Explicit Partition Selection

MySQL also allows explicit partition selection in supported situations.

Example:

```sql
SELECT *
FROM orders PARTITION (p2026);
```

This can be useful for administration, diagnostics, or specialized workloads.

However, application queries generally should rely on normal predicates and partition pruning rather than hard-coding physical partition names.

---

# 25. EXPLAIN and Partitioning

`EXPLAIN` can help investigate partition usage.

Example:

```sql
EXPLAIN
SELECT *
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';
```

For partitioned tables, the output can include a `partitions` field showing which partitions MySQL expects to examine.

This helps answer:

* Is partition pruning occurring?
* Which partitions are being accessed?
* Is the query still scanning many partitions?

---

# 26. Adding Partitions

For appropriate RANGE or LIST partition layouts, partitions can be added using:

```sql
ALTER TABLE orders
ADD PARTITION (
    PARTITION p2027 VALUES LESS THAN ('2028-01-01')
);
```

However, partition maintenance rules depend on the existing partition layout.

In particular, a RANGE table ending with:

```sql
VALUES LESS THAN (MAXVALUE)
```

cannot simply receive a new higher RANGE partition after the `MAXVALUE` boundary.

The `MAXVALUE` partition generally needs to be reorganized.

---

# 27. Dropping Partitions

A partition can be removed with:

```sql
ALTER TABLE orders
DROP PARTITION p2024;
```

This removes the partition and the rows stored in it.

For example:

```text
Before:

p2024
p2025
p2026

After:

p2025
p2026
```

Important:

```sql
DROP PARTITION
```

is not merely an index or metadata operation.

The data contained in the dropped partition is removed.

---

# 28. TRUNCATE PARTITION

`TRUNCATE PARTITION` removes all rows from selected partitions while keeping the partition itself.

Conceptually:

```text
DROP PARTITION
    ↓
Partition + its data removed

TRUNCATE PARTITION
    ↓
Data removed
Partition remains
```

Example:

```sql
ALTER TABLE orders
TRUNCATE PARTITION p2024;
```

This can be useful when a partition needs to be emptied without removing its partition definition.

---

# 29. REORGANIZE PARTITION

`REORGANIZE PARTITION` changes the boundaries or structure of existing partitions.

For example:

```sql
ALTER TABLE orders
REORGANIZE PARTITION p2026, p_future INTO (
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p2027 VALUES LESS THAN ('2028-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);
```

This can be used to create a new partition while preserving the overall range coverage.

---

# 30. Splitting a Partition

A large partition can sometimes be reorganized into smaller partitions.

Conceptually:

```text
Before:

p2026
```

could become:

```text
p2026_h1
p2026_h2
```

using `REORGANIZE PARTITION` with appropriate boundaries.

This can be useful when the existing partition has become too large.

---

# 31. Merging Partitions

Partitions can also be reorganized into larger ranges when appropriate.

Conceptually:

```text
p2024
p2025
```

could become:

```text
p2024_2025
```

The exact `REORGANIZE PARTITION` definition must preserve valid, non-overlapping ranges.

---

# 32. EXCHANGE PARTITION

MySQL supports exchanging a partition with a nonpartitioned table in supported partitioning scenarios.

Conceptually:

```text
Partitioned table
       │
       └── p2024
             ⇅
       staging table
```

Example concept:

```sql
ALTER TABLE orders
EXCHANGE PARTITION p2024
WITH TABLE orders_archive;
```

`EXCHANGE PARTITION` has strict structural and data requirements.

The participating tables must satisfy MySQL's compatibility rules, and the data must be appropriate for the partition's range.

This feature should be tested carefully before production use.

---

# 33. Inspecting Partitions

MySQL exposes partition metadata through:

```text
INFORMATION_SCHEMA.PARTITIONS
```

Example:

```sql
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    PARTITION_NAME,
    PARTITION_METHOD,
    PARTITION_EXPRESSION,
    PARTITION_DESCRIPTION,
    TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'orders'
ORDER BY PARTITION_ORDINAL_POSITION;
```

This can help inspect:

* Partition names
* Partition methods
* Partition expressions
* Partition boundaries
* Estimated row counts
* Partition order

---

# 34. Partition Maintenance

Partitioned tables require regular maintenance planning.

For a time-based table, a common lifecycle might be:

```text
Current
   ↓
Create future partition
   ↓
Load new data
   ↓
Query active partitions
   ↓
Archive old data
   ↓
Drop old partition
```

Partitioning works best when partition maintenance is part of the database operating process.

---

# 35. Future Partition Planning

A time-based partitioned table should not unexpectedly run out of valid future partitions.

For example:

```text
p2025
p2026
p2027
```

If the application reaches 2028 without an appropriate partition, inserts may fail depending on the partition definition.

A `MAXVALUE` partition can act as a safety boundary, but it still needs to be reorganized when creating explicit future partitions.

---

# 36. Partition Count

More partitions are not automatically better.

A table with:

```text
4 partitions
```

may be easy to manage.

A table with:

```text
10,000 partitions
```

can introduce significant overhead and complexity.

Partition count should be based on:

* Data volume
* Query patterns
* Maintenance frequency
* Retention requirements
* Operational capabilities

Use the smallest number of partitions that provides a meaningful benefit.

---

# 37. Partitioning and Data Distribution

Different partitioning methods produce different distributions.

### RANGE

Useful for ordered data:

```text
2024
2025
2026
```

### LIST

Useful for categories:

```text
North
South
West
East
```

### HASH

Useful for distributing rows across partitions:

```text
Partition 1
Partition 2
Partition 3
Partition 4
```

The best strategy depends on why the table needs partitioning.

---

# 38. Partitioning and NULL Values

Partitioning behavior involving `NULL` values depends on the partitioning method and expression.

Do not assume that `NULL` behaves like an ordinary value in every partitioning strategy.

When partitioning columns can contain `NULL`, test the actual behavior and define constraints intentionally.

For critical production schemas, it is often preferable to make the partitioning column `NOT NULL` when the business model permits it.

Example:

```sql
order_date DATE NOT NULL
```

---

# 39. Partitioning vs Sharding

Partitioning and sharding are different concepts.

### Partitioning

Usually divides data within one MySQL table/database environment.

```text
MySQL
  │
  └── orders
       ├── partition A
       ├── partition B
       └── partition C
```

### Sharding

Distributes data across separate database servers or nodes.

```text
Application
    │
    ├── MySQL Node 1
    ├── MySQL Node 2
    └── MySQL Node 3
```

Partitioning is not the same as distributed sharding.

---

# 40. Partitioning vs Separate Tables

Another design question is whether to use:

```text
Partitioned table
```

or:

```text
orders_2024
orders_2025
orders_2026
```

Separate tables require application logic to determine which table to query.

Partitioning keeps one logical table:

```sql
SELECT *
FROM orders;
```

This is often simpler for applications.

---

# 41. Partitioning Does Not Fix Poor Queries

Consider:

```sql
SELECT *
FROM orders;
```

Partitioning does not magically make a full-table query efficient.

If the query needs every row, MySQL may need to examine every partition.

Similarly, if the partition key does not match the query workload, partitioning may provide little benefit.

Always analyze the workload before partitioning.

---

# 42. Partitioning Does Not Replace Proper Indexes

Suppose the table is partitioned by:

```sql
order_date
```

but queries frequently search:

```sql
WHERE customer_id = 100
```

Partitioning by date does not automatically make customer lookups efficient.

An appropriate index may still be required:

```sql
CREATE INDEX idx_customer_id
ON orders(customer_id);
```

Good database design often combines:

* Partitioning
* Indexing
* Efficient SQL
* Appropriate schema design

---

# 43. Functions and Partition Pruning

Query predicates should be designed so that MySQL can effectively use the partitioning strategy.

For example, if a table is partitioned using a date column, prefer predicates that directly constrain the date range when possible:

```sql
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01'
```

rather than unnecessarily transforming the column in a way that may interfere with optimization.

Always verify the actual execution plan with `EXPLAIN`.

---

# 44. Composite Partitioning Columns

MySQL supports partitioning based on multiple columns in supported partitioning strategies.

For example:

```sql
PARTITION BY RANGE COLUMNS (order_date, customer_id)
```

However, multi-column RANGE COLUMNS boundaries follow ordered/lexicographic comparison semantics.

It does not mean:

```text
partition independently by date
AND
partition independently by customer
```

Therefore, composite partitioning should only be used when its ordering behavior matches the intended data distribution.

---

# 45. Subpartitioning

MySQL also supports the concept of subpartitioning, where partitions can themselves be divided into subpartitions.

Conceptually:

```text
orders
│
├── 2025
│    ├── subpartition 1
│    ├── subpartition 2
│    └── subpartition 3
│
└── 2026
     ├── subpartition 1
     ├── subpartition 2
     └── subpartition 3
```

Subpartitioning is an advanced feature and should not be introduced simply because it is available.

It increases design and operational complexity.

Use it only when there is a clear workload or maintenance requirement.

---

# 46. Common Partitioning Use Cases

Partitioning is commonly considered for:

### Logs

```text
application_logs
```

Partition by:

```text
log_date
```

### Events

```text
events
```

Partition by:

```text
event_date
```

### Orders

```text
orders
```

Partition by:

```text
order_date
```

### Audit Records

```text
audit_logs
```

Partition by:

```text
created_at
```

### Sensor Data

```text
sensor_readings
```

Partition by:

```text
reading_date
```

---

# 47. Example: Time-Based Orders Table

A practical design might look like:

```sql
CREATE TABLE orders (
    order_id BIGINT NOT NULL,
    order_date DATE NOT NULL,
    customer_id BIGINT NOT NULL,
    total_amount DECIMAL(12, 2) NOT NULL,

    PRIMARY KEY (order_id, order_date),

    INDEX idx_customer_id (customer_id)
)
PARTITION BY RANGE COLUMNS (order_date) (
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION p2025 VALUES LESS THAN ('2026-01-01'),
    PARTITION p2026 VALUES LESS THAN ('2027-01-01'),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);
```

This design combines:

* Composite primary key
* Customer index
* Date-based RANGE COLUMNS partitioning
* Future catch-all partition

---

# 48. Example Query Against the Partitioned Table

```sql
SELECT
    order_id,
    order_date,
    customer_id,
    total_amount
FROM orders
WHERE order_date >= '2026-01-01'
  AND order_date < '2027-01-01';
```

The date predicate gives MySQL an opportunity to prune irrelevant partitions.

Use:

```sql
EXPLAIN
```

to inspect the execution plan.

---

# 49. Example: Removing Old Data

Suppose:

```text
p2024
```

contains data that has reached its retention limit.

A maintenance operation might be:

```sql
ALTER TABLE orders
DROP PARTITION p2024;
```

This is potentially much more appropriate for partition lifecycle management than deleting a very large number of individual rows.

However, the operation permanently removes the partition's data, so archival requirements must be considered first.

---

# 50. Partitioning and Retention Policies

Partitioning works particularly well with explicit retention policies.

For example:

```text
Keep 3 years of event data.
```

The system might maintain:

```text
2024
2025
2026
2027
```

and periodically remove the oldest partition after confirming that the data no longer needs to be retained.

This makes partitioning both a performance and data-lifecycle tool.

---

# 51. Partitioning and Archiving

A mature data lifecycle may look like:

```text
Hot data
   ↓
Active partition
   ↓
Older partition
   ↓
Archive
   ↓
Drop from primary table
```

Possible archive mechanisms include:

* Archive tables
* Exported files
* Separate databases
* Data warehouses
* Object storage
* External archival systems

Partitioning itself does not automatically create an archive.

---

# 52. Common Mistakes

### Mistake 1 — Partitioning every large table

Not every large table needs partitioning.

---

### Mistake 2 — Treating partitioning as an index replacement

Partitioning and indexing solve different problems.

---

### Mistake 3 — Choosing a partition key unrelated to queries

If most queries filter by `customer_id` but the table is partitioned by an unrelated column, partition pruning may provide little value.

---

### Mistake 4 — Creating too many partitions

Thousands of unnecessary partitions can increase complexity and overhead.

---

### Mistake 5 — Forgetting primary/unique key rules

The partitioning columns must be included in every unique key.

---

### Mistake 6 — Forgetting future partitions

Time-based partitioning requires a maintenance process for future ranges.

---

### Mistake 7 — Using `DROP PARTITION` without understanding its effect

`DROP PARTITION` removes the data stored in that partition.

---

### Mistake 8 — Assuming partitioning always improves performance

Partitioning can help specific workloads, especially when partition pruning is effective.

It can also provide little benefit or add complexity when used incorrectly.

---

### Mistake 9 — Ignoring indexes inside partitions

Partitioning does not eliminate the need for appropriate indexes.

---

### Mistake 10 — Using complex partitioning without a clear reason

Simple designs are generally easier to understand and maintain.

---

# 53. Best Practices

## 53.1 Start With the Workload

Before partitioning, understand:

* What queries are slow?
* How much data exists?
* How fast is the table growing?
* What columns are frequently filtered?
* What data needs to be archived?
* How long must data be retained?

---

## 53.2 Choose a Meaningful Partition Key

Good partition keys often relate to:

* Date ranges
* Data lifecycle
* Frequently filtered dimensions

---

## 53.3 Prefer Simple Designs

If:

```text
RANGE COLUMNS(order_date)
```

solves the problem, avoid introducing unnecessarily complicated partitioning.

---

## 53.4 Keep Appropriate Indexes

Partitioning and indexing should work together.

---

## 53.5 Test Partition Pruning

Use:

```sql
EXPLAIN
```

and, where appropriate:

```sql
EXPLAIN ANALYZE
```

to understand actual query behavior.

---

## 53.6 Monitor Partition Growth

A partition that becomes significantly larger than the others may indicate that partition boundaries need adjustment.

---

## 53.7 Plan Maintenance

For time-based partitioning, establish a process for:

* Creating future partitions
* Archiving old data
* Dropping expired partitions
* Monitoring partition sizes
* Verifying retention policies

---

## 53.8 Test DDL Operations

Operations such as:

```sql
ADD PARTITION
DROP PARTITION
REORGANIZE PARTITION
TRUNCATE PARTITION
EXCHANGE PARTITION
```

should be tested before production use.

---

# 54. Partitioning Design Checklist

Before partitioning a table, ask:

```text
[ ] Is the table large enough to justify partitioning?
[ ] Is there a natural partition key?
[ ] Do important queries filter by the partition key?
[ ] Will partition pruning occur?
[ ] Are appropriate indexes still required?
[ ] Do all unique keys include the partitioning columns?
[ ] Are partition boundaries correct?
[ ] Is the number of partitions reasonable?
[ ] Is there a future-partition strategy?
[ ] Is there an archival strategy?
[ ] Is there a retention policy?
[ ] Has the design been tested with realistic data?
[ ] Has EXPLAIN been used to verify query behavior?
[ ] Is partitioning actually better than a simpler design?
```

---

# 55. Practical Partitioning Workflow

A practical database engineer can approach partitioning like this:

```text
1. Identify a large table
        ↓
2. Analyze query patterns
        ↓
3. Analyze data lifecycle
        ↓
4. Choose a partition key
        ↓
5. Select partitioning strategy
        ↓
6. Design partition boundaries
        ↓
7. Verify primary/unique key requirements
        ↓
8. Add appropriate indexes
        ↓
9. Test with realistic data
        ↓
10. Use EXPLAIN to inspect pruning
        ↓
11. Plan partition maintenance
        ↓
12. Monitor production behavior
```

---

# 56. Key Takeaways

* Table partitioning divides one logical table into multiple physical partitions.
* MySQL supports RANGE, RANGE COLUMNS, LIST, LIST COLUMNS, HASH, and KEY partitioning.
* RANGE and RANGE COLUMNS are especially useful for ordered and time-based data.
* LIST and LIST COLUMNS are useful for categorical partitioning.
* HASH and KEY can distribute rows across partitions.
* Partitioning can enable partition pruning.
* Partition pruning can reduce the amount of data scanned for suitable queries.
* Partitioning does not replace indexes.
* Partitioned tables still need good indexes and efficient queries.
* Every partitioning column must be included in every unique key.
* `DROP PARTITION` removes the data stored in that partition.
* `TRUNCATE PARTITION` removes rows while keeping the partition.
* `REORGANIZE PARTITION` can change partition boundaries and structure.
* `EXCHANGE PARTITION` can support advanced data-loading and archival workflows.
* `INFORMATION_SCHEMA.PARTITIONS` can be used to inspect partition metadata.
* Time-based partitioning requires ongoing maintenance.
* Too many partitions can create unnecessary complexity.
* Partitioning is different from sharding.
* Partitioning should be driven by workload and data-lifecycle requirements.
* Always verify the actual benefit with realistic data and execution plans.

---

# 57. Learning Goal

After completing this module, you should be able to:

1. Explain what table partitioning is.
2. Explain why large tables may benefit from partitioning.
3. Distinguish partitioning from indexing.
4. Explain horizontal partitioning.
5. Choose an appropriate partition key.
6. Create RANGE partitions.
7. Create RANGE COLUMNS partitions.
8. Create LIST partitions.
9. Create LIST COLUMNS partitions.
10. Create HASH partitions.
11. Create KEY partitions.
12. Explain partition pruning.
13. Use EXPLAIN to investigate partition usage.
14. Understand indexing on partitioned tables.
15. Apply MySQL primary-key and unique-key partitioning rules.
16. Add partitions.
17. Drop partitions safely.
18. Truncate partitions.
19. Reorganize partitions.
20. Understand partition exchange.
21. Inspect partition metadata.
22. Design time-based partitioning.
23. Plan partition maintenance.
24. Compare partitioning with sharding.
25. Identify situations where partitioning is inappropriate.
26. Design a practical partitioning strategy for large MySQL tables.

---

# Final Principle

Partitioning should not be added simply because a table is large.

The goal is to solve a specific problem.

A good partitioning design connects:

```text
Data size
   +
Query patterns
   +
Data lifecycle
   +
Maintenance requirements
   +
Indexes
   +
Execution plans
```

When these factors align, partitioning can make large MySQL tables easier to query, maintain, archive, and manage.
