# Module 37: Real-World SQL Projects

## Overview

This final module applies SQL to a practical e-commerce analytics project. Instead of learning one isolated feature, you will combine relational database design, joins, aggregation, CTEs, window functions, and business reporting.

The project models an online store that sells products to customers. Customers place orders, and each order can contain multiple products. The database records the products purchased, quantities, prices, and order dates.

## Learning Objectives

By the end of this module, you should be able to:

- Work with a multi-table relational schema.
- Retrieve meaningful business information using joins.
- Calculate revenue, order totals, and product performance.
- Analyze customer purchasing behavior.
- Build monthly and category-level reports.
- Use CTEs and window functions in practical analytics.
- Identify customers who have not placed orders.
- Validate query results against business expectations.
- Organize SQL scripts for a professional GitHub portfolio.

## 1. Project Scenario

An online store wants to understand its sales performance. Management needs answers to questions such as:

- How much revenue has the store generated?
- Which products generate the most revenue?
- Which customers spend the most?
- How does revenue change from month to month?
- Which customers have never ordered?
- What is the average order value?
- Which products are selling below expectations?

We will answer these questions using SQL.

## 2. Database Schema

The project uses four tables.

### customers

Stores customer information.

- `customer_id`: Primary key.
- `customer_name`: Customer's name.
- `email`: Customer's email address.
- `city`: Customer's city.

### products

Stores the products available for sale.

- `product_id`: Primary key.
- `product_name`: Product name.
- `category`: Product category.
- `price`: Current listed price.

### orders

Stores order-level information.

- `order_id`: Primary key.
- `customer_id`: Customer who placed the order.
- `order_date`: Date the order was placed.
- `status`: Order status.

### order_items

Stores the products and quantities belonging to each order.

- `order_item_id`: Primary key.
- `order_id`: Related order.
- `product_id`: Related product.
- `quantity`: Number of units purchased.
- `unit_price`: Price per unit at the time of purchase.

The `unit_price` in `order_items` preserves the historical selling price. It should be used for sales calculations rather than the product's current listed price.

## 3. Relationships

One customer can place many orders. Each order belongs to one customer.

One order can contain many order items. Each order item references one product.

One product can appear in many order items.

These relationships allow us to combine customer, order, and product information without storing everything in a single table.

## 4. Defining Revenue

For this learning project, revenue is calculated from completed orders only.

The revenue for an order item is:

```sql
quantity * unit_price
````

Total order revenue is the sum of its order-item amounts.

SQL

```
SELECT
    oi.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_revenue
FROM order_items AS oi
GROUP BY oi.order_id;
```

This project uses a simplified revenue model. It does not account for tax, shipping, refunds, discounts, or currency conversion. In a production system, those rules must be defined explicitly.

## 5. Joining the Tables

A typical sales report joins orders to their items and products.

SQL

```
SELECT
    o.order_id,
    o.order_date,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id;
```

Use explicit join conditions. Avoid joining tables without a defined relationship, because this can multiply rows and inflate totals.

## 6. Revenue by Product

SQL

```
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products AS p
JOIN order_items AS oi
    ON p.product_id = oi.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;
```

This report ranks products by revenue. If products with no completed sales must also appear, use `LEFT JOIN` and place the order-status condition in the join rather than filtering those rows away in `WHERE`.

## 7. Customer Lifetime Spending

Customer spending can be calculated by grouping completed order items by customer.

SQL

```
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(
        SUM(oi.quantity * oi.unit_price),
        0
    ) AS lifetime_spending
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
   AND o.status = 'Completed'
LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name;
```

This query includes customers who have never completed an order. `COALESCE` converts their missing total to zero.

## 8. Monthly Revenue

SQL

```
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;
```

This produces one row per month with completed sales. Months without sales are omitted unless a calendar table or generated month series is added.

## 9. Average Order Value

Average order value (AOV) is total completed-order revenue divided by the number of completed orders.

SQL

```
WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
)
SELECT AVG(order_total) AS average_order_value
FROM order_totals;
```

Calculate each order total first. Averaging individual order-item prices would produce a different and generally incorrect metric.

## 10. Ranking Products

Window functions can rank products within their categories.

SQL

```
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS revenue
    FROM products AS p
    JOIN order_items AS oi
        ON p.product_id = oi.product_id
    JOIN orders AS o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY p.product_id, p.product_name, p.category
)
SELECT
    product_name,
    category,
    revenue,
    DENSE_RANK() OVER (
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS category_rank
FROM product_sales;
```

`DENSE_RANK()` assigns the same rank to products with equal revenue. Products with no completed sales are excluded from this example.

## 11. Data Quality Checks

Real-world analytics depends on trustworthy data. Useful checks include:

* Orders referencing valid customers.

* Order items referencing valid products and orders.

* Positive quantities and non-negative prices.

* Valid order statuses.

* Duplicate business identifiers.

* Orders that have no line items.

Foreign keys and suitable constraints can prevent many data-quality problems. Analytical queries should still be tested against expected totals and edge cases.

## 12. Performance Considerations

As the dataset grows, consider indexes on frequently joined and filtered columns.

Typical candidates include:

* `orders.customer_id`

* `orders.status`

* `orders.order_date`

* `order_items.order_id`

* `order_items.product_id`

Use `EXPLAIN` to inspect query plans. Indexes should be selected based on real query patterns and measured performance, not added indiscriminately.

## 13. Portfolio Presentation

A professional project repository should include:

* A clear project description.

* The database schema and relationships.

* SQL setup scripts.

* Analytical queries grouped by business question.

* Sample results or screenshots.

* Instructions for running the project.

* Notes about assumptions and limitations.

Document the revenue definition and the treatment of cancelled or pending orders. Clear business assumptions are part of good data analysis.

## Summary

This project demonstrates how SQL can turn relational data into business insights. It combines joins, aggregation, CTEs, window functions, and data-quality checks in a realistic analytical workflow.

The central lesson is to define the business metric first, write the query to match that definition, and validate the result before presenting it.
