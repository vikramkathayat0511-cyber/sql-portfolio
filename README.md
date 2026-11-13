# SQL Portfolio

SQL analysis of the Chinook digital music store, using SQLite and DB Browser for SQLite.

The database covers customers, invoices, tracks, albums, artists and genres. Every query in this repo starts from a plain-English question and ends with the result and a written insight.

## Contents

| Folder | What it covers | Status |
|---|---|---|
| [01_Basics](01_Basics/) | Aggregate, string, numeric, date and conditional functions | Done |
| [02_Joins](02_Joins/) | JOIN, LEFT JOIN, multi-table chains, self-join | Done |
| [03_Window_functions](03_Window_functions/) | Ranking, running totals, LAG, PARTITION BY | Done |

## Key findings

**Customers and revenue**
- The store has 59 customers and 2,328.60 in revenue, about 39.47 per customer, with an average invoice of 5.65.
- The USA holds about 22% of customers and about 22% of revenue, so revenue follows customer count.
- 13 of 59 customers (22%) had not bought for over a year, measured from the last invoice in the data (22 December 2025).
- The highest average invoices (Chile, Hungary, Ireland) come from countries with a single customer, so they are unreliable.

**Catalogue and genres**
- Rock earns about 35% of revenue, and the top four genres about 73%.
- About 43% of the catalogue (1,519 of 3,503 tracks) has never been sold.
- The 10 longest tracks (up to 88 minutes) are all video files, which pulls the average track length up to 6.56 minutes.

**Trends**
- Yearly revenue is roughly flat from 2021 to 2025 (449 to 481), and 35 of 59 month-to-month changes are exactly 0.
- Rounding every invoice down would lose about 16.7% of revenue, so ROUND is the right tool for money.

## Skills demonstrated

- **Aggregation:** COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING, subqueries
- **Data cleaning and text:** string functions, CASE WHEN, COALESCE, NULL handling
- **Dates:** strftime, julianday
- **Joins:** inner, left, multi-table chains, self-join, finding unmatched rows
- **Window functions:** RANK, ROW_NUMBER, PARTITION BY, running totals, LAG, CTEs

## How each query is documented

1. **Question:** the business question in plain English
2. **Query:** the SQL that answers it
3. **Result:** what the query returned
4. **Insight:** what it means, plus a follow-up worth checking

## How to run

1. Download `Data/Chinook_Sqlite.sqlite` from this repo.
2. Open it in DB Browser for SQLite (free, sqlitebrowser.org).
3. Open any `.sql` file in the Execute SQL tab.
4. Highlight one query and press Ctrl+Enter to run it.

## Tools

- SQLite
- DB Browser for SQLite
- Dataset: Chinook sample database
