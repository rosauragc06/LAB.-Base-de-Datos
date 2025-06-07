
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')') AS result
FROM OCCUPATIONS
ORDER BY Name;


SELECT CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.') AS result
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*) ASC, Occupation ASC;
