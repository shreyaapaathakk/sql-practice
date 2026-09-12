-- ============================================================
-- Module 28: JSON Data in MySQL
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

CREATE DATABASE IF NOT EXISTS sql_practice_json;

USE sql_practice_json;


-- ============================================================
-- Challenge Dataset
-- ============================================================

DROP TABLE IF EXISTS challenge_products;

CREATE TABLE challenge_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    attributes JSON
);

INSERT INTO challenge_products (
    product_id,
    product_name,
    category,
    price,
    attributes
)
VALUES
(
    1,
    'Ultra Laptop',
    'Electronics',
    120000.00,
    '{
        "brand":"Dell",
        "ram":32,
        "storage":1024,
        "color":"black",
        "ports":["USB-C","HDMI","USB-A"],
        "features":{
            "wireless":true,
            "touchscreen":true
        }
    }'
),
(
    2,
    'Business Laptop',
    'Electronics',
    90000.00,
    '{
        "brand":"Lenovo",
        "ram":16,
        "storage":512,
        "color":"gray",
        "ports":["USB-C","HDMI"],
        "features":{
            "wireless":true,
            "touchscreen":false
        }
    }'
),
(
    3,
    'Gaming Laptop',
    'Electronics',
    150000.00,
    '{
        "brand":"ASUS",
        "ram":32,
        "storage":2048,
        "color":"black",
        "ports":["USB-C","HDMI","USB-A"],
        "features":{
            "wireless":true,
            "touchscreen":false
        }
    }'
),
(
    4,
    'Budget Phone',
    'Mobile',
    18000.00,
    '{
        "brand":"Samsung",
        "ram":6,
        "storage":128,
        "color":"blue",
        "features":{
            "wireless":true,
            "waterproof":false
        }
    }'
),
(
    5,
    'Premium Phone',
    'Mobile',
    80000.00,
    '{
        "brand":"Apple",
        "ram":8,
        "storage":512,
        "color":"black",
        "features":{
            "wireless":true,
            "waterproof":true
        }
    }'
),
(
    6,
    'Office Monitor',
    'Electronics',
    25000.00,
    '{
        "brand":"LG",
        "size":27,
        "resolution":"4K",
        "color":"black",
        "features":{
            "wireless":false
        }
    }'
),
(
    7,
    'Mechanical Keyboard',
    'Accessories',
    7500.00,
    '{
        "brand":"Logitech",
        "color":"black",
        "switch":"brown",
        "features":{
            "wireless":true,
            "backlit":true
        }
    }'
),
(
    8,
    'Wireless Mouse',
    'Accessories',
    3000.00,
    '{
        "brand":"Logitech",
        "color":"white",
        "dpi":1600,
        "features":{
            "wireless":true
        }
    }'
),
(
    9,
    'Smartwatch Pro',
    'Wearables',
    30000.00,
    '{
        "brand":"Samsung",
        "storage":32,
        "color":"black",
        "features":{
            "wireless":true,
            "waterproof":true,
            "gps":true
        }
    }'
),
(
    10,
    'Noise Cancelling Headphones',
    'Accessories',
    22000.00,
    '{
        "brand":"Sony",
        "color":"black",
        "features":{
            "wireless":true,
            "noise_cancellation":true
        }
    }'
);


-- ============================================================
-- Challenge 1
-- ============================================================
-- Create a report containing:
-- product_name
-- category
-- price
-- brand
-- color
--
-- Extract brand and color from JSON.


-- ============================================================
-- Challenge 2
-- ============================================================
-- Find all products with RAM of at least 16 GB.
--
-- Products without a RAM property should not appear.


-- ============================================================
-- Challenge 3
-- ============================================================
-- Find all products with storage of at least 512 GB.


-- ============================================================
-- Challenge 4
-- ============================================================
-- Find all black products regardless of category.


-- ============================================================
-- Challenge 5
-- ============================================================
-- Find products whose nested JSON property:
--
-- $.features.wireless
--
-- is true.


-- ============================================================
-- Challenge 6
-- ============================================================
-- Find products that support touchscreen functionality.
--
-- Only products where:
--
-- $.features.touchscreen = true
--
-- should appear.


-- ============================================================
-- Challenge 7
-- ============================================================
-- Find all products that contain the JSON property:
--
-- $.features.waterproof
--
-- regardless of whether its value is true or false.


-- ============================================================
-- Challenge 8
-- ============================================================
-- Find products whose JSON contains:
--
-- {"brand":"Logitech"}
--
-- using JSON_CONTAINS().


-- ============================================================
-- Challenge 9
-- ============================================================
-- Find products that contain "USB-C" in their ports array.


-- ============================================================
-- Challenge 10
-- ============================================================
-- Return the number of ports available for each laptop.
--
-- Products without a ports property should not be included.


-- ============================================================
-- Challenge 11
-- ============================================================
-- Create a JSON object for every product containing:
--
-- product_name
-- category
-- price
-- brand
--
-- The result should be one JSON object per row.


-- ============================================================
-- Challenge 12
-- ============================================================
-- Create one JSON array containing all product names
-- in the Electronics category.


-- ============================================================
-- Challenge 13
-- ============================================================
-- Create a JSON object mapping:
--
-- product_name → price
--
-- for all products.


-- ============================================================
-- Challenge 14
-- ============================================================
-- Group products by category and create a JSON object
-- mapping:
--
-- product_name → brand
--
-- for each category.


-- ============================================================
-- Challenge 15
-- ============================================================
-- Use JSON_TABLE() to convert the following JSON array
-- into relational columns:
--
-- [
--     {
--         "product_id":1,
--         "name":"Laptop",
--         "specs":{
--             "ram":16,
--             "storage":512
--         }
--     },
--     {
--         "product_id":2,
--         "name":"Phone",
--         "specs":{
--             "ram":8,
--             "storage":256
--         }
--     }
-- ]
--
-- Return:
-- product_id
-- name
-- ram
-- storage


-- ============================================================
-- Challenge 16
-- ============================================================
-- Use JSON_TABLE() to transform the ports array of the
-- Ultra Laptop into separate rows.
--
-- Expected columns:
-- product_name
-- port


-- ============================================================
-- Challenge 17
-- ============================================================
-- Create a generated column called brand from:
--
-- $.brand
--
-- Then create an index on that generated column.


-- ============================================================
-- Challenge 18
-- ============================================================
-- Using the generated brand column, return the products
-- manufactured by Logitech.


-- ============================================================
-- Challenge 19
-- ============================================================
-- Create a CTE that extracts:
--
-- product_name
-- brand
-- ram
-- storage
--
-- from the JSON attributes.
--
-- Then return products with RAM >= 16.


-- ============================================================
-- Challenge 20
-- ============================================================
-- Calculate the average price for each JSON brand.
--
-- Return:
-- brand
-- product_count
-- average_price
--
-- Sort by average_price descending.


-- ============================================================
-- Challenge 21
-- ============================================================
-- Rank products within each JSON brand based on price
-- from highest to lowest.
--
-- Return:
-- product_name
-- brand
-- price
-- brand_rank


-- ============================================================
-- Challenge 22
-- ============================================================
-- Find the most expensive product for each JSON brand.
--
-- If two products have the same price, use product_id
-- as a deterministic tie-breaker.


-- ============================================================
-- Challenge 23
-- ============================================================
-- Create a comprehensive JSON product report.
--
-- Each row should contain:
--
-- product_name
-- category
-- price
-- brand
-- color
-- ram
-- storage
-- wireless
--
-- The extracted values should be presented as normal
-- relational columns.


-- ============================================================
-- Challenge 24: Complete JSON Data Project
-- ============================================================
--
-- Design and implement a small product catalog that
-- combines relational columns with JSON attributes.
--
-- Requirements:
--
-- 1. Create a products table containing:
--       product_id
--       product_name
--       category
--       price
--       attributes JSON
--
-- 2. Store at least 10 products.
--
-- 3. Each product should contain at least:
--       brand
--       color
--
-- 4. Some products should additionally contain:
--       RAM
--       storage
--       wireless
--       features
--       specifications
--
-- 5. Extract brand and color into a report.
--
-- 6. Find products using a JSON property.
--
-- 7. Find products using a nested JSON property.
--
-- 8. Find products containing a specific array element.
--
-- 9. Update an existing JSON property.
--
-- 10. Add a new JSON property.
--
-- 11. Remove a JSON property.
--
-- 12. Create a JSON array containing product names.
--
-- 13. Create a JSON object mapping product names to prices.
--
-- 14. Use JSON_TABLE() to transform at least one
--     nested JSON structure into relational rows.
--
-- 15. Create a generated column for a frequently queried
--     JSON attribute.
--
-- 16. Create an index on the generated column.
--
-- 17. Write a query that uses a CTE with JSON extraction.
--
-- 18. Produce a final report containing:
--       product
--       category
--       price
--       brand
--       selected JSON attributes
--
-- 19. Explain in comments which attributes belong in
--     normal relational columns and which are better
--     suited for JSON.
--
-- 20. Add at least three design decisions explaining why
--     JSON was used for specific attributes.
