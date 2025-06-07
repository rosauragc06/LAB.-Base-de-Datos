SELECT 
    SUM(CITY.Population) AS TotalPopulationAsia
FROM 
    CITY
JOIN 
    COUNTRY ON CITY.CountryCode = COUNTRY.Code
WHERE 
    COUNTRY.Continent = 'Asia';
