SELECT
  t.name,
  COUNT(*) AS matches,
  SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals > m.team_2_goals) OR
             (t.id = m.team_2 AND m.team_2_goals > m.team_1_goals) 
        THEN 1 ELSE 0 END) AS victories,
  SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals < m.team_2_goals) OR
             (t.id = m.team_2 AND m.team_2_goals < m.team_1_goals) 
        THEN 1 ELSE 0 END) AS defeats,
  SUM(CASE WHEN m.team_1_goals = m.team_2_goals THEN 1 ELSE 0 END) AS draws,
  SUM(CASE 
        WHEN (t.id = m.team_1 AND m.team_1_goals > m.team_2_goals) OR
             (t.id = m.team_2 AND m.team_2_goals > m.team_1_goals) 
        THEN 3
        WHEN m.team_1_goals = m.team_2_goals THEN 1
        ELSE 0 END) AS score
FROM teams t
JOIN matches m ON t.id IN (m.team_1, m.team_2)
GROUP BY t.name
ORDER BY score DESC;