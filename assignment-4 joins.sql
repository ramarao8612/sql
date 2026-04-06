use  sakila;
show tables; 
select * from sakila.customer; 
select * from sakila.rental; 
select * from sakila.film;  
select * from sakila.inventory; 
select * from sakila.actor;

##List all customers along with the films they have rented. select c.customer_id,c.first_name,c.last_name,f.title  
select c.customer_id, c.first_name, c.last_name, f.title
from customer c 
join rental r on r.customer_id=c.customer_id 
join inventory i on r.inventory_id=i.inventory_id 
join film f on i.film_id=f.film_id; 

##List all customers and show their rental count, including those who haven't rented any films.  
select c.customer_id,c.first_name,c.last_name,count(r.rental_id) as rental_count 
from customer c
left join rental r on r.customer_id=c.customer_id  
GROUP BY c.customer_id, c.first_name, c.last_name; 

##Show all films along with their category. Include films that don't have a category assigned.
select f.title, fc.name
from film f  
left join film_category fca on fca.film_id=f.film_id
left join category fc on fc.category_id=fca.category_id;

##Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION). 
select c.email,'customer' as type
from customer c 
union
select  s.email,'staff' as type from staff s;

##Find all actors who acted in the film "ACADEMY DINOSAUR". 
select a.actor_id, a.first_name,a.last_name from sakila.film f 
join film_actor fa on fa.film_id=f.film_id  
join actor a on a.actor_id=fa.actor_id
where f.title='ACADEMY DINOSAUR'; 

##List all stores and the total number of staff members working in each store, even if a store has no staff.
select count(*) as total_staff,so.store_id FROM staff s
 join store so on so.store_id=s.store_id
group by so.store_id; 

##List the customers who have rented films more than 5 times. Include their name and total rental count. 
select c.customer_id,c.first_name,c.last_name,count(r.rental_id) as total from  customer c 
join rental r on r.customer_id=c.customer_id 
group by customer_id,first_name,last_name
having count(r.rental_id)>5;



















