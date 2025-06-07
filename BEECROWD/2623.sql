SELECT p.name AS product_name, c.name AS category_name
FROM products p
JOIN categories c ON p.id_categories = c.id
WHERE p.amount > 100 AND c.id IN (1, 2, 3, 6, 9)
ORDER BY c.id ASC;