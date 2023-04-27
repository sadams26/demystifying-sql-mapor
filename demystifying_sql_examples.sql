/***********************************
SECTION 1: BASIC SELECT STATEMENTS
***********************************/

-- Example 1a: SELECT *
SELECT * FROM Customers;

-- Example 1b: Select a single column
SELECT CustomerName FROM Customers;

-- Example 1c: Select multiple columns, but not all column
SELECT 
    CustomerID, 
    CustomerName, 
    ContactName 
FROM Customers;

-- Example 1d: Select multiple columns, first 10 rows
SELECT 
    CustomerID, 
    CustomerName, 
    ContactName 
FROM Customers
LIMIT 10;

-- Example 1d: Select multiple columns, first/last 10 rows
SELECT 
    CustomerID, 
    CustomerName, 
    ContactName 
FROM Customers
ORDER BY CustomerID 
LIMIT 10;


SELECT 
    CustomerID, 
    CustomerName, 
    ContactName 
FROM Customers
ORDER BY CustomerID DESC
LIMIT 10;

-- Exercise 1: What is the first ContactName when ordered by ContactName in Ascending Order?
SELECT *
FROM Customers
ORDER BY ContactName; 

/***********************************
SECTION 2: FILTERING ROWS
***********************************/

-- Example 2a: Filter by numeric column
SELECT * 
FROM Customers
WHERE CustomerID <= 10;

-- Example 2b: Filter by numeric column with BETWEEN
SELECT * 
FROM Customers
WHERE CustomerID BETWEEN 1 AND 10;

-- Example 2c: Filter by text column
SELECT * 
FROM Customers
WHERE Country = 'USA';

-- Example 2d: Filter by text column with % WILDCARDS

SELECT * 
FROM Customers
WHERE Country LIKE 'US%';

SELECT * 
FROM Customers
WHERE Country LIKE '%Y';


-- Example 2e: Filter dates

SELECT * FROM Orders
WHERE OrderDate <= '1996-08-01';


--- Example 2f: Filter by multiple columns
SELECT * 
FROM Customers
WHERE Country = 'USA' AND City = 'Seattle';


-- Example 2g: Filter by multiple values in a column

SELECT * 
FROM Customers
WHERE 
    Country = 'USA' 
    OR Country = 'Germany';

SELECT * 
FROM Customers
WHERE Country IN ('USA', 'Germany', 'UK');


/***********************************
SECTION 3: AGGREGATE FUNCTIONS 
***********************************/

-- Example 3a: COUNT all rows

SELECT COUNT(*) FROM OrderDetails;

-- Example 3b: COUNT non-null values in a column

SELECT COUNT(OrderID);

-- Example 3b: COUNT DISTINCT orders
SELECT COUNT(DISTINCT OrderID) AS "Orders" FROM OrderDetails;

-- Example 3c: Total Units Ordered

SELECT SUM(Quantity) FROM OrderDetails;

SELECT MAX(Quantity) FROM OrderDetails;

-- Example 3d: COUNT of Customers in USA

SELECT COUNT(*)
FROM Customers 
WHERE Country = 'USA';

-- Exercise 3: How many customers live in a country beginning with a 'U'?

SELECT COUNT(*) 
FROM Customers
WHERE Country LIKE ('U%');


/***********************************
SECTION 4: GROUPING 
***********************************/

-- Example 4a: How many customers live in a country beginning with a 'U', and what are these countries?

SELECT Country, COUNT(*) 
FROM Customers
WHERE Country LIKE ('U%')
GROUP BY Country;


-- Example 4b: Count of customers by country
SELECT Country, COUNT(*) 
FROM Customers
GROUP BY Country;

-- Example 4c: Count of customers by country where count > 10

SELECT Country, COUNT(*) 
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 10

SELECT Country, COUNT(*) 
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 10
ORDER BY Country DESC;

-- Example 4d: Count of customers by country where count > 10 as a subquery

SELECT * FROM (
SELECT Country, COUNT(*) 
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 10
ORDER BY Country DESC) AS subquery
WHERE Country = 'USA';

-- Exercise 4: How many orders contain more than 150 items?

SELECT 
	OrderID, 
	SUM(Quantity) 
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(Quantity) >=200;

/***********************************
SECTION 5: JOINS 
***********************************/

-- Example 5a: LEFT JOIN
SELECT 
	a.*, 
    b.ProductName 
FROM OrderDetails AS a
FULL OUTER JOIN Products AS b
ON a.ProductID = b.ProductID;

-- Example 5b: FULL OUTER JOIN

SELECT 
	a.*, 
    b.ProductName 
FROM (
    SELECT * FROM OrderDetails 
    WHERE OrderID IN (10248, 10249, 10250)
    ) AS a
FULL OUTER JOIN Products AS b
ON a.ProductID = b.ProductID;

-- Example 5c: INNER JOIN

SELECT 
	a.*, 
    b.ProductName 
FROM (
    SELECT * FROM OrderDetails 
    WHERE OrderID IN (10248, 10249, 10250)
    ) AS a
INNER JOIN Products AS b
ON a.ProductID = b.ProductID;
