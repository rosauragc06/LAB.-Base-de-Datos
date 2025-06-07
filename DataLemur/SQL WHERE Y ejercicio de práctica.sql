SELECT review_id, user_id, "submitted_date", product_id, estrellas
FROM reviews
WHERE estrellas >= 4
AND review_id BETWEEN 2001 AND 5999
AND user_id != 142;
