# Module 28: JSON Data in MySQL

MySQL 8.0+ provides native support for storing, querying, modifying, validating, and indexing JSON data.

JSON is useful when data has a flexible or semi-structured structure that does not fit naturally into a fixed relational schema.

This module focuses on practical MySQL JSON features while reinforcing an important principle:

> JSON is a useful data type, but it does not replace good relational database design.

---

# 1. What Is JSON?

JSON stands for **JavaScript Object Notation**.

It is a lightweight format for representing structured data.

A simple JSON object looks like:

```json
{
    "name": "Alice",
    "age": 25,
    "city": "Delhi"
}
````

JSON consists of key-value pairs.

Example:

```json
{
    "name": "Alice",
    "age": 25
}
```

Here:

```text
name → Alice
age  → 25
```

JSON can also contain arrays:

```json
{
    "name": "Alice",
    "skills": [
        "SQL",
        "Python",
        "Java"
    ]
}
```

---

# 2. Why Use JSON in MySQL?

Traditional relational tables have a fixed structure.

For example:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(20)
);
```

Every customer uses the same columns.

However, sometimes records contain additional attributes that vary between rows.

For example:

```text
Customer A
    preferred_language
    loyalty_level

Customer B
    preferred_language
    company_name
    tax_number

Customer C
    preferred_language
    delivery_instructions
```

Creating a separate column for every possible attribute can make the table unnecessarily wide.

A JSON column can store flexible attributes:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255),
    attributes JSON
);
```

---

# 3. JSON vs Relational Data

JSON should not automatically be used for everything.

Relational columns are generally preferable for important structured data such as:

```text
customer_id
email
price
order_date
department_id
```

JSON is useful for:

```text
optional attributes
flexible metadata
external API responses
configuration
semi-structured information
```

A good design often combines both approaches.

---

# 4. MySQL JSON Data Type

MySQL provides a native `JSON` data type.

Example:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    attributes JSON
);
```

The `attributes` column can store JSON documents.

Example:

```json
{
    "color": "black",
    "size": "large",
    "weight": 2.5
}
```

---

# 5. Inserting JSON Data

JSON values can be inserted directly.

```sql
INSERT INTO products (
    product_id,
    product_name,
    attributes
)
VALUES (
    1,
    'Laptop',
    '{"color": "black", "ram": 16, "storage": 512}'
);
```

The JSON document must be valid JSON.

---

# 6. JSON Objects

A JSON object contains key-value pairs.

Example:

```json
{
    "color": "black",
    "ram": 16,
    "storage": 512
}
```

The values can have different JSON types:

```text
String
Number
Boolean
Null
Object
Array
```

---

# 7. JSON Arrays

JSON arrays contain ordered values.

Example:

```json
{
    "skills": [
        "SQL",
        "Python",
        "Java"
    ]
}
```

Arrays are useful for representing collections of related values.

---

# 8. Nested JSON Objects

JSON objects can contain other objects.

Example:

```json
{
    "name": "Alice",
    "address": {
        "city": "Delhi",
        "state": "Delhi",
        "country": "India"
    }
}
```

Here:

```text
address
    ├── city
    ├── state
    └── country
```

---

# 9. JSON Data Types

JSON supports:

```text
String
Number
Boolean
Null
Object
Array
```

Example:

```json
{
    "name": "Alice",
    "age": 25,
    "active": true,
    "middle_name": null,
    "skills": ["SQL", "Python"],
    "address": {
        "city": "Delhi"
    }
}
```

---

# 10. JSON Validation

MySQL validates values inserted into a `JSON` column.

For example:

```sql
INSERT INTO products (
    product_id,
    product_name,
    attributes
)
VALUES (
    2,
    'Phone',
    '{"color": "blue", "ram": 8}'
);
```

This is valid JSON.

An invalid document such as:

```text
{color: blue}
```

is not valid JSON because JSON object keys must be quoted.

Correct:

```json
{
    "color": "blue"
}
```

---

# 11. JSON_OBJECT()

`JSON_OBJECT()` creates a JSON object.

Example:

```sql
SELECT JSON_OBJECT(
    'name', 'Alice',
    'age', 25,
    'city', 'Delhi'
);
```

Result:

```json
{
    "name": "Alice",
    "age": 25,
    "city": "Delhi"
}
```

This is useful when constructing JSON dynamically.

---

# 12. JSON_ARRAY()

`JSON_ARRAY()` creates a JSON array.

Example:

```sql
SELECT JSON_ARRAY(
    'SQL',
    'Python',
    'Java'
);
```

Result:

```json
[
    "SQL",
    "Python",
    "Java"
]
```

---

# 13. JSON_OBJECTAGG()

`JSON_OBJECTAGG()` creates a JSON object by aggregating key-value pairs.

Example:

```sql
SELECT JSON_OBJECTAGG(
    product_name,
    price
)
FROM products;
```

Conceptually, the result might look like:

```json
{
    "Laptop": 80000,
    "Phone": 40000,
    "Tablet": 30000
}
```

This is useful for generating JSON reports.

---

# 14. JSON_ARRAYAGG()

`JSON_ARRAYAGG()` aggregates values into a JSON array.

Example:

```sql
SELECT JSON_ARRAYAGG(product_name)
FROM products;
```

Possible result:

```json
[
    "Laptop",
    "Phone",
    "Tablet"
]
```

---

# 15. JSON_EXTRACT()

`JSON_EXTRACT()` retrieves data from a JSON document.

Example:

```sql
SELECT JSON_EXTRACT(
    '{"name": "Alice", "age": 25}',
    '$.name'
);
```

Result:

```text
"Alice"
```

---

# 16. JSON Path Expressions

MySQL uses JSON path expressions to identify values.

The root of a JSON document is:

```text
$
```

For example:

```json
{
    "name": "Alice",
    "age": 25
}
```

The path to `name` is:

```text
$.name
```

The path to `age` is:

```text
$.age
```

---

# 17. Accessing Nested Objects

Consider:

```json
{
    "name": "Alice",
    "address": {
        "city": "Delhi",
        "country": "India"
    }
}
```

The city can be accessed with:

```text
$.address.city
```

Example:

```sql
SELECT JSON_EXTRACT(
    '{"name":"Alice","address":{"city":"Delhi"}}',
    '$.address.city'
);
```

---

# 18. Accessing Array Elements

Consider:

```json
{
    "skills": [
        "SQL",
        "Python",
        "Java"
    ]
}
```

JSON array indexes start at zero.

Therefore:

```text
$.skills[0]
```

returns:

```text
SQL
```

And:

```text
$.skills[1]
```

returns:

```text
Python
```

---

# 19. The -> Operator

MySQL provides a shorthand operator for JSON extraction.

Example:

```sql
SELECT attributes->'$.color'
FROM products;
```

This is shorthand for:

```sql
JSON_EXTRACT(attributes, '$.color')
```

---

# 20. The ->> Operator

The `->>` operator extracts a JSON value as an unquoted string.

Example:

```sql
SELECT attributes->>'$.color'
FROM products;
```

If the JSON contains:

```json
{
    "color": "black"
}
```

the result is:

```text
black
```

rather than:

```text
"black"
```

---

# 21. JSON_EXTRACT() vs ->>

Consider:

```sql
SELECT JSON_EXTRACT(
    '{"name":"Alice"}',
    '$.name'
);
```

The result represents a JSON string:

```text
"Alice"
```

Using:

```sql
SELECT
    '{"name":"Alice"}'->>'$.name';
```

returns:

```text
Alice
```

The distinction is important when JSON values are used in further SQL expressions.

---

# 22. JSON_UNQUOTE()

`JSON_UNQUOTE()` removes JSON string quoting.

Example:

```sql
SELECT JSON_UNQUOTE(
    JSON_EXTRACT(
        '{"name":"Alice"}',
        '$.name'
    )
);
```

Result:

```text
Alice
```

This is conceptually similar to using `->>`.

---

# 23. JSON_VALUE()

`JSON_VALUE()` extracts a scalar value from JSON.

Example:

```sql
SELECT JSON_VALUE(
    '{"name":"Alice","age":25}',
    '$.name'
);
```

It is useful when you want a scalar SQL value rather than a JSON document.

---

# 24. Searching JSON Data

JSON data can be filtered using JSON path expressions.

Example:

```sql
SELECT *
FROM products
WHERE attributes->>'$.color' = 'black';
```

This finds products whose JSON `color` attribute is `black`.

---

# 25. Filtering Numeric JSON Values

Suppose:

```json
{
    "ram": 16
}
```

You can filter using:

```sql
SELECT *
FROM products
WHERE CAST(
    attributes->>'$.ram'
    AS UNSIGNED
) >= 16;
```

Explicit conversion can make the intended data type clear.

---

# 26. JSON_CONTAINS()

`JSON_CONTAINS()` determines whether a JSON document contains a specified value or structure.

Example:

```sql
SELECT JSON_CONTAINS(
    '{"skills":["SQL","Python"]}',
    '"SQL"',
    '$.skills'
);
```

The result is:

```text
1
```

A result of `0` means the value was not found according to the specified containment rules.

---

# 27. JSON_CONTAINS() with Objects

Example:

```sql
SELECT JSON_CONTAINS(
    '{"color":"black","ram":16}',
    '{"color":"black"}'
);
```

This checks whether the target JSON contains the specified object structure.

---

# 28. JSON_CONTAINS_PATH()

`JSON_CONTAINS_PATH()` checks whether a specified path exists.

Example:

```sql
SELECT JSON_CONTAINS_PATH(
    '{"name":"Alice","age":25}',
    'one',
    '$.name'
);
```

The result is:

```text
1
```

---

# 29. one vs all

`JSON_CONTAINS_PATH()` accepts:

```text
one
all
```

For example:

```sql
SELECT JSON_CONTAINS_PATH(
    '{"name":"Alice","age":25}',
    'one',
    '$.name',
    '$.email'
);
```

`one` means at least one path must exist.

Using:

```sql
all
```

means every specified path must exist.

---

# 30. JSON_KEYS()

`JSON_KEYS()` returns the keys of a JSON object.

Example:

```sql
SELECT JSON_KEYS(
    '{"name":"Alice","age":25,"city":"Delhi"}'
);
```

Result:

```json
[
    "name",
    "age",
    "city"
]
```

---

# 31. JSON_LENGTH()

`JSON_LENGTH()` returns the number of elements in a JSON document or array.

Example:

```sql
SELECT JSON_LENGTH(
    '["SQL","Python","Java"]'
);
```

Result:

```text
3
```

It can also be used with a path.

---

# 32. JSON_TYPE()

`JSON_TYPE()` identifies the JSON type of a value.

Example:

```sql
SELECT JSON_TYPE('25');
```

Result:

```text
INTEGER
```

Another example:

```sql
SELECT JSON_TYPE('["SQL","Python"]');
```

Result:

```text
ARRAY
```

This is useful when working with flexible JSON structures.

---

# 33. JSON_VALID()

`JSON_VALID()` checks whether a value contains valid JSON.

Example:

```sql
SELECT JSON_VALID('{"name":"Alice"}');
```

Result:

```text
1
```

Invalid JSON:

```sql
SELECT JSON_VALID('{name: Alice}');
```

Result:

```text
0
```

---

# 34. JSON_SET()

`JSON_SET()` inserts or updates a value at a specified path.

Example:

```sql
SELECT JSON_SET(
    '{"name":"Alice","age":25}',
    '$.age',
    26
);
```

Result:

```json
{
    "name": "Alice",
    "age": 26
}
```

If the path does not exist, `JSON_SET()` can add it.

---

# 35. JSON_SET() with a New Property

Example:

```sql
SELECT JSON_SET(
    '{"name":"Alice"}',
    '$.city',
    'Delhi'
);
```

Result:

```json
{
    "name": "Alice",
    "city": "Delhi"
}
```

---

# 36. JSON_INSERT()

`JSON_INSERT()` inserts values only when the specified path does not already exist.

Example:

```sql
SELECT JSON_INSERT(
    '{"name":"Alice"}',
    '$.city',
    'Delhi'
);
```

The new property is added.

If `city` already exists, `JSON_INSERT()` does not overwrite it.

---

# 37. JSON_REPLACE()

`JSON_REPLACE()` updates an existing path.

Example:

```sql
SELECT JSON_REPLACE(
    '{"name":"Alice","age":25}',
    '$.age',
    26
);
```

If the path does not exist, it is not created.

---

# 38. JSON_SET vs JSON_INSERT vs JSON_REPLACE

| Function         | Existing Path   | Missing Path    |
| ---------------- | --------------- | --------------- |
| `JSON_SET()`     | Updates         | Inserts         |
| `JSON_INSERT()`  | Does not update | Inserts         |
| `JSON_REPLACE()` | Updates         | Does not insert |

This distinction is important.

---

# 39. JSON_REMOVE()

`JSON_REMOVE()` removes a value at a specified path.

Example:

```sql
SELECT JSON_REMOVE(
    '{"name":"Alice","age":25,"city":"Delhi"}',
    '$.city'
);
```

Result:

```json
{
    "name": "Alice",
    "age": 25
}
```

---

# 40. Updating a JSON Column

Suppose a table contains:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    profile JSON
);
```

You can update a JSON property:

```sql
UPDATE customers
SET profile = JSON_SET(
    profile,
    '$.loyalty_level',
    'gold'
)
WHERE customer_id = 1;
```

Only the specified JSON property is changed.

---

# 41. Removing a JSON Property

Example:

```sql
UPDATE customers
SET profile = JSON_REMOVE(
    profile,
    '$.temporary_code'
)
WHERE customer_id = 1;
```

---

# 42. JSON_ARRAY_APPEND()

`JSON_ARRAY_APPEND()` adds values to an existing JSON array.

Example:

```sql
SELECT JSON_ARRAY_APPEND(
    '{"skills":["SQL","Python"]}',
    '$.skills',
    'Java'
);
```

Result:

```json
{
    "skills": [
        "SQL",
        "Python",
        "Java"
    ]
}
```

---

# 43. JSON_ARRAY_INSERT()

`JSON_ARRAY_INSERT()` inserts a value at a specified array position.

Example:

```sql
SELECT JSON_ARRAY_INSERT(
    '{"skills":["SQL","Java"]}',
    '$.skills[1]',
    'Python'
);
```

Result:

```json
{
    "skills": [
        "SQL",
        "Python",
        "Java"
    ]
}
```

---

# 44. JSON_MERGE_PATCH()

`JSON_MERGE_PATCH()` merges JSON objects using merge-patch semantics.

Example:

```sql
SELECT JSON_MERGE_PATCH(
    '{"name":"Alice","age":25}',
    '{"age":26,"city":"Delhi"}'
);
```

Result:

```json
{
    "name": "Alice",
    "age": 26,
    "city": "Delhi"
}
```

Values from the later document can replace existing values.

---

# 45. JSON_TABLE()

`JSON_TABLE()` is one of the most powerful MySQL JSON features.

It converts JSON data into relational rows and columns.

Example JSON:

```json
[
    {
        "id": 1,
        "name": "Alice"
    },
    {
        "id": 2,
        "name": "Bob"
    }
]
```

A simplified query:

```sql
SELECT *
FROM JSON_TABLE(
    '[
        {"id":1,"name":"Alice"},
        {"id":2,"name":"Bob"}
    ]',
    '$[*]'
    COLUMNS (
        id INT PATH '$.id',
        name VARCHAR(100) PATH '$.name'
    )
) AS jt;
```

The JSON array becomes a relational result set.

---

# 46. JSON_TABLE() Concept

Conceptually:

```text
JSON document
     ↓
JSON_TABLE()
     ↓
Rows + Columns
```

This is extremely useful when importing or analyzing JSON data.

---

# 47. JSON_TABLE() with Nested Arrays

Suppose JSON contains:

```json
{
    "customer": "Alice",
    "orders": [
        {
            "order_id": 101,
            "amount": 500
        },
        {
            "order_id": 102,
            "amount": 700
        }
    ]
}
```

`JSON_TABLE()` can transform nested JSON structures into relational rows.

This is particularly useful when processing API responses or semi-structured data.

---

# 48. JSON_TABLE() with a Table Column

`JSON_TABLE()` can operate on JSON stored in a table.

Conceptually:

```sql
SELECT
    c.customer_id,
    jt.order_id,
    jt.amount
FROM customers AS c
JOIN JSON_TABLE(
    c.orders,
    '$[*]'
    COLUMNS (
        order_id INT PATH '$.order_id',
        amount DECIMAL(10,2) PATH '$.amount'
    )
) AS jt;
```

This allows JSON data to participate in relational queries.

---

# 49. JSON and Generated Columns

A JSON property can be exposed through a generated column.

Example:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    attributes JSON,
    color VARCHAR(50)
        GENERATED ALWAYS AS (
            attributes->>'$.color'
        ) STORED
);
```

Now `color` can be queried like a regular column.

---

# 50. Why Generated Columns Are Useful

Suppose you frequently run:

```sql
SELECT *
FROM products
WHERE attributes->>'$.color' = 'black';
```

You may instead expose the frequently queried property as a generated column and index it.

This can make repeated filtering more practical.

---

# 51. Indexing JSON Data

JSON columns themselves require careful indexing strategies.

A common approach is to index a generated column containing the JSON property that is frequently queried.

Example:

```sql
CREATE INDEX idx_products_color
ON products(color);
```

Then queries can use:

```sql
SELECT *
FROM products
WHERE color = 'black';
```

---

# 52. Functional Indexes and JSON Expressions

MySQL also supports indexes based on expressions in appropriate versions and configurations.

For JSON workloads, generated columns are a commonly used and explicit strategy.

The key principle is:

> Index the JSON attributes that are frequently used for filtering, joining, or sorting rather than attempting to index every possible JSON property.

---

# 53. JSON and Query Performance

JSON can make data flexible, but flexibility can come with trade-offs.

Potential issues include:

* Complex extraction expressions
* Repeated parsing/extraction work
* Difficult indexing
* Large JSON documents
* Poorly designed JSON structures
* Complicated queries
* Reduced relational transparency

Always measure performance for important workloads.

---

# 54. JSON vs Normalized Tables

Consider storing product categories.

A JSON approach might be:

```json
{
    "categories": [
        "electronics",
        "laptops"
    ]
}
```

A relational design might use:

```text
products
categories
product_categories
```

The relational approach is often better when categories need:

* Foreign keys
* Referential integrity
* Independent attributes
* Frequent joins
* Complex filtering
* Many-to-many relationships

This connects directly to **Module 27: Database Design & Normalization**.

---

# 55. When JSON Is a Good Choice

JSON is often appropriate for:

* Flexible metadata
* Optional attributes
* Configuration data
* API payloads
* External service responses
* Semi-structured information
* Event metadata
* Product specifications that vary significantly

---

# 56. When JSON Is a Poor Choice

Avoid putting important relational entities into JSON simply to avoid designing tables.

For example, storing:

```json
{
    "customer_id": 10,
    "product_id": 20,
    "quantity": 3
}
```

inside an order record may be a poor design if these values participate heavily in:

* Joins
* Foreign keys
* Aggregations
* Constraints
* Reporting

A normalized relational structure is generally more appropriate.

---

# 57. JSON and Referential Integrity

JSON values do not automatically provide the same referential-integrity guarantees as relational foreign keys.

For example:

```json
{
    "department_id": 10
}
```

does not automatically create a foreign-key relationship with:

```text
departments.department_id
```

If relational integrity is important, a normal foreign-key column is usually preferable.

---

# 58. JSON and Constraints

Relational columns can use constraints such as:

```sql
PRIMARY KEY
FOREIGN KEY
UNIQUE
NOT NULL
CHECK
```

JSON documents are more flexible but may require additional validation logic.

Do not use JSON merely to avoid defining appropriate constraints.

---

# 59. JSON Schema Considerations

JSON itself is flexible, but application requirements may still require a consistent structure.

For example, product metadata might be expected to contain:

```json
{
    "color": "...",
    "weight": "...",
    "brand": "..."
}
```

If different rows contain completely different structures, queries and maintenance can become difficult.

A practical JSON design should therefore establish expected structures even when the database does not enforce every detail.

---

# 60. JSON and NULL

There is an important distinction between SQL `NULL` and JSON `null`.

SQL `NULL` means:

```text
The SQL column has no value.
```

JSON `null` is a value inside a JSON document:

```json
{
    "middle_name": null
}
```

These should not be treated as identical concepts.

---

# 61. JSON String vs JSON Number

These are different:

```json
{
    "age": 25
}
```

and:

```json
{
    "age": "25"
}
```

The first contains a JSON number.

The second contains a JSON string.

This difference can affect comparisons and calculations.

Always maintain consistent JSON types when designing a JSON structure.

---

# 62. Boolean Values

JSON supports:

```json
true
```

and:

```json
false
```

Example:

```json
{
    "active": true
}
```

When extracting JSON values, be aware of the difference between JSON values and SQL representations.

---

# 63. JSON Null vs Missing Property

These are also different:

```json
{
    "phone": null
}
```

versus:

```json
{
    "name": "Alice"
}
```

In the first case, the property exists and has a JSON `null` value.

In the second case, the property does not exist.

This distinction can matter when validating or filtering JSON documents.

---

# 64. JSON Path Wildcards

JSON paths can use wildcards.

For example:

```text
$.* 
```

can refer to object members.

Array wildcard syntax includes:

```text
$[*]
```

which refers to array elements.

These are especially useful with functions such as `JSON_EXTRACT()` and `JSON_TABLE()`.

---

# 65. Recursive JSON Structures

JSON can contain deeply nested objects and arrays.

For example:

```json
{
    "company": {
        "address": {
            "location": {
                "city": "Delhi"
            }
        }
    }
}
```

The path becomes:

```text
$.company.address.location.city
```

Deep nesting should be used carefully.

Excessively nested JSON can become difficult to query and maintain.

---

# 66. JSON Aggregation

JSON aggregation can be combined with normal SQL grouping.

Example:

```sql
SELECT
    department_id,
    JSON_ARRAYAGG(employee_name) AS employees
FROM employees
GROUP BY department_id;
```

This creates one JSON array per department.

Example result:

```text
department_id | employees
--------------+----------------------------
10            | ["Alice","Bob","Charlie"]
20            | ["David","Emma"]
```

---

# 67. JSON_OBJECTAGG() with GROUP BY

Example:

```sql
SELECT
    department_id,
    JSON_OBJECTAGG(
        employee_id,
        employee_name
    ) AS employees
FROM employees
GROUP BY department_id;
```

This produces a JSON object for each department.

---

# 68. JSON with CTEs

JSON can be combined with CTEs.

Example:

```sql
WITH customer_data AS (
    SELECT
        customer_id,
        profile->>'$.city' AS city
    FROM customers
)
SELECT
    city,
    COUNT(*) AS customer_count
FROM customer_data
GROUP BY city;
```

This demonstrates how JSON extraction can become part of a larger relational query.

---

# 69. JSON with Window Functions

JSON extraction can also be used with window functions.

Example:

```sql
SELECT
    customer_id,
    profile->>'$.city' AS city,
    COUNT(*) OVER (
        PARTITION BY profile->>'$.city'
    ) AS customers_in_city
FROM customers;
```

This combines concepts from earlier modules.

---

# 70. JSON with JOINs

Extracted JSON values can sometimes participate in joins.

For example:

```sql
SELECT
    c.customer_id,
    d.department_name
FROM customers AS c
JOIN departments AS d
    ON CAST(
        c.profile->>'$.department_id'
        AS UNSIGNED
    ) = d.department_id;
```

However, if such joins are common, storing `department_id` as a proper relational foreign key is generally preferable.

---

# 71. JSON with CASE

JSON values can be used in conditional expressions.

Example:

```sql
SELECT
    customer_id,
    CASE
        WHEN profile->>'$.membership' = 'gold'
            THEN 'Premium'
        WHEN profile->>'$.membership' = 'silver'
            THEN 'Standard'
        ELSE 'Basic'
    END AS customer_category
FROM customers;
```

---

# 72. JSON Data Extraction Workflow

A practical workflow is:

```text
JSON column
     ↓
Identify path
     ↓
Extract value
     ↓
Convert data type if needed
     ↓
Filter / calculate / aggregate
     ↓
Index frequently used attributes
```

For example:

```sql
SELECT
    CAST(
        attributes->>'$.price'
        AS DECIMAL(10,2)
    ) AS price
FROM products;
```

---

# 73. JSON Data Modification Workflow

For updates:

```text
JSON column
     ↓
Identify path
     ↓
Choose operation
     ↓
JSON_SET / JSON_INSERT / JSON_REPLACE
     ↓
UPDATE
```

Choose the function according to the desired behavior.

---

# 74. Choosing JSON Modification Functions

Use:

```text
JSON_SET()
```

when you want:

```text
insert OR update
```

Use:

```text
JSON_INSERT()
```

when you want:

```text
insert only
```

Use:

```text
JSON_REPLACE()
```

when you want:

```text
update only
```

Use:

```text
JSON_REMOVE()
```

when you want:

```text
delete a property
```

---

# 75. JSON_TABLE() vs JSON_EXTRACT()

Use `JSON_EXTRACT()` when you need to retrieve specific values.

Example:

```sql
SELECT attributes->>'$.color'
FROM products;
```

Use `JSON_TABLE()` when you need to transform structured JSON into relational rows and columns.

Example concept:

```text
JSON array
    ↓
multiple rows
    ↓
multiple relational columns
```

---

# 76. JSON and API Data

A common real-world use case is storing data received from an external API.

For example:

```json
{
    "status": "success",
    "source": "external_api",
    "metadata": {
        "request_id": "ABC123"
    },
    "data": {
        "temperature": 28,
        "humidity": 70
    }
}
```

A system may store the original payload in a JSON column while extracting important values into relational columns when needed.

This can provide both flexibility and queryability.

---

# 77. Hybrid Relational + JSON Design

A practical table might look like:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT NOT NULL,
    attributes JSON
);
```

Core business fields remain relational.

Flexible product-specific attributes are stored in JSON.

This is often a better design than placing everything into JSON.

---

# 78. JSON Audit Data

JSON is also useful for audit metadata.

For example:

```json
{
    "changed_by": "admin",
    "source": "web",
    "reason": "price update"
}
```

An audit table could contain:

```text
audit_id
entity_id
action
changed_at
metadata JSON
```

This allows additional audit information to vary without continually changing the table schema.

---

# 79. JSON and Logging

JSON is commonly used for structured logs.

Example:

```json
{
    "event": "login",
    "user_id": 1001,
    "ip": "192.168.1.10",
    "success": true
}
```

Structured JSON logs are easier for applications and analytics systems to process than arbitrary text.

---

# 80. JSON Storage Design Guidelines

When using JSON:

1. Keep frequently queried core fields relational.
2. Use JSON for genuinely flexible attributes.
3. Maintain a predictable JSON structure.
4. Avoid unnecessary nesting.
5. Keep JSON documents reasonably sized.
6. Use appropriate data types.
7. Validate important structures.
8. Index frequently queried attributes.
9. Avoid storing relational entities inside JSON unnecessarily.
10. Consider future query requirements before choosing JSON.

---

# 81. Common JSON Mistake: Storing Everything as JSON

This is usually poor design:

```json
{
    "customer_id": 1,
    "name": "Alice",
    "email": "alice@example.com",
    "department_id": 10,
    "salary": 50000
}
```

If every query needs to extract these fields, a relational table would generally be more appropriate.

Use JSON because the data is genuinely semi-structured, not simply because JSON is convenient.

---

# 82. Common JSON Mistake: Inconsistent Types

Avoid:

```json
{
    "age": 25
}
```

in one row and:

```json
{
    "age": "25"
}
```

in another.

Inconsistent types make queries and comparisons harder.

---

# 83. Common JSON Mistake: Deep Nesting

Avoid unnecessarily deep structures such as:

```json
{
    "customer": {
        "profile": {
            "contact": {
                "address": {
                    "location": {
                        "city": "Delhi"
                    }
                }
            }
        }
    }
}
```

If the city is frequently queried, a normal relational column may be much easier to work with.

---

# 84. Common JSON Mistake: Ignoring Indexing

A query such as:

```sql
WHERE attributes->>'$.color' = 'black'
```

may become expensive at scale if the expression cannot be efficiently indexed.

For heavily queried JSON attributes, consider generated columns and appropriate indexes.

---

# 85. Common JSON Mistake: Treating JSON as a Replacement for Foreign Keys

This:

```json
{
    "department_id": 10
}
```

does not provide the same integrity guarantees as:

```sql
department_id INT,
FOREIGN KEY (department_id)
REFERENCES departments(department_id)
```

Use relational constraints when relationships are important.

---

# 86. Common JSON Mistake: Ignoring NULL and Missing Paths

These situations are different:

```json
{
    "phone": null
}
```

and:

```json
{
    "name": "Alice"
}
```

Applications should decide whether a missing property and an explicit `null` value have different meanings.

---

# 87. Common JSON Mistake: Repeated Extraction

If a query repeatedly extracts the same JSON property:

```sql
attributes->>'$.category'
```

consider whether that property should instead be represented as a relational column or generated column.

Repeated extraction can make SQL harder to read and potentially less efficient.

---

# 88. JSON Security Considerations

JSON does not eliminate SQL security concerns.

Always use parameterized queries in application code.

Do not construct SQL by directly concatenating untrusted JSON values into SQL statements.

Also consider:

* Sensitive data
* Access controls
* Data validation
* Logging
* Data retention
* Encryption requirements

---

# 89. JSON and Transactions

JSON modifications are still part of normal SQL transaction behavior.

For example:

```sql
START TRANSACTION;

UPDATE customers
SET profile = JSON_SET(
    profile,
    '$.status',
    'active'
)
WHERE customer_id = 1;

COMMIT;
```

If the transaction is rolled back, the JSON update is rolled back along with other transactional changes.

This connects to **Module 23: Transactions**.

---

# 90. JSON and Triggers

JSON columns can also be used in trigger logic.

For example, a trigger could record JSON metadata describing a change.

Conceptually:

```text
Data modification
       ↓
Trigger
       ↓
Audit record
       ↓
JSON metadata
```

This connects JSON with the trigger concepts covered earlier.

---

# 91. JSON and Stored Procedures

Stored procedures can accept and manipulate JSON data.

For example, a procedure could receive a JSON document containing product attributes and update a product record.

This allows database-side processing of structured application input.

This connects JSON with **Module 22: Stored Procedures**.

---

# 92. JSON and Database Design

The most important design question is not:

> "Can this data be stored as JSON?"

The answer is often yes.

The better question is:

> "Should this data be stored as JSON?"

Consider:

```text
How often is it queried?
How often is it updated?
Does it have relationships?
Does it need foreign keys?
Does it need constraints?
Is its structure predictable?
Will it be indexed?
Will it be aggregated frequently?
```

These questions help determine whether JSON or relational columns are appropriate.

---

# 93. JSON Design Decision Matrix

| Requirement          | Relational Column | JSON              |
| -------------------- | ----------------- | ----------------- |
| Fixed structure      | Excellent         | Possible          |
| Strong foreign keys  | Excellent         | Poor              |
| Frequent joins       | Excellent         | Usually poor      |
| Flexible attributes  | Less flexible     | Excellent         |
| Variable structure   | Difficult         | Excellent         |
| Frequent aggregation | Excellent         | Can be harder     |
| Simple indexing      | Excellent         | Requires planning |
| API payload storage  | Possible          | Excellent         |
| Strict constraints   | Excellent         | More difficult    |

---

# 94. Practical JSON Architecture

A common architecture is:

```text
                 Application
                      │
                      ▼
              MySQL Database
                      │
          ┌───────────┴───────────┐
          │                       │
     Relational Columns        JSON
          │                       │
 Core business data        Flexible metadata
          │                       │
          └───────────┬───────────┘
                      │
                      ▼
                   Queries
```

This hybrid approach often provides a useful balance.

---

# 95. JSON Querying Checklist

When querying JSON, ask:

* What is the JSON path?
* Is the value an object, array, string, number, or boolean?
* Should I use `JSON_EXTRACT()` or `->>`?
* Do I need type conversion?
* Is the path missing in some rows?
* Could the value be JSON `null`?
* Is the property frequently queried?
* Should it have a generated column?
* Should it be indexed?

---

# 96. JSON Modification Checklist

Before updating JSON:

* Identify the exact path.
* Decide whether to insert, replace, or upsert.
* Choose between `JSON_SET()`, `JSON_INSERT()`, and `JSON_REPLACE()`.
* Consider whether the property already exists.
* Consider JSON type consistency.
* Test the resulting document.
* Use a transaction when multiple related changes must succeed together.

---

# 97. JSON Performance Checklist

For production JSON workloads:

* Avoid unnecessarily large documents.
* Avoid unnecessary nesting.
* Filter relational columns before expensive JSON processing when possible.
* Extract frequently queried attributes into generated columns where appropriate.
* Add indexes for important access patterns.
* Avoid indexing every JSON attribute.
* Inspect execution plans.
* Benchmark important queries with realistic data volumes.

---

# 98. Important JSON Functions

| Function               | Purpose                                    |
| ---------------------- | ------------------------------------------ |
| `JSON_OBJECT()`        | Create JSON object                         |
| `JSON_ARRAY()`         | Create JSON array                          |
| `JSON_OBJECTAGG()`     | Aggregate key-value pairs into JSON object |
| `JSON_ARRAYAGG()`      | Aggregate values into JSON array           |
| `JSON_EXTRACT()`       | Extract JSON data                          |
| `JSON_VALUE()`         | Extract scalar value                       |
| `JSON_UNQUOTE()`       | Remove JSON string quoting                 |
| `JSON_SET()`           | Insert or update                           |
| `JSON_INSERT()`        | Insert only                                |
| `JSON_REPLACE()`       | Replace existing value                     |
| `JSON_REMOVE()`        | Remove value                               |
| `JSON_CONTAINS()`      | Test containment                           |
| `JSON_CONTAINS_PATH()` | Test path existence                        |
| `JSON_KEYS()`          | Return object keys                         |
| `JSON_LENGTH()`        | Return JSON length                         |
| `JSON_TYPE()`          | Return JSON type                           |
| `JSON_VALID()`         | Validate JSON                              |
| `JSON_ARRAY_APPEND()`  | Append to array                            |
| `JSON_ARRAY_INSERT()`  | Insert into array                          |
| `JSON_MERGE_PATCH()`   | Merge JSON objects                         |
| `JSON_TABLE()`         | Convert JSON into relational rows          |

---

# 99. Key Takeaways

Remember these core principles:

1. MySQL 8.0+ supports a native `JSON` data type.
2. JSON is useful for semi-structured and flexible data.
3. JSON does not replace relational database design.
4. Use `JSON_OBJECT()` and `JSON_ARRAY()` to construct JSON.
5. Use `JSON_EXTRACT()`, `->`, and `->>` to retrieve values.
6. JSON paths begin with `$`.
7. Array indexes begin at zero.
8. `JSON_SET()` can insert or update.
9. `JSON_INSERT()` inserts only when the path does not exist.
10. `JSON_REPLACE()` updates only existing paths.
11. `JSON_REMOVE()` deletes JSON values.
12. `JSON_CONTAINS()` helps search JSON structures.
13. `JSON_CONTAINS_PATH()` checks whether paths exist.
14. `JSON_TABLE()` converts JSON into relational rows and columns.
15. JSON arrays and objects can be aggregated using JSON aggregation functions.
16. Generated columns can expose frequently queried JSON attributes.
17. Frequently queried JSON properties may benefit from indexing.
18. SQL `NULL` and JSON `null` are different concepts.
19. Missing JSON properties and explicit JSON `null` values are different.
20. Consistent JSON data types make querying easier.
21. Avoid unnecessary JSON nesting.
22. Avoid putting core relational entities into JSON merely for convenience.
23. JSON can work alongside CTEs, window functions, stored procedures, transactions, and triggers.
24. Hybrid relational + JSON designs are often practical.
25. Always choose JSON based on data characteristics and query requirements, not simply convenience.

---

# 100. Module 28 Learning Objectives

After completing this module, you should be able to:

* Explain what JSON is.
* Explain when JSON is appropriate in MySQL.
* Create tables containing JSON columns.
* Insert JSON objects and arrays.
* Understand JSON data types.
* Understand JSON paths.
* Extract JSON values.
* Use `->` and `->>`.
* Use `JSON_EXTRACT()`.
* Use `JSON_VALUE()`.
* Use `JSON_UNQUOTE()`.
* Search JSON documents.
* Use `JSON_CONTAINS()`.
* Use `JSON_CONTAINS_PATH()`.
* Check JSON structure and types.
* Use `JSON_VALID()`.
* Modify JSON documents.
* Use `JSON_SET()`.
* Use `JSON_INSERT()`.
* Use `JSON_REPLACE()`.
* Use `JSON_REMOVE()`.
* Modify JSON arrays.
* Aggregate relational data into JSON.
* Use `JSON_OBJECTAGG()`.
* Use `JSON_ARRAYAGG()`.
* Convert JSON into relational data using `JSON_TABLE()`.
* Use JSON with CTEs and other SQL features.
* Understand JSON indexing strategies.
* Use generated columns with JSON.
* Evaluate JSON vs normalized relational design.
* Identify common JSON design mistakes.
* Design practical hybrid relational/JSON schemas.

---

# 101. Final Mental Model

Think about JSON in MySQL as an additional tool rather than a replacement for relational SQL.

```text
                    MySQL
                      │
          ┌───────────┴───────────┐
          │                       │
     Relational Data          JSON Data
          │                       │
     Fixed structure        Flexible structure
          │                       │
     Foreign keys            Metadata
     Constraints             API payloads
     Joins                   Optional attributes
     Aggregation             Semi-structured data
          │                       │
          └───────────┬───────────┘
                      │
                      ▼
               Hybrid Design
```

The goal is not to choose JSON everywhere.

The goal is to understand **where JSON adds flexibility without sacrificing good database design**.

The key question should always be:

```text
Can this data be stored as JSON?
        ↓
Usually yes.
        ↓
Should it be stored as JSON?
        ↓
Consider structure, relationships,
constraints, queries, indexing,
performance, and maintainability.
```

A strong SQL developer should be comfortable working with both relational and semi-structured data.

```
```
