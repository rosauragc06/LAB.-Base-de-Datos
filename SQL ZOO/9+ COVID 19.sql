---1
SELECT name, DAY(whn),
       confirmed, deaths, recovered
  FROM covid
 WHERE name = 'Spain'   -- Cambié aquí
   AND MONTH(whn) = 3
   AND YEAR(whn) = 2020
 ORDER BY whn;

---2
SELECT 
    name, 
    DAY(whn), 
    confirmed,
    LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS confirmed_previous_day
FROM covid
WHERE name = 'Italy'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY whn;

---3
SELECT 
    name, 
    DAY(whn) AS day,
    confirmed,
    confirmed - COALESCE(LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn), 0) AS new_cases
FROM covid
WHERE name = 'Italy'
  AND MONTH(whn) = 3
  AND YEAR(whn) = 2020
ORDER BY whn;

---4
SELECT 
  name AS nombre, 
  DATE_FORMAT(whn, '%Y-%m-%d') AS fecha, 
  confirmed AS confirmados,
  confirmed - COALESCE(LAG(confirmed) OVER (PARTITION BY name ORDER BY whn), 0) AS nuevos_estos
FROM covid
WHERE name = 'Italy'
  AND WEEKDAY(whn) = 0  -- solo lunes
  AND YEAR(whn) = 2020
ORDER BY whn;

---5
SELECT 
  tw.name, 
  DATE_FORMAT(tw.whn, '%Y-%m-%d') AS fecha, 
  tw.confirmed,
  COALESCE(tw.confirmed - lw.confirmed, tw.confirmed) AS nuevos_estos
FROM covid tw 
LEFT JOIN covid lw 
  ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
  AND tw.name = lw.name
WHERE tw.name = 'Italy'
  AND WEEKDAY(tw.whn) = 0  -- lunes solamente
ORDER BY tw.whn;


---6
SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) AS rc_confirmed,
   deaths,
   RANK() OVER (ORDER BY deaths DESC) AS rc_deaths
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

---7
SELECT 
   world.name,
   ROUND(100000 * confirmed / population, 2) AS infection_rate,
   RANK() OVER (ORDER BY ROUND(100000 * confirmed / population, 2) DESC) AS infection_rank
FROM covid 
JOIN world ON covid.name = world.name
WHERE whn = '2020-04-20' 
  AND population > 10000000
ORDER BY infection_rate DESC;

---8
WITH daily_new_cases AS (
  SELECT 
    name,
    whn,
    confirmed,
    confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new_cases
  FROM covid
),
max_new_cases AS (
  SELECT
    name,
    MAX(new_cases) AS max_new_cases
  FROM daily_new_cases
  WHERE new_cases >= 20000
  GROUP BY name
)
SELECT 
  dnc.name,
  dnc.whn AS peak_date,
  dnc.new_cases AS peak_new_cases
FROM daily_new_cases dnc
JOIN max_new_cases mnc ON dnc.name = mnc.name AND dnc.new_cases = mnc.max_new_cases
ORDER BY dnc.name;
