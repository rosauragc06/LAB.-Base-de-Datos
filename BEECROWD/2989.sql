SELECT 
  dept.nome AS departamento,
  div.nome AS divisao,
  ROUND(AVG(COALESCE(s.total_salario, 0) - COALESCE(d.total_desconto, 0)), 2) AS media,
  ROUND(MAX(COALESCE(s.total_salario, 0) - COALESCE(d.total_desconto, 0)), 2) AS maior
FROM departamento dept
JOIN divisao div ON dept.cod_dep = div.cod_dep
JOIN empregado e ON div.cod_divisao = e.lotacao_div
LEFT JOIN (
  SELECT ev.matr, SUM(v.valor) AS total_salario
  FROM emp_venc ev
  JOIN vencimento v ON ev.cod_venc = v.cod_venc
  GROUP BY ev.matr
) s ON e.matr = s.matr
LEFT JOIN (
  SELECT ed.matr, SUM(des.valor) AS total_desconto
  FROM emp_desc ed
  JOIN desconto des ON ed.cod_desc = des.cod_desc
  GROUP BY ed.matr
) d ON e.matr = d.matr
GROUP BY dept.nome, div.nome
ORDER BY media DESC;
