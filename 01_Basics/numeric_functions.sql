-- ============================================
-- Numeric Functions: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================

-- Q1: What is each track's length in minutes (rounded to 1 decimal) for the 20 longest tracks?
SELECT Name AS Track_name,
       ROUND(Milliseconds/60000.0,1) AS Track_length_min
FROM Track
ORDER BY Track_length_min DESC, Track_name
LIMIT 20;

-- Answers the follow-up from Q6 in the aggregate file
-- Result: longest tracks are 88.1 and 84.8 minutes, then a group of about 49 minutes
/* Insight: The longest tracks are far beyond normal song length, and their names (Battlestar
   Galactica, "The Living Legend") suggest TV episodes instead of music. Worth confirming
   with the media types.*/
   
   
-- Q2: How large is each of the 10 biggest tracks, in megabytes?
SELECT Name,
       ROUND(Bytes/1048576.0,2) AS Megabytes
FROM Track
ORDER BY Megabytes DESC , Name
LIMIT 10;

-- Result:  largest tracks are 1,010.46 MB ("Through a Looking Glass") and 1,005.58 MB ("Occupation / Precipice")
/* Insight: The two largest files (about 1 GB each) are also the two longest tracks. Beyond those, size and length don't line up.*/

-- Q3: Which 10 invoices are furthest from the average invoice total?
SELECT InvoiceId,
       Total,
       ROUND(ABS(Total-(SELECT AVG(Total) FROM Invoice)),2) AS Distance
FROM Invoice
ORDER BY Distance DESC, InvoiceId
LIMIT 10;

-- Result: furthest invoices are 404 (25.86), 299 (23.86), 96 and 194 (21.86), then 18.86 and below.
/* Insight: All 10 invoices furthest from the 5.65 average are large ones, and the biggest
  (25.86) is about 4.6 times the average. The smallest invoice (0.99) is only about 4.7 below
  it, so large invoices stretch the average upward. Worth checking which customers placed these.*/
	   
	   
-- Q4: What is each invoice total rounded down and to the nearest dollar, for the first 15 invoices?
SELECT InvoiceId,
       Total,
	   CAST (Total AS INT) AS Rounded_down,
	   ROUND(Total) AS Rounded_nearest
FROM Invoice
LIMIT 15;

-- Result: 15 invoices shown. Rounding down gives 0 to 13, rounding to the nearest gives 1 to 14.
/* Insight: Rounding down loses almost a dollar per invoice (0.86 to 0.99), while ROUND is off by 0.14 at most.
   For revenue reporting, ROUND is far more accurate than CAST.
   Worth checking how much total revenue would be lost if all 412 invoices were rounded down.*/
   

-- Q5: How much revenue would be lost if every invoice were rounded down instead of to the nearest dollar?
SELECT ROUND(SUM(Total), 2) AS Actual_revenue,
       SUM(ROUND(Total)) AS Rounded_nearest,
       SUM(CAST(Total AS INT)) AS Rounded_down,
       SUM(ROUND(Total))-SUM(CAST(Total AS INT)) AS Revenue_lost
FROM Invoice;

-- Result: actual revenue 2,328.60, rounded to nearest 2,351, rounded down 1,939, difference 412.
/* Insight: Rounding every invoice down would lose about 16.7% of revenue, while rounding to the nearest changes it by only about 1%.*/
