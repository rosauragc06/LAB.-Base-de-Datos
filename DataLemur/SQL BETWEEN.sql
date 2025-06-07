SELECT manufacturer, drug, units_sold
FROM pharmacy_sales
WHERE manufacturer IN ('Biogen', 'AbbVie', 'Eli Lilly')
  AND units_sold BETWEEN 100000 AND 105000;
