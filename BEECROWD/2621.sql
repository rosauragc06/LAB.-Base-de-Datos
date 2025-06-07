SELECT p.name
FROM products p
JOIN providers pr ON p.id_providers = pr.id
WHERE p.amount BETWEEN 10 AND 20
AND pr.name LIKE 'P%';
