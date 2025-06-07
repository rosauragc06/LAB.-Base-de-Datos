SELECT CEIL(AVG(salary) - AVG(
    CAST(
        REPLACE(CAST(salary AS CHAR), '0', '') AS UNSIGNED
    )
)) AS error_difference
FROM EMPLOYEES;
