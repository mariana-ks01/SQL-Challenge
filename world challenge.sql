-- World Challenge SQL
USE world;

-- Using COUNT , get the number of cities in the USA.
SELECT COUNT(`Name`) FROM city WHERE CountryCode = 'USA';

-- Find out the population and life expectancy for people in Argentina.
SELECT Population, LifeExpectancy FROM country WHERE `Name` = 'Argentina';

-- Using IS NOT NULL , ORDER BY , and LIMIT , which country has the highest life expectancy?
SELECT `Name`, LifeExpectancy FROM country WHERE LifeExpectancy IS NOT NULL ORDER BY LifeExpectancy DESC LIMIT 1;

-- Using JOIN ... ON , find the capital city of Spain.
CREATE VIEW Capital_city AS SELECT co.`Name` AS 'CountryName', ci.`Name` AS 'CapitalName'
FROM country co
INNER JOIN city ci ON ci.ID = co.capital;

SELECT CapitalName FROM capital_city WHERE CountryName = 'Spain';

-- Using JOIN ... ON , list all the languages spoken in the Southeast Asia region.
SELECT cl.`Language` FROM countrylanguage cl
INNER JOIN country co ON co.`Code` = cl.CountryCode
WHERE co.Region = 'Southeast Asia';

-- Using a single query, list 25 cities around the world that start with the letter F.
SELECT `Name` FROM city WHERE `Name` LIKE 'F%' LIMIT 25;

-- Using COUNT and JOIN ... ON , get the number of cities in China.
SELECT COUNT(ci.`Name`) FROM city ci
INNER JOIN country co ON co.`Code` = ci.CountryCode
WHERE co.`Name` = 'China';

-- Using IS NOT NULL , ORDER BY , and LIMIT , which country has the lowest population? Discard non-zero populations.
SELECT `Name`, Population FROM country WHERE Population =0 IS NOT NULL ORDER BY Population ASC LIMIT 1;

-- Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(`Code`) FROM country;

-- What are the top ten largest countries by area?
SELECT `Name`, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 10;

-- List the five largest cities by population in Japan.
SELECT ci.`Name`, ci.Population FROM city ci
INNER JOIN country co ON co.`Code` = ci.CountryCode
WHERE co.`Name` = 'Japan'
ORDER BY ci.Population DESC LIMIT 5;

-- List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
SELECT `Name`,
REPLACE (HeadOfState,'s','z') 
FROM country
WHERE HeadOfState = 'Elisabeth II';

-- List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT `Name`, Population/SurfaceArea AS PopulationToAreaRatio FROM country WHERE Population !=0 ORDER BY PopulationToAreaRatio ASC LIMIT 10;

-- List every unique world language.
SELECT DISTINCT `Language` FROM countrylanguage;

-- List the names and GNP of the world's top 10 richest countries.
SELECT `Name`, GNP FROM country ORDER BY GNP DESC LIMIT 10;

-- List the names of, and number of languages spoken by, the top ten most multilingual countries.
SELECT co.`Name`, COUNT(cl.`Language`) AS LanguagesSpoken FROM country co
INNER JOIN countrylanguage cl ON cl.CountryCode = co.`Code`
GROUP BY `Name` ORDER BY COUNT(cl.`Language`) DESC LIMIT 10;

-- List every country where over 50% of its population can speak German.
SELECT co.`Name` FROM country co
INNER JOIN countrylanguage cl ON cl.CountryCode = co.`Code` 
WHERE cl.`Language` = 'German' AND cl.Percentage > 50;

-- Which country has the worst life expectancy? Discard zero or null values.
SELECT MIN(LifeExpectancy) FROM country WHERE LifeExpectancy IS NOT NULL !=0;

-- List the top three most common government forms.
SELECT GovernmentForm, COUNT(GovernmentForm) AS `Count` FROM country
GROUP BY GovernmentForm ORDER BY `Count` DESC LIMIT 3;

-- How many countries have gained independence since records began?
SELECT COUNT(`Name`) FROM country WHERE IndepYear IS NOT NULL;


