SELECT l.name, ROUND(l.omega * 1.618, 3) AS "The N Factor"
FROM life_registry l, dimensions d
WHERE l.dimensions_id = d.id
  AND l.name LIKE 'Richard%'
  AND (d.name = 'C774' OR d.name = 'C875')
ORDER BY l.omega;
