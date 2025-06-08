---1
SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024'
   AND yr = 2017
ORDER BY votes DESC;


---2
SELECT party,
       RANK() OVER (ORDER BY votes DESC) AS posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party;


---3
SELECT yr, party, votes,
       RANK() OVER (PARTITION BY yr ORDER BY votes DESC) AS posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party, yr;

---4
SELECT constituency, party, votes,
       RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr = 2017
ORDER BY posn, constituency;


---5
SELECT constituency, party
  FROM (
    SELECT constituency, party,
           RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS posn
      FROM ge
     WHERE yr = 2017
       AND constituency BETWEEN 'S14000021' AND 'S14000026'
  ) AS ranked
 WHERE posn = 1
ORDER BY constituency;

---6
SELECT party, COUNT(DISTINCT constituency) AS seats
FROM (
    SELECT constituency, party,
           RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rank
    FROM ge
    WHERE yr = 2017
      AND constituency LIKE 'S%'
) AS ranked
WHERE rank = 1
GROUP BY party
ORDER BY seats DESC;
