# Module 29: Full-Text Search in MySQL

## 1. Introduction

Full-text search allows MySQL to search efficiently through large amounts of textual data.

For example, an application may need to search:

* Product names and descriptions
* Blog posts
* Articles
* Customer reviews
* Documentation
* Job descriptions
* Support tickets
* News content

A simple search can be performed using `LIKE`:

```sql
SELECT *
FROM products
WHERE description LIKE '%database%';
```

However, `LIKE` is not designed to provide sophisticated text search or relevance ranking.

MySQL provides **Full-Text Search** through `FULLTEXT` indexes and the `MATCH() ... AGAINST()` syntax.

---

# 2. What Is Full-Text Search?

Full-text search is a search technique designed specifically for natural-language text.

Instead of simply checking whether a sequence of characters exists, MySQL analyzes words in the indexed text and can determine how relevant each row is to a search query.

The basic syntax is:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');
```

Here:

* `MATCH()` specifies the columns being searched.
* `AGAINST()` specifies the search terms.

---

# 3. FULLTEXT Index

Before using full-text search efficiently, the searched columns normally need a `FULLTEXT` index.

Example:

```sql
CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    FULLTEXT(title, content)
);
```

The `FULLTEXT` index allows MySQL to build a searchable index over the text.

You can also add the index later:

```sql
ALTER TABLE articles
ADD FULLTEXT(title, content);
```

---

# 4. Columns Supported by FULLTEXT

Full-text indexes can be created on:

* `CHAR`
* `VARCHAR`
* `TEXT`

Example:

```sql
CREATE FULLTEXT INDEX idx_article_search
ON articles(title, content);
```

The columns in a `MATCH()` expression must correspond to a compatible full-text index.

For example:

```sql
MATCH(title, content)
```

should use an index covering:

```text
(title, content)
```

---

# 5. MATCH() ... AGAINST()

The primary syntax is:

```sql
MATCH(column1, column2)
AGAINST('search terms');
```

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('SQL database');
```

This searches the `title` and `content` columns for the specified terms.

---

# 6. Natural Language Mode

Natural language mode is the default full-text search mode.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('database optimization');
```

Natural language search attempts to determine which rows are more relevant to the search terms.

It is useful when users enter normal search queries.

---

# 7. Relevance Scores

One important advantage of full-text search is that MySQL can calculate a **relevance score**.

Example:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC;
```

Rows with higher relevance scores appear first.

This is useful for implementing search-result ranking.

---

# 8. Using MATCH() in SELECT

`MATCH() ... AGAINST()` does not have to appear only in `WHERE`.

It can also appear in the `SELECT` list.

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('MySQL') AS relevance
FROM articles;
```

The relevance value can then be used for sorting.

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('MySQL') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('MySQL')
ORDER BY relevance DESC;
```

---

# 9. Searching Multiple Columns

Full-text search can search several columns together.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(200),
    description TEXT,
    FULLTEXT(name, description)
);
```

Search:

```sql
SELECT *
FROM products
WHERE MATCH(name, description)
      AGAINST('wireless keyboard');
```

Searching multiple columns is useful when different pieces of text together describe the searchable content.

---

# 10. Boolean Mode

Boolean mode provides more control over the search.

Syntax:

```sql
MATCH(column1, column2)
AGAINST('query' IN BOOLEAN MODE)
```

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql database' IN BOOLEAN MODE);
```

Boolean mode supports special operators that allow more precise searches.

---

# 11. Required Words Using +

The `+` operator requires a word to be present.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('+mysql +database' IN BOOLEAN MODE);
```

Both words are required.

Conceptually:

```text
mysql AND database
```

---

# 12. Excluding Words Using -

The `-` operator excludes a word.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('+mysql -oracle' IN BOOLEAN MODE);
```

This means:

* `mysql` must appear.
* `oracle` must not appear.

---

# 13. Prefix Searches Using *

The `*` operator performs a prefix search.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('databas*' IN BOOLEAN MODE);
```

This can match words beginning with the specified prefix.

For example:

```text
database
databases
databased
```

Prefix searching is particularly useful for partial word searches.

---

# 14. Phrase Searching

Double quotation marks can be used to search for a phrase.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('"database design"' IN BOOLEAN MODE);
```

This searches for the phrase rather than treating the words independently.

Phrase searches can be useful for queries such as:

```text
"machine learning"
"database design"
"web development"
```

---

# 15. Soft Exclusion Using ~

The `~` operator can indicate that a word should reduce relevance rather than completely exclude a row.

Example:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql ~oracle' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql ~oracle' IN BOOLEAN MODE)
ORDER BY relevance DESC;
```

Unlike `-`, the `~` operator does not simply remove matching rows.

It can reduce their relevance.

---

# 16. Increasing Relevance Using >

The `>` operator can increase the importance of a search term.

Example:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql >database' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql >database' IN BOOLEAN MODE)
ORDER BY relevance DESC;
```

This is useful when one term should contribute more strongly to ranking.

---

# 17. Decreasing Relevance Using <

The `<` operator can decrease the importance of a search term.

Example:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql <tutorial' IN BOOLEAN MODE) AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql <tutorial' IN BOOLEAN MODE)
ORDER BY relevance DESC;
```

This allows more control over relevance ranking.

---

# 18. Natural Language vs Boolean Mode

The two common modes serve different purposes.

### Natural Language

```sql
AGAINST('mysql database')
```

Good for:

* General searches
* User-friendly search boxes
* Relevance-based ranking
* Natural search queries

### Boolean Mode

```sql
AGAINST('+mysql -oracle' IN BOOLEAN MODE)
```

Good for:

* Required words
* Excluded words
* Prefix searches
* Exact phrases
* More controlled searches

---

# 19. Searching With LIKE vs FULLTEXT

Consider:

```sql
SELECT *
FROM articles
WHERE content LIKE '%database%';
```

This searches for a character sequence.

Full-text search:

```sql
SELECT *
FROM articles
WHERE MATCH(content)
      AGAINST('database');
```

is designed specifically for word-based text searching.

### LIKE

Advantages:

* Simple
* Supports arbitrary substring searches
* Easy to understand
* Useful for small datasets

Limitations:

* No relevance ranking
* Leading `%` can prevent efficient index use
* Not designed for natural-language search
* Can become expensive on large text datasets

### FULLTEXT

Advantages:

* Designed for text searching
* Supports relevance
* Supports natural-language search
* Supports Boolean operators
* Can search large text collections more effectively

---

# 20. FULLTEXT Search and WHERE Conditions

Full-text search can be combined with normal filtering.

Example:

```sql
SELECT *
FROM articles
WHERE category_id = 5
  AND MATCH(title, content)
      AGAINST('database');
```

The full-text condition does not replace ordinary filtering.

You can combine it with:

```sql
WHERE
    status = 'published'
    AND category_id = 5
    AND MATCH(title, content)
        AGAINST('database');
```

---

# 21. FULLTEXT Search With ORDER BY

Search results can be ranked by relevance.

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC;
```

This creates a basic search-results system.

---

# 22. FULLTEXT Search With LIMIT

Search results can be limited.

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC
LIMIT 10;
```

This is useful for applications where only the top results should be displayed.

---

# 23. FULLTEXT Search With JOIN

Full-text search can be combined with joins.

Example:

```sql
SELECT
    a.article_id,
    a.title,
    c.category_name
FROM articles a
JOIN categories c
    ON a.category_id = c.category_id
WHERE MATCH(a.title, a.content)
      AGAINST('database');
```

The search determines which articles match, while the join retrieves related information.

---

# 24. FULLTEXT Search With CASE

Search results can also be classified.

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql') AS relevance,
    CASE
        WHEN MATCH(title, content)
             AGAINST('mysql') >= 5
            THEN 'Highly Relevant'
        WHEN MATCH(title, content)
             AGAINST('mysql') >= 2
            THEN 'Relevant'
        ELSE 'Low Relevance'
    END AS relevance_level
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql');
```

This can be useful for custom search interfaces.

---

# 25. FULLTEXT Search With Aggregation

Full-text results can be aggregated by category.

Example:

```sql
SELECT
    category_id,
    COUNT(*) AS matching_articles
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
GROUP BY category_id;
```

This can be used to build search-result summaries.

---

# 26. Stopwords

MySQL full-text search can ignore certain common words called **stopwords**.

Examples of common words may include:

```text
the
and
is
of
to
```

The exact behavior depends on the MySQL full-text configuration.

This is important because searching for a very common word may not behave like a normal substring search.

---

# 27. Minimum Word Length

MySQL can also ignore words below a configured minimum length.

For example, a very short word may not be indexed depending on the configured full-text settings.

This means:

```sql
AGAINST('SQL')
```

does not necessarily behave like:

```sql
LIKE '%SQL%'
```

when configuration causes short words to be excluded from the full-text index.

Always consider the server's full-text configuration when designing a search system.

---

# 28. Full-Text Search and Word Boundaries

Full-text search is primarily word-oriented.

For example:

```text
database
```

is treated as a word rather than simply a sequence of characters.

Therefore, full-text search should not automatically be considered a replacement for every possible `LIKE` search.

If an application needs substring matching inside arbitrary words, `LIKE` or another search technology may be more appropriate.

---

# 29. FULLTEXT Index Inspection

Indexes can be inspected using:

```sql
SHOW INDEX FROM articles;
```

This allows you to verify that the expected `FULLTEXT` index exists.

You can also inspect table creation:

```sql
SHOW CREATE TABLE articles;
```

This is useful when troubleshooting full-text search.

---

# 30. Adding a FULLTEXT Index to an Existing Table

Suppose a table already exists:

```sql
CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT
);
```

A full-text index can be added later:

```sql
ALTER TABLE articles
ADD FULLTEXT idx_article_fulltext(title, content);
```

Then search:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('database');
```

---

# 31. Removing a FULLTEXT Index

If an index is no longer needed:

```sql
ALTER TABLE articles
DROP INDEX idx_article_fulltext;
```

The full-text search using that index should then be redesigned or the index recreated if the search remains necessary.

---

# 32. FULLTEXT Index Naming

Use descriptive index names.

Good:

```sql
idx_article_fulltext
```

```sql
idx_product_search
```

```sql
idx_review_fulltext
```

Avoid unclear names such as:

```sql
idx1
index2
search
```

Clear naming makes database maintenance easier.

---

# 33. Searching Titles and Content Together

A common application pattern is:

```sql
FULLTEXT(title, content)
```

and:

```sql
MATCH(title, content)
AGAINST('database optimization');
```

This treats the title and content as a combined searchable document.

However, sometimes the title should have greater importance than the body.

In such cases, applications may perform separate searches or implement additional ranking logic.

---

# 34. Search Relevance

Relevance is one of the most useful features of full-text search.

Example:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql')
ORDER BY relevance DESC;
```

The result can be conceptually viewed as:

| article_id | title                   | relevance |
| ---------: | ----------------------- | --------: |
|          4 | MySQL Performance Guide |       7.5 |
|          8 | Introduction to MySQL   |       4.2 |
|         12 | Database Concepts       |       1.8 |

The exact relevance values depend on the indexed data and search configuration.

---

# 35. Query Expansion

MySQL supports query expansion using:

```sql
WITH QUERY EXPANSION
```

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('database' WITH QUERY EXPANSION);
```

Query expansion can use terms found in highly relevant results to broaden the search.

It can be useful when users enter incomplete search terms.

However, it should be tested carefully because broadening a query can also introduce less relevant results.

---

# 36. Boolean Mode Does Not Require Natural-Language Ranking

Boolean mode is designed primarily around search conditions and operators.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('+mysql -oracle' IN BOOLEAN MODE);
```

It is especially useful when the application needs precise search rules.

---

# 37. Prefix Search for User Queries

A search interface might allow:

```text
data*
```

which can match words beginning with:

```text
data
database
datasets
```

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('data*' IN BOOLEAN MODE);
```

The wildcard must be used in Boolean mode for this style of prefix searching.

---

# 38. Exact Phrase Search

For a phrase such as:

```text
"database normalization"
```

use:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST('"database normalization"' IN BOOLEAN MODE);
```

Phrase searching is useful when word order matters.

---

# 39. Combining Boolean Operators

Boolean operators can be combined.

Example:

```sql
SELECT *
FROM articles
WHERE MATCH(title, content)
      AGAINST(
          '+mysql +database -oracle'
          IN BOOLEAN MODE
      );
```

Conceptually:

```text
mysql must exist
database must exist
oracle must not exist
```

Another example:

```sql
SELECT *
FROM products
WHERE MATCH(name, description)
      AGAINST(
          '+wireless +(keyboard mouse) -gaming'
          IN BOOLEAN MODE
      );
```

Complex Boolean searches should be tested carefully to make sure they match the intended business requirements.

---

# 40. FULLTEXT Search in a Product Catalog

A product search system might contain:

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    description TEXT,
    FULLTEXT(product_name, description)
);
```

A basic search:

```sql
SELECT
    product_id,
    product_name,
    MATCH(product_name, description)
        AGAINST('wireless keyboard') AS relevance
FROM products
WHERE MATCH(product_name, description)
      AGAINST('wireless keyboard')
ORDER BY relevance DESC;
```

This provides a foundation for a searchable product catalog.

---

# 41. FULLTEXT Search in Reviews

Reviews are another common use case.

```sql
CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    review_title VARCHAR(255),
    review_text TEXT,
    FULLTEXT(review_title, review_text)
);
```

Search:

```sql
SELECT
    review_id,
    product_id,
    review_title
FROM reviews
WHERE MATCH(review_title, review_text)
      AGAINST('excellent quality');
```

This allows applications to find reviews containing relevant concepts.

---

# 42. Search With Status Filtering

Suppose articles have a status:

```text
draft
published
archived
```

A public search should usually search only published articles.

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql') AS relevance
FROM articles
WHERE status = 'published'
  AND MATCH(title, content)
      AGAINST('mysql')
ORDER BY relevance DESC;
```

This demonstrates an important principle:

> Full-text search is one part of a query, not necessarily the entire query.

---

# 43. Search With Dates

Search can also be restricted by date.

```sql
SELECT
    article_id,
    title,
    published_at
FROM articles
WHERE published_at >= '2026-01-01'
  AND MATCH(title, content)
      AGAINST('database')
ORDER BY published_at DESC;
```

This can be useful for news, blogs, documentation, and other time-based content.

---

# 44. Search and Pagination

A real application often needs pagination.

Example:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('database')
ORDER BY relevance DESC
LIMIT 20 OFFSET 40;
```

This retrieves a page of results.

For very large search systems, however, pagination strategy should be designed carefully for performance.

---

# 45. Full-Text Search and Performance

Full-text indexes are designed to make text searching more efficient than repeatedly scanning large text columns.

However, performance still depends on:

* Number of rows
* Amount of text
* Search complexity
* Index configuration
* Additional filters
* Server resources
* Query design

Do not assume that adding a full-text index automatically makes every query fast.

Measure real workloads.

---

# 46. Full-Text Search vs Traditional Indexes

A normal B-tree index:

```sql
CREATE INDEX idx_title
ON articles(title);
```

is useful for many structured operations.

A full-text index:

```sql
CREATE FULLTEXT INDEX idx_article_search
ON articles(title, content);
```

is specifically designed for full-text searching.

They solve different problems.

Do not treat `FULLTEXT` as simply another replacement for every ordinary index.

---

# 47. FULLTEXT and Exact Equality

If you need an exact value:

```sql
WHERE product_code = 'ABC123'
```

a normal index is appropriate.

Full-text search is intended for textual search such as:

```sql
MATCH(name, description)
AGAINST('wireless keyboard');
```

Choose the indexing strategy according to the type of query.

---

# 48. FULLTEXT and LIKE

These approaches can coexist.

For example:

```sql
SELECT *
FROM products
WHERE MATCH(name, description)
      AGAINST('keyboard')
   OR name LIKE '%keyboard%';
```

This can be useful when an application needs both:

* word-based search
* arbitrary substring matching

However, combining search strategies should be done intentionally because it can affect performance and result ranking.

---

# 49. Search Architecture

A practical search workflow can look like this:

```text
User enters search
        ↓
Normalize search input
        ↓
Choose search mode
        ↓
Run FULLTEXT search
        ↓
Calculate relevance
        ↓
Apply filters
        ↓
Sort results
        ↓
Paginate
        ↓
Return results
```

The database handles the core search operation, while the application can handle additional business logic.

---

# 50. Security Considerations

Search input often comes directly from users.

Applications should avoid constructing SQL through unsafe string concatenation.

Bad application pattern:

```text
"SELECT ... AGAINST('" + user_input + "')"
```

Applications should use parameterized queries or prepared statements.

The database search itself does not eliminate SQL injection risks.

---

# 51. Choosing Natural Language or Boolean Mode

Use **natural language mode** when:

* Users enter ordinary search terms.
* Relevance ranking is important.
* You want a simple search experience.

Use **Boolean mode** when:

* Specific words must be present.
* Certain words must be excluded.
* Prefix searching is needed.
* Phrase searching is needed.
* The application needs more control over matching.

---

# 52. Common Mistakes

### Mistake 1: Forgetting the FULLTEXT index

```sql
MATCH(title, content)
AGAINST('mysql')
```

should be supported by an appropriate full-text index for normal indexed use.

### Mistake 2: Treating FULLTEXT like LIKE

These are different search systems.

### Mistake 3: Expecting arbitrary substring matching

Full-text search is word-oriented.

### Mistake 4: Ignoring stopwords and minimum word length

Configuration can affect which terms are searchable.

### Mistake 5: Forgetting relevance ranking

For search-result systems, relevance can be extremely useful.

### Mistake 6: Using Boolean operators without understanding them

For example:

```sql
'+mysql -oracle'
```

has very different behavior from:

```sql
'mysql oracle'
```

### Mistake 7: Building SQL with raw user input

Always use safe parameter handling in application code.

---

# 53. Best Practices

1. Use `FULLTEXT` indexes for genuine text-search requirements.
2. Use `MATCH() ... AGAINST()` for full-text searches.
3. Use natural language mode for general search.
4. Use Boolean mode when precise control is required.
5. Use relevance scores to rank results.
6. Use `LIMIT` for search-result pages.
7. Combine full-text search with normal filters where appropriate.
8. Understand stopword and minimum-word-length behavior.
9. Do not use full-text search for arbitrary substring requirements.
10. Keep full-text index names descriptive.
11. Inspect indexes when troubleshooting.
12. Benchmark search queries using realistic data.
13. Use prepared statements in application code.
14. Test search behavior with realistic user queries.
15. Keep search requirements separate from database indexing assumptions.

---

# 54. Practical Example

Suppose we have:

```sql
CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    status VARCHAR(20),
    FULLTEXT(title, content)
);
```

A basic search:

```sql
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql database');
```

Ranked search:

```sql
SELECT
    article_id,
    title,
    MATCH(title, content)
        AGAINST('mysql database') AS relevance
FROM articles
WHERE MATCH(title, content)
      AGAINST('mysql database')
ORDER BY relevance DESC;
```

Boolean search:

```sql
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('+mysql -oracle' IN BOOLEAN MODE);
```

Phrase search:

```sql
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('"database design"' IN BOOLEAN MODE);
```

Prefix search:

```sql
SELECT
    article_id,
    title
FROM articles
WHERE MATCH(title, content)
      AGAINST('databas*' IN BOOLEAN MODE);
```

---

# 55. Full-Text Search Checklist

Before implementing a full-text search feature, ask:

```text
[ ] What text needs to be searchable?
[ ] Which columns should be indexed?
[ ] Is a FULLTEXT index present?
[ ] Should natural language mode be used?
[ ] Is Boolean mode required?
[ ] Is relevance ranking required?
[ ] Are phrase searches required?
[ ] Are prefix searches required?
[ ] Are stopwords relevant?
[ ] Is minimum word length relevant?
[ ] Are normal WHERE filters required?
[ ] Is pagination required?
[ ] Is the query parameterized?
[ ] Has performance been tested?
```

---

# 56. Key Takeaways

* Full-text search is designed for searching textual data.
* MySQL implements full-text search using `FULLTEXT` indexes.
* `MATCH() ... AGAINST()` is the primary full-text search syntax.
* Natural language mode is the default search mode.
* Boolean mode provides more precise search control.
* `+` requires a term.
* `-` excludes a term.
* `*` performs prefix matching.
* Quotation marks can be used for phrase searches.
* `~`, `>` and `<` can influence relevance in Boolean searches.
* Full-text search can return relevance scores.
* Relevance can be used with `ORDER BY`.
* Full-text search works well with normal SQL filtering and joins.
* `FULLTEXT` is different from a normal B-tree index.
* `FULLTEXT` is not a universal replacement for `LIKE`.
* Stopwords and minimum word length can affect search results.
* Search input should be handled safely using parameterized queries.
* Good search systems combine indexing, relevance, filtering, ranking, and pagination.

---

# 57. Module 29 Learning Goal

After completing this module, you should be able to:

1. Explain what full-text search is.
2. Create a `FULLTEXT` index.
3. Search text using `MATCH() ... AGAINST()`.
4. Use natural language search.
5. Use Boolean mode.
6. Require and exclude search terms.
7. Perform prefix searches.
8. Search exact phrases.
9. Calculate and use relevance scores.
10. Combine full-text search with joins and filters.
11. Understand the difference between `LIKE` and `FULLTEXT`.
12. Understand stopwords and minimum word-length considerations.
13. Design a basic database-backed search system.
14. Troubleshoot common full-text search problems.
15. Apply full-text search concepts to practical SQL projects.
