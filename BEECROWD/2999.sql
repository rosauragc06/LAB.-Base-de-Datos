SELECT
  e.nome,
  ROUND(SUM(DISTINCT COALESCE(v.valor, 0)) - SUM(DISTINCT COALESCE(d.valor, 0)), 2) AS salario_liquido
FROM empregado e
LEFT JOIN emp_desc ed ON ed.matr = e.matr
LEFT JOIN desconto d ON d.cod_desc = ed.cod_desc
INNER JOIN emp_venc ev ON ev.matr = e.matr
INNER JOIN vencimento v ON v.cod_venc = ev.cod_venc
GROUP BY e.nome, e.lotacao
HAVING ROUND(SUM(DISTINCT COALESCE(v.valor, 0)) - SUM(DISTINCT COALESCE(d.valor, 0)), 2) > 8000
ORDER BY e.lotacao ASC;
