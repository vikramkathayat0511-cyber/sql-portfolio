
-- ============================================
-- Joins: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================



-- Q1: What is each customer’s full name and country, together with the total they spent?
SELECT C.FirstName||' '||C.LastName AS Customer_Name,
       C.Country AS Customer_country,
	   COALESCE(ROUND(SUM(I.Total),2),0) AS Spending
FROM Customer C
LEFT JOIN Invoice I
ON C.CustomerId=I.CustomerId
GROUP BY C.CustomerId
ORDER BY Spending DESC, Customer_name;

-- Builds on Q10 in the aggregate file, now with names and countries
-- Result: top spenders are Helena Holý (Czech Republic, 49.62), Richard Cunningham (USA, 47.62),Luis Rojas (Chile, 46.62)
/* Insight: The top 5 spenders come from five different countries. Luis Rojas (Chile), Hugh O'Reilly (Ireland) and 
   Ladislav Kovács (Hungary) explain why those countries had the highest average invoices in Q13 of aggregate_functions.sql.*/
   
   
-- Q2: What are the 10 longest tracks, and what media type is each?
SELECT T.Name AS Track_name,
       M.Name AS Media_type,
	   ROUND(T.Milliseconds/60000.0,2) AS Minutes
FROM Track T
LEFT JOIN MediaType M
ON T.MediaTypeId = M.MediaTypeId
ORDER BY Minutes DESC, Track_name
LIMIT 10;

-- Follows up on Q1 of numeric_functions.sql (the longest tracks).
-- Result: The 10 longest tracks run from 88.12 down to 48.78 minutes, and all 10 are Protected MPEG-4 video files.
/* Insight: All 10 longest tracks are video files (probably TV episodes),
   which explains why the average track length is pulled up.*/
   
   
-- Q3: Which genres generate the most revenue?
SELECT G.Name AS Genre,
       ROUND(SUM(IL.UnitPrice*IL.Quantity),2) AS Revenue_generated
FROM InvoiceLine IL
LEFT JOIN Track T
ON IL.TrackId = T.TrackId
LEFT JOIN Genre G
ON T.GenreId = G.GenreId
GROUP BY G.Name
ORDER BY Revenue_generated DESC, Genre;

-- Answers the follow-up from Q2 of aggregate_functions.sql (are sales concentrated in a few genres?)
-- Result: Rock 826.65, Latin 382.14, Metal 261.36, Alternative & Punk 241.56, TV Shows 93.53, ...
/* Insight: Revenue is concentrated in a few genres. Rock earns about 35.5% and the top four about 73.5%.
   Worth checking whether Rock's lead comes from having the most tracks or from selling more per track.*/
   
-- Q4: Who are the top 5 artists by revenue?
SELECT Ar.Name AS Artist_name,
       ROUND(SUM(IL.UnitPrice*IL.Quantity),2) AS Revenue_earned
FROM InvoiceLine IL
LEFT JOIN Track T
ON IL.TrackId = T.TrackId
LEFT JOIN Album A
ON T.AlbumId = A.AlbumId
LEFT JOIN Artist Ar
ON A.ArtistId = Ar.ArtistId
GROUP BY Ar.ArtistId
ORDER BY Revenue_earned DESC, Artist_name
LIMIT 5;

-- Result: Iron Maiden 138.60, U2 105.93, Metallica 90.09, Led Zeppelin 86.13, Lost 81.59.
/* Insight: -- Insight: Iron Maiden leads with about 6% of revenue,
   and the top 5 artists earn about 22% combined, so revenue is spread across many artists.*/
   
   
-- Q5: Which tracks have never been sold?
SELECT T.Name AS Track_name,
       IL.Quantity*IL.UnitPrice AS Sales
FROM Track T
LEFT JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId
WHERE IL.InvoiceLineId IS NULL ;

-- Follows up on Q2 of aggregate_functions.sql (the track catalogue).
-- Result: 1,519 of 3,503 tracks (about 43%) have never been sold.
/* Insight: Nearly half the catalogue (43%) has never been bought, while the other 1,984 tracks account
   for all 2,328.60 in revenue. Worth checking which genres or media types the unsold tracks belong to.*/
   
   
-- Q6: Who does each employee report to?
SELECT E.FirstName||' '||E.LastName AS Employee_name,
       E.Title,
       M.FirstName||' '||M.LastName AS Manager_Name
FROM Employee E
LEFT JOIN Employee M
ON E.ReportsTo = M.EmployeeId;

-- Result: 8 employees. Andrew Adams has no manager, Nancy Edwards and Michael Mitchell report to him,
/* Insight: Three levels: Andrew Adams on top, two managers (Sales, IT) below him, and 5 staff under them.
   Worth checking how many customers each sales support agent handles, using Customer.SupportRepId.*/
   
   
