
-- ============================================
-- Conditional Logic: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================


-- Q1: How many invoices fall into each size band: Small, Medium and Large?
SELECT CASE WHEN Total < 3 THEN 'Small'
            WHEN Total < 7 THEN 'Medium'
	        ELSE 'Large' END AS Invoice_size,
	   COUNT(*) AS Total_invoices
FROM Invoice
GROUP BY Invoice_size
ORDER BY Total_invoices DESC;

-- Result: Small 171, followed by Large 122 and Medium 119 invoices.
/* Insight:  Small invoices are the largest band (41.5%), but Large and Medium are close behind,
   so purchase sizes are fairly evenly spread.Worth checking the revenue each band brings in. */
   
   
-- Q2: -- Q2: Which companies do customers belong to, using 'Individual' when none is on file?
SELECT FirstName||' '||LastName AS Customer_name,
       COALESCE(Company,'Individual') AS Company_name
FROM Customer
ORDER BY Customer_name;

-- Result: 59 customers listed, 49 shown as 'Individual' and 10 with a company name.
/* Insight:  Most customers (49 of 59, about 83%) have no company on file, so the store sells mainly to individuals.
   Worth checking whether the 10 company customers spend more than individuals.*/
   
   
-- Q3: How many customers have a state on file, and how many don’t?
SELECT SUM(CASE WHEN State is NULL THEN 1 ELSE 0 END) AS No_state,
       SUM(CASE WHEN State is NOT NULL THEN 1 ELSE 0 END) AS Has_state
FROM Customer;

-- Result: 29 customers have no state and 30 have one (59 in total)
/* Insight: About half of customers (29 of 59) have no state,
   mostly in countries that don't use states, so the gaps look expected and
   not like a data-quality problem. Worth checking that customers in countries that
   do use states (USA, Canada, Brazil) are all filled in.*/
 
 
-- Q4: How many tracks fall into each length category: Short, Medium and Long?
SELECT CASE WHEN Milliseconds/60000.0 < 3 THEN 'Short'
            WHEN Milliseconds/60000.0 < 6 THEN 'Medium'
			ELSE 'Long' END AS Length_category,
			COUNT(*) AS Tracks_count
FROM Track
GROUP BY Length_category
ORDER BY Tracks_count DESC;

-- Result: Short (under 3 min) 480, Medium (3 to under 6 min) 2,400, Long (6 min or more) 623; total 3,503
/* Insight: About 68.5% of tracks are 3 to 6 minutes long, and a few very long tracks
   pull the average (6.56 min) above the typical track.*/
   
   
   