SELECT
  node_id,
  CASE
    WHEN node_id NOT IN (SELECT pointer FROM nodes WHERE pointer IS NOT NULL) THEN 'ROOT'
    WHEN node_id IN (SELECT pointer FROM nodes WHERE pointer IS NOT NULL) 
         AND node_id IN (SELECT node_id FROM nodes WHERE pointer IS NOT NULL) THEN 'INNER'
    ELSE 'LEAF'
  END AS type
FROM
  (SELECT DISTINCT node_id FROM nodes
   UNION
   SELECT DISTINCT pointer FROM nodes WHERE pointer IS NOT NULL) AS all_nodes
ORDER BY node_id;
