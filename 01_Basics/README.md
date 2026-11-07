
# 01 Basics

SQL fundamentals on the Chinook music store database.

| File | Topics | Queries |
|---|---|---|
| [aggregate_functions.sql](aggregate_functions.sql) | COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING, subqueries | 15 |
| [string_functions.sql](string_functions.sql) | concatenation, LIKE, SUBSTR, INSTR, LENGTH, REPLACE, UPPER, LOWER | 10 |
| [numeric_functions.sql](numeric_functions.sql) | ROUND, ABS, CAST, unit conversion | 5 |
| [date_functions.sql](date_functions.sql) | strftime, julianday, MIN and MAX on dates | 4 |
| [conditional_logic.sql](conditional_logic.sql) | CASE WHEN, COALESCE, NULL handling | 4 |


# Findings
- Revenue is roughly flat from 2021 to 2025 (449 to 481 a year), with no strong seasonality.
- 22% of customers (13 of 59) haven't bought for over a year,as of the last invoice (22 December 2025).
- Rounding every invoice down would lose about 16.7% of revenue, so truncating with CAST badly understates totals, while ROUND stays within about 1%.
- Invoices are spread fairly evenly across sizes (Small 41.5%, Large 29.6%, Medium 28.9%).
