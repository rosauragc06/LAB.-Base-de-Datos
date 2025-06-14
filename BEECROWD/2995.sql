SELECT 
    temperature, 
    COUNT(*) AS number_of_records
FROM records
GROUP BY mark, temperature
ORDER BY MIN(id);
