---1
SELECT COUNT(*) FROM stops;


---2
SELECT id FROM stops WHERE name = 'Craiglockhart';


---3
SELECT s.id, s.name
FROM route r
JOIN stops s ON r.stop = s.id
WHERE r.num = '4' AND r.company = 'LRT';

---4
SELECT company, num, COUNT(*)
FROM route
WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING COUNT(DISTINCT stop) = 2;

---5
SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 53 AND b.stop = 149;

---6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops stopa ON a.stop = stopa.id
JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'London Road';

---7
SELECT a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 115 AND b.stop = 137;

---8
SELECT a.company, a.num
FROM route a
JOIN route b ON a.company = b.company AND a.num = b.num
WHERE a.stop = 53 AND b.stop = (SELECT id FROM stops WHERE name = 'Tollcross');

---9
SELECT DISTINCT b.name, a.company, a.num
FROM route a
JOIN route b1 ON a.company = b1.company AND a.num = b1.num
JOIN stops b ON b1.stop = b.id
WHERE a.stop = 53 AND a.company = 'LRT';

---10
SELECT DISTINCT
  first.company, first.num, transfer.name AS transfer_stop,
  second.company, second.num
FROM route first
JOIN route transfer1 ON first.company = transfer1.company AND first.num = transfer1.num
JOIN stops transfer ON transfer1.stop = transfer.id
JOIN route transfer2 ON transfer.name = transfer2.stop
JOIN route second ON transfer2.company = second.company AND transfer2.num = second.num
WHERE first.stop = 53
  AND second.stop = (SELECT id FROM stops WHERE name = 'Lochend');