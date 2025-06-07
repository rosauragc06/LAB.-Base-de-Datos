SELECT category, COUNT(DISTINCT product) AS count
FROM product_spend
GROUP BY category;
