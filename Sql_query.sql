select concat (first_name,' ',last_name) as full_name from actor
select * from film_actor
order by film_id


select * from customer
order by last_name asc

select * from customer
order by last_name desc 

select * from payment
where amount > 2.99

select title,description, rental_rate 
from film
where rental_rate >.99
select * from film where replacement_cost=19.99

select * from film where rating = 'PG'
select * from film where rating <= 'PG'
select * from film where replacement_cost = 12
select * from film where title='Center Dinosaur'

select * from film where (rental_rate>.99) and (replacement_cost <17.99)
and (rental_duration>5)
select * from film where (rental_rate>.99) or (replacement_cost <17.99)
or (rental_duration>5)

select * from film where ((rental_rate>.99) and (replacement_cost <17.99))
or (rental_duration>5)

select * from film where (rental_rate>.99) and ((replacement_cost <17.99)
or (rental_duration>5))

select * from film where (rental_rate>.99) and (replacement_cost <17.99)
or (rental_duration>5)

 *\ between operator\
select * from film where rental_rate between .99 and 4.99
select * from film where length between 80 and 110

select * from film where "length"= 80 and "length" <=110

select title,length(title)
 as title_length, length from film
 where length between 80 and 110
 
 *\ In operator\
 
 SELECT * FROM customer 
WHere last_name In ('Smith')

select * from customer where first_name In 
(select last_name from customer)

*\ NOT In operator\
SELECT * FROM customer 
WHERE last_name NOT IN ('Smith')

*\ ALL operator\

SELECT * FROM actor
WHERE LENGTH(last_name) > ALL(select LENGTH(first_name) from actor);

*\ ANY operator \ *

SELECT * FROM actor
WHERE LENGTH(last_name) > Any(select LENGTH(last_name) from customer);

SELECT * FROM customer
WHERE LENGTH(last_name) > Any(select LENGTH(last_name) from actor);

*\ EXISTS operator\*

SELECT customer_id, first_name, last_name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
    AND r.return_date IS NULL);

SELECT first_name
FROM customer
WHERE EXISTS 
(SELECT amount FROM payment 
 WHERE customer.customer_id = payment.customer_id AND amount > 10);

*\wildcard characters "%"\*

case scentive with "Cat"
Select * from film
where description like '%cat%'

*\Use I like operator
Select * from film
where description Ilike '%cat%'

select * from film
where description Ilike '%cat%' And description Ilike '%dog%'

Select * from film
where description Ilike '%cat%dog%'

*\Wild character "_"\*

select * from film
where description Ilike '%m_d%'

*\sorting and order by ASC and DESC \*

select *from film
order by length desc, rental_rate asc
limit 20

*\distinct cluase \*

select distinct(rental_rate)from film

select distinct replacement_cost from film
order by replacement_cost asc

select p.amount, p.payment_id, r.inventory_id,r.return_date,r.rental_id,p.rental_id
from rental r
left join
payment p on p.rental_id=r.rental_id
order by return_date asc

select p.amount, p.payment_id, r.inventory_id,r.return_date,r.rental_id,p.rental_id
from rental r
inner join
payment p on p.rental_id=r.rental_id
order by return_date asc

select p.amount, p.payment_id, r.inventory_id,r.return_date,r.rental_id,p.rental_id
from rental r
full join
payment p on p.rental_id=r.rental_id
order by return_date asc

select p.amount, p.payment_id, r.inventory_id,r.return_date,r.rental_id,p.rental_id
from rental r
right join
payment p on p.rental_id=r.rental_id
order by return_date asc


*****Aggregate function*****

select max(length) from film 
select min(length) from film 
select avg(length) from film 
select stddev(length) from film 
select variance(length) from film 

select min(title)from film
select max(title) from film 

select max(rating) from film 
select min(rating) from film 

select min(rental_date)from rental
select max(rental_date) from rental 

select min(rental_date)as first_rental,
max(rental_date)as last_rental,
min(return_date)as return_date,
max(return_date)as return_date from rental

select * from rental
order by rental_date desc

***count***
select count(film_id) from film_category
select count(*) from film_category
select count(1) from film_category
select *,'oct 12 data'from film_category
select avg(length) as mean, stddev(length)as sd from film
select count(distinct category_id) from film_category

select category_id, count(film_id)as category_count from film_category
group by category_id
order by category_id

select c.category_id,c.name as category_name, count(fc.film_id)as film_count from category c
join film_category fc on c.category_id=fc.category_id
group by c.category_id
order by film_count desc

***************Getting total revenue by rating type
SELECT f.rating, SUM(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating
ORDER BY total_revenue DESC;



****************Seeing total count and total amount for each genre

SELECT c.category_id, c.name AS category_name, 
COUNT(f.film_id) AS film_count, SUM(p.amount) AS total_amount
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY total_amount DESC;


*** HAVING***
SELECT c.customer_id, c.first_name, c.last_name, COUNT(*) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(*) > 30;

SELECT f.rating, SUM(p.amount) AS total_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating
HAVING SUM(p.amount) > 13000
ORDER BY total_revenue DESC;

select cu.customer_id,cu.first_name,city.city,address.address_id,cu.last_name,c.country
from customer cu
full join address on address.address_id=cu.address_id
full join city on address.city_id=city.city_id
full join country c on c.country_id=city.country_id
order by city.city desc


select count(cu.customer_id),c.country
from customer cu
full join address on address.address_id=cu.address_id
full join city on address.city_id=city.city_id
full join country c on c.country_id=city.country_id
group by c.country
order by count(cu.customer_id) 

select count(cu.customer_id),c.country
from customer cu
full join address on address.address_id=cu.address_id
full join city on address.city_id=city.city_id
right join country c on c.country_id=city.country_id
group by c.country
order
by count(*),c.country 

select count(cu.customer_id),c.country
from customer cu
 join address on address.address_id=cu.address_id
 join city on address.city_id=city.city_id
 join country c on c.country_id=city.country_id
group by c.country
order by count(cu.customer_id) 


----how to count the null values--

select address_id from customer where address_id is null

