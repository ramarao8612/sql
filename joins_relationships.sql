#relationships. 
-- Relationships:
-- Relationships define how tables are connected using keys.
-- A primary key (PK) uniquely identifies a row, and a foreign key (FK) links it to another table.

-- Example: customer → payment relationship

-- customer.customer_id = PRIMARY KEY
-- payment.customer_id = FOREIGN KEY

SELECT *
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id;  -- relationship connection

-- Types of Relationships
-- 1. One-to-Many

-- One row in table A is related to many rows in table B.
-- Most common relationship in databases.

-- One customer → many payments

SELECT c.customer_id, p.payment_id
FROM customer c
JOIN payment p 
    ON c.customer_id = p.customer_id;

-- 2.Many-to-Many 
-- Many rows in one table relate to many rows in another table.
-- Handled using a junction table.

-- film ↔ actor (via film_actor table)
SELECT f.title, a.first_name
FROM film f
JOIN film_actor fa 
    ON f.film_id = fa.film_id                                -- junction table
JOIN actor a 
    ON fa.actor_id = a.actor_id;

-- One-to-One 
-- One row in one table relates to exactly one row in another.
-- Rare, usually for splitting data.
-- Example (conceptual): store - manager
-- Not common in Sakila, but structure is same
SELECT *
FROM store s
JOIN staff st 
    ON s.manager_staff_id = st.staff_id;  -- one-to-one mapping

-- 2. JOINS
-- 1. INNER JOIN
-- Returns only matching rows from both tables.
-- Non-matching rows are excluded.

-- Get customers who made payments

SELECT c.first_name, p.amount
FROM customer c
INNER JOIN payment p 
    ON c.customer_id = p.customer_id;             -- only matching rows
--  2. LEFT JOIN

-- Returns all rows from left table and matching rows from right.
-- If no match → NULL values.
-- Get all customers, even those with no payments

SELECT c.first_name, p.amount
FROM customer c
LEFT JOIN payment p 
    ON c.customer_id = p.customer_id;  -- unmatched → NULL

-- 3. RIGHT JOIN

-- Returns all rows from right table and matching rows from left.
-- Unmatched rows on left become NULL.

-- Get all payments and matching customers

SELECT c.first_name, p.amount
FROM customer c
RIGHT JOIN payment p 
    ON c.customer_id = p.customer_id;

-- 4. FULL OUTER JOIN

-- Returns all rows from both tables.
-- Unmatched rows from either side are filled with NULL.

-- MySQL doesn't support FULL JOIN directly → use UNION

SELECT c.first_name, p.amount
FROM customer c
LEFT JOIN payment p 
    ON c.customer_id = p.customer_id

UNION

SELECT c.first_name, p.amount
FROM customer c
RIGHT JOIN payment p 
    ON c.customer_id = p.customer_id;

-- 5. CROSS JOIN

-- Returns all possible combinations of rows (Cartesian product).
-- No condition is used.

-- Combine every customer with every store

SELECT c.first_name, s.store_id
FROM customer c
CROSS JOIN store s;  -- all combinations

-- 6. SELF JOIN

-- A table is joined with itself.
-- Used when rows in the same table are related.

-- Find staff and their managers

SELECT s1.first_name AS staff, s2.first_name AS manager
FROM staff s1
JOIN staff s2 
    ON s1.staff_id = s2.staff_id;  -- self relationship 

select * from sakila.staff;

-- Concept	Meaning
-- INNER JOIN	Only matching rows
-- LEFT JOIN	All left + matching right
-- RIGHT JOIN	All right + matching left
-- FULL JOIN	All rows from both
-- CROSS JOIN	All combinations
-- SELF JOIN	Table joins itself