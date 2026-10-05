sql
-- ============================================================
-- SALES ANALYSIS PROJECT
-- schema.sql
-- MySQL 8.0+
-- ============================================================

-- Create database
CREATE DATABASE IF NOT EXISTS sales_analysis;

USE sales_analysis;


-- ============================================================
-- 1. CATEGORIES
-- ============================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


-- ============================================================
-- 2. PRODUCTS
-- ============================================================

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    product_status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    CONSTRAINT chk_products_price
        CHECK (unit_price >= 0),

    CONSTRAINT chk_products_stock
        CHECK (stock_quantity >= 0)
);


-- ============================================================
-- 3. CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50),
    registration_date DATE NOT NULL
);


-- ============================================================
-- 4. SALES ORDERS
-- ============================================================

CREATE TABLE sales_orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    region VARCHAR(50) NOT NULL,
    order_status ENUM(
        'Completed',
        'Pending',
        'Cancelled'
    ) NOT NULL DEFAULT 'Completed',

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


-- ============================================================
-- 5. SALES ORDER ITEMS
-- ============================================================

CREATE TABLE sales_order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount_percent DECIMAL(5, 2) NOT NULL DEFAULT 0.00,

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES sales_orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_order_items_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_items_price
        CHECK (unit_price >= 0),

    CONSTRAINT chk_order_items_discount
        CHECK (
            discount_percent >= 0
            AND discount_percent <= 100
        )
);


-- ============================================================
-- INDEXES
-- ============================================================

CREATE INDEX idx_products_category
ON products(category_id);

CREATE INDEX idx_customers_region
ON customers(region);

CREATE INDEX idx_orders_customer
ON sales_orders(customer_id);

CREATE INDEX idx_orders_date
ON sales_orders(order_date);

CREATE INDEX idx_orders_status
ON sales_orders(order_status);

CREATE INDEX idx_order_items_order
ON sales_order_items(order_id);

CREATE INDEX idx_order_items_product
ON sales_order_items(product_id);


-- ============================================================
-- VERIFICATION
-- ============================================================

SHOW TABLES;
