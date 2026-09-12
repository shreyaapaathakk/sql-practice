-- ============================================================
-- Module 28: JSON Data in MySQL
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

-- ============================================================
-- 1. Create Database
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice_json;

USE sql_practice_json;


-- ============================================================
-- 2. Basic JSON Table
-- ============================================================

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    attributes JSON
);


-- ============================================================
-- 3. Insert JSON Objects
-- ============================================================

INSERT INTO products (
    product_id,
    product_name,
    price,
    attributes
)
VALUES
(
    1,
    'Laptop',
    75000.00,
    '{"brand":"Dell","color":"black","ram":16,"storage":512}'
),
(
    2,
    'Smartphone',
    45000.00,
    '{"brand":"Samsung","color":"blue","ram":8,"storage":256}'
),
(
    3,
    'Tablet',
    30000.00,
    '{"brand":"Apple","color":"silver","ram":8,"storage":128}'
),
(
    4,
    'Monitor',
    22000.00,
    '{"brand":"LG","color":"black","size":27,"resolution":"4K"}'
);


-- ============================================================
-- 4. Display JSON Data
-- ============================================================

SELECT
    product_id,
    product_name,
    attributes
FROM products;


-- ============================================================
-- 5. JSON_OBJECT()
-- ============================================================

SELECT JSON_OBJECT(
    'name', 'Alice',
    'age', 25,
    'city', 'Delhi'
) AS person;


-- ============================================================
-- 6. JSON_ARRAY()
-- ============================================================

SELECT JSON_ARRAY(
    'SQL',
    'Python',
    'Java'
) AS skills;


-- ============================================================
-- 7. JSON_OBJECT() from Table Columns
-- ============================================================

SELECT
    product_id,
    JSON_OBJECT(
        'name', product_name,
        'price', price
    ) AS product_json
FROM products;


-- ============================================================
-- 8. JSON_ARRAY() from Table Columns
-- ============================================================

SELECT
    product_id,
    JSON_ARRAY(
        product_name,
        price
    ) AS product_array
FROM products;


-- ============================================================
-- 9. JSON_EXTRACT()
-- ============================================================

SELECT
    product_name,
    JSON_EXTRACT(
        attributes,
        '$.brand'
    ) AS brand
FROM products;


-- ============================================================
-- 10. JSON Path for Nested Data
-- ============================================================

SELECT JSON_EXTRACT(
    '{
        "name":"Alice",
        "address":{
            "city":"Delhi",
            "country":"India"
        }
    }',
    '$.address.city'
) AS city;


-- ============================================================
-- 11. Array Access
-- ============================================================

SELECT JSON_EXTRACT(
    '{
        "skills":["SQL","Python","Java"]
    }',
    '$.skills[0]'
) AS first_skill;


SELECT JSON_EXTRACT(
    '{
        "skills":["SQL","Python","Java"]
    }',
    '$.skills[1]'
) AS second_skill;


-- ============================================================
-- 12. -> Operator
-- ============================================================

SELECT
    product_name,
    attributes->'$.brand' AS brand
FROM products;


-- ============================================================
-- 13. ->> Operator
-- ============================================================

SELECT
    product_name,
    attributes->>'$.brand' AS brand
FROM products;


-- ============================================================
-- 14. JSON_UNQUOTE()
-- ============================================================

SELECT
    JSON_UNQUOTE(
        JSON_EXTRACT(
            '{"name":"Alice"}',
            '$.name'
        )
    ) AS name;


-- ============================================================
-- 15. JSON_VALUE()
-- ============================================================

SELECT
    JSON_VALUE(
        '{"name":"Alice","age":25}',
        '$.name'
    ) AS name,
    JSON_VALUE(
        '{"name":"Alice","age":25}',
        '$.age'
    ) AS age;


-- ============================================================
-- 16. Extract Numeric JSON Values
-- ============================================================

SELECT
    product_name,
    attributes->>'$.ram' AS ram
FROM products;


-- ============================================================
-- 17. Cast Extracted JSON Values
-- ============================================================

SELECT
    product_name,
    CAST(
        attributes->>'$.ram'
        AS UNSIGNED
    ) AS ram
FROM products;


-- ============================================================
-- 18. Filter by JSON Value
-- ============================================================

SELECT
    product_id,
    product_name,
    attributes
FROM products
WHERE attributes->>'$.color' = 'black';


-- ============================================================
-- 19. Filter by Numeric JSON Value
-- ============================================================

SELECT
    product_id,
    product_name,
    attributes->>'$.ram' AS ram
FROM products
WHERE CAST(
    attributes->>'$.ram'
    AS UNSIGNED
) >= 8;


-- ============================================================
-- 20. JSON_CONTAINS_PATH()
-- ============================================================

SELECT
    product_name,
    JSON_CONTAINS_PATH(
        attributes,
        'one',
        '$.brand'
    ) AS has_brand
FROM products;


-- ============================================================
-- 21. JSON_CONTAINS_PATH() with ALL
-- ============================================================

SELECT
    product_name,
    JSON_CONTAINS_PATH(
        attributes,
        'all',
        '$.brand',
        '$.color'
    ) AS has_brand_and_color
FROM products;


-- ============================================================
-- 22. JSON_CONTAINS()
-- ============================================================

SELECT
    JSON_CONTAINS(
        '{"skills":["SQL","Python","Java"]}',
        '"SQL"',
        '$.skills'
    ) AS contains_sql;


-- ============================================================
-- 23. JSON_CONTAINS() with Object
-- ============================================================

SELECT
    JSON_CONTAINS(
        '{"brand":"Dell","ram":16,"storage":512}',
        '{"brand":"Dell"}'
    ) AS contains_brand;


-- ============================================================
-- 24. JSON_KEYS()
-- ============================================================

SELECT
    product_name,
    JSON_KEYS(attributes) AS attribute_names
FROM products;


-- ============================================================
-- 25. JSON_LENGTH()
-- ============================================================

SELECT
    JSON_LENGTH(
        '["SQL","Python","Java"]'
    ) AS skill_count;


-- ============================================================
-- 26. JSON_TYPE()
-- ============================================================

SELECT
    JSON_TYPE('25') AS number_type,
    JSON_TYPE('"Alice"') AS string_type,
    JSON_TYPE('true') AS boolean_type,
    JSON_TYPE('[]') AS array_type,
    JSON_TYPE('{}') AS object_type;


-- ============================================================
-- 27. JSON_VALID()
-- ============================================================

SELECT
    JSON_VALID('{"name":"Alice"}') AS valid_json,
    JSON_VALID('{name: Alice}') AS invalid_json;


-- ============================================================
-- 28. JSON_SET()
-- ============================================================

SELECT JSON_SET(
    '{"name":"Alice","age":25}',
    '$.age',
    26
) AS updated_json;


-- ============================================================
-- 29. JSON_SET() Adding a Property
-- ============================================================

SELECT JSON_SET(
    '{"name":"Alice"}',
    '$.city',
    'Delhi'
) AS updated_json;


-- ============================================================
-- 30. JSON_INSERT()
-- ============================================================

SELECT JSON_INSERT(
    '{"name":"Alice"}',
    '$.city',
    'Delhi'
) AS inserted_json;


-- ============================================================
-- 31. JSON_INSERT() Does Not Replace Existing Values
-- ============================================================

SELECT JSON_INSERT(
    '{"name":"Alice","age":25}',
    '$.age',
    30
) AS unchanged_json;


-- ============================================================
-- 32. JSON_REPLACE()
-- ============================================================

SELECT JSON_REPLACE(
    '{"name":"Alice","age":25}',
    '$.age',
    30
) AS replaced_json;


-- ============================================================
-- 33. JSON_REPLACE() Does Not Add Missing Paths
-- ============================================================

SELECT JSON_REPLACE(
    '{"name":"Alice"}',
    '$.city',
    'Delhi'
) AS unchanged_json;


-- ============================================================
-- 34. JSON_REMOVE()
-- ============================================================

SELECT JSON_REMOVE(
    '{"name":"Alice","age":25,"city":"Delhi"}',
    '$.city'
) AS removed_json;


-- ============================================================
-- 35. Update JSON Data in a Table
-- ============================================================

UPDATE products
SET attributes = JSON_SET(
    attributes,
    '$.warranty_years',
    2
)
WHERE product_id = 1;


SELECT *
FROM products
WHERE product_id = 1;


-- ============================================================
-- 36. Update Existing JSON Property
-- ============================================================

UPDATE products
SET attributes = JSON_SET(
    attributes,
    '$.color',
    'red'
)
WHERE product_id = 1;


SELECT
    product_name,
    attributes->>'$.color' AS color
FROM products
WHERE product_id = 1;


-- ============================================================
-- 37. Remove JSON Property
-- ============================================================

UPDATE products
SET attributes = JSON_REMOVE(
    attributes,
    '$.warranty_years'
)
WHERE product_id = 1;


-- ============================================================
-- 38. JSON_ARRAY_APPEND()
-- ============================================================

SELECT JSON_ARRAY_APPEND(
    '{"skills":["SQL","Python"]}',
    '$.skills',
    'Java'
) AS updated_json;


-- ============================================================
-- 39. JSON_ARRAY_INSERT()
-- ============================================================

SELECT JSON_ARRAY_INSERT(
    '{"skills":["SQL","Java"]}',
    '$.skills[1]',
    'Python'
) AS updated_json;


-- ============================================================
-- 40. JSON_MERGE_PATCH()
-- ============================================================

SELECT JSON_MERGE_PATCH(
    '{"name":"Alice","age":25}',
    '{"age":26,"city":"Delhi"}'
) AS merged_json;


-- ============================================================
-- 41. JSON_ARRAYAGG()
-- ============================================================

SELECT JSON_ARRAYAGG(product_name)
FROM products;


-- ============================================================
-- 42. JSON_ARRAYAGG() with GROUP BY
-- ============================================================

DROP TABLE IF EXISTS product_categories;

CREATE TABLE product_categories (
    product_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

INSERT INTO product_categories (
    product_id,
    category_name
)
VALUES
(1, 'Computers'),
(2, 'Mobile'),
(3, 'Mobile'),
(4, 'Computers');


SELECT
    category_name,
    JSON_ARRAYAGG(product_id) AS product_ids
FROM product_categories
GROUP BY category_name;


-- ============================================================
-- 43. JSON_OBJECTAGG()
-- ============================================================

SELECT JSON_OBJECTAGG(
    product_name,
    price
) AS product_prices
FROM products;


-- ============================================================
-- 44. JSON_OBJECTAGG() with GROUP BY
-- ============================================================

SELECT
    pc.category_name,
    JSON_OBJECTAGG(
        p.product_name,
        p.price
    ) AS products
FROM products AS p
JOIN product_categories AS pc
    ON p.product_id = pc.product_id
GROUP BY pc.category_name;


-- ============================================================
-- 45. JSON_TABLE() with JSON Array
-- ============================================================

SELECT *
FROM JSON_TABLE(
    '[
        {"id":1,"name":"Alice","age":25},
        {"id":2,"name":"Bob","age":30}
    ]',
    '$[*]'
    COLUMNS (
        id INT PATH '$.id',
        name VARCHAR(100) PATH '$.name',
        age INT PATH '$.age'
    )
) AS jt;


-- ============================================================
-- 46. JSON_TABLE() with Nested Data
-- ============================================================

SELECT *
FROM JSON_TABLE(
    '{
        "customer":"Alice",
        "orders":[
            {"order_id":101,"amount":500},
            {"order_id":102,"amount":700}
        ]
    }',
    '$'
    COLUMNS (
        customer VARCHAR(100) PATH '$.customer',
        NESTED PATH '$.orders[*]'
        COLUMNS (
            order_id INT PATH '$.order_id',
            amount DECIMAL(10,2) PATH '$.amount'
        )
    )
) AS jt;


-- ============================================================
-- 47. JSON_TABLE() with a Table Column
-- ============================================================

DROP TABLE IF EXISTS customer_orders;

CREATE TABLE customer_orders (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    orders JSON
);

INSERT INTO customer_orders (
    customer_id,
    customer_name,
    orders
)
VALUES
(
    1,
    'Alice',
    '[
        {"order_id":101,"amount":500},
        {"order_id":102,"amount":700}
    ]'
),
(
    2,
    'Bob',
    '[
        {"order_id":103,"amount":900}
    ]'
);


SELECT
    c.customer_id,
    c.customer_name,
    jt.order_id,
    jt.amount
FROM customer_orders AS c
JOIN JSON_TABLE(
    c.orders,
    '$[*]'
    COLUMNS (
        order_id INT PATH '$.order_id',
        amount DECIMAL(10,2) PATH '$.amount'
    )
) AS jt;


-- ============================================================
-- 48. Generated Column from JSON
-- ============================================================

DROP TABLE IF EXISTS products_generated;

CREATE TABLE products_generated (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    attributes JSON,

    color VARCHAR(50)
        GENERATED ALWAYS AS (
            attributes->>'$.color'
        ) STORED
);

INSERT INTO products_generated (
    product_id,
    product_name,
    attributes
)
VALUES
(
    1,
    'Laptop',
    '{"color":"black","ram":16}'
),
(
    2,
    'Phone',
    '{"color":"blue","ram":8}'
),
(
    3,
    'Monitor',
    '{"color":"black","size":27}'
);


SELECT
    product_id,
    product_name,
    color
FROM products_generated;


-- ============================================================
-- 49. Index Generated JSON Column
-- ============================================================

CREATE INDEX idx_products_generated_color
ON products_generated(color);


-- ============================================================
-- 50. Query Using Generated Column
-- ============================================================

SELECT
    product_id,
    product_name,
    color
FROM products_generated
WHERE color = 'black';


-- ============================================================
-- 51. Hybrid Relational + JSON Design
-- ============================================================

DROP TABLE IF EXISTS hybrid_products;

CREATE TABLE hybrid_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    attributes JSON
);

INSERT INTO hybrid_products (
    product_id,
    product_name,
    category_id,
    price,
    attributes
)
VALUES
(
    1,
    'Laptop',
    10,
    75000,
    '{"brand":"Dell","ram":16,"storage":512}'
),
(
    2,
    'Phone',
    20,
    45000,
    '{"brand":"Samsung","ram":8,"storage":256}'
);


SELECT
    product_id,
    product_name,
    category_id,
    price,
    attributes->>'$.brand' AS brand,
    attributes->>'$.ram' AS ram
FROM hybrid_products;


-- ============================================================
-- 52. JSON with CTE
-- ============================================================

WITH product_data AS (
    SELECT
        product_id,
        product_name,
        attributes->>'$.brand' AS brand
    FROM products
)
SELECT
    brand,
    COUNT(*) AS product_count
FROM product_data
GROUP BY brand;


-- ============================================================
-- 53. JSON with CASE
-- ============================================================

SELECT
    product_name,
    CASE
        WHEN CAST(
            attributes->>'$.ram'
            AS UNSIGNED
        ) >= 16
            THEN 'High RAM'
        WHEN CAST(
            attributes->>'$.ram'
            AS UNSIGNED
        ) >= 8
            THEN 'Medium RAM'
        ELSE 'Low RAM'
    END AS ram_category
FROM products
WHERE attributes->>'$.ram' IS NOT NULL;


-- ============================================================
-- 54. JSON with COALESCE
-- ============================================================

SELECT
    product_name,
    COALESCE(
        attributes->>'$.warranty_years',
        'Not specified'
    ) AS warranty
FROM products;


-- ============================================================
-- 55. JSON Missing Property
-- ============================================================

SELECT
    product_name,
    attributes->>'$.weight' AS weight
FROM products;


-- ============================================================
-- 56. JSON Null
-- ============================================================

SELECT JSON_EXTRACT(
    '{"name":"Alice","phone":null}',
    '$.phone'
) AS phone;


-- ============================================================
-- 57. Missing Property vs JSON Null
-- ============================================================

SELECT
    JSON_CONTAINS_PATH(
        '{"name":"Alice","phone":null}',
        'one',
        '$.phone'
    ) AS phone_exists,

    JSON_CONTAINS_PATH(
        '{"name":"Alice"}',
        'one',
        '$.phone'
    ) AS phone_missing;


-- ============================================================
-- 58. Percentage Based on JSON Numeric Data
-- ============================================================

SELECT
    product_name,
    price,
    CAST(
        attributes->>'$.ram'
        AS DECIMAL(10,2)
    ) AS ram
FROM products
WHERE attributes->>'$.ram' IS NOT NULL;


-- ============================================================
-- 59. JSON Data with Aggregation
-- ============================================================

SELECT
    attributes->>'$.brand' AS brand,
    COUNT(*) AS product_count,
    AVG(price) AS average_price
FROM products
GROUP BY attributes->>'$.brand';


-- ============================================================
-- 60. Inspect Table Structure
-- ============================================================

DESCRIBE products;

SHOW CREATE TABLE products;

SHOW INDEX FROM products_generated;
