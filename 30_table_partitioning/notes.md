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
