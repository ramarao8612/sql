-- 1. Stored Procedure.
-- A stored procedure is reusable SQL logic that can include conditions, loops, and parameters.
-- It helps reduce repeated queries and improves maintainability.

-- Get customer payment summary with condition


-- Get customer payment summary with condition

DELIMITER //

CREATE PROCEDURE GetCustomerSummary(IN cust_id INT)
BEGIN
    DECLARE total DECIMAL(10,2);

    -- Calculate total payment
    SELECT SUM(amount)
    INTO total
    FROM payment
    WHERE customer_id = cust_id;

    -- Conditional logic
    IF total > 100 THEN
        SELECT 'Premium Customer' AS status, total;
    ELSE
        SELECT 'Regular Customer' AS status, total;
    END IF;

END //

DELIMITER ;

-- Call procedure
CALL GetCustomerSummary(1);  

-- Change delimiter so MySQL doesn't stop at semicolons inside procedure
DELIMITER //

--  procedure with multiple input parameters
CREATE PROCEDURE GetCustomerPaymentsInDateRange(
    IN cust_id INT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    -- Select payments for given customer and date range
    SELECT *
    FROM payment
    WHERE customer_id = cust_id
      AND payment_date BETWEEN start_date AND end_date;
END //

-- Reset delimiter back to default
DELIMITER ; 

-- Get payments for customer 1 between May 1, 2005 and May 31, 2005
CALL GetCustomerPaymentsInDateRange(1, '2005-05-01', '2005-05-31');




-- Insight:
-- Combines SELECT + variables + IF logic
-- Acts like a small program inside DB




-- Call procedure
CALL GetCustomerSummary(1);

-- logic:
-- Combines SELECT + variables + IF logic
-- Acts like a small program inside DB

-- 2. Indexing 
-- Indexes are used internally by the database to avoid full table scans.
-- They are most useful on columns used in WHERE, JOIN, ORDER BY.

-- Without index (slow for large tables) 

SELECT *
FROM payment
WHERE customer_id = 10;

-- Create index
CREATE INDEX idx_payment_customer
ON payment(customer_id);

-- Now DB uses index to jump directly to rows

-- Insight:
-- Without index - scans entire table
-- With index - uses lookup or locate.

--  3. Clustered Index (Deeper Understanding)

-- Clustered index stores actual table data in sorted order.
-- Since data itself is sorted, range queries become very fast.

-- Example: PRIMARY KEY = clustered index

CREATE TABLE orders (
    order_id INT PRIMARY KEY,   -- clustered index
    customer_id INT,
    order_date DATE
);

-- Query using range
select * from orders
WHERE order_id BETWEEN 10 AND 20;

-- Insight:
-- Data is physically ordered → range scan is fast
-- Only ONE clustered index possible

--  4. Non-Clustered Index 

-- Non-clustered index stores column values + pointer to actual row.
-- Useful when searching on non-primary key columns.

-- Create index on last_name

CREATE INDEX idx_customer_lastname
ON customer(last_name);

-- Query using index
SELECT customer_id, first_name
FROM customer
WHERE last_name = 'SMITH';

-- Insight:
-- Index finds matching rows quickly
-- Then fetches actual data using pointer

--  5. Composite Index 

-- Composite index works best when queries filter using multiple columns in the same order.
-- Column order in index is very important.

-- Create composite index

CREATE INDEX idx_customer_date
ON payment(customer_id, payment_date);

-- Efficient query (uses index fully)
SELECT *
FROM payment
WHERE customer_id = 5 
  AND payment_date = '2005-05-25';

-- Less efficient (partial use)
SELECT *
FROM payment
WHERE payment_date = '2005-05-25';

--  Insight:
-- Index works best from LEFT → RIGHT
-- (customer_id first, then payment_date)

-- Real Understanding (Important)
--  Why Index Helps
-- Without Index:
-- Scan → row1, row2, row3, ... (slow)

-- With Index:
-- Jump - exact location (fast)

-- When Index Hurts
-- INSERT / UPDATE / DELETE becomes slower
-- because index also needs updating


-- Works: WHERE A = ? AND B = ?
-- Works: WHERE A = ?
-- Not optimal: WHERE B = ?

--  Final Intuition
-- Stored Procedure - SQL program
-- Index - shortcut to data
-- Clustered - data itself sorted
-- Non-clustered - pointer system
-- Composite - multi-column optimization