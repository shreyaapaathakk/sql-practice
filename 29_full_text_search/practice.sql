-- ============================================================
-- Module 29: Full-Text Search
-- File: practice.sql
-- MySQL 8.0+
-- ============================================================

USE sql_practice_fulltext;

-- ============================================================
-- EASY
-- ============================================================

-- 1. Display all articles.

-- 2. Search articles containing the term "database" using
--    FULLTEXT search.

-- 3. Search articles for the term "mysql".

-- 4. Search articles for "programming".

-- 5. Search the title and content columns for "database design".

-- 6. Display article_id and title for articles matching
--    "optimization".

-- 7. Calculate the relevance score for a search for
--    "database".

-- 8. Sort database search results by relevance descending.

-- 9. Return only the top 5 database search results.

-- 10. Search only published articles for "database".

-- ============================================================
-- EASY → MEDIUM
-- ============================================================

-- 11. Search articles published on or after 2026-02-01
--     for "database".

-- 12. Join articles with categories and display:
--     article_id, title, category_name
--     for articles matching "database".

-- 13. Search only the Databases category for "mysql".

-- 14. Count the number of articles matching "database".

-- 15. Count database-related articles by category.

-- 16. Count programming-related articles by status.

-- 17. Search for "mysql database" using natural language mode.

-- 18. Search for "mysql database" using Boolean mode.

-- 19. Use + so that both "mysql" and "database" are required.

-- 20. Search for articles containing "database" but excluding
--     "python".

-- ============================================================
-- MEDIUM
-- ============================================================

-- 21. Perform a Boolean prefix search for words beginning
--     with "databas".

-- 22. Search for the exact phrase "database design".

-- 23. Search for the exact phrase "query optimization".

-- 24. Require the phrase "database design" using Boolean mode.

-- 25. Search for "mysql" while decreasing the relevance of
--     "programming" using <.

-- 26. Search for "database" while increasing the relevance
--     of "mysql" using >.

-- 27. Search for "database" while soft-excluding "python"
--     using ~.

-- 28. Create a search using:
--     +database
--     +mysql
--     -python

-- 29. Return article titles and relevance scores for a search
--     for "mysql".

-- 30. Create a CASE expression that classifies search results
--     as:
--       relevance >= 3  -> Highly Relevant
--       relevance >= 1  -> Relevant
--       otherwise       -> Low Relevance

-- ============================================================
-- MEDIUM → HARD
-- ============================================================

-- 31. Return the first page of database search results using
--     LIMIT 3 OFFSET 0.

-- 32. Return the second page using LIMIT 3 OFFSET 3.

-- 33. Return the third page using LIMIT 3 OFFSET 6.

-- 34. Search only published articles and order results by
--     relevance.

-- 35. Search articles after 2026-01-31 for "mysql" and order
--     by relevance.

-- 36. Search "database" and return category information.

-- 37. Count database search results by category and sort the
--     categories by the number of matches.

-- 38. Search reviews for "database".

-- 39. Search reviews for "optimization" and display the
--     relevance score.

-- 40. Join reviews and articles and display matching reviews
--     together with their article titles.

-- ============================================================
-- HARD
-- ============================================================

-- 41. Search products for "wireless keyboard".

-- 42. Return product search results ordered by relevance.

-- 43. Search products using Boolean mode where "wireless"
--     is required and "gaming" is excluded.

-- 44. Perform a prefix search for "program".

-- 45. Search products for "programming database".

-- 46. Display product name, price, and relevance for a
--     programming search.

-- 47. Find the three most relevant products for "programming".

-- 48. Find all published articles matching either a database
--     concept or MySQL-related search using two separate
--     FULLTEXT searches combined with OR.

-- 49. Create a search that requires "database" and excludes
--     "python", then order the results by relevance.

-- 50. Search for the exact phrase "query optimization" and
--     display the matching article titles.

-- ============================================================
-- ADVANCED BEGINNER
-- ============================================================

-- 51. Create a ranked search for "database mysql" that returns:
--       article_id
--       title
--       relevance
--     and sorts by relevance descending and article_id ascending.

-- 52. Create a published-article search for "database" with:
--       category_name
--       title
--       relevance
--     sorted by relevance.

-- 53. Find the number of published articles matching "database"
--     in each category.

-- 54. Return the most relevant published article matching
--     "mysql".

-- 55. Return the most recent published article matching
--     "database", while using relevance as the primary ordering
--     criterion.

-- 56. Search reviews for "database", return review title,
--     rating, and relevance, and sort by relevance descending.

-- 57. Find the average rating of reviews matching "database".

-- 58. Find the category containing the greatest number of
--     articles matching "database".

-- 59. Build a product search returning only products that:
--       contain "programming"
--       cost less than 50000
--     and display relevance.

-- 60. Build a final article search that:
--       - searches title and content
--       - requires "database"
--       - excludes "python"
--       - searches only published articles
--       - orders by relevance
--       - returns the top 5 results

-- ============================================================
-- End of practice.sql
-- ============================================================
