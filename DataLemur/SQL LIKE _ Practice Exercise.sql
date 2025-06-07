SELECT *
FROM customers
WHERE SUBSTRING(customer_name, 2, 2) = 'ee';
