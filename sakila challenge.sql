-- SAKILA CHALLENGE
USE sakila;

-- List all actors.
SELECT first_name, last_name FROM actor_info;

-- Find the surname of the actor with the forename 'John'.
SELECT DISTINCT last_name FROM actor_info WHERE first_name = 'John';

-- Find all actors with surname 'Neeson'.
SELECT DISTINCT first_name FROM actor_info WHERE last_name = 'Neeson';

-- Find all actors with ID numbers divisible by 10.
SELECT actor_id, first_name, last_name FROM actor_info WHERE actor_id%10 = 0;

-- What is the description of the movie with an ID of 100?
SELECT `description` FROM film_list WHERE FID = 100;

-- Find every R-rated movie.
SELECT * FROM film_list WHERE rating = 'R';

-- Find every non-R-rated movie.
SELECT * FROM film_list WHERE rating != 'R';

-- Find the ten shortest movies.
SELECT * FROM film_list ORDER BY `length` ASC LIMIT 10;

-- Find the movies with the longest runtime, without using LIMIT .
SELECT title FROM film WHERE `length` =
(SELECT MAX(`length`) FROM film);

-- Find all movies that have deleted scenes.
SELECT * FROM film WHERE special_features LIKE '%Deleted Scenes%';

-- Using HAVING , reverse-alphabetically list the last names that are not repeated.
SELECT last_name FROM actor GROUP BY last_name HAVING COUNT(last_name) =1 ORDER BY last_name DESC;

-- Using HAVING , list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) AS `count` FROM actor
GROUP BY last_name HAVING `count` >1 ORDER BY `count` DESC;

-- Which actor has appeared in the most films?
SELECT `actor_id`, COUNT(`actor_id`) FROM film_actor GROUP BY `actor_id` ORDER BY COUNT(`actor_id`) DESC LIMIT 1;
SELECT first_name, last_name FROM actor WHERE actor_id = 107;

-- 'Academy Dinosaur' has been rented out, when is it due to be returned?
CREATE VIEW rented_movies AS SELECT f.title, r.rental_date, r.return_date, f.rental_duration
FROM rental r
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id;

SELECT DATE_ADD(rental_date, INTERVAL rental_duration DAY) FROM rented_movies WHERE title = 'ACADEMY DINOSAUR' AND return_date IS NULL;

-- What is the average runtime of all films?
SELECT AVG(length) FROM film;

-- List the average runtime for every film category.
SELECT category, AVG(length) FROM film_list GROUP BY category;

-- List all movies featuring a robot.
SELECT * FROM film_list WHERE `description` LIKE '%robot%';

--  How many movies were released in 2010?
SELECT film_id, COUNT(film_id) FROM film WHERE release_year = 2010;

-- Find the titles of all the horror movies.
SELECT title FROM film_list WHERE category = 'horror';

-- List the full name of the staff member with the ID of 2.#
SELECT first_name, last_name FROM staff WHERE staff_id = 2;

-- List all the movies that Fred Costner has appeared in.
SELECT title FROM film_list WHERE actors LIKE '%Fred Costner%';

-- How many distinct countries are there?
SELECT MAX(country_id) FROM country;

-- List the name of every language in reverse-alphabetical order.
SELECT `name` FROM `language` ORDER BY `name` DESC;

-- List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%son' ORDER BY first_name ASC;

-- Which category contains the most films?
SELECT category, COUNT(category) FROM film_list GROUP BY category ORDER BY COUNT(category) DESC LIMIT 2;
