USE sales_analysis;

-- ============================================================
-- SALES ANALYSIS PROJECT
-- File: data.sql
-- Description: Sample data for the Sales Analysis project
-- SQL Dialect: MySQL 8.0+
-- ============================================================


-- ============================================================
-- 1. CATEGORIES
-- ============================================================

INSERT INTO categories
    (category_id, category_name, description)
VALUES
    (1, 'Electronics', 'Electronic devices and accessories'),
    (2, 'Home & Kitchen', 'Products for home and kitchen use'),
    (3, 'Office Supplies', 'Stationery and office essentials'),
    (4, 'Fitness & Sports', 'Fitness equipment and sports accessories'),
    (5, 'Personal Care', 'Personal care and wellness products');


-- ============================================================
-- 2. PRODUCTS
-- ============================================================

INSERT INTO products
    (product_id, product_name, category_id, unit_price, stock_quantity, product_status)
VALUES
    (101, 'Wireless Headphones', 1, 2499.00, 85, 'Active'),
    (102, 'Bluetooth Speaker', 1, 1899.00, 120, 'Active'),
    (103, 'Mechanical Keyboard', 1, 3299.00, 65, 'Active'),
    (104, 'Wireless Mouse', 1, 899.00, 150, 'Active'),
    (105, 'USB-C Hub', 1, 1599.00, 95, 'Active'),
    (106, 'Smart Watch', 1, 4999.00, 45, 'Active'),

    (201, 'Electric Kettle', 2, 1799.00, 75, 'Active'),
    (202, 'Mixer Grinder', 2, 3499.00, 50, 'Active'),
    (203, 'Non-Stick Cookware Set', 2, 4299.00, 40, 'Active'),
    (204, 'Storage Container Set', 2, 1299.00, 100, 'Active'),
    (205, 'Air Fryer', 2, 5999.00, 35, 'Active'),
    (206, 'Water Bottle', 2, 699.00, 200, 'Active'),

    (301, 'Notebook Set', 3, 499.00, 180, 'Active'),
    (302, 'Gel Pen Pack', 3, 299.00, 250, 'Active'),
    (303, 'Desk Organizer', 3, 799.00, 90, 'Active'),
    (304, 'Office Backpack', 3, 1899.00, 60, 'Active'),
    (305, 'Desk Lamp', 3, 1499.00, 70, 'Active'),

    (401, 'Yoga Mat', 4, 999.00, 110, 'Active'),
    (402, 'Resistance Band Set', 4, 799.00, 130, 'Active'),
    (403, 'Dumbbell Set', 4, 2999.00, 55, 'Active'),
    (404, 'Running Shoes', 4, 3999.00, 45, 'Active'),
    (405, 'Fitness Tracker', 4, 2799.00, 65, 'Active'),

    (501, 'Electric Trimmer', 5, 1599.00, 80, 'Active'),
    (502, 'Facial Cleanser', 5, 599.00, 140, 'Active'),
    (503, 'Hair Dryer', 5, 2199.00, 60, 'Active'),
    (504, 'Massage Gun', 5, 3499.00, 40, 'Active'),
    (505, 'Grooming Kit', 5, 2499.00, 50, 'Active');


-- ============================================================
-- 3. CUSTOMERS
-- ============================================================

INSERT INTO customers
    (customer_id, first_name, last_name, email, phone, city, state, region, registration_date)
VALUES
    (1001, 'Aarav', 'Sharma', 'aarav.sharma@example.com', '9876501001',
        'Delhi', 'Delhi', 'North', '2025-01-15'),

    (1002, 'Priya', 'Verma', 'priya.verma@example.com', '9876501002',
        'Lucknow', 'Uttar Pradesh', 'North', '2025-01-20'),

    (1003, 'Rahul', 'Mehta', 'rahul.mehta@example.com', '9876501003',
        'Mumbai', 'Maharashtra', 'West', '2025-02-05'),

    (1004, 'Sneha', 'Patel', 'sneha.patel@example.com', '9876501004',
        'Ahmedabad', 'Gujarat', 'West', '2025-02-18'),

    (1005, 'Arjun', 'Rao', 'arjun.rao@example.com', '9876501005',
        'Bengaluru', 'Karnataka', 'South', '2025-03-01'),

    (1006, 'Ananya', 'Iyer', 'ananya.iyer@example.com', '9876501006',
        'Chennai', 'Tamil Nadu', 'South', '2025-03-12'),

    (1007, 'Vikram', 'Singh', 'vikram.singh@example.com', '9876501007',
        'Jaipur', 'Rajasthan', 'North', '2025-03-25'),

    (1008, 'Kavya', 'Nair', 'kavya.nair@example.com', '9876501008',
        'Kochi', 'Kerala', 'South', '2025-04-03'),

    (1009, 'Rohan', 'Kapoor', 'rohan.kapoor@example.com', '9876501009',
        'Chandigarh', 'Chandigarh', 'North', '2025-04-15'),

    (1010, 'Meera', 'Joshi', 'meera.joshi@example.com', '9876501010',
        'Pune', 'Maharashtra', 'West', '2025-04-20'),

    (1011, 'Aditya', 'Malhotra', 'aditya.malhotra@example.com', '9876501011',
        'Noida', 'Uttar Pradesh', 'North', '2025-05-02'),

    (1012, 'Ishita', 'Gupta', 'ishita.gupta@example.com', '9876501012',
        'Kolkata', 'West Bengal', 'East', '2025-05-14'),

    (1013, 'Karan', 'Desai', 'karan.desai@example.com', '9876501013',
        'Surat', 'Gujarat', 'West', '2025-05-25'),

    (1014, 'Neha', 'Chopra', 'neha.chopra@example.com', '9876501014',
        'Delhi', 'Delhi', 'North', '2025-06-04'),

    (1015, 'Manish', 'Kumar', 'manish.kumar@example.com', '9876501015',
        'Patna', 'Bihar', 'East', '2025-06-15'),

    (1016, 'Pooja', 'Shah', 'pooja.shah@example.com', '9876501016',
        'Vadodara', 'Gujarat', 'West', '2025-06-22'),

    (1017, 'Siddharth', 'Bose', 'siddharth.bose@example.com', '9876501017',
        'Kolkata', 'West Bengal', 'East', '2025-07-01'),

    (1018, 'Riya', 'Mishra', 'riya.mishra@example.com', '9876501018',
        'Prayagraj', 'Uttar Pradesh', 'North', '2025-07-10'),

    (1019, 'Nikhil', 'Menon', 'nikhil.menon@example.com', '9876501019',
        'Thiruvananthapuram', 'Kerala', 'South', '2025-07-18'),

    (1020, 'Tanvi', 'Kulkarni', 'tanvi.kulkarni@example.com', '9876501020',
        'Nagpur', 'Maharashtra', 'West', '2025-08-01'),

    (1021, 'Yash', 'Agarwal', 'yash.agarwal@example.com', '9876501021',
        'Kanpur', 'Uttar Pradesh', 'North', '2025-08-15'),

    (1022, 'Simran', 'Kaur', 'simran.kaur@example.com', '9876501022',
        'Amritsar', 'Punjab', 'North', '2025-08-22'),

    (1023, 'Dev', 'Chatterjee', 'dev.chatterjee@example.com', '9876501023',
        'Bhubaneswar', 'Odisha', 'East', '2025-09-03'),

    (1024, 'Aditi', 'Reddy', 'aditi.reddy@example.com', '9876501024',
        'Hyderabad', 'Telangana', 'South', '2025-09-12'),

    (1025, 'Mohit', 'Saxena', 'mohit.saxena@example.com', '9876501025',
        'Bhopal', 'Madhya Pradesh', 'Central', '2025-09-25'),

    (1026, 'Divya', 'Sethi', 'divya.sethi@example.com', '9876501026',
        'Gurugram', 'Haryana', 'North', '2025-10-01'),

    (1027, 'Harsh', 'Tiwari', 'harsh.tiwari@example.com', '9876501027',
        'Varanasi', 'Uttar Pradesh', 'North', '2025-10-15'),

    (1028, 'Nandini', 'Krishnan', 'nandini.krishnan@example.com', '9876501028',
        'Coimbatore', 'Tamil Nadu', 'South', '2025-10-25'),

    (1029, 'Saurabh', 'Jain', 'saurabh.jain@example.com', '9876501029',
        'Indore', 'Madhya Pradesh', 'Central', '2025-11-05'),

    (1030, 'Kritika', 'Bansal', 'kritika.bansal@example.com', '9876501030',
        'Ludhiana', 'Punjab', 'North', '2025-11-18');


-- ============================================================
-- 4. SALES ORDERS
-- ============================================================

INSERT INTO sales_orders
    (order_id, customer_id, order_date, region, order_status)
VALUES

    -- January 2026
    (5001, 1001, '2026-01-03', 'North', 'Completed'),
    (5002, 1002, '2026-01-07', 'North', 'Completed'),
    (5003, 1003, '2026-01-12', 'West', 'Completed'),
    (5004, 1004, '2026-01-18', 'West', 'Cancelled'),
    (5005, 1005, '2026-01-24', 'South', 'Completed'),

    -- February 2026
    (5006, 1006, '2026-02-02', 'South', 'Completed'),
    (5007, 1007, '2026-02-06', 'North', 'Completed'),
    (5008, 1008, '2026-02-11', 'South', 'Pending'),
    (5009, 1009, '2026-02-16', 'North', 'Completed'),
    (5010, 1010, '2026-02-23', 'West', 'Completed'),

    -- March 2026
    (5011, 1011, '2026-03-04', 'North', 'Completed'),
    (5012, 1012, '2026-03-08', 'East', 'Completed'),
    (5013, 1013, '2026-03-13', 'West', 'Completed'),
    (5014, 1014, '2026-03-19', 'North', 'Pending'),
    (5015, 1015, '2026-03-27', 'East', 'Completed'),

    -- April 2026
    (5016, 1016, '2026-04-03', 'West', 'Completed'),
    (5017, 1017, '2026-04-09', 'East', 'Cancelled'),
    (5018, 1018, '2026-04-15', 'North', 'Completed'),
    (5019, 1019, '2026-04-21', 'South', 'Completed'),
    (5020, 1020, '2026-04-28', 'West', 'Completed'),

    -- May 2026
    (5021, 1021, '2026-05-02', 'North', 'Completed'),
    (5022, 1022, '2026-05-08', 'North', 'Completed'),
    (5023, 1023, '2026-05-14', 'East', 'Completed'),
    (5024, 1024, '2026-05-20', 'South', 'Pending'),
    (5025, 1025, '2026-05-27', 'Central', 'Completed'),

    -- June 2026
    (5026, 1026, '2026-06-04', 'North', 'Completed'),
    (5027, 1027, '2026-06-10', 'North', 'Completed'),
    (5028, 1028, '2026-06-16', 'South', 'Completed'),
    (5029, 1029, '2026-06-22', 'Central', 'Cancelled'),
    (5030, 1030, '2026-06-29', 'North', 'Completed'),

    -- July 2026
    (5031, 1001, '2026-07-03', 'North', 'Completed'),
    (5032, 1003, '2026-07-08', 'West', 'Completed'),
    (5033, 1005, '2026-07-14', 'South', 'Completed'),
    (5034, 1007, '2026-07-19', 'North', 'Pending'),
    (5035, 1010, '2026-07-25', 'West', 'Completed'),

    -- August 2026
    (5036, 1002, '2026-08-02', 'North', 'Completed'),
    (5037, 1004, '2026-08-07', 'West', 'Completed'),
    (5038, 1006, '2026-08-13', 'South', 'Completed'),
    (5039, 1012, '2026-08-18', 'East', 'Completed'),
    (5040, 1014, '2026-08-26', 'North', 'Completed'),

    -- September 2026
    (5041, 1011, '2026-09-03', 'North', 'Completed'),
    (5042, 1013, '2026-09-09', 'West', 'Completed'),
    (5043, 1018, '2026-09-15', 'North', 'Completed'),
    (5044, 1024, '2026-09-21', 'South', 'Pending'),
    (5045, 1027, '2026-09-28', 'North', 'Completed'),

    -- October 2026
    (5046, 1001, '2026-10-02', 'North', 'Completed'),
    (5047, 1005, '2026-10-04', 'South', 'Completed');


-- ============================================================
-- 5. SALES ORDER ITEMS
-- ============================================================

INSERT INTO sales_order_items
    (order_item_id, order_id, product_id, quantity, unit_price, discount_percent)
VALUES

    -- Order 5001
    (1, 5001, 101, 1, 2499.00, 5.00),
    (2, 5001, 104, 2, 899.00, 0.00),

    -- Order 5002
    (3, 5002, 201, 1, 1799.00, 0.00),
    (4, 5002, 206, 2, 699.00, 5.00),

    -- Order 5003
    (5, 5003, 106, 1, 4999.00, 10.00),
    (6, 5003, 105, 1, 1599.00, 5.00),

    -- Order 5004 - Cancelled
    (7, 5004, 203, 1, 4299.00, 0.00),
    (8, 5004, 204, 2, 1299.00, 10.00),

    -- Order 5005
    (9, 5005, 403, 1, 2999.00, 5.00),
    (10, 5005, 401, 2, 999.00, 0.00),

    -- Order 5006
    (11, 5006, 202, 1, 3499.00, 5.00),
    (12, 5006, 206, 3, 699.00, 0.00),

    -- Order 5007
    (13, 5007, 103, 1, 3299.00, 10.00),
    (14, 5007, 104, 1, 899.00, 0.00),

    -- Order 5008 - Pending
    (15, 5008, 205, 1, 5999.00, 5.00),
    (16, 5008, 206, 2, 699.00, 0.00),

    -- Order 5009
    (17, 5009, 304, 1, 1899.00, 5.00),
    (18, 5009, 301, 2, 499.00, 0.00),
    (19, 5009, 302, 2, 299.00, 0.00),

    -- Order 5010
    (20, 5010, 102, 1, 1899.00, 5.00),
    (21, 5010, 101, 1, 2499.00, 10.00),

    -- Order 5011
    (22, 5011, 106, 1, 4999.00, 5.00),
    (23, 5011, 104, 2, 899.00, 0.00),

    -- Order 5012
    (24, 5012, 305, 1, 1499.00, 0.00),
    (25, 5012, 303, 1, 799.00, 5.00),

    -- Order 5013
    (26, 5013, 105, 2, 1599.00, 5.00),
    (27, 5013, 102, 1, 1899.00, 0.00),

    -- Order 5014 - Pending
    (28, 5014, 205, 1, 5999.00, 10.00),
    (29, 5014, 201, 1, 1799.00, 0.00),

    -- Order 5015
    (30, 5015, 302, 5, 299.00, 0.00),
    (31, 5015, 301, 3, 499.00, 5.00),

    -- Order 5016
    (32, 5016, 504, 1, 3499.00, 10.00),
    (33, 5016, 502, 2, 599.00, 0.00),

    -- Order 5017 - Cancelled
    (34, 5017, 503, 1, 2199.00, 5.00),
    (35, 5017, 501, 1, 1599.00, 0.00),

    -- Order 5018
    (36, 5018, 101, 1, 2499.00, 5.00),
    (37, 5018, 103, 1, 3299.00, 10.00),

    -- Order 5019
    (38, 5019, 404, 1, 3999.00, 10.00),
    (39, 5019, 402, 2, 799.00, 0.00),

    -- Order 5020
    (40, 5020, 203, 1, 4299.00, 5.00),
    (41, 5020, 204, 2, 1299.00, 0.00),

    -- Order 5021
    (42, 5021, 106, 1, 4999.00, 10.00),
    (43, 5021, 105, 1, 1599.00, 0.00),

    -- Order 5022
    (44, 5022, 201, 2, 1799.00, 5.00),
    (45, 5022, 206, 3, 699.00, 0.00),

    -- Order 5023
    (46, 5023, 304, 1, 1899.00, 0.00),
    (47, 5023, 303, 2, 799.00, 5.00),

    -- Order 5024 - Pending
    (48, 5024, 405, 1, 2799.00, 5.00),
    (49, 5024, 401, 1, 999.00, 0.00),

    -- Order 5025
    (50, 5025, 202, 1, 3499.00, 10.00),
    (51, 5025, 204, 2, 1299.00, 0.00),

    -- Order 5026
    (52, 5026, 101, 2, 2499.00, 10.00),
    (53, 5026, 102, 1, 1899.00, 5.00),

    -- Order 5027
    (54, 5027, 403, 1, 2999.00, 5.00),
    (55, 5027, 402, 2, 799.00, 0.00),

    -- Order 5028
    (56, 5028, 205, 1, 5999.00, 10.00),
    (57, 5028, 206, 2, 699.00, 0.00),

    -- Order 5029 - Cancelled
    (58, 5029, 404, 1, 3999.00, 5.00),
    (59, 5029, 405, 1, 2799.00, 0.00),

    -- Order 5030
    (60, 5030, 304, 1, 1899.00, 5.00),
    (61, 5030, 301, 4, 499.00, 0.00),

    -- Order 5031
    (62, 5031, 106, 1, 4999.00, 10.00),
    (63, 5031, 104, 2, 899.00, 5.00),

    -- Order 5032
    (64, 5032, 103, 1, 3299.00, 5.00),
    (65, 5032, 105, 1, 1599.00, 0.00),

    -- Order 5033
    (66, 5033, 404, 1, 3999.00, 10.00),
    (67, 5033, 401, 1, 999.00, 0.00),

    -- Order 5034 - Pending
    (68, 5034, 403, 1, 2999.00, 5.00),
    (69, 5034, 402, 2, 799.00, 0.00),

    -- Order 5035
    (70, 5035, 102, 2, 1899.00, 5.00),
    (71, 5035, 101, 1, 2499.00, 10.00),

    -- Order 5036
    (72, 5036, 201, 1, 1799.00, 0.00),
    (73, 5036, 206, 4, 699.00, 5.00),

    -- Order 5037
    (74, 5037, 203, 1, 4299.00, 10.00),
    (75, 5037, 204, 2, 1299.00, 0.00),

    -- Order 5038
    (76, 5038, 504, 1, 3499.00, 5.00),
    (77, 5038, 502, 2, 599.00, 0.00),

    -- Order 5039
    (78, 5039, 305, 1, 1499.00, 5.00),
    (79, 5039, 303, 2, 799.00, 0.00),

    -- Order 5040
    (80, 5040, 106, 1, 4999.00, 10.00),
    (81, 5040, 105, 1, 1599.00, 5.00),

    -- Order 5041
    (82, 5041, 101, 1, 2499.00, 5.00),
    (83, 5041, 103, 1, 3299.00, 10.00),

    -- Order 5042
    (84, 5042, 202, 1, 3499.00, 5.00),
    (85, 5042, 201, 1, 1799.00, 0.00),

    -- Order 5043
    (86, 5043, 403, 1, 2999.00, 10.00),
    (87, 5043, 401, 2, 999.00, 0.00),

    -- Order 5044 - Pending
    (88, 5044, 205, 1, 5999.00, 5.00),
    (89, 5044, 206, 2, 699.00, 0.00),

    -- Order 5045
    (90, 5045, 304, 1, 1899.00, 5.00),
    (91, 5045, 302, 3, 299.00, 0.00),

    -- Order 5046
    (92, 5046, 106, 1, 4999.00, 5.00),
    (93, 5046, 101, 1, 2499.00, 10.00),
    (94, 5046, 104, 2, 899.00, 0.00),

    -- Order 5047
    (95, 5047, 404, 1, 3999.00, 5.00),
    (96, 5047, 402, 2, 799.00, 0.00);


-- ============================================================
-- 6. DATA VALIDATION QUERIES
-- ============================================================

-- Check number of categories
SELECT COUNT(*) AS total_categories
FROM categories;


-- Check number of products
SELECT COUNT(*) AS total_products
FROM products;


-- Check number of customers
SELECT COUNT(*) AS total_customers
FROM customers;


-- Check number of orders
SELECT COUNT(*) AS total_orders
FROM sales_orders;


-- Check number of order items
SELECT COUNT(*) AS total_order_items
FROM sales_order_items;


-- Check order status distribution
SELECT
    order_status,
    COUNT(*) AS order_count
FROM sales_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- Check orders by region
SELECT
    region,
    COUNT(*) AS order_count
FROM sales_orders
GROUP BY region
ORDER BY order_count DESC;


-- Check that every order item references an existing order
SELECT COUNT(*) AS invalid_order_references
FROM sales_order_items oi
LEFT JOIN sales_orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


-- Check that every order item references an existing product
SELECT COUNT(*) AS invalid_product_references
FROM sales_order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


-- Check for customers without orders
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customers c
LEFT JOIN sales_orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;


-- ============================================================
-- END OF DATA
-- ============================================================
