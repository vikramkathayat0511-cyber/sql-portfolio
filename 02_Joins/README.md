# 02 Joins

Combining tables in the Chinook music store database.

| File | Topics | Queries |
|---|---|---|
| [Joins.sql](Joins.sql) | JOIN, LEFT JOIN, multi-table joins, self-join, finding unmatched rows | 6 |

## Queries

| # | Question | Tables | Join technique |
|---|---|---|---|
| 1 | What is each customer's name, country and total spend? | Customer, Invoice | LEFT JOIN with GROUP BY |
| 2 | What are the 10 longest tracks, and what media type is each? | Track, MediaType | JOIN |
| 3 | Which genres generate the most revenue? | InvoiceLine, Track, Genre | 3-table chain |
| 4 | Who are the top 5 artists by revenue? | InvoiceLine, Track, Album, Artist | 4-table chain |
| 5 | Which tracks have never been sold? | Track, InvoiceLine | LEFT JOIN with IS NULL |
| 6 | Who does each employee report to? | Employee, Employee | Self-join |

## Findings

- The 10 longest tracks are all video files (Protected MPEG-4), which explains the long-track tail in the aggregate queries.
- Rock earns about 35% of revenue, and the top four genres earn about 73%.
- The top 5 artists earn about 22% of revenue, led by Iron Maiden (138.60).
- About 43% of the catalogue (1,519 of 3,503 tracks) has never been sold.
- The top spenders from Chile, Ireland and Hungary are each the only customer in their country, which explains why those countries had the highest average invoices.

## How to run

1. Download `Data/Chinook_Sqlite.sqlite` from the main folder of this repo.
2. Open it in DB Browser for SQLite.
3. Open `joins.sql` in the Execute SQL tab and run each query on its own (highlight it, then press Ctrl+Enter).
