-- ============================================
-- String Functions: Chinook Music Store
-- Tool: SQLite (DB Browser) | Dataset: Chinook
-- ============================================

-- Q1: What is each customer’s full name in one column?
SELECT FirstName||' '||LastName AS Customer_name
FROM Customer
ORDER BY Customer_name;

-- Result: 59 full names, for example "Aaron Mitchell", "Alexandre Rocha", "Astrid Gruber"
/* Insight: Joining the names gives one clean column, ready for reports or mailing lists.
   No customer has a missing name (checked), so no full name came out blank.*/
   
   
-- Q2: Which customers have a Gmail address?
SELECT FirstName||' '||LastName AS Customer_name,
       Email
FROM Customer
WHERE Email LIKE '%@gmail.com'
ORDER BY Customer_name;

-- Result: 8 of 59 customers use Gmail
/* Insight: Gmail (13%) is a minority provider.
   Worth checking which domains the other 51 use.”*/

   
-- Q3: Which customers have first names with exactly 5 characters?
SELECT FirstName
FROM Customer
WHERE LENGTH(FirstName) = 5;

-- Result: Identified 13 customer records with first names
/* Insight: The name "Frank" appears wice, highlighting that first names
   are not necessarily unique identifiers for customers. */
   
   
-- Q4: Extract the email username of each customer?
SELECT Email,
       SUBSTR(Email,1,(INSTR(Email,'@')-1)) AS Email_username
FROM Customer;

-- Result: 59 usernames extracted, for example luisg, bjorn.hansen, daan_peeters
/* Insight: Usernames follow no single format (19 with a dot,
   6 with an underscore, 34 plain), so lengths vary widely.*/

-- Q5: Which customers have email usernames containing more than 10 characters?
SELECT SUBSTR(Email,1,(INSTR(Email,'@')-1)) AS Username
FROM Customer
WHERE LENGTH(SUBSTR(Email, 1, INSTR(Email, '@') - 1)) > 10;
	   
-- Result: 33 customers have usernames longer than 10 characters.
/* Insight: 33 out of 59 customers (55.93%) have email usernames longer than 10 characters,
   while 26 customers (44.07%) have usernames of 10 characters or fewer. */
   
   
-- Q6: Find customers whose first and last names start with the same letter?
SELECT FirstName,
       LastName
FROM Customer
WHERE LOWER(SUBSTR(FirstName,1,1))=LOWER(SUBSTR(LastName,1,1))
ORDER BY FirstName;

-- Result: Only 2 customer have first and last name starting with the same letter
/* Insight: Matching initials are rare. LOWER() in SQLite only handles
-- plain English letters, so names starting with accented capitals could be missed. */
   
   
-- Q7: Which email domains do customers use, and how many customers does each have?
SELECT SUBSTR(Email,INSTR(Email,'@')+ 1 ) AS Email_domains,
       COUNT(*) AS Customer_count
FROM Customer
GROUP BY SUBSTR(Email,INSTR(Email,'@')+ 1 )
ORDER BY Customer_count DESC, Email_domains;

-- Builds on Q2 and Q4
-- Result: gmail.com 8, hotmail.com 4, shaw.ca 3, then 2 or fewer (41 domains in total)
/* Insight: Gmail is the biggest single domain (8 of 59),
   but Yahoo's country versions together are larger.
   Worth checking the domains against a list of real providers.*/
   
   
-- Q8: Which 10 album titles are the longest?
SELECT Title,
       LENGTH(Title) AS Title_length
FROM Album
ORDER BY Title_length DESC
LIMIT 10;

-- Result: longest title is 95 characters ("Tchaikovsky: 1812 Festival Overture..."), then 86 and 77
/* Insight: The longest album titles are mostly classical works 
   and compilation series, which carry long descriptions.*/
   

-- Q9: Which track names contain an ampersand (&), and what do they look like with “&” replaced by “and”?
SELECT Name AS Original_name,
       REPLACE(Name,'&','and') AS Cleaned_name
FROM Track
WHERE Name LIKE('%&%')
ORDER BY Name;

-- Result: 17 tracks contain "&".
/* Insight: Only 17 of 3,503 tracks (about 0.5%) contain "&", so it's a small cleaning job.
   "Rock & Roll" appears twice, so track names aren't unique.*/
   

-- Q10: What is each employee's full name and job title (in uppercase)?
SELECT FirstName||' '||LastName AS Employee_name,
       UPPER(Title) AS Job_title
FROM Employee
ORDER BY Employee_name;

-- Result: 8 employees.
-- Insight: Sales support agents are the largest group (3 of 8 employees), followed by IT staff (2).