-- ============================================================
-- Module 28: JSON Data in MySQL
-- File: practice.sql
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
-- Basic JSON
-- ============================================================

-- Exercise 1
-- Display all products and their JSON attributes.


-- Exercise 2
-- Display product_name and the JSON brand.


-- Exercise 3
-- Extract the JSON color for every product.


-- Exercise 4
-- Extract the JSON RAM value for products that contain RAM.


-- Exercise 5
-- Extract the JSON storage value for products that contain storage.


-- Exercise 6
-- Extract the wireless property from every product.


-- Exercise 7
-- Create a JSON object containing product_name and price for every product.


-- Exercise 8
-- Create a JSON array containing product_name and category.


-- Exercise 9
-- Return the first element of this JSON array:
-- ["SQL", "Python", "Java"].


-- Exercise 10
-- Return the city from:
-- {"name":"Alice","address":{"city":"Delhi","country":"India"}}


-- ============================================================
-- JSON Operators and Functions
-- ============================================================

-- Exercise 11
-- Use the -> operator to extract each product's brand.


-- Exercise 12
-- Use the ->> operator to extract each product's brand
-- as an unquoted SQL value.


-- Exercise 13
-- Use JSON_EXTRACT() to extract each product's color.


-- Exercise 14
-- Use JSON_UNQUOTE() with JSON_EXTRACT() to extract
-- a product's brand.


-- Exercise 15
-- Use JSON_VALUE() to extract a product's brand.


-- Exercise 16
-- Use JSON_KEYS() to display the JSON keys of each product.


-- Exercise 17
-- Use JSON_LENGTH() to determine the number of elements
-- in this JSON array:
-- ["SQL","Python","Java","MySQL"].


-- Exercise 18
-- Use JSON_TYPE() to determine the type of:
-- 100


-- Exercise 19
-- Use JSON_TYPE() to determine the type of:
-- ["SQL","Python"]


-- Exercise 20
-- Use JSON_VALID() to test:
-- {"name":"Alice"}


-- ============================================================
-- Filtering JSON
-- ============================================================

-- Exercise 21
-- Find products whose JSON color is black.


-- Exercise 22
-- Find products whose JSON brand is Samsung.


-- Exercise 23
-- Find products with at least 16 GB of RAM.


-- Exercise 24
-- Find products with storage of at least 256 GB.


-- Exercise 25
-- Find products where wireless is true.


-- Exercise 26
-- Find products that contain a JSON brand property.


-- Exercise 27
-- Find products that contain both brand and color properties.


-- Exercise 28
-- Find products that contain the JSON property noise_cancellation.


-- Exercise 29
-- Find products whose JSON data contains:
-- {"brand":"Logitech"}


-- Exercise 30
-- Find products whose JSON data contains:
-- "black" inside the color property.


-- ============================================================
-- JSON Modification
-- ============================================================

-- Exercise 31
-- Add a JSON property "warranty_years": 2 to product 1
-- using JSON_SET().


-- Exercise 32
-- Change product 2's JSON color to "gold".


-- Exercise 33
-- Add a JSON property "discount": 10 to product 3.


-- Exercise 34
-- Use JSON_INSERT() to add a property called "origin"
-- with value "India" to product 4.


-- Exercise 35
-- Attempt to change an existing JSON property using
-- JSON_INSERT(). Observe the result.


-- Exercise 36
-- Use JSON_REPLACE() to change product 5's JSON brand
-- to "Apple Inc."


-- Exercise 37
-- Attempt to add a new JSON property using JSON_REPLACE().
-- Observe the result.


-- Exercise 38
-- Remove the JSON property wireless from product 1.


-- Exercise 39
-- Remove the JSON property noise_cancellation from product 10.


-- Exercise 40
-- Append "Bluetooth" to this JSON array:
-- {"features":["Wireless","USB"]}


-- ============================================================
-- JSON Aggregation
-- ============================================================

-- Exercise 41
-- Return all product names as one JSON array.


-- Exercise 42
-- Return all brands as one JSON array.


-- Exercise 43
-- Create a JSON object mapping product names to prices.


-- Exercise 44
-- Group products by category and create a JSON array
-- containing the product names in each category.


-- Exercise 45
-- Group products by category and create a JSON object
-- mapping product names to prices.


-- ============================================================
-- JSON_TABLE()
-- ============================================================

-- Exercise 46
-- Use JSON_TABLE() to convert:
--
-- [
--     {"id":1,"name":"Alice","age":25},
--     {"id":2,"name":"Bob","age":30}
-- ]
--
-- into relational columns.


-- Exercise 47
-- Use JSON_TABLE() to convert:
--
-- [
--     {"product":"Laptop","price":75000},
--     {"product":"Phone","price":45000}
-- ]
--
-- into rows.


-- Exercise 48
-- Use JSON_TABLE() to extract customer information and
-- nested orders from:
--
-- {
--     "customer":"Alice",
--     "orders":[
--         {"order_id":101,"amount":500},
--         {"order_id":102,"amount":700}
--     ]
-- }


-- Exercise 49
-- Create a JSON_TABLE() query that extracts:
-- order_id, product_name, quantity
-- from a JSON array of order items.


-- Exercise 50
-- Use JSON_TABLE() to convert a JSON array containing
-- employee_id, employee_name, and salary into rows.


-- ============================================================
-- Generated Columns and Indexing
-- ============================================================

-- Exercise 51
-- Create a table called json_products with:
-- product_id
-- product_name
-- attributes JSON
-- color as a STORED generated column extracted from
-- attributes->>'$.color'.


-- Exercise 52
-- Insert at least three products into json_products.


-- Exercise 53
-- Query the generated color column.


-- Exercise 54
-- Create an index on the generated color column.


-- Exercise 55
-- Find all products with color = 'black' using
-- the generated column.


-- ============================================================
-- JSON with Other SQL Features
-- ============================================================

-- Exercise 56
-- Create a CTE that extracts the JSON brand and then
-- counts products by brand.


-- Exercise 57
-- Create a query that categorizes products as:
-- High RAM: RAM >= 16
-- Medium RAM: RAM = 8
-- Unknown: no RAM property.


-- Exercise 58
-- Calculate the average product price by JSON brand.


-- Exercise 59
-- Find the most expensive product for each JSON brand.


-- Exercise 60
-- Write a final report showing:
-- product_name
-- category
-- price
-- brand
-- color
-- RAM
-- storage
--
-- Use JSON extraction for the JSON attributes.
