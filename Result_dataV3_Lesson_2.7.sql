USE sakila;

/*
1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
*/
-- SELECT * from category;  -- to check on the total amount of existing cateories

SELECT c.name, count(f.film_id) AS Counts
FROM category c LEFT JOIN film_category f
ON f.category_id = c.category_id
GROUP BY c.category_id, c.name; 	-- 16 unique categories with related number of films i the category
/*

2. Display the total amount rung up by each staff member in August of 2005.
*/
-- SELECT * FROM payment; -- to have an overview of content
-- SELECT sum(amount) FROM payment WHERE MONTH(payment_date) IN (8); -- TO SEE TOTAL AMOUNT OF PAYMENTS

SELECT first_name, last_name, SUM(amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
WHERE MONTH(p.payment_date) in (8)
GROUP BY p.staff_id
ORDER BY last_name ASC; -- total amount of pyments in august distributed per employee

/*
3. Which actor has appeared in the most films?
*/
SELECT COUNT(actor.actor_id) AS COUNTS, actor.last_name 
FROM film_actor 
JOIN actor ON actor.actor_id = film_actor.actor_id 
GROUP BY  actor.actor_id,actor.last_name 
HAVING COUNT(film_actor.actor_id) =
(SELECT MAX(COUNTS) FROM
(SELECT COUNT(actor_id) AS COUNTS
    FROM film_actor
    GROUP BY actor_id
) AS COUNTS
); 

/*
4. Most active customer (the customer that has rented the most number of films)
*/
SELECT customer_id, COUNT(*) AS 'Total rentals'
FROM rental
GROUP BY customer_id
ORDER BY COUNT(*) DESC
LIMIT 1; -- first I checked without limitation, in case 2 or more customers have the same amount of rentals, then limited to 1

-- for getting name of customer, join would be needed. 

SELECT r.customer_id, c.first_name, c.last_name, COUNT(*) AS Total_Rentals
FROM rental as r
INNER JOIN customer AS c 
ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY Total_Rentals DESC LIMIT 1; -- with the name of customer

/*

5. Display the first and last names, as well as the address, of each staff member.
*/
SELECT s.first_name, s.first_name, a.address, a.district, a.city_id, a.postal_code 
FROM staff s 
INNER JOIN address a 
ON s.address_id = a.address_id; -- name and address fields from 2 tables for employee addresses

/*

6. List each film and the number of actors who are listed for that film.
*/
SELECT f.film_id, f.title, COUNT(*) AS Total_Actors
FROM film_actor a  
INNER JOIN film f
ON a.film_id = f.film_id
GROUP BY f.film_id; -- grouped by film id in case that a title is duplicated.. 
    
/*
7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
List the customers alphabetically by last name.
*/
SELECT c.first_name, c.last_name, SUM(amount) AS 'Total paid by each customer'
FROM payment p INNER JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name ASC;  -- I group by ID in case of some names would be duplicated. 

/*
8. List number of films per category.
*/
SELECT c.name AS 'Customer name',  COUNT(fc.film_id) AS 'Counts'
FROM category c 
LEFT JOIN film_category fc
ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name; -- connected the categeory table with film_category table, still guessing if left or right : ) 