-- ============================================
-- Aggregate Functions: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================

-- Q1: How many customers are there in total?
SELECT COUNT(*) AS Total_customers
FROM Customer;

-- Result: 59 Customers
-- Insight: The store has 59 customers in total, which is a small base. Worth checking whether one country accounts for most of the customers.


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
/* Insight: The longest track (88.12 min) is about 13 times the average (6.56 min),
   so it is an outlier. Worth checking which track it is and its media type.*/
