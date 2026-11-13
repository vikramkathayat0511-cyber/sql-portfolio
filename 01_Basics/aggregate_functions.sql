-- ============================================
-- Aggregate Functions: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================

-- Q1: How many customers are there in total?
SELECT COUNT(*) AS Total_customers
FROM Customer;

-- Result: 59 Customers
-- Insight: The store has 59 customers in total, which is a small base.
            Worth checking whether one country accounts for most of the customers.


-- Q2: How many tracks are there in total?
SELECT COUNT(*) AS Total_tracks
FROM Track;

-- Result: 3,503 tracks.
/* Insight: The track catalogue is much larger than the customer base of 59 customers,
            which works out to roughly 59 tracks per customer (3,503/59), so it would 
            be worth checking whether sales are concentrated in a few genres.*/


-- Q3: What is the Total Revenue?
SELECT ROUND(SUM(Total),2) AS Total_revenue
FROM Invoice;

-- Result: 2,328.60 Total Revenue
-- Insight: With a customer base of 59 it comes to 39.47 revenue per Customer. Worth checking which country contributes most.


-- Q4: What is the average invoice total?
SELECT ROUND(AVG(Total),2) AS Average_invoice
FROM Invoice;

-- Result: 5.65 Average invoice  
/* Insight: Average invoice is small compared to 39.47 revenue per customer, 
            so each customer places roughly 7 invoices on average. Worth checking whether
            some countries have a much higher average invoice.*/


-- Q5: What are the cheapest and highest track prices?
SELECT MIN(UnitPrice) AS Cheapest_price,
       MAX(UnitPrice) AS Highest_price
FROM Track;

-- Result: Cheapest 0.99, Highest 1.99 
/* Insight: Track prices range only from 0.99 to 1.99, 
            a narrow price range means spending differences between customers probably 
            come from how many tracks they buy. Worth checking how many tracks sit at each price.*/


-- Q6: What are the Longest, Shortest and Average track lengths, in minutes?
SELECT ROUND(MAX(Milliseconds)/60000.0,2) AS Longest_min,
       ROUND(MIN(Milliseconds)/60000.0,2) AS Shortest_min,
       ROUND(AVG(Milliseconds)/60000.0,2) AS Average_min
FROM Track;

-- Result: Longest_min 88.12, Shortest_min 0.02, Average_min 6.56
/* Insight: The longest track (88.12 min) is about 13 times the average (6.56 min)
            so it is an outlier. Worth checking which track it is and its media type.*/


-- Q7: How many customers are in each country, most first?
SELECT Country,
       COUNT(CustomerId) AS Total_customers
FROM Customer
GROUP BY Country
ORDER BY Total_customers DESC,Country;

-- Answers the follow-up from Q1
-- Result: USA 13, Canada 8, France 5, Brazil 5, Germany 4, United Kingdom 3, then 2 or fewer elsewhere
/* Insight: No single country dominates the customer base. The USA has the most customers
            (13 of 59, about 22%), and the USA and Canada together make up 21, about 36%.
            Most other countries have only 1 or 2 customers. Worth checking whether the countries
            with the most customers also bring in the most revenue.*/
   
   
-- Q8: How many invoices does each customer have?
SELECT CustomerId,
       COUNT(InvoiceId) AS Total_invoices
FROM Invoice
GROUP BY CustomerId
ORDER BY Total_invoices DESC;
	   
-- Result: 58 customers have 7 invoices each, and 1 customer has 6. This matches the roughly 7 invoices per customer from Q4.
/* Insight: Nearly every customer has 7 invoices, so spend differences must come from invoice size.
            Worth checking total spend per customer.*/
   

-- Q9: What is the total revenue for each billing country, highest first?
SELECT BillingCountry AS Country,
       ROUND(SUM(Total),2) AS Total_revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY Total_revenue DESC;

-- Answers the follow-ups from Q3 and Q7
-- Result: USA 523.06, Canada 303.96, France 195.10, Brazil 190.10, Germany 156.48
/* Insight: The USA brings in about 22% of revenue, close to its 22% share of customers in Q7,
            so revenue follows customer count. Worth checking revenue per customer by country to see which markets spend more per head.*/
   
  
-- Q10: Who are the top 5 customers by total spend?
SELECT CustomerId,
       ROUND(SUM(Total),2) AS Total_spend
FROM Invoice
GROUP BY CustomerId
ORDER BY Total_spend DESC, CustomerId
LIMIT 5;

-- Answers the follow-up from Q8
-- Result: Customer 6 (49.62), 26 (47.62), 57 (46.62), 45 (45.62), 46 (45.62)
/* Insight: Customers buy equally often (Q8), but spend still varies. The top customer
            spent 49.62, about 26% above the 39.47 average (Q3). The top 5 together spent 235.10,
            roughly 10% of revenue, so no small group dominates. Worth checking spend per country.*/
   
   
-- Q11: Which countries have fewer than 5 customers?
SELECT Country,
       COUNT(CustomerId) AS Total_customers
FROM Customer
GROUP BY Country
HAVING COUNT(CustomerID) < 5
ORDER BY Total_customers DESC;

-- Result: 20 countries have fewer than 5 customers (Germany 4, United Kingdom 3, then 2 or fewer)
/* Insight: 20 of 24 countries have fewer than 5 customers, yet together they hold about 47% of all customers
            Worth checking whether these small markets bring in less revenue per customer than the big ones.*/
   

-- Q12: How many invoices over $5 does each billing country have?
SELECT BillingCountry,
       COUNT(*) AS Invoices_over_5
FROM Invoice
WHERE Total > 5
GROUP BY BillingCountry
ORDER BY Invoices_over_5 DESC, BillingCountry;

-- Result: USA 40, Canada 24, Brazil 15, France 15, Germany 12, United Kingdom 9, then 6 or fewer
/* Insight: USA (40) and Canada (24) lead on invoices over $5, matching their lead in revenue (Q9).
            Worth checking what share of each country's invoices are over $5, to see which markets have unusually large orders.*/
	
	
-- Q13: What is the average invoice of Billing Countries, and how many invoices is each based on?
SELECT BillingCountry AS Country,
      ROUND(AVG(Total),2) AS Average_invoice,
	  COUNT(*) AS Invoices_count
FROM Invoice
GROUP BY BillingCountry
ORDER BY Average_invoice DESC, BillingCountry;

-- Answers the follow-up from Q4
-- Result: highest Chile 6.66 (7 invoices), Hungary 6.52 (7), Ireland 6.52 (7)
/* Insight: The highest averages come from countries with only 7 invoices, meaning one customer
            each (Q8), so a single customer can decide the average. Worth checking the ranking again
            using only countries with at least 10 invoices.*/
   
   
-- Q14: What percentage of all customers does each country account for?
SELECT Country,
       COUNT(*) AS Total_customers,
	   ROUND(COUNT(*) * 100.0/(SELECT COUNT(*) FROM Customer),1) AS Pct_of_customers
FROM Customer
GROUP BY Country
ORDER BY pct_of_customers DESC, Country;

-- Builds on Q7: turns the customer counts into percentages
-- Result: USA 22.0%, Canada 13.6%, France 8.5%, Brazil 8.5%, Germany 6.8%, United Kingdom 5.1%.
/* Insight: The USA and Canada together account for about 36% of customers, and no other
            country exceeds 9%, so the customer base is spread across many small markets.*/
   
   
-- Q15: What are the maximum, minimum and average number of invoices per day?
SELECT MAX(Invoice_per_day) AS  Max_invoices_per_day,
       MIN(Invoice_per_day) AS Min_invoices_per_day,
	   ROUND(AVG(Invoice_per_day),2) AS Avg_invoices_per_day
FROM (SELECT DATE(InvoiceDate) AS Invoice_day,
             COUNT(*) AS Invoice_per_day
      FROM Invoice
      GROUP BY DATE(InvoiceDate));
	  
-- Result: Max 2, Min 1, Average 1.16 Invoices per day.
/* Insight: Sales are spread out, with at most 2 invoices on any day.
            Worth checking invoices per month or year to see if sales change over time.*/
   
   

   
