-- ============================================================
-- Module 29: Full-Text Search
-- File: examples.sql
-- MySQL 8.0+
-- ============================================================

DROP DATABASE IF EXISTS sql_practice_fulltext;
CREATE DATABASE sql_practice_fulltext;

USE sql_practice_fulltext;

-- ============================================================
-- 1. Create Categories
-- ============================================================

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO categories (category_id, category_name)
VALUES
    (1, 'Databases'),
    (2, 'Programming'),
    (3, 'Web Development'),
    (4, 'Cybersecurity');

-- ============================================================
-- 2. Create Articles
-- ============================================================

CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    category_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    published_at DATE,
    FULLTEXT INDEX idx_article_fulltext (title, content),
    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

INSERT INTO articles
    (article_id, category_id, title, content, status, published_at)
VALUES
    (
        1,
        1,
        'Introduction to MySQL',
        'MySQL is a relational database management system used to store and manage structured data.',
        'published',
        '2026-01-10'
    ),
    (
        2,
        1,
        'Database Design Fundamentals',
        'Good database design reduces redundancy and improves data integrity through appropriate tables and relationships.',
        'published',
        '2026-01-15'
    ),
    (
        3,
        1,
        'SQL Query Optimization',
        'Query optimization involves indexes, execution plans, filtering, joins, and efficient SQL statements.',
        'published',
        '2026-02-01'
    ),
    (
        4,
        2,
        'Python Programming Basics',
        'Python is a popular programming language used for automation, data analysis, and application development.',
        'published',
        '2026-02-10'
    ),
    (
        5,
        3,
        'Modern Web Development',
        'Web development commonly uses HTML, CSS, JavaScript, databases, APIs, and server-side programming.',
        'published',
        '2026-02-20'
    ),
    (
        6,
        4,
        'Introduction to Cybersecurity',
        'Cybersecurity protects systems, networks, applications, and data from unauthorized access and attacks.',
        'published',
        '2026-03-01'
    ),
    (
        7,
        1,
        'Advanced MySQL Performance',
        'MySQL performance depends on indexes, query structure, statistics, joins, and appropriate database design.',
        'published',
        '2026-03-05'
    ),
    (
        8,
        2,
        'Programming and Databases',
        'Modern applications often combine programming languages with relational databases and APIs.',
        'draft',
        NULL
    ),
    (
        9,
        1,
        'Database Normalization',
        'Database normalization organizes data into related tables and reduces update, insert, and delete anomalies.',
        'published',
        '2026-03-10'
    ),
    (
        10,
        3,
        'Building Search Applications',
        'Search applications can combine database queries, full-text search, relevance ranking, filters, and pagination.',
        'published',
        '2026-03-15'
    );

-- ============================================================
-- 3. Inspect the FULLTEXT Index
-- ============================================================

SHOW INDEX FROM articles;

SHOW CREATE TABLE articles;

-- ============================================================
-- 4. Basic FULLTEXT Search
-- ============================================================

SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- ============================================================
-- 5. Search for Multiple Terms
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('database design');

-- ============================================================
-- 6. Calculate Relevance
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- ============================================================
-- 7. Order by Relevance
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC;

-- ============================================================
-- 8. Limit Search Results
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC
LIMIT 5;

-- ============================================================
-- 9. Search Only Published Articles
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('programming');

-- ============================================================
-- 10. Search With a Date Filter
-- ============================================================

SELECT
    article_id,
    title,
    published_at
FROM articles
WHERE status = 'published'
  AND published_at >= '2026-02-01'
  AND MATCH(title, content)
      AGAINST('database')
ORDER BY published_at DESC;

-- ============================================================
-- 11. Search With JOIN
-- ============================================================

SELECT
    a.article_id,
    a.title,
    c.category_name
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE MATCH(a.title, a.content)
      AGAINST('database');

-- ============================================================
-- 12. Search by Category
-- ============================================================

SELECT
    a.article_id,
    a.title,
    c.category_name
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE c.category_name = 'Databases'
  AND MATCH(a.title, a.content)
      AGAINST('mysql');

-- ============================================================
-- 13. Boolean Mode
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql database' IN BOOLEAN MODE);

-- ============================================================
-- 14. Required Terms Using +
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+mysql +database' IN BOOLEAN MODE);

-- ============================================================
-- 15. Excluding Terms Using -
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+database -python' IN BOOLEAN MODE);

-- ============================================================
-- 16. Prefix Search
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('databas*' IN BOOLEAN MODE);

-- ============================================================
-- 17. Phrase Search
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('"database design"' IN BOOLEAN MODE);

-- ============================================================
-- 18. Required Phrase
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+"database design"' IN BOOLEAN MODE);

-- ============================================================
-- 19. Relevance With Boolean Search
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('+database +design' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('+database +design' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- ============================================================
-- 20. Increasing Relevance Using >
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql >database' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql >database' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- ============================================================
-- 21. Decreasing Relevance Using <
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql <programming' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql <programming' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- ============================================================
-- 22. Soft Exclusion Using ~
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database ~python' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database ~python' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- ============================================================
-- 23. Combining Boolean Operators
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST(
          '+database +mysql -python'
          IN BOOLEAN MODE
      );

-- ============================================================
-- 24. Query Expansion
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST(
          'database'
          WITH QUERY EXPANSION
      );

-- ============================================================
-- 25. Search With CASE
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance,
    CASE
        WHEN MATCH(title, content)
             AGAINST('database') >= 3
            THEN 'Highly Relevant'
        WHEN MATCH(title, content)
             AGAINST('database') >= 1
            THEN 'Relevant'
        ELSE 'Low Relevance'
    END AS relevance_level
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC;

-- ============================================================
-- 26. Count Matching Articles
-- ============================================================

SELECT
    COUNT(*) AS matching_articles
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- ============================================================
-- 27. Count Matches by Category
-- ============================================================

SELECT
    c.category_name,
    COUNT(*) AS matching_articles
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE MATCH(a.title, a.content)
      AGAINST('database')
GROUP BY c.category_id, c.category_name
ORDER BY matching_articles DESC;

-- ============================================================
-- 28. Search and Group by Status
-- ============================================================

SELECT
    status,
    COUNT(*) AS matching_articles
FROM articles
WHERE MATCH(title, content)
      AGAINST('programming')
GROUP BY status;

-- ============================================================
-- 29. Search With Pagination
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC
LIMIT 3 OFFSET 0;

-- ============================================================
-- 30. Second Search Page
-- ============================================================

SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC
LIMIT 3 OFFSET 3;

-- ============================================================
-- 31. Compare FULLTEXT With LIKE
-- ============================================================

SELECT
    article_id,
    title
FROM articles
WHERE content LIKE '%database%';

SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- ============================================================
-- 32. Create a Reviews Table
-- ============================================================

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    article_id INT NOT NULL,
    review_title VARCHAR(255) NOT NULL,
    review_text TEXT NOT NULL,
    rating INT NOT NULL,
    FULLTEXT INDEX idx_review_fulltext (review_title, review_text),
    FOREIGN KEY (article_id)
        REFERENCES articles(article_id)
);

INSERT INTO reviews
    (review_id, article_id, review_title, review_text, rating)
VALUES
    (
        1,
        1,
        'Excellent MySQL Introduction',
        'The database examples are clear and useful for beginners.',
        5
    ),
    (
        2,
        3,
        'Helpful Optimization Guide',
        'The article explains indexes and query optimization well.',
        5
    ),
    (
        3,
        4,
        'Good Python Tutorial',
        'The programming examples are easy to understand.',
        4
    ),
    (
        4,
        7,
        'Useful Performance Information',
        'The MySQL performance discussion is practical.',
        5
    ),
    (
        5,
        9,
        'Clear Normalization Explanation',
        'The database design concepts are explained clearly.',
        4
    );

-- ============================================================
-- 33. Search Reviews
-- ============================================================

SELECT
    review_id,
    review_title,
    rating
FROM reviews
WHERE MATCH(review_title, review_text)
      AGAINST('database');

-- ============================================================
-- 34. Search Reviews With Relevance
-- ============================================================

SELECT
    review_id,
    review_title,
    rating,
    MATCH(review_title, review_text)
        AGAINST('database') AS relevance
FROM reviews
WHERE MATCH(review_title, review_text)
      AGAINST('database')
ORDER BY relevance DESC;

-- ============================================================
-- 35. Search Reviews With Article Information
-- ============================================================

SELECT
    r.review_id,
    r.review_title,
    a.title AS article_title,
    r.rating
FROM reviews AS r
JOIN articles AS a
    ON r.article_id = a.article_id
WHERE MATCH(r.review_title, r.review_text)
      AGAINST('database');

-- ============================================================
-- 36. Search Product Catalog
-- ============================================================

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FULLTEXT INDEX idx_product_search (product_name, description)
);

INSERT INTO products
    (product_id, product_name, description, price)
VALUES
    (
        1,
        'Wireless Keyboard',
        'Compact wireless keyboard suitable for programming and office work.',
        1499.00
    ),
    (
        2,
        'Mechanical Keyboard',
        'Mechanical keyboard designed for programming and gaming.',
        3999.00
    ),
    (
        3,
        'Wireless Mouse',
        'Ergonomic wireless mouse for office and computer work.',
        999.00
    ),
    (
        4,
        'USB-C Hub',
        'USB-C hub with multiple ports for laptops and computers.',
        1799.00
    ),
    (
        5,
        'Programming Laptop',
        'Laptop designed for programming, databases, and development work.',
        64999.00
    );

-- ============================================================
-- 37. Product Search
-- ============================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE MATCH(product_name, description)
      AGAINST('wireless keyboard');

-- ============================================================
-- 38. Ranked Product Search
-- ============================================================

SELECT
    product_id,
    product_name,
    price,
    MATCH(product_name, description)
        AGAINST('programming') AS relevance
FROM products
WHERE MATCH(product_name, description)
      AGAINST('programming')
ORDER BY relevance DESC;

-- ============================================================
-- 39. Boolean Product Search
-- ============================================================

SELECT
    product_id,
    product_name,
    price
FROM products
WHERE MATCH(product_name, description)
      AGAINST('+wireless -gaming' IN BOOLEAN MODE);

-- ============================================================
-- 40. Prefix Product Search
-- ============================================================

SELECT
    product_id,
    product_name
FROM products
WHERE MATCH(product_name, description)
      AGAINST('program*' IN BOOLEAN MODE);

-- ============================================================
-- End of examples.sql
-- ============================================================
