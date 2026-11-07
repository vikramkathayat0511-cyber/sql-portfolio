
# 01 Basics

SQL fundamentals on the Chinook music store database.

| File | Topics | Queries |
|---|---|---|
| [Aggregate_functions.sql](Aggregate_functions.sql) | COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING, subqueries | 15 |
| [String_functions.sql](String_functions.sql) | concatenation, LIKE, SUBSTR, INSTR, LENGTH, REPLACE, UPPER, LOWER | 10 |
| [Numeric_functions.sql](Numeric_functions.sql) | ROUND, ABS, CAST, unit conversion | 5 |
| [Date_functions.sql](Date_functions.sql) | strftime, julianday, MIN and MAX on dates | 4 |
| [Conditional_logic.sql](Conditional_logic.sql) | CASE WHEN, COALESCE, NULL handling | 4 |


# Findings
- Revenue is roughly flat from 2021 to 2025 (449 to 481 a year), with no strong seasonality.
- 22% of customers (13 of 59) haven't bought for over a year.
- Rounding every invoice down would lose about 16.7% of revenue, so truncating with CAST badly understates totals, while ROUND stays within about 1%.
- Invoices are spread fairly evenly across sizes (Small 41.5%, Large 29.6%, Medium 28.9%).
