SELECT 
    TRUNCATE(MAX(LAT_N), 4) AS lat_norte
FROM 
    STATION
WHERE 
    LAT_N < 137.2345;
