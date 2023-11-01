wild character '%' and '_'

SELECT description FROM film
WHERE description ILIKE '%cat%' 
OR description ILIKE '%d_g%'
OR description ILIKE '%bird%';
string_to_array([delimited_column], '[delimiter]')

--string agg and string array and grouping---
WITH short_film AS (
	SELECT*FROM film
	LIMIT 20	   	   )
select rating, string_to_array(STRING_AGG(description, '54639 '),'54639 ')
FROM short_film
GROUP BY rating;

WITH short_film AS (
	SELECT*FROM film
	LIMIT 20	   	   )
select rating,STRING_AGG(description, '54639 ')
FROM short_film
GROUP BY rating;

select inventory_id from inventory where inentory_id not in (select inventiry_id from rental)

select * from inventory inven
full outer join rental r 
----
with rental_count_table as (
SELECT i.film_id, count(i.film_id) as rental_count
FROM inventory i JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY i.film_id
ORDER by rental_count )

SELECT*FROM rental_count_table
WHERE rental_count <=
(SELECT
 PERCENTILE_CONT(0.3) WITHIN GROUP (ORDER BY rental_count)
 FROM rental_count_table);
----

---most revenue--sum amount and group by

select sum(amount) from payment 
group by staff_id
order by staff_id desc
-----dense rank---
SELECT
  movie_title,
  rental_count,
  DENSE_RANK() OVER (ORDER BY rental_count DESC) AS rank
FROM
  movies_rental_count;
  
----dense rank--

with staff_revenue as(
select sum(amount)as staff_total,staff_id
from payment
group by staff_id
	order by staff_id desc
)
select *, 
dense_rank() over(order by staff_total desc) as staff_rank
from staff_revenue

----count---

select count(staff_id),staff_id
from rental group by staff_i0d

___-
select s.store_id, count(s.store_id)
from store s
join staff st on s.store_id=st.store_id
join rental on rental.staff_id=st.staff_id
group by s.store_id

SELECT *,
    CASE WHEN special_features LIKE '%Trailers%' THEN 1 ELSE 0 END AS Trailers,
    CASE WHEN special_features LIKE '%Commentaries%' THEN 1 ELSE 0 END AS Commentaries,
    CASE WHEN special_features LIKE '%Deleted Scenes%' THEN 1 ELSE 0 END AS Deleted_Scenes,
    CASE WHEN special_features LIKE '%Behind the Scenes%' THEN 1 ELSE 0 END AS Behind_the_Scenes
FROM FILM;

-- Using UNION to get customers who made orders


Select name, sum as Rental_count From (
Select SUM(Count), category_id from (
select Count(*), Film_id from rental as r inner join inventory 
as i on i.inventory_id = r.inventory_id 
group by Film_id ) setA inner join film_category fc on SetA.film_id = Fc.film_id 
group by Category_id ) setB left join category c on setb.category_id = c.category_id 
order by rental_count desc



group by customer_id
	order by customer_total desc
)
select *, 
dense_rank() over(order by customer_total desc) as customer_rank
from staff_revenue





