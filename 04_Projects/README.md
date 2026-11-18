
# 04 Project: Revenue Analysis

**Business question:** Where does the Chinook music store's revenue come from, and where could it grow?

Six queries on the Chinook database (SQLite) that break total revenue into its parts, then look at it by country, genre, customer, sales agent and catalogue. The full SQL is in [Revenue_analysis.sql](Revenue_analysis.sql).

## Summary

Revenue of 2,328.60 is the product of **59 customers x 6.98 invoices each x 5.65 per invoice**. Spending is very even: countries, customers and sales agents all look alike on revenue per customer, so differences in revenue come mainly from how many customers there are, not from how much each one spends. The exceptions are genres (Rock and the top four earn most of the revenue) and the catalogue (43.4% of tracks have never sold).

## Queries

| # | Question | Techniques |
|---|---|---|
| 1 | What are the headline numbers behind total revenue? | COUNT DISTINCT, AVG, SUM |
| 2 | Which countries earn the most revenue per customer? | JOIN, GROUP BY, HAVING |
| 3 | What share of revenue does each genre earn? | 3-table JOIN, SUM() OVER () |
| 4 | How much revenue comes from the top 10 customers? | CTE, ROW_NUMBER, running SUM OVER |
| 5 | How much revenue does each sales support agent's customer group bring in? | 3-table JOIN, GROUP BY |
| 6 | Which genres have the most tracks that have never been sold? | LEFT JOIN, COUNT DISTINCT |

## Findings and recommendations

### 1. Revenue has three parts, and the baseline is steady

59 customers x 6.98 invoices x 5.65 average invoice = 2,328.60. Customers buy at almost the same frequency, and 35 of 59 month-to-month revenue changes are exactly 0.

**Recommendation:** Growth has to come from more customers or larger invoices, since frequency is already even. Testing bundles or higher-priced items would show whether invoice size can grow.

### 2. Revenue follows customer numbers, not spending habits

Among countries with 3 or more customers, revenue per customer sits between 37.62 and 40.24 (USA 40.24, Germany 39.12, France 39.02, Brazil 38.02, Canada 37.99, United Kingdom 37.62). The three sales agents are just as close: 38.77 to 40.01 per customer. The agents' totals differ (Jane Peacock 833.04, Margaret Park 775.40, Steve Johnson 720.16) because they handle 21, 20 and 18 customers.

The unfiltered country ranking is led by Chile, Hungary and Ireland, but each has a single customer, so it says little.

**Recommendation:** Focus on adding customers, especially in the largest markets, rather than on raising spend per customer in one country. Check whether customers are assigned to agents by country before comparing agents.

### 3. Revenue is concentrated by genre, but not by customer

Rock earns 35.5% of revenue, Latin 16.4%, Metal 11.2% and Alternative & Punk 10.4%, so the top four earn 73.5%. By contrast, the top 10 customers (17% of the 59) earn only 19.4%, and the best customer spent about 26% above the average.

**Recommendation:** The store does not depend on any single customer, which makes revenue resilient. Genre mix is the larger risk, so the top four genres deserve the most attention when buying or promoting music.

### 4. 43.4% of the catalogue has never sold

1,519 of 3,503 tracks have never been sold. They are spread roughly in proportion to genre size: the four biggest genres hold about 70% of the unsold tracks and about 74% of the catalogue, and they sell better than average (34.6% to 39.8% unsold). Smaller genres such as Alternative (65.0%) and Electronica/Dance (61.3%) have the highest unsold rates, though each has only 30 to 40 tracks.

**Recommendation:** Before adding more music, check whether the unsold tracks come from artists with no sales at all or are spread across artists. That shows whether the problem is artists or individual tracks.

## Limitations

- The data shows patterns, not causes. Words like "suggests" and "worth checking" are used on purpose.
- Several countries and genres have very few customers or tracks, so their percentages swing widely (Opera is 100% unsold, but it is a single track).
- Some genres look like video content (TV Shows, Drama, Comedy), which probably affects the unsold figures. Check this with the media type before stating it as fact.

## How to run

1. Download `Data/Chinook_Sqlite.sqlite` from the main folder of this repo.
2. Open it in DB Browser for SQLite.
3. Open `Revenue_analysis.sql` in the Execute SQL tab.
4. Highlight one query and press Ctrl+Enter to run it.
