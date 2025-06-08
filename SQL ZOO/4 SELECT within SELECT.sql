-- 1
SELECT name
  FROM world
 WHERE population >
       (SELECT population FROM world
         WHERE name = 'Russia');

-- 2
SELECT name
  FROM world
 WHERE continent = 'Europe'
   AND gdp / population >
       (SELECT gdp / population FROM world
         WHERE name = 'United Kingdom');

-- 3
SELECT name, continent
  FROM world
 WHERE continent IN (
       SELECT continent FROM world
        WHERE name IN ('Argentina', 'Australia'))
 ORDER BY name;

-- 4
SELECT name, population
  FROM world
 WHERE population >
       (SELECT population FROM world WHERE name = 'United Kingdom')
   AND population <
       (SELECT population FROM world WHERE name = 'Germany');

-- 5
SELECT name,
       CONCAT(ROUND(population * 100.0 / 
             (SELECT population FROM world WHERE name = 'Germany')), '%') AS percentage
  FROM world
 WHERE continent = 'Europe';

-- 6
SELECT name
  FROM world
 WHERE gdp > ALL (
       SELECT gdp FROM world
        WHERE continent = 'Europe'
          AND gdp IS NOT NULL);

-- 7
SELECT continent, name, area
  FROM world x
 WHERE area >= ALL (
       SELECT area FROM world y
        WHERE y.continent = x.continent
          AND area IS NOT NULL);

-- 8
SELECT continent, name
  FROM world x
 WHERE name = (
       SELECT MIN(name) FROM world y
        WHERE x.continent = y.continent);

-- 9
SELECT name, continent, population
  FROM world
 WHERE continent IN (
       SELECT continent
         FROM world
       GROUP BY continent
       HAVING MAX(population) <= 25000000);

-- 10
SELECT name, continent
  FROM world x
 WHERE population > ALL (
       SELECT population * 3 FROM world y
        WHERE x.continent = y.continent
          AND x.name != y.name);
