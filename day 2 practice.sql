use sakila; 
show tables; 
select * from sakila.film;  

## string functions 

select ascii(title) as titlenum from sakila.film; #ascii

select char_length(title) as title_length from sakila.film;  #char_length 

select title,character_length(description) as description_length from sakila.film;  #character_length  

SELECT CONCAT(title, ': ', description) AS formatted_listing
FROM sakila.film;                                                #concat 

select concat_ws(' ',title,description) as combined_string 
from sakila.film;                                                 #concat_ws    

SELECT first_name
FROM sakila.actor
ORDER BY FIELD(first_name, 'PENELOPE', 'NICK', 'ED') desc;    #field 

SELECT title, special_features
FROM sakila.film
WHERE FIND_IN_SET('Deleted Scenes', special_features) > 0;        #find_in_set  

select length(first_name) as lenght_first from sakila.actor;      #length 

SELECT actor_id,
  LPAD(actor_id, 5, '0') AS formatted_id FROM sakila.actor;    #lpad


select lower(title) from sakila.film;                  #lower

select upper(description) from sakila.film;          #upper 

select title,left(title,4) from sakila.film;          #left 

select title,right(title,3) from sakila.film;         #right   

select substr(title,1,2) from sakila.film;           #substr  
 
select title,rating,concat(title,' : ',rating) as movie_rating from sakila.film;   #concat   

select mid(first_name,2,2) from sakila.customer;         #mid  


##Numeric functions 

 select abs(amount) as abs_amount  from sakila.payment;     #abs  
 
select avg(amount) as avg_amount from sakila.payment;         #avg  

select sum(amount) as total_sum from sakila.payment;          #sum

select round(rental_rate,1) from sakila.film;                         #round  

select ceil(replacement_cost) from sakila.film;                     #ceil 

select floor(replacement_cost) from sakila.film;                   #floor 

## mod function return the remainder of the two numbers. 

##power(number,power) 

## sqrt(number) 

select greatest(film_id,length) from sakila.film;   #greatest

select least(film_id,length) from sakila.film;     #least 

select rand();  


#date functions: 
SELECT NOW() AS current_datetime;

select current_date(); 

select current_time(); 

select current_timestamp(); 

select date(current_timestamp()); 

select time(current_timestamp());  

select customer_id,amount,extract(year from payment_date) as payment_year  from sakila.payment;       #extract

select customer_id,datediff(last_update,payment_date) as datedif from sakila.payment;            #datediff 

SELECT payment_id, payment_date, TIMEDIFF('2005-05-31 12:00:00', payment_date) AS diff_from_noon
FROM sakila.payment limit 5;                                                                                       
#timediff 

SELECT payment_id, payment_date, DATE_ADD(payment_date, INTERVAL 7 DAY) AS follow_up_date
FROM sakila.payment
LIMIT 5;                                                                                  #date_add 

SELECT payment_id, payment_date, DATE_SUB(payment_date, INTERVAL 48 HOUR) AS preparation_start_time 
FROM  sakila.payment
LIMIT 10;
#date_sub  

SELECT payment_id, payment_date, DATE_FORMAT(payment_date, '%W, %M %d, %Y') AS readable_date,DATE_FORMAT(payment_date, '%H:%i') AS time_only
FROM sakila.payment
LIMIT 8;
#date_format 























 













