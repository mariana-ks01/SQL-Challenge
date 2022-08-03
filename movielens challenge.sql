-- MOVIELENS CHALLENGE
USE movielens;

CREATE VIEW united_table AS 
SELECT r.user_id, u.age, u.gender, o.`name` AS 'occupation', m.title, m.release_date, g.`name` as 'genre', r.rating FROM users u
INNER JOIN occupations o ON o.id = u.occupation_id
INNER JOIN ratings r ON r.user_id = u.id
INNER JOIN movies m ON m.id = r.movie_id
INNER JOIN genres_movies gm ON gm.movie_id = m.id
INNER JOIN genres g ON g.id = gm.genre_id
ORDER BY title;

-- List the titles and release dates of movies released between 1983-1993 in reverse chronological order.
SELECT title, release_date FROM movies WHERE release_date BETWEEN '1983-01-01' AND '1993-12-31' ORDER BY release_date DESC;

-- Without using LIMIT , list the titles of the movies with the lowest average rating.
SELECT m.title, AVG(r.rating) AS average_rating FROM movies m
INNER JOIN ratings r ON r.movie_id = m.id
GROUP BY title ORDER BY average_rating ASC;

-- List the unique records for Sci-Fi movies where male 24-year-old students have given 5-star ratings.
SELECT DISTINCT title FROM united_table WHERE genre = 'Sci-Fi' AND gender = 'M' AND age = 24 AND occupation = 'student' AND rating = 5;

-- List the unique titles of each of the movies released on the most popular release day.
SELECT DISTINCT title FROM movies WHERE release_date =
(SELECT release_date FROM movies
GROUP BY release_date ORDER BY COUNT(release_date) DESC LIMIT 1);

-- Find the total number of movies in each genre; list the results in ascending numeric order.
SELECT COUNT(DISTINCT title) AS number_of_movies, genre FROM united_table GROUP BY genre ORDER BY number_of_movies ASC;