# Module 20 — Advanced CTE Applications

## 1. Module Overview

Common Table Expressions (CTEs) were introduced earlier as a way to create temporary named result sets using:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT ...
FROM cte_name;
```

This module moves beyond basic CTE syntax.

The focus here is on using CTEs as building blocks for solving complex SQL problems.

We will work with:

* Multiple CTEs
* CTE chains
* CTEs with joins
* CTEs with aggregation
* CTEs with window functions
* CTEs with CASE expressions
* CTEs for filtering intermediate results
* CTEs for ranking
* CTEs for reporting
* CTEs for multi-step transformations
* CTEs combined with subqueries
* Recursive CTEs for hierarchical data

The key idea is:

```text
Raw Data
   ↓
CTE 1
   ↓
CTE 2
   ↓
CTE 3
   ↓
Final Query
```

Instead of writing one extremely complicated query, we can break the problem into logical stages.

---

# 2. Review: Basic CTE

A basic CTE looks like:

```sql
WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
)
SELECT *
FROM active_customers;
```

The CTE exists only for the duration of that SQL statement.

---

# 3. Multiple CTEs

Multiple CTEs can be defined in the same `WITH` clause.

Example:

```sql
WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
),
customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    o.order_count
FROM active_customers c
JOIN customer_orders o
    ON c.customer_id = o.customer_id;
```

The CTEs are separated by commas.

```text
WITH
    CTE_1 AS (...),
    CTE_2 AS (...),
    CTE_3 AS (...)
SELECT ...
```

---

# 4. CTE Pipelines

A powerful technique is to let one CTE use another CTE.

Example:

```sql
WITH active_customers AS (
    SELECT *
    FROM customers
    WHERE status = 'ACTIVE'
),
customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
),
high_value_customers AS (
    SELECT
        a.customer_id,
        a.customer_name,
        o.order_count
    FROM active_customers a
    JOIN customer_orders o
        ON a.customer_id = o.customer_id
    WHERE o.order_count >= 5
)
SELECT *
FROM high_value_customers;
```

This creates a logical pipeline:

```text
customers
   ↓
active_customers
   ↓
customer_orders
   ↓
high_value_customers
   ↓
final result
```

---

# 5. Why Use CTE Pipelines?

A complex query can become difficult to understand when everything is placed into one SELECT statement.

For example:

```sql
SELECT ...
FROM ...
JOIN ...
WHERE ...
GROUP BY ...
HAVING ...
```

with multiple nested subqueries can become difficult to maintain.

CTEs allow us to divide the problem into meaningful stages.

Each CTE should ideally represent one logical operation.

---

# 6. CTE for Filtering

Suppose we want employees earning more than the average salary.

First calculate the average:

```sql
WITH salary_stats AS (
    SELECT AVG(salary) AS average_salary
    FROM employees
)
SELECT
    e.employee_id,
    e.first_name,
    e.salary
FROM employees e
CROSS JOIN salary_stats s
WHERE e.salary > s.average_salary;
```

The CTE calculates the value.

The outer query uses it.

---

# 7. CTE for Aggregation

Suppose we want customers whose total spending exceeds 10,000.

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent
FROM customer_totals
WHERE total_spent > 10000;
```

The CTE performs aggregation.

The outer query filters the aggregated result.

---

# 8. CTE + JOIN

CTEs can be joined just like tables.

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    t.total_spent
FROM customers c
JOIN customer_totals t
    ON c.customer_id = t.customer_id;
```

This separates the aggregation from the customer lookup.

---

# 9. CTE + CASE

CTEs work well with conditional logic.

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent,
    CASE
        WHEN total_spent >= 50000 THEN 'VIP'
        WHEN total_spent >= 20000 THEN 'PREMIUM'
        WHEN total_spent >= 5000 THEN 'REGULAR'
        ELSE 'LOW'
    END AS customer_category
FROM customer_totals;
```

This creates a reusable intermediate dataset before classification.

---

# 10. CTE + Window Functions

CTEs become particularly powerful when combined with window functions.

Example:

```sql
WITH ranked_employees AS (
    SELECT
        employee_id,
        first_name,
        department_id,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT *
FROM ranked_employees
WHERE salary_rank <= 2;
```

The CTE calculates rankings.

The outer query filters the rankings.

This pattern is extremely useful because window-function results generally cannot be filtered directly in the same query's `WHERE` clause.

---

# 11. Top N Per Group

One of the most useful advanced CTE patterns is:

```text
1. Calculate ranking.
2. Store ranking in a CTE.
3. Filter ranking in the outer query.
```

Example:

```sql
WITH ranked_products AS (
    SELECT
        product_id,
        category_id,
        sales,
        ROW_NUMBER() OVER (
            PARTITION BY category_id
            ORDER BY sales DESC
        ) AS row_num
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE row_num <= 3;
```

This returns the top three products from each category.

---

# 12. CTE + Multiple Aggregation Levels

A complex report may require multiple levels of aggregation.

Example:

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS customer_total
    FROM orders
    GROUP BY customer_id
),
customer_statistics AS (
    SELECT
        AVG(customer_total) AS average_customer_total
    FROM customer_totals
)
SELECT
    c.customer_id,
    c.customer_total
FROM customer_totals c
CROSS JOIN customer_statistics s
WHERE c.customer_total > s.average_customer_total;
```

The first CTE calculates totals per customer.

The second CTE calculates statistics across those customer totals.

The final query compares each customer with the overall average.

---

# 13. CTEs as Intermediate Tables

Think of each CTE as a temporary logical table.

For example:

```sql
WITH sales AS (
    SELECT ...
),
customer_totals AS (
    SELECT ...
    FROM sales
    GROUP BY ...
),
ranked_customers AS (
    SELECT ...
    FROM customer_totals
)
SELECT ...
FROM ranked_customers;
```

Conceptually:

```text
sales
   ↓
customer_totals
   ↓
ranked_customers
   ↓
final result
```

This mental model makes complex SQL much easier to design.

---

# 14. Naming CTEs

CTE names should describe what they contain.

Good:

```text
active_customers
customer_totals
monthly_sales
ranked_products
department_statistics
high_value_customers
```

Avoid:

```text
x
temp1
data
query2
abc
```

Good names make complex queries easier to understand.

---

# 15. One CTE, One Logical Purpose

A useful design principle is:

> Each CTE should ideally perform one meaningful transformation.

For example:

```sql
WITH filtered_orders AS (
    ...
),
customer_totals AS (
    ...
),
ranked_customers AS (
    ...
)
SELECT ...
```

This is easier to understand than putting filtering, aggregation, ranking, and classification into one huge CTE.

---

# 16. CTEs vs Nested Subqueries

Nested subquery:

```sql
SELECT *
FROM (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
) totals
WHERE total_spent > 10000;
```

CTE version:

```sql
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_totals
WHERE total_spent > 10000;
```

The CTE version is often easier to read.

---

# 17. CTEs vs Views

A CTE:

```text
Temporary for one statement
```

A view:

```text
Saved database object
```

Example:

```sql
WITH customer_totals AS (...)
SELECT ...
```

The CTE disappears after the statement finishes.

A view remains available until it is dropped.

---

# 18. CTEs vs Temporary Tables

A CTE:

```text
Exists for one SQL statement
```

A temporary table:

```text
Can exist for a session
```

Use a CTE when the intermediate result only needs to exist within one query.

Use a temporary table when intermediate data needs to be reused across multiple statements or needs properties of a table.

---

# 19. Recursive CTEs

A recursive CTE refers to itself.

It is useful for hierarchical or sequential data.

Basic structure:

```sql
WITH RECURSIVE cte_name AS (
    -- Anchor query

    UNION ALL

    -- Recursive query
)
SELECT *
FROM cte_name;
```

A recursive CTE has two important parts:

```text
Anchor member
      ↓
Recursive member
      ↓
Repeated until termination
```

---

# 20. Simple Recursive Example

Generate numbers from 1 to 5:

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS number

    UNION ALL

    SELECT number + 1
    FROM numbers
    WHERE number < 5
)
SELECT *
FROM numbers;
```

Result:

```text
1
2
3
4
5
```

The anchor starts with:

```text
1
```

The recursive part generates:

```text
2
3
4
5
```

---

# 21. Recursive CTE for Hierarchical Data

Consider an employee hierarchy:

```text
CEO
├── Manager A
│   ├── Employee A1
│   └── Employee A2
└── Manager B
    ├── Employee B1
    └── Employee B2
```

A recursive CTE can traverse the hierarchy.

Example structure:

```sql
WITH RECURSIVE employee_hierarchy AS (

    SELECT
        employee_id,
        employee_name,
        manager_id,
        0 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.employee_name,
        e.manager_id,
        h.level + 1
    FROM employees e
    JOIN employee_hierarchy h
        ON e.manager_id = h.employee_id
)
SELECT *
FROM employee_hierarchy;
```

The first query finds the root employee.

The recursive query finds employees reporting to previously discovered employees.

---

# 22. Recursive CTE Termination

A recursive CTE must have a termination condition.

For example:

```sql
WHERE number < 10
```

Without proper termination, recursion can continue until the database's recursion limit or an error condition is reached.

Always design recursive CTEs carefully.

---

# 23. CTE + Date Analysis

CTEs can simplify date-based reports.

For example:

```sql
WITH monthly_sales AS (
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(total_amount) AS revenue
    FROM orders
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)
SELECT *
FROM monthly_sales
ORDER BY
    sales_year,
    sales_month;
```

The CTE creates a clean monthly dataset.

---

# 24. CTE + Running Totals

A CTE can prepare data before calculating a running total.

```sql
WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY order_date
    ) AS running_revenue
FROM daily_sales;
```

The CTE first creates daily totals.

The window function then calculates cumulative revenue.

---

# 25. CTE + Previous Row Comparison

CTEs can also make comparisons easier.

```sql
WITH daily_sales AS (
    SELECT
        order_date,
        SUM(total_amount) AS revenue
    FROM orders
    GROUP BY order_date
)
SELECT
    order_date,
    revenue,
    LAG(revenue) OVER (
        ORDER BY order_date
    ) AS previous_revenue
FROM daily_sales;
```

The CTE creates one row per day.

`LAG()` retrieves the previous row's revenue.

---

# 26. CTE + Percentage Calculations

Example:

```sql
WITH department_totals AS (
    SELECT
        department_id,
        SUM(salary) AS department_salary
    FROM employees
    GROUP BY department_id
),
company_total AS (
    SELECT
        SUM(department_salary) AS total_salary
    FROM department_totals
)
SELECT
    d.department_id,
    d.department_salary,
    d.department_salary / c.total_salary * 100
        AS salary_percentage
FROM department_totals d
CROSS JOIN company_total c;
```

This demonstrates a multi-stage analytical query.

---

# 27. CTE + Duplicate Detection

CTEs can simplify duplicate detection.

Example:

```sql
WITH duplicate_emails AS (
    SELECT
        email,
        COUNT(*) AS email_count
    FROM customers
    GROUP BY email
)
SELECT *
FROM duplicate_emails
WHERE email_count > 1;
```

The CTE identifies duplicate values.

---

# 28. CTE for Data Quality Checks

CTEs can be used to build validation reports.

Example:

```sql
WITH invalid_employees AS (
    SELECT *
    FROM employees
    WHERE email IS NULL
       OR salary <= 0
)
SELECT *
FROM invalid_employees;
```

More complex validation can use multiple CTEs:

```sql
WITH missing_email AS (
    SELECT *
    FROM employees
    WHERE email IS NULL
),
invalid_salary AS (
    SELECT *
    FROM employees
    WHERE salary <= 0
)
SELECT ...
```

---

# 29. Combining Multiple CTE Results

Suppose we have:

```sql
WITH active_customers AS (
    SELECT customer_id
    FROM customers
    WHERE status = 'ACTIVE'
),
high_spenders AS (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 10000
)
SELECT customer_id
FROM active_customers

INTERSECT

SELECT customer_id
FROM high_spenders;
```

CTEs can therefore be combined with set operations where supported.

---

# 30. CTEs and Query Readability

A major advantage of advanced CTE usage is readability.

Instead of asking:

> How do I write one giant query?

ask:

> What are the logical steps needed to solve this problem?

Then create one CTE for each major step.

For example:

```text
Step 1 → filter relevant rows
Step 2 → aggregate
Step 3 → calculate rankings
Step 4 → classify
Step 5 → produce final output
```

This is a powerful SQL problem-solving technique.

---

# 31. Avoiding Unnecessary CTEs

CTEs are useful, but not every query needs one.

This:

```sql
WITH employees_cte AS (
    SELECT *
    FROM employees
)
SELECT *
FROM employees_cte;
```

adds no meaningful value.

The equivalent is simply:

```sql
SELECT *
FROM employees;
```

Use CTEs when they improve:

* readability
* organization
* reuse within the statement
* multi-step transformations

---

# 32. CTE Performance

A CTE is primarily a query-organization feature.

Do not assume:

```text
CTE
=
faster query
```

Performance depends on the database optimizer, query structure, indexes, data volume, and execution plan.

A well-designed CTE can make a query much easier to understand without necessarily changing its performance characteristics.

Use `EXPLAIN` when performance matters.

---

# 33. CTE Design Workflow

When facing a complex SQL problem:

### Step 1

Understand the final result.

### Step 2

Break the problem into logical steps.

### Step 3

Create a CTE for the first transformation.

### Step 4

Build the next CTE from the previous result.

### Step 5

Continue until the required dataset exists.

### Step 6

Write the final SELECT.

Conceptually:

```text
Problem
  ↓
Step 1
  ↓
CTE 1
  ↓
Step 2
  ↓
CTE 2
  ↓
Step 3
  ↓
CTE 3
  ↓
Final Result
```

---

# 34. Advanced CTE Pattern

A very useful pattern is:

```sql
WITH filtered_data AS (
    SELECT ...
    FROM ...
    WHERE ...
),
aggregated_data AS (
    SELECT ...
    FROM filtered_data
    GROUP BY ...
),
ranked_data AS (
    SELECT ...,
           RANK() OVER (...) AS ranking
    FROM aggregated_data
)
SELECT ...
FROM ranked_data
WHERE ranking <= 3;
```

This pattern appears frequently in real-world analytics.

---

# 35. Key Takeaways

Advanced CTEs are not about memorizing more syntax.

They are about learning how to break complex SQL problems into logical stages.

Important patterns:

```text
Multiple CTEs
CTE pipelines
CTE + JOIN
CTE + GROUP BY
CTE + CASE
CTE + Window Functions
CTE + Ranking
CTE + Date Analysis
CTE + Data Quality
Recursive CTEs
CTE + Set Operations
```

The most important mental model is:

```text
Complex Problem
       ↓
Break into Steps
       ↓
One CTE per Logical Step
       ↓
Combine Results
       ↓
Final Query
```

---
