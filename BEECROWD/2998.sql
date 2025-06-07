WITH acumulado AS (
    SELECT
        c.id,
        c.name,
        c.investment,
        o.month,
        SUM(o.profit) OVER (PARTITION BY c.id ORDER BY o.month) AS acumulado_mes
    FROM clients c
    JOIN operations o ON c.id = o.client_id
),
payback AS (
    SELECT
        id,
        name,
        investment,
        month,
        acumulado_mes,
        acumulado_mes - investment AS retorno,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY month) AS rn
    FROM acumulado
    WHERE acumulado_mes >= investment
)
SELECT
    name,
    investment,
    month AS month_of_payback,
    retorno AS return
FROM payback
WHERE rn = 1
ORDER BY retorno DESC;
