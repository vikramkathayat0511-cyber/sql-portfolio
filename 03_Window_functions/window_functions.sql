
-- ============================================
-- Window Functions: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================


-- Q1: Rank every customer by total spend, with ties sharing a rank?
SELECT c.FirstName||' '||c.LastName AS Customer_name,
       c.Country,
	   ROUND(SUM(I.Total),2) AS Total_spend,
	   Rank() OVER(ORDER BY SUM(I.Total) DESC) AS Ranking
FROM Customer c 
LEFT JOIN Invoice I 
ON c.CustomerId = I.CustomerId
GROUP BY c.CustomerId
ORDER BY Ranking,Customer_name;

-- Builds on Q1 of joins.sql
-- Result: Helena Holý ranks 1 (49.62)
/* Insight:  Many customers share the same spend, so ties are common, and RANK() skips a number after
             each tie (4, 4, 6). Worth using ROW_NUMBER() when you need exactly N rows.*/

			 
-- Q2: What is the running total of revenue by month?
with monthly_revenue AS (
       SELECT strftime('%Y-%m',InvoiceDate) AS Year_Month,
       ROUND(SUM(total),2) AS Total_revenue
	   FROM Invoice
	   GROUP BY strftime('%Y-%m',InvoiceDate)
)
	
SELECT Year_Month,
       Total_revenue,
	   SUM(Total_revenue) OVER(ORDER BY Year_Month) AS Running_total
	   FROM monthly_revenue
	   ORDER BY Year_Month;

-- Builds on Q1 of date_functions.sql (revenue per year)
-- Result: running total reaches 449.46 by December 2021 and 2,328.60 after 60 months.
/* Insight: Monthly revenue is very steady (37.62 in 11 of the first 12 months),
            with one bump in January to March 2022.. Worth checking month-over-month changes
            to find the biggest rise and fall.*/
			

-- Q3: How does each month’s revenue compare with the previous month?
with monthly_revenue AS (
       SELECT strftime('%Y-%m',InvoiceDate) AS Year_Month,
              ROUND(SUM(total),2) AS Total_revenue
	   FROM Invoice
	   GROUP BY strftime('%Y-%m',InvoiceDate)
)

SELECT Year_Month,
       Total_revenue,
	   lAG(Total_revenue) OVER(ORDER BY Year_Month) AS Previous_month,
	   ROUND(Total_revenue - LAG(Total_revenue) OVER (ORDER BY Year_month), 2) AS Change
	   FROM monthly_revenue
	   ORDER BY Year_Month;
	   
-- Builds on Q2 (running total)
-- Result: biggest rises January 2022 (+15.00), April 2023 (+14.00), December 2023 (+13.86);
--         biggest falls November 2023 (-13.86), July 2023 (-13.00), December 2025 (-11.00)
/* Insight: Monthly revenue sits at 37.62 in most months (35 of 59 changes are exactly 0), with short
   bumps and dips around it. The largest dip (November 2023, 23.76) rebounds the next month, so the
   swings look like one-off large or small invoices, not a trend. Worth checking which invoices drive
   the bumps in early 2022 and mid 2023.*/
   

-- Q4: Who is the top-spending customer in each country?
with customers AS(
       SELECT c.FirstName||' '||c.LastName AS Customer_name,
	          c.Country,
			  COALESCE(ROUND(SUM(I.Total),2),0) AS Spending
       FROM Customer C
       LEFT JOIN Invoice I
       ON C.CustomerId=I.CustomerId
       GROUP BY C.CustomerId
),
 Ranked AS (SELECT Customer_name,
       country,
	   spending,
	   ROW_NUMBER() OVER (PARTITION BY Country ORDER BY Spending DESC) AS Rank_in_country
FROM customers
)
SELECT Customer_name, Country, Spending
FROM ranked
WHERE Rank_in_country = 1
ORDER BY Spending DESC, Country;

-- Builds on Q1 of joins.sql and Q1 of this file
-- Result: 24 countries, one top spender each. Highest: Helena Holý (Czech Republic, 49.62),
--         then Richard Cunningham (USA, 47.62), Luis Rojas (Chile, 46.62)
/* Insight: The top spender in each country spends between 37.62 and 49.62. In countries with a single
            customer, that customer is automatically the top spender, so this list says little there.
            Worth checking the gap between each country's top spender and its average spender.*/
			
			
