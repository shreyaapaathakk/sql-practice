-- ============================================================
-- Module 28: JSON Data in MySQL
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice_json;

USE sql_practice_json;


-- ============================================================
-- Setup
-- ============================================================

DROP TABLE IF EXISTS practice_products;

CREATE TABLE practice_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    attributes JSON
);

INSERT INTO practice_products (
    product_id,
    product_name,
    category,
    price,
    attributes
)
VALUES
(
    1,
    'Laptop Pro',
    'Electronics',
    85000.00,
    '{"brand":"Dell","color":"black","ram":16,"storage":512,"wireless":true}'
),
(
    2,
    'Laptop Air',
    'Electronics',
    70000.00,
    '{"brand":"HP","color":"silver","ram":16,"storage":512,"wireless":true}'
),
(
    3,
    'Smartphone X',
    'Mobile',
    55000.00,
    '{"brand":"Samsung","color":"blue","ram":8,"storage":256,"wireless":true}'
),
(
    4,
    'Smartphone Y',
    'Mobile',
    35000.00,
    '{"brand":"OnePlus","color":"black","ram":8,"storage":128,"wireless":true}'
),
(
    5,
    'Tablet Pro',
    'Tablet',
    45000.00,
    '{"brand":"Apple","color":"silver","ram":8,"storage":256}'
),
(
    6,
    'Monitor 4K',
    'Electronics',
    30000.00,
    '{"brand":"LG","color":"black","size":27,"resolution":"4K"}'
),
(
    7,
    'Keyboard',
    'Accessories',
    5000.00,
    '{"brand":"Logitech","color":"black","wireless":true}'
),
(
    8,
    'Mouse',
    'Accessories',
    2500.00,
    '{"brand":"Logitech","color":"black","wireless":true}'
),
(
    9,
    'Smartwatch',
    'Wearables',
    18000.00,
    '{"brand":"Samsung","color":"black","storage":32,"waterproof":true}'
),
(
    10,
    'Headphones',
    'Accessories',
    12000.00,
    '{"brand":"Sony","color":"black","wireless":true,"noise_cancellation":true}'
);


-- ============================================================
-- Solutions 1-10
-- ============================================================

-- 1
SELECT
    product_id,
    product_name,
    attributes
FROM practice_products;


-- 2
SELECT
    product_name,
    attributes->>'$.brand' AS brand
FROM practice_products;


-- 3
SELECT
    product_name,
    attributes->>'$.color' AS color
FROM practice_products;


-- 4
SELECT
    product_name,
    attributes->>'$.ram' AS ram
FROM practice_products
WHERE JSON_CONTAINS_PATH(
    attributes,
    'one',
    '$.ram'
);


-- 5
SELECT
    product_name,
    attributes->>'$.storage' AS storage
FROM practice_products
WHERE JSON_CONTAINS_PATH(
    attributes,
    'one',
    '$.storage'
);


-- 6
SELECT
    product_name,
    attributes->>'$.wireless' AS wireless
FROM practice_products;


-- 7
SELECT
    product_name,
    JSON_OBJECT(
        'product_name', product_name,
        'price', price
    ) AS product_json
FROM practice_products;


-- 8
SELECT
    product_name,
    JSON_ARRAY(
        product_name,
        category
    ) AS product_array
FROM practice_products;


-- 9
SELECT JSON_EXTRACT(
    '["SQL","Python","Java"]',
    '$[0]'
) AS first_element;


-- 10
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
-- Solutions 11-20
-- ============================================================

-- 11
SELECT
    product_name,
    attributes->'$.brand' AS brand
FROM practice_products;


-- 12
SELECT
    product_name,
    attributes->>'$.brand' AS brand
FROM practice_products;


-- 13
SELECT
    product_name,
    JSON_EXTRACT(
        attributes,
        '$.color'
    ) AS color
FROM practice_products;


-- 14
SELECT
    product_name,
    JSON_UNQUOTE(
        JSON_EXTRACT(
            attributes,
            '$.brand'
        )
    ) AS brand
FROM practice_products;


-- 15
SELECT
    product_name,
    JSON_VALUE(
        attributes,
        '$.brand'
    ) AS brand
FROM practice_products;


-- 16
SELECT
    product_name,
    JSON_KEYS(attributes) AS json_keys
FROM practice_products;


-- 17
SELECT JSON_LENGTH(
    '["SQL","Python","Java","MySQL"]'
) AS element_count;


-- 18
SELECT JSON_TYPE('100') AS value_type;


-- 19
SELECT JSON_TYPE(
    '["SQL","Python"]'
) AS value_type;


-- 20
SELECT JSON_VALID(
    '{"name":"Alice"}'
) AS is_valid;


-- ============================================================
-- Solutions 21-30
-- ============================================================

-- 21
SELECT
    product_id,
    product_name
FROM practice_products
WHERE attributes->>'$.color' = 'black';


-- 22
SELECT
    product_id,
    product_name
FROM practice_products
WHERE attributes->>'$.brand' = 'Samsung';


-- 23
SELECT
    product_id,
    product_name,
    attributes->>'$.ram' AS ram
FROM practice_products
WHERE CAST(
    attributes->>'$.ram'
    AS UNSIGNED
) >= 16;


-- 24
SELECT
    product_id,
    product_name,
    attributes->>'$.storage' AS storage
FROM practice_products
WHERE CAST(
    attributes->>'$.storage'
    AS UNSIGNED
) >= 256;


-- 25
SELECT
    product_id,
    product_name
FROM practice_products
WHERE JSON_VALUE(
    attributes,
    '$.wireless'
) = 1;


-- 26
SELECT
    product_id,
    product_name
FROM practice_products
WHERE JSON_CONTAINS_PATH(
    attributes,
    'one',
    '$.brand'
);


-- 27
SELECT
    product_id,
    product_name
FROM practice_products
WHERE JSON_CONTAINS_PATH(
    attributes,
    'all',
    '$.brand',
    '$.color'
);


-- 28
SELECT
    product_id,
    product_name
FROM practice_products
WHERE JSON_CONTAINS_PATH(
    attributes,
    'one',
    '$.noise_cancellation'
);


-- 29
SELECT
    product_id,
    product_name
FROM practice_products
WHERE JSON_CONTAINS(
    attributes,
    '{"brand":"Logitech"}'
);


-- 30
SELECT
    product_id,
    product_name
FROM practice_products
WHERE JSON_CONTAINS(
    attributes,
    '"black"',
    '$.color'
);


-- ============================================================
-- Solutions 31-40
-- ============================================================

-- 31
UPDATE practice_products
SET attributes = JSON_SET(
    attributes,
    '$.warranty_years',
    2
)
WHERE product_id = 1;


-- 32
UPDATE practice_products
SET attributes = JSON_SET(
    attributes,
    '$.color',
    'gold'
)
WHERE product_id = 2;


-- 33
UPDATE practice_products
SET attributes = JSON_SET(
    attributes,
    '$.discount',
    10
)
WHERE product_id = 3;


-- 34
UPDATE practice_products
SET attributes = JSON_INSERT(
    attributes,
    '$.origin',
    'India'
)
WHERE product_id = 4;


-- 35
SELECT JSON_INSERT(
    attributes,
    '$.brand',
    'Changed Brand'
) AS result
FROM practice_products
WHERE product_id = 1;


-- 36
UPDATE practice_products
SET attributes = JSON_REPLACE(
    attributes,
    '$.brand',
    'Apple Inc.'
)
WHERE product_id = 5;


-- 37
SELECT JSON_REPLACE(
    attributes,
    '$.new_property',
    'test'
) AS result
FROM practice_products
WHERE product_id = 5;


-- 38
UPDATE practice_products
SET attributes = JSON_REMOVE(
    attributes,
    '$.wireless'
)
WHERE product_id = 1;


-- 39
UPDATE practice_products
SET attributes = JSON_REMOVE(
    attributes,
    '$.noise_cancellation'
)
WHERE product_id = 10;


-- 40
SELECT JSON_ARRAY_APPEND(
    '{"features":["Wireless","USB"]}',
    '$.features',
    'Bluetooth'
) AS updated_json;


-- ============================================================
-- Solutions 41-45
-- ============================================================

-- 41
SELECT JSON_ARRAYAGG(
    product_name
) AS product_names
FROM practice_products;


-- 42
SELECT JSON_ARRAYAGG(
    attributes->>'$.brand'
) AS brands
FROM practice_products;


-- 43
SELECT JSON_OBJECTAGG(
    product_name,
    price
) AS product_prices
FROM practice_products;


-- 44
SELECT
    category,
    JSON_ARRAYAGG(product_name) AS products
FROM practice_products
GROUP BY category;


-- 45
SELECT
    category,
    JSON_OBJECTAGG(
        product_name,
        price
    ) AS products
FROM practice_products
GROUP BY category;


-- ============================================================
-- Solutions 46-50
-- ============================================================

-- 46
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


-- 47
SELECT *
FROM JSON_TABLE(
    '[
        {"product":"Laptop","price":75000},
        {"product":"Phone","price":45000}
    ]',
    '$[*]'
    COLUMNS (
        product VARCHAR(100) PATH '$.product',
        price DECIMAL(10,2) PATH '$.price'
    )
) AS jt;


-- 48
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


-- 49
SELECT *
FROM JSON_TABLE(
    '[
        {"order_id":101,"product_name":"Laptop","quantity":2},
        {"order_id":102,"product_name":"Mouse","quantity":3}
    ]',
    '$[*]'
    COLUMNS (
        order_id INT PATH '$.order_id',
        product_name VARCHAR(100) PATH '$.product_name',
        quantity INT PATH '$.quantity'
    )
) AS jt;


-- 50
SELECT *
FROM JSON_TABLE(
    '[
        {"employee_id":1,"employee_name":"Alice","salary":50000},
        {"employee_id":2,"employee_name":"Bob","salary":60000},
        {"employee_id":3,"employee_name":"Charlie","salary":55000}
    ]',
    '$[*]'
    COLUMNS (
        employee_id INT PATH '$.employee_id',
        employee_name VARCHAR(100) PATH '$.employee_name',
        salary DECIMAL(10,2) PATH '$.salary'
    )
) AS jt;


-- ============================================================
-- Solutions 51-55
-- ============================================================

-- 51
DROP TABLE IF EXISTS json_products;

CREATE TABLE json_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    attributes JSON,

    color VARCHAR(50)
        GENERATED ALWAYS AS (
            attributes->>'$.color'
        ) STORED
);


-- 52
INSERT INTO json_products (
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


-- 53
SELECT
    product_id,
    product_name,
    color
FROM json_products;


-- 54
CREATE INDEX idx_json_products_color
ON json_products(color);


-- 55
SELECT
    product_id,
    product_name,
    color
FROM json_products
WHERE color = 'black';


-- ============================================================
-- Solutions 56-60
-- ============================================================

-- 56
WITH product_brands AS (
    SELECT
        product_id,
        attributes->>'$.brand' AS brand
    FROM practice_products
)
SELECT
    brand,
    COUNT(*) AS product_count
FROM product_brands
GROUP BY brand
ORDER BY product_count DESC;


-- 57
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
        ) = 8
            THEN 'Medium RAM'

        ELSE 'Unknown'
    END AS ram_category
FROM practice_products;


-- 58
SELECT
    attributes->>'$.brand' AS brand,
    AVG(price) AS average_price
FROM practice_products
GROUP BY attributes->>'$.brand'
ORDER BY average_price DESC;


-- 59
WITH ranked_products AS (
    SELECT
        product_id,
        product_name,
        price,
        attributes->>'$.brand' AS brand,

        ROW_NUMBER() OVER (
            PARTITION BY attributes->>'$.brand'
            ORDER BY price DESC, product_id
        ) AS row_num

    FROM practice_products
)
SELECT
    product_id,
    product_name,
    brand,
    price
FROM ranked_products
WHERE row_num = 1;


-- 60
SELECT
    product_name,
    category,
    price,
    attributes->>'$.brand' AS brand,
    attributes->>'$.color' AS color,
    attributes->>'$.ram' AS ram,
    attributes->>'$.storage' AS storage
FROM practice_products
ORDER BY product_id;
