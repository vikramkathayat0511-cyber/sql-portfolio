# SQL Portfolio

SQL analysis of the Chinook digital music store, using SQLite and DB Browser for SQLite.

The database covers customers, invoices, tracks, albums, artists and genres. Each query in this repo starts from a plain-English question and ends with the result and a written insight.

## Contents

| Folder | What it covers | Status |
|---|---|---|
| [01_Basics](01_Basics/) | Aggregate, string, numeric, date and conditional functions (38 queries) | Done |
| [02_Joins](02_Joins/) | JOIN, LEFT JOIN, multi-table chains, self-join (6 queries) | Done |
| 03_Window_Functions | Rankings and running totals | Planned |

## Key findings so far

- The store has 59 customers and 2,328.60 in total revenue, about 39.47 per customer.
- The average invoice is 5.65, so each customer places roughly 7 invoices on average.
- Track prices only range from 0.99 to 1.99.
- The longest track is 88.12 minutes, about 13 times the average of 6.56 minutes.
- The USA brings in about 22% of revenue, matching its share of customers.
- The highest average invoices come from countries with a single customer, so they are unreliable.

## How each query is documented

1. **Question:** the business question in plain English
2. **Query:** the SQL that answers it
3. **Result:** what the query returned
4. **Insight:** what the result means, plus a follow-up worth checking

## How to run

1. Download `Data/Chinook_Sqlite.sqlite` from this repo.
2. Open it in DB Browser for SQLite (free, sqlitebrowser.org).
3. Go to the Execute SQL tab and open any `.sql` file.
4. Press Ctrl+Enter to run a query.

## Tools
- SQLite
- DB Browser for SQLite
- Dataset: Chinook sample database
