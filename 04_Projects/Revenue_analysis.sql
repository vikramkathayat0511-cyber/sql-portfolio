
-- ============================================
-- Revenue Analysis: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- Question: Where does the store's revenue come from, and where could it grow?
-- ============================================

-- Q1: What are the headline numbers behind total revenue?
SELECT COUNT(DISTINCT CustomerId) AS Customers,
       COUNT(*) AS Invoices,
	   ROUND(1.0 * COUNT(*) / COUNT(DISTINCT CustomerId),2) AS Invoices_per_customers,
	   ROUND(SUM(Total),2) AS Revenue,
	   ROUND(AVG(Total),2) AS Avg_Invoice
FROM Invoice;

-- Result: 59 customers, 412 invoices, 6.98 invoices per customer, 5.65 average invoice, 2,328.60 revenue
/* Insight: Revenue is the product of three parts: 59 customers x 6.98 invoices each x 5.65 per invoice.
            Frequency is almost identical across customers (see aggregate_functions.sql), so growth would
            have to come from more customers or larger invoices. The next queries look at where each part varies.*/
			
			
-- Q2: which countries earn the most per customer?
SELECT	C.Country,
	    COUNT(DISTINCT C.CustomerId) AS Customers,
	    ROUND(SUM(I.total),2) AS Revenue,
	    ROUND(SUM(I.total) / COUNT(Distinct C.CustomerId),2) AS Revenue_per_customer
FROM Customer C
LEFT JOIN Invoice I 
ON C.CustomerId = I.CustomerId
GROUP BY C.Country
ORDER BY Revenue_per_customer DESC, Customers;

-- Follows up on Q9 of aggregate_functions.sql (revenue follows customer count)
-- Result: among countries with 3+ customers, USA leads at 40.24 per customer, then Germany 39.12,
--         France 39.02, Brazil 38.02, Canada 37.99 and the United Kingdom 37.62
/* Insight: Among countries with 3+ customers, revenue per customer is nearly identical (37.62 to 40.24),
            so revenue differences come from how many customers a country has.Worth checking whether the
			few large invoices behind the January 2022 and April 2023 bumps came from particular countries.*/
			
			
-- Q3: What share of revenue does each genre earn?
WITH Genre_revenue AS (
       SELECT G.Name AS Genres,
	          ROUND(SUM(IL.UnitPrice * IL.Quantity),2) AS Revenue
	   FROM InvoiceLine IL
	   LEFT JOIN Track T
	   ON IL.TrackId = T.TrackId
	   LEFT JOIN Genre G
	   ON T.GenreId = G.GenreId
	   GROUP BY G.GenreId
)
SELECT Genres,
       Revenue,
	   ROUND(100.0 * Revenue / SUM(Revenue) OVER(),1) AS Pct_of_revenue
FROM Genre_revenue
ORDER BY Revenue DESC,Genres;

-- Builds on Q3 of joins.sql, now as percentages
-- Result: Rock 35.5%, Latin 16.4%, Metal 11.2%, Alternative & Punk 10.4%, TV Shows 4.0%, ... (24 genres)
/* Insight: Revenue is concentrated: Rock earns 35.5% and the top four genres 73.5%, while most
            genres earn under 1% each. The TV and video-related genres add up to roughly 9.5%. Worth comparing
            with the 43% of tracks that have never sold to see where catalogue effort isn't paying off.*/
			
			
-- Q4: How much of total revenue comes from the top 10 customers?
WITH customer_spend AS (
    SELECT C.CustomerId,
           C.FirstName || ' ' || C.LastName AS Customer_name,
           ROUND(SUM(I.Total), 2) AS Spending
    FROM Customer C
    JOIN Invoice I
      ON C.CustomerId = I.CustomerId
    GROUP BY C.CustomerId
)
SELECT Customer_name,
       Spending,
       ROW_NUMBER() OVER (ORDER BY Spending DESC, Customer_name) AS Spend_rank,
       ROUND(100.0 * SUM(Spending) OVER (ORDER BY Spending DESC, Customer_name)
             / SUM(Spending) OVER (), 1) AS Cumulative_pct
FROM customer_spend
ORDER BY Spend_rank
LIMIT 10;

-- Builds on Q10 of aggregate_functions.sql (top 5 customers) and Q1 of this file
-- Result: the top 10 customers earn 19.4% of revenue, from Helena Holý (49.62, 2.1%) to Victor Stevens (42.62)
/* Insight: Revenue is not concentrated in a few customers. The top 10 (17% of the 59 customers) earn
            19.4% of revenue, and the best customer spent only about 26% above
            the average. That makes revenue resilient, but it also means there are no standout customers to grow.
            Worth checking whether the same holds for invoices: do a few large invoices drive the bumps in monthly revenue?*/
			
			
-- Q5: How much revenue does each sales support agent's customer group bring in?
SELECT E.FirstName||' '||E.LastName AS Sales_support_agent,
       COUNT(DISTINCT C.CustomerId) AS Customers,
	   ROUND(SUM(I.Total),2) AS Revenue,
	   ROUND(SUM(I.Total) / COUNT(DISTINCT C.CustomerId),2) AS Revenue_per_customer
FROM Employee E
INNER JOIN Customer C 
ON E.EmployeeId = C.SupportRepId
INNER JOIN Invoice I 
ON C.CustomerId = I.CustomerId
GROUP BY E.EmployeeId
ORDER BY Revenue DESC,Sales_support_agent;

-- Follows up on Q10 of string_functions.sql (customers per support agent)
-- Result: Jane Peacock 833.04 (21 customers), Margaret Park 775.40 (20), Steve Johnson 720.16 (18)
/* Insight: Agents differ in total revenue only because they handle different numbers of customers, not performance.
            Revenue per customer is almost identical (38.77 to 40.01). Worth checking whether
            customers are assigned by country, since that could explain the split.*/
			
			
-- Q6: Which genres have the most tracks that have never been sold?
SELECT G.Name as Genres,
       COUNT(DISTINCT T.TrackId) AS Tracks,
	   COUNT(DISTINCT T.TrackId)-COUNT(DISTINCT IL.TrackId) AS Unsold_tracks,
	   ROUND(100.0*(COUNT(DISTINCT T.TrackId)-COUNT(DISTINCT IL.TrackId)) / COUNT(T.TrackId),1) AS Pct_unsold
FROM Track T 
LEFT JOIN Genre G 
ON T.GenreId = G.GenreId
LEFT JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId
GROUP BY G.GenreId
ORDER BY Unsold_tracks DESC,Genres;

-- Builds on the unsold-tracks finding in aggregate_functions.sql (1,519 of 3,503 tracks)
-- Result: 1,519 unsold tracks (43.4%). Most unsold: Rock 552, followed by Latin 239 and Metal 143.
/* Insight: : 43.4% of tracks never sold, spread roughly in proportion to genre size.
              Larger genres sell better than average (35-40% unsold), while smaller ones like Alternative reach 65%.
			  Worth checking whether the unsold tracks are mostly by artists who sold nothing at all, or spread across artists.*/
			  
			  

			  
			  
			
