-- ============================================================
-- Module 29: Full-Text Search
-- File: challenge.sql
-- MySQL 8.0+
-- ============================================================

USE sql_practice_fulltext;

-- ============================================================
-- Challenge 1: Basic Search Engine
-- ============================================================

-- Build a search query that:
--   1. Searches article title and content.
--   2. Searches for "database".
--   3. Returns article_id, title, and relevance.
--   4. Orders by relevance descending.
--   5. Returns the top 5 results.


-- ============================================================
-- Challenge 2: Published Content Search
-- ============================================================

-- Build a search for "mysql" that returns only published
-- articles.
--
-- Display:
--   article_id
--   title
--   published_at
--   relevance
--
-- Sort by relevance descending.


-- ============================================================
-- Challenge 3: Boolean Search Rules
-- ============================================================

-- Create a Boolean search where:
--   database must exist
--   mysql must exist
--   python must not exist
--
-- Return matching article titles.


-- ============================================================
-- Challenge 4: Phrase Search
-- ============================================================

-- Find articles containing the exact phrase:
--
--     "database design"
--
-- Use Boolean mode.


-- ============================================================
-- Challenge 5: Prefix Search
-- ============================================================

-- Search for words beginning with:
--
--     program
--
-- using Boolean mode and the prefix operator.


-- ============================================================
-- Challenge 6: Search Ranking
-- ============================================================

-- Search for:
--
--     database mysql
--
-- Return:
--   article_id
--   title
--   relevance
--
-- Sort by relevance descending.


-- ============================================================
-- Challenge 7: Category Search
-- ============================================================

-- Find published articles in the "Databases" category that
-- match "mysql".
--
-- Return:
--   article_id
--   title
--   category_name
--   relevance
--
-- Sort by relevance.


-- ============================================================
-- Challenge 8: Search Statistics
-- ============================================================

-- Find how many articles in each category match:
--
--     database
--
-- Return:
--   category_name
--   matching_articles
--
-- Sort from highest count to lowest.


-- ============================================================
-- Challenge 9: Search Reviews
-- ============================================================

-- Find reviews matching:
--
--     database
--
-- Return:
--   review_id
--   review_title
--   rating
--   relevance
--
-- Sort by relevance descending.


-- ============================================================
-- Challenge 10: Average Matching Review Rating
-- ============================================================

-- Find the average rating of reviews matching:
--
--     database
--
-- Return a single value called average_rating.


-- ============================================================
-- Challenge 11: Product Search
-- ============================================================

-- Search the products table for:
--
--     wireless
--
-- Return:
--   product_id
--   product_name
--   price
--   relevance
--
-- Sort by relevance descending.


-- ============================================================
-- Challenge 12: Product Search With Price Filter
-- ============================================================

-- Search for products related to:
--
--     programming
--
-- but return only products costing less than 50000.
--
-- Display relevance and sort by relevance.


-- ============================================================
-- Challenge 13: Required and Excluded Product Terms
-- ============================================================

-- Search products where:
--   wireless must exist
--   gaming must not exist
--
-- Use Boolean mode.


-- ============================================================
-- Challenge 14: Relevance Weighting
-- ============================================================

-- Create a Boolean search for:
--
--     mysql database
--
-- where "mysql" has increased relevance.
--
-- Display relevance and sort by relevance descending.


-- ============================================================
-- Challenge 15: Search With Multiple Filters
-- ============================================================

-- Find published articles matching:
--
--     database
--
-- where:
--   published_at >= '2026-02-01'
--
-- Return:
--   article_id
--   title
--   published_at
--   relevance
--
-- Sort by relevance.


-- ============================================================
-- Challenge 16: Search Pagination
-- ============================================================

-- Create a search for:
--
--     database
--
-- Return the second page when each page contains 3 rows.
--
-- Include relevance and sort by relevance.


-- ============================================================
-- Challenge 17: Search Classification
-- ============================================================

-- Search for:
--
--     database
--
-- Create a relevance classification:
--
--   relevance >= 3 -> Highly Relevant
--   relevance >= 1 -> Relevant
--   otherwise      -> Low Relevance
--
-- Display:
--   article_id
--   title
--   relevance
--   relevance_level


-- ============================================================
-- Challenge 18: Search With JOIN and Aggregation
-- ============================================================

-- Find the number of published articles matching:
--
--     database
--
-- for each category.
--
-- Display:
--   category_name
--   matching_articles
--
-- Sort by matching_articles descending.


-- ============================================================
-- Challenge 19: Search Result Summary
-- ============================================================

-- Build a query that returns:
--
--   total matching published articles
--   highest relevance
--   average relevance
--
-- for the search:
--
--     database
--
-- Use an appropriate aggregate query.


-- ============================================================
-- Challenge 20: Combined Boolean Search
-- ============================================================

-- Create a Boolean search that:
--
--   requires database
--   requires mysql
--   excludes python
--
-- Return:
--   article_id
--   title
--   relevance
--
-- Sort by relevance.


-- ============================================================
-- Challenge 21: Search Application Query
-- ============================================================

-- Imagine a user searches for:
--
--     database mysql
--
-- Build a production-style query that:
--
--   1. Searches title and content.
--   2. Uses natural language mode.
--   3. Returns only published articles.
--   4. Calculates relevance.
--   5. Orders by relevance descending.
--   6. Uses article_id as a secondary sort.
--   7. Returns the first 5 results.
--
-- Return:
--   article_id
--   title
--   published_at
--   relevance


-- ============================================================
-- Challenge 22: Advanced Product Search
-- ============================================================

-- Build a product search for:
--
--     programming
--
-- Requirements:
--   - Product price must be below 50000.
--   - Search title/name and description.
--   - Calculate relevance.
--   - Sort by relevance descending.
--   - Return the top 3 products.


-- ============================================================
-- Challenge 23: Full-Text Search Audit
-- ============================================================

-- Inspect the articles table and verify that an appropriate
-- FULLTEXT index exists for:
--
--   title
--   content
--
-- Use:
--   SHOW INDEX
--   SHOW CREATE TABLE
--
-- Write down:
--   1. The index name.
--   2. The indexed columns.
--   3. The index type.


-- ============================================================
-- Challenge 24: Final Full-Text Search Project
-- ============================================================

-- Build a complete article-search query representing a small
-- production-style search feature.
--
-- Requirements:
--
-- 1. Search title and content.
--
-- 2. Search for:
--
--       database mysql
--
-- 3. Use Boolean mode.
--
-- 4. Require "database".
--
-- 5. Give "mysql" increased relevance.
--
-- 6. Exclude "python".
--
-- 7. Return only published articles.
--
-- 8. Join the category table.
--
-- 9. Return:
--
--       article_id
--       title
--       category_name
--       published_at
--       relevance
--
-- 10. Sort by:
--
--       relevance DESC
--       published_at DESC
--       article_id ASC
--
-- 11. Return only the top 5 results.
--
-- 12. The final query should be clean and readable.


-- ============================================================
-- End of challenge.sql
-- ============================================================
