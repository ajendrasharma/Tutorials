
-- Explore Tables and Data Records

--- List all tables in the Sakila database:
SHOW TABLES;

--- View the structure of a table (e.g., actor):
DESCRIBE actor;


SELECT * FROM actor LIMIT 10;


-- Explore View:

SHOW FULL TABLES WHERE TABLE_TYPE LIKE 'VIEW';

SELECT * FROM customer_list LIMIT 10;


-- Explore Stored Procedures

SHOW PROCEDURE STATUS WHERE Db = 'sakila';


CALL film_in_stock(1, 1, @count);
SELECT @count;


-- Explore Functions
SHOW FUNCTION STATUS WHERE Db = 'sakila';


SELECT get_customer_balance(1, NOW());


-- Explore Triggers

SHOW TRIGGERS;


SHOW CREATE TRIGGER customer_create_date;


--  Sample Queries

-- Query to find the top 5 customers with the most rentals:
SELECT customer.customer_id, CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name,
       COUNT(rental.rental_id) AS total_rentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer_name
ORDER BY total_rentals DESC
LIMIT 5;


-- Query to find films rented in the last 30 days:
SELECT film.title, rental.rental_date
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.rental_date >= NOW() - INTERVAL 30 DAY;


-- Query to list overdue rentals
SELECT CONCAT(customer.last_name, ', ', customer.first_name) AS customer,
       film.title, rental.rental_date, rental.return_date
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE rental.return_date IS NULL
AND rental.rental_date + INTERVAL film.rental_duration DAY < NOW();
