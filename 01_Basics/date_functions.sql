-- ============================================
-- Date Functions: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================


-- Checking Date COLUMN
SELECT InvoiceDate FROM Invoice LIMIT 5; -- In yyyy-mm-dd format with timestamp 


-- Q1: How many invoices and how much revenue are there in each year?
SELECT strftime('%Y',InvoiceDate) AS Year,
       COUNT(InvoiceId) AS Num_of_Invoices,
	   ROUND(SUM(Total),2) AS Revenue
FROM Invoice
GROUP BY strftime('%Y',InvoiceDate)
ORDER BY Year;

-- Answers the follow-up from Q3 in the aggregate file
-- Result: 2022 the best year and 2021 the weakest
/* Insight: Revenue is roughly flat across the five years (449.46 to 481.45), with 2022 the best.
   Every year has 83 invoices except 2025 (80). Every year has 83 invoices except 2025 with 80,
   so differences come mostly from invoice size. Worth checking whether 2025 is a full year
   by looking at the latest invoice date.*/

   
-- Q2: Which months are busiest, with all years combined?
SELECT strftime('%m',InvoiceDate) AS Invoice_month,
       COUNT(*) AS Invoice_count,
       ROUND(SUM(Total),2) AS Revenue
	   
FROM Invoice
GROUP BY strftime('%m',InvoiceDate)
ORDER BY Invoice_count DESC, Revenue DESC, Invoice_month;

-- Result: 7 months tie at 35 invoices (June, August, March, May, October, July, December),
-- then January and November at 34, and April, September and February at 33.
/* Insight: Invoice counts barely vary by month (33 to 35), so there's no busy season.
    Worth checking the average invoice per month.*/
	
	
-- Q3: What are the earliest and latest invoice dates?
SELECT DATE(MIN(InvoiceDate)) AS Earliest_invoice_date,
       DATE(MAX(InvoiceDate)) AS Latest_invoice_date
FROM Invoice;

-- Follow up on Q1 Date_functions
-- Result: Earliest invoice date: 2021-01-01, Latest invoice date: 2025-12-22
/* Insight: The data covers five years, 2021 to 2025, and the last invoice is dated 22 December
   2025. 2025's lower invoice count (80 against 83) is close to what a late-December cutoff
   would explain, so worth checking whether the other years also end around 22 December.*/
   
   
-- Q4: How many days has it been since each customer’s last purchase, measured from the latest invoice date in the data?
Select CustomerId AS Customer,
       DATE(MAX(InvoiceDate)) AS Last_purchase,
	   CAST(julianday((SELECT MAX(InvoiceDate)FROM Invoice)) - julianday(MAX(InvoiceDate)) AS INT) AS Days_since_last_purchase 
FROM Invoice
GROUP BY CustomerId
ORDER BY Days_since_last_purchase DESC,Last_purchase;

-- Follows up on Q3
-- Result: longest inactive customer 59 (571 days), then 38 (540) and 2 (527); most recent customer 58 (0 days). Measured from 2025-12-22
/* INSIGHT: 13 of 59 customers (about 22%) haven't bought for over a year, and the longest gap is 571 days.
   Worth checking whether the 13 long-inactive customers share a country or spending level*/
 