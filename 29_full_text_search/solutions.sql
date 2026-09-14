-- ============================================================
-- Module 29: Full-Text Search
-- File: solutions.sql
-- MySQL 8.0+
-- ============================================================

USE sql_practice_fulltext;

-- ============================================================
-- EASY
-- ============================================================

-- 1.
SELECT *
FROM articles;

-- 2.
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- 3.
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql');

-- 4.
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('programming');

-- 5.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('database design');

-- 6.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('optimization');

-- 7.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- 8.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC;

-- 9.
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

-- 10.
SELECT
    article_id,
    title
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('database');

-- ============================================================
-- EASY → MEDIUM
-- ============================================================

-- 11.
SELECT
    article_id,
    title,
    published_at
FROM articles
WHERE published_at >= '2026-02-01'
  AND MATCH(title, content)
      AGAINST('database');

-- 12.
SELECT
    a.article_id,
    a.title,
    c.category_name
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE MATCH(a.title, a.content)
      AGAINST('database');

-- 13.
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

-- 14.
SELECT
    COUNT(*) AS matching_articles
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');

-- 15.
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

-- 16.
SELECT
    status,
    COUNT(*) AS matching_articles
FROM articles
WHERE MATCH(title, content)
      AGAINST('programming')
GROUP BY status;

-- 17.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql database');

-- 18.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql database' IN BOOLEAN MODE);

-- 19.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+mysql +database' IN BOOLEAN MODE);

-- 20.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+database -python' IN BOOLEAN MODE);

-- ============================================================
-- MEDIUM
-- ============================================================

-- 21.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('databas*' IN BOOLEAN MODE);

-- 22.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('"database design"' IN BOOLEAN MODE);

-- 23.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('"query optimization"' IN BOOLEAN MODE);

-- 24.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+"database design"' IN BOOLEAN MODE);

-- 25.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql <programming' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql <programming' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- 26.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database >mysql' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database >mysql' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- 27.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database ~python' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database ~python' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- 28.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST(
          '+database +mysql -python'
          IN BOOLEAN MODE
      );

-- 29.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql')
ORDER BY relevance DESC;

-- 30.
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
-- MEDIUM → HARD
-- ============================================================

-- 31.
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

-- 32.
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

-- 33.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC
LIMIT 3 OFFSET 6;

-- 34.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC;

-- 35.
SELECT
    article_id,
    title,
    published_at,
    MATCH(title, content)
        AGAINST('mysql') AS relevance
FROM articles
WHERE published_at > '2026-01-31'
  AND MATCH(title, content)
      AGAINST('mysql')
ORDER BY relevance DESC;

-- 36.
SELECT
    a.article_id,
    a.title,
    c.category_name
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE MATCH(a.title, a.content)
      AGAINST('database');

-- 37.
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

-- 38.
SELECT
    review_id,
    review_title,
    review_text,
    rating
FROM reviews
WHERE MATCH(review_title, review_text)
      AGAINST('database');

-- 39.
SELECT
    review_id,
    review_title,
    rating,
    MATCH(review_title, review_text)
        AGAINST('optimization') AS relevance
FROM reviews
WHERE MATCH(review_title, review_text)
      AGAINST('optimization')
ORDER BY relevance DESC;

-- 40.
SELECT
    r.review_id,
    r.review_title,
    r.rating,
    a.title AS article_title
FROM reviews AS r
JOIN articles AS a
    ON r.article_id = a.article_id
WHERE MATCH(r.review_title, r.review_text)
      AGAINST('database');

-- ============================================================
-- HARD
-- ============================================================

-- 41.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE MATCH(product_name, description)
      AGAINST('wireless keyboard');

-- 42.
SELECT
    product_id,
    product_name,
    price,
    MATCH(product_name, description)
        AGAINST('wireless keyboard') AS relevance
FROM products
WHERE MATCH(product_name, description)
      AGAINST('wireless keyboard')
ORDER BY relevance DESC;

-- 43.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE MATCH(product_name, description)
      AGAINST('+wireless -gaming' IN BOOLEAN MODE);

-- 44.
SELECT
    product_id,
    product_name
FROM products
WHERE MATCH(product_name, description)
      AGAINST('program*' IN BOOLEAN MODE);

-- 45.
SELECT
    product_id,
    product_name,
    price
FROM products
WHERE MATCH(product_name, description)
      AGAINST('programming database');

-- 46.
SELECT
    product_name,
    price,
    MATCH(product_name, description)
        AGAINST('programming') AS relevance
FROM products
WHERE MATCH(product_name, description)
      AGAINST('programming')
ORDER BY relevance DESC;

-- 47.
SELECT
    product_id,
    product_name,
    price,
    MATCH(product_name, description)
        AGAINST('programming') AS relevance
FROM products
WHERE MATCH(product_name, description)
      AGAINST('programming')
ORDER BY relevance DESC
LIMIT 3;

-- 48.
SELECT
    article_id,
    title
FROM articles
WHERE status = 'published'
  AND (
      MATCH(title, content)
          AGAINST('database')
      OR
      MATCH(title, content)
          AGAINST('mysql')
  );

-- 49.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('+database -python' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('+database -python' IN BOOLEAN MODE)
ORDER BY relevance DESC;

-- 50.
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('"query optimization"' IN BOOLEAN MODE);

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- 51.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database mysql') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database mysql')
ORDER BY relevance DESC,
         article_id ASC;

-- 52.
SELECT
    c.category_name,
    a.title,
    MATCH(a.title, a.content)
        AGAINST('database') AS relevance
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE a.status = 'published'
  AND MATCH(a.title, a.content)
      AGAINST('database')
ORDER BY relevance DESC;

-- 53.
SELECT
    c.category_name,
    COUNT(*) AS matching_articles
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE a.status = 'published'
  AND MATCH(a.title, a.content)
      AGAINST('database')
GROUP BY c.category_id, c.category_name
ORDER BY matching_articles DESC;

-- 54.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql') AS relevance
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('mysql')
ORDER BY relevance DESC
LIMIT 1;

-- 55.
SELECT
    article_id,
    title,
    published_at,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC,
         published_at DESC
LIMIT 1;

-- 56.
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

-- 57.
SELECT
    AVG(rating) AS average_rating
FROM reviews
WHERE MATCH(review_title, review_text)
      AGAINST('database');

-- 58.
SELECT
    c.category_name,
    COUNT(*) AS matching_articles
FROM articles AS a
JOIN categories AS c
    ON a.category_id = c.category_id
WHERE MATCH(a.title, a.content)
      AGAINST('database')
GROUP BY c.category_id, c.category_name
ORDER BY matching_articles DESC
LIMIT 1;

-- 59.
SELECT
    product_id,
    product_name,
    price,
    MATCH(product_name, description)
        AGAINST('programming') AS relevance
FROM products
WHERE price < 50000
  AND MATCH(product_name, description)
      AGAINST('programming')
ORDER BY relevance DESC;

-- 60.
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('+database -python' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('+database -python' IN BOOLEAN MODE)
ORDER BY relevance DESC
LIMIT 5;

-- ============================================================
-- End of solutions.sql
-- ============================================================
