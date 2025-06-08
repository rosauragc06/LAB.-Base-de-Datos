-- 1
SELECT id, title
FROM movie
WHERE yr = 1962;

-- 2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr;

-- 4
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6
SELECT actor.name
FROM casting
JOIN actor ON actorid = actor.id
WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca');

-- 7
SELECT actor.name
FROM casting
JOIN actor ON actorid = actor.id
WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien');

-- 8
SELECT movie.title
FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE actor.name = 'Harrison Ford';

-- 9
SELECT movie.title
FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE actor.name = 'Harrison Ford'
  AND casting.ord <> 1;

-- 10
SELECT movie.title, actor.name AS lead_actor
FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE yr = 1962
  AND casting.ord = 1;

-- 11
SELECT yr, COUNT(movie.title) AS movie_count
FROM movie
JOIN casting ON movieid = movie.id
JOIN actor ON actorid = actor.id
WHERE actor.name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(movie.title) > 2;

-- 12
SELECT DISTINCT m.title, lead_actor.name AS lead_actor
FROM movie AS m

-- Encontrar participaciones de Julie Andrews
JOIN casting AS ca_ja ON m.id = ca_ja.movieid
JOIN actor AS ja ON ca_ja.actorid = ja.id

-- Encontrar actor principal de la misma película
JOIN casting AS ca_lead ON m.id = ca_lead.movieid AND ca_lead.ord = 1
JOIN actor AS lead_actor ON ca_lead.actorid = lead_actor.id

WHERE ja.name = 'Julie Andrews';


-- 13
SELECT actor.name
FROM casting
JOIN actor ON actorid = actor.id
WHERE casting.ord = 1
GROUP BY actor.name
HAVING COUNT(*) >= 15
ORDER BY actor.name;

-- 14
SELECT movie.title, COUNT(casting.actorid) AS cast_count
FROM movie
JOIN casting ON movieid = movie.id
WHERE yr = 1978
GROUP BY movie.title
ORDER BY cast_count DESC, movie.title;

-- 15
SELECT DISTINCT a2.name
FROM casting AS ca1
JOIN actor AS a1 ON ca1.actorid = a1.id
JOIN casting AS ca2 ON ca1.movieid = ca2.movieid
JOIN actor AS a2 ON ca2.actorid = a2.id
WHERE a1.name = 'Art Garfunkel'
  AND a2.name <> 'Art Garfunkel';
