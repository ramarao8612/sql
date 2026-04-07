##subqueries  
## A QUERY INSIDE ANOTHER QUERY IS CALLED SUBQUERY
## 1.subquery(where) 
##A subquery is placed inside WHERE (or other clauses) to filter data.
##It runs first and returns a value/list used by the outer query. 
SELECT customer_id, amount
FROM sakila.payment
WHERE amount > (
    SELECT AVG(amount) FROM sakila.payment   -- subquery runs first
); 

##Subquery in SELECT 
##A subquery can be used inside the SELECT list to return a value for each row.
##Usually must return a single value.
##It is often used to calculate additional columns or derived values.
##Show each customer and total number of payments they made

SELECT c.customer_id,c.first_name,(SELECT COUNT(*) 
FROM payment p 
WHERE p.customer_id = c.customer_id) AS total_payments
FROM customer c;															##subquery runs for each customer row 

##Derived Tables (Subquery in FROM) 
##A derived table is a subquery placed inside the FROM clause.
##The result of the subquery acts like a temporary table that the outer query can use. 
##It must have an alias and can be joined or filtered 
-- Get customers whose total payment is greater than 100
SELECT *
FROM (
    SELECT customer_id, SUM(amount) AS total_payment
    FROM sakila.payment
    GROUP BY customer_id
) AS customer_totals   -- derived table
WHERE total_payment > 100;

##When Subquery Fails
##A subquery fails when it returns multiple rows but the outer query expects only one value.
##This usually happens when using operators like '=' with a multi-row result. 
-- This will fail if multiple rows are returned
SELECT first_name
FROM customer
WHERE customer_id = (
    SELECT customer_id
    FROM payment
    WHERE amount > 5
);
-- Use IN when multiple values are returned
SELECT first_name
FROM sakila.customer
WHERE customer_id IN (
    SELECT customer_id
    FROM sakila.payment
    WHERE amount > 5
); 

##Correlated Subquery
##A correlated subquery depends on values from the outer query.
##It runs once for every row processed by the outer query. 
-- Find payments greater than that customer's average payment
SELECT customer_id, amount
FROM payment p1
WHERE amount > (
    SELECT AVG(amount)
    FROM payment p2
    WHERE p2.customer_id = p1.customer_id
  );                                                                                   -- subquery uses value from outer query
##EXISTS (Important Type)
##Checks if the subquery returns any rows (TRUE/FALSE).
##Stops early,more efficient than IN in many cases.
SELECT first_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM payment p
    WHERE p.customer_id = c.customer_id
);

-- Subquery (WHERE)     - filter using another query
-- Subquery (SELECT)    - compute value per row
-- Derived Table        - subquery as table
-- Correlated           - runs per row (depends on outer query)
-- EXISTS               - checks if rows exist
-- Failure case         - multiple rows when single expected 

-- disadvantages:more complexity,less scope,larger space,less reusability. 

##CTE (Common Table Expression)
##A CTE is a temporary named result set created using WITH.
##It exists only during the execution of the query and improves readability of complex queries. 
-- Get customers whose total payment > 100

WITH customer_total AS (
    SELECT customer_id, SUM(amount) AS total
    FROM sakila.payment
    GROUP BY customer_id
)
SELECT *
FROM customer_total
WHERE total > 100;                                   -- using CTE like a table. 

##advantages:code reusability,redability  --disadvantages:The scope is limited to query level.

##Recursive CTE
##A recursive CTE repeatedly executes itself until a stopping condition is met.
##It is used for hierarchical or iterative problems (like trees, sequences).
-- Generate numbers from 1 to 5

WITH RECURSIVE nums AS (
    SELECT 1 AS n           -- base case (start)
    UNION ALL
    SELECT n + 1
    FROM nums
    WHERE n < 5             -- stopping condition
)
SELECT * FROM nums;

##Temporary Table
##A temporary table is a real table stored only for the current session.
##It stores data physically and can be reused multiple times before being automatically deleted. 
##so,the table in our local.only we can access it.
-- Create temporary table

CREATE TEMPORARY TABLE temp_customer_total AS
SELECT customer_id, SUM(amount) AS total
FROM payment
GROUP BY customer_id;

-- Use it multiple times
SELECT *
FROM temp_customer_total
WHERE total > 100; 

##server-level problem for temporary tables. 

##Views
##A view is a virtual table based on a stored SQL query.
##It does not store data; it runs the query each time you access it. 
-- Create a view

CREATE VIEW customer_summary AS
SELECT c.customer_id, c.first_name, SUM(p.amount) AS total
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name;

-- Use the view
SELECT *
FROM customer_summary
WHERE total > 100; 

##CTE	Temporary named query
##Recursive CTE	Repeats itself (loop)
##Temporary Table	Stores data temporarily
##View	Saved query (virtual table)







