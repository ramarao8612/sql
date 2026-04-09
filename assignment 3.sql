 ##display all customer details who have made more than 5 payments.  
 ##using subqueries 
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(payment_id) > 5
);

##Find the names of actors who have acted in more than 10 films. 
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) > 10
);

##Find the names of customers who never made a payment. 
SELECT *
FROM customer
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM payment
);

##List all films whose rental rate is higher than the average rental rate of all films.  
select * from film 
where rental_rate >(select avg(rental_rate) from film) ; 


##List the titles of films that were never rented. 
SELECT title
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT film_id
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
);

##ctes 
##Display the customers who rented films in the same month as customer with ID 5. 
WITH cust_months5 AS (
    SELECT DISTINCT MONTH(rental_date) AS month_val
    FROM rental
    WHERE customer_id = 5
)
SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE MONTH(r.rental_date) IN (SELECT month_val FROM cust_months5); 

## Find all staff members who handled a payment greater than the average payment amount.
 WITH avg_payment AS (
    SELECT AVG(amount) AS avg_amt FROM payment
)
SELECT DISTINCT s.staff_id, s.first_name, s.last_name
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE p.amount > (SELECT avg_amt FROM avg_payment); 

## Show the title and rental duration of films whose rental duration is greater than the average. 
with avg_duration as (select avg(rental_duration) as avg_dur from film)
select title,rental_duration from film 
where rental_duration>(select avg_dur from avg_duration); 

##Find all customers who have the same address as customer with ID 1. 
CREATE TEMPORARY TABLE temp_address AS
SELECT address_id
FROM customer
WHERE customer_id = 1;

SELECT *
FROM customer
WHERE address_id IN (SELECT address_id FROM temp_address); 

##List all payments that are greater than the average of all payments.
CREATE VIEW payments_high AS
SELECT *
FROM payment
WHERE amount > (SELECT AVG(amount) FROM payment);

-- To use the view
SELECT * FROM payments_high;




 

