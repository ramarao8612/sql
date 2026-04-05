use sakila;
show tables;  

##Get all customers whose first name starts with 'J' and who are active. 
select * from sakila.customer
where first_name like 'j%' and active>0; 

##Find all films where the title contains the word 'ACTION' or the description contains 'WAR' 
select * from sakila.film 
where title like '%action%' or description like '%war%'; 

 ##List all customers whose last name is not 'SMITH' and whose first name ends with 'a 
 select * from sakila.customer 
 where last_name not like 'SMITH' AND first_name like '%a'; 
 
## Get all films where the rental rate is greater than 3.0 and the replacement cost is not null. 
select * from sakila.film
where  rental_rate>3.0 and replacement_cost is not null; 

##Count how many customers exist in each store who have active status = 1.
SELECT store_id, COUNT(*) AS total_customers
FROM sakila.customer
WHERE active = 1
GROUP BY store_id; 

##Show distinct film ratings available in the film table. 
select distinct rating from sakila.film; 

##Find the number of films for each rental duration where the average length is more than 100 minutes
SELECT rental_duration, COUNT(*) AS film_count, AVG(length) AS avg_length
FROM sakila.film
GROUP BY rental_duration
HAVING AVG(length) > 100; 

##List payment dates and total amount paid per date, but only include days where more than 100 payments were made 
SELECT DATE(payment_date) AS pay_date,
       SUM(amount) AS total_amount,
       COUNT(*) AS total_payments
FROM sakila.payment
GROUP BY DATE(payment_date)
HAVING COUNT(*) > 100; 

##Find customers whose email address is null or ends with '.org
select * from sakila.customer
where email like '%.org' or null; 

##List all films with rating 'PG' or 'G', and order them by rental rate in descending order. 
 select * from sakila.film 
 where rating in ('PG','G')
 order by rental_rate desc; 
 
##Count how many films exist for each length where the film title starts with 'T' and the count is more than 5 
SELECT length, COUNT(*) AS film_count
FROM sakila.film
WHERE title LIKE 'T%'
GROUP BY length
HAVING COUNT(*) > 5; 

##List all actors who have appeared in more than 10 films.

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM sakila.actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10; 

select * from sakila.actor; 

##Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second. 
SELECT title, rental_rate, length
FROM film
ORDER BY rental_rate DESC, length DESC
LIMIT 5; 

##Show all customers along with the total number of rentals they have made, ordered from most to least rentals. 
SELECT c.customer_id, c.first_name, c.last_name,
       COUNT(r.rental_id) AS total_rentals
FROM sakila.customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC;

##List the film titles that have never been rented  
SELECT f.title
FROM sakila.film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;


















 

