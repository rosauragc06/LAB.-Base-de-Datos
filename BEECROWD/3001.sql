SELECT 
  name,
  CASE
    WHEN type = 'A' THEN 20.0
    WHEN type = 'B' THEN 70.0
    WHEN type = 'C' THEN 530.5
  END AS price
FROM products
ORDER BY 
  CASE type
    WHEN 'A' THEN 1
    WHEN 'B' THEN 2
    WHEN 'C' THEN 3
  END,
  id DESC;
