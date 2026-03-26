show tables;

-- overviewing different tables

select * from actor limit 10;
select * from customer limit 10;
select * from film_actor limit 10;
select * from inventory limit 10;
select * from payment limit 10;
select * from store limit 10;
select * from language limit 10;
select * from film_category limit 10;
select * from country limit 10;

-- 1 concatenating actor names as full name

select 
    concat(first_name,' ',last_name) as full_name,
    count(*) as total_count
from actor
group by 
    first_name,
    last_name;


-- 2 number of films category-wise with ranking

select 
    category_name,
    total_films,
    rank() over(order by total_films desc) as rnk
from(
    select 
        c.name as category_name,
        count(fc.film_id) as total_films
    from category c
    join film_category fc
        on c.category_id=fc.category_id
    group by c.name
) temp;

-- 3 Most Rented Films Analysis

SELECT 
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
JOIN rental r 
    ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 5;

-- 4 number of releases in a particular year

select 
    release_year,
    count(*) as total_movies
from film
group by release_year; -- all movies are from 2006

-- 5 Count of Movies in Each Language

select 
    l.name as language,
    count(f.language_id) as number_of_movies
from language l
join film f
    on l.language_id=f.language_id
group by l.name; -- all movies are in English

-- 6 number of times each customer rented a movie

select *
from(
    select 
        c.customer_id,
        c.first_name,
        c.last_name,
        count(r.rental_id) as total_rent,
        rank() over(order by count(r.rental_id) desc) as rnk
    from customer c
    join rental r
        on c.customer_id=r.customer_id
    group by 
        c.customer_id,
        c.first_name,
        c.last_name
) temp; -- Eleanor Hunt rented the most movies

-- 7 rating count as per rating type

select 
    rating,
    count(*) as total_movies
from film
group by rating
order by count(*) desc; -- most movies have PG-13 rating


-- ===============================
-- REVENUE ANALYSIS
-- ===============================

-- 8 top 5 movies by total revenue

select 
    f.title,
    sum(p.amount) as total_revenue
from film f
join inventory i 
    on f.film_id=i.film_id
join rental r 
    on i.inventory_id=r.inventory_id
join payment p 
    on r.rental_id=p.rental_id
group by f.title
order by total_revenue desc
limit 5;

-- 9 revenue by store

select 
    s.store_id,
    sum(p.amount) as total_revenue
from payment p
join customer c 
    on c.customer_id=p.customer_id
join store s 
    on s.store_id=c.store_id
group by s.store_id; -- store 1 generates more revenue

-- 10 monthly revenue

select 
    month,
    total_revenue,
    rank() over(order by total_revenue desc) as rnk
from(
    select 
        month(payment_date) as month,
        sum(amount) as total_revenue
    from payment
    group by month(payment_date)
) temp; -- month 7 (July) has the highest revenue

-- 11 revenue by category

select 
    c.name as category_name,
    sum(p.amount) as total_revenue
from category c
join film_category fc 
    on c.category_id=fc.category_id
join inventory i 
    on fc.film_id=i.film_id
join rental r 
    on i.inventory_id=r.inventory_id
join payment p 
    on r.rental_id=p.rental_id
group by c.name
order by total_revenue desc;

-- average revenue per customer

select 
    avg(total_spent) as avg_revenue_per_customer
from(
    select 
        customer_id,
        sum(amount) as total_spent
    from payment
    group by customer_id
) temp;


-- ===============================
-- CUSTOMER ANALYSIS
-- ===============================

-- 12 customer expense on movies

select 
    customer_id,
    first_name,
    last_name,
    total_expense,
    rank() over(order by total_expense desc) as rnk
from(
    select 
        c.customer_id,
        c.first_name,
        c.last_name,
        sum(p.amount) as total_expense
    from customer c
    join payment p 
        on c.customer_id=p.customer_id
    group by 
        c.customer_id,
        c.first_name,
        c.last_name
) temp; -- Karl Seal has the highest expense

-- customer segmentation based on spending
SELECT 
    segment, 
    COUNT(customer_id) AS customer_count
FROM (
    SELECT 
        customer_id,
        CASE 
            WHEN SUM(amount) > 200 THEN 'High Value'
            WHEN SUM(amount) > 100 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS segment
    FROM payment
    GROUP BY customer_id
) AS customer_segments
GROUP BY segment
ORDER BY customer_count DESC;

-- classify customers as one-time or repeat

select 
    customer_type,
    count(*) as total_customers
from(
    select 
        customer_id,
        case 
            when count(*) = 1 then 'One-Time Customer'
            else 'Repeat Customer'
        end as customer_type
    from rental
    group by customer_id
) temp
group by customer_type;


-- 13 rental duration analysis

select 
    rental_id,
    datediff(return_date,rental_date) as rental_duration_days
from rental;

-- customers rental by  days

SELECT 
    duration_segment, 
    COUNT(*) AS total_rentals
FROM (
    SELECT 
        CASE 
            WHEN DATEDIFF(return_date, rental_date) IS NULL THEN 'Not Returned'
            WHEN DATEDIFF(return_date, rental_date) > 7 THEN 'Extra Long (7+ days)'
            WHEN DATEDIFF(return_date, rental_date) BETWEEN 4 AND 7 THEN 'Medium (4-7 days)'
            ELSE 'Short (Under 4 days)'
        END AS duration_segment
    FROM rental
) AS duration_groups
GROUP BY duration_segment
ORDER BY total_rentals DESC;

-- overall rental insights

select 
    avg(datediff(return_date,rental_date)) as avg_rental_duration,
    max(datediff(return_date,rental_date)) as max_rental_duration,
    min(datediff(return_date,rental_date)) as min_rental_duration
from rental;