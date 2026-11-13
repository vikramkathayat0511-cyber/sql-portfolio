# 03 Window Functions

Ranking, running totals and row-to-row comparisons on the Chinook music store database.

| File | Topics | Queries |
|---|---|---|
| [window_functions.sql](window_functions.sql) | RANK, ROW_NUMBER, PARTITION BY, running SUM, LAG, CTEs | 4 |

## Queries

| # | Question | Technique |
|---|---|---|
| 1 | Rank every customer by total spend, with ties sharing a rank | RANK() |
| 2 | What is the running total of revenue by month? | SUM() OVER (ORDER BY) |
| 3 | How does each month's revenue compare with the previous month? | LAG() |
| 4 | Who is the top-spending customer in each country? | ROW_NUMBER() with PARTITION BY |

## Findings

- Ties are common among customer spending (customers 45 and 46 both spent 45.62 and share rank 4), and RANK() skips the next number after a tie (4, 4, 6).
- Monthly revenue is very steady: 35 of the 59 month-to-month changes are exactly 0, with revenue at 37.62 in most months.
- The biggest monthly rise is January 2022 (+15.00), and the biggest fall is November 2023 (-13.86), which rebounds the next month.

## How to run

1. Download `Data/Chinook_Sqlite.sqlite` from the main folder of this repo.
2. Open it in DB Browser for SQLite.
3. Open `window_functions.sql` in the Execute SQL tab and run each query on its own (highlight it, then press Ctrl+Enter).
