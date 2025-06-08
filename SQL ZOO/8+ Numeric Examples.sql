---1
SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question = 'Q01'
   AND institution = 'Edinburgh Napier University'
   AND subject = '(8) Computer Science';


---2
SELECT institution, subject
  FROM nss
 WHERE question = 'Q15'
   AND (A_AGREE + A_STRONGLY_AGREE) >= 100;


---3
SELECT institution, score
  FROM nss
 WHERE question = 'Q15'
   AND subject = '(8) Computer Science'
   AND score < 50;

---4
SELECT subject, SUM(response) AS total_responses
  FROM nss
 WHERE question = 'Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;


---5
SELECT subject, SUM(response * A_STRONGLY_AGREE / 100) AS strongly_agree_total
  FROM nss
 WHERE question = 'Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;


---6
SELECT subject,
       ROUND(SUM(response * A_STRONGLY_AGREE / 100.0) * 100.0 / SUM(response)) AS percent_strongly_agree
FROM nss
WHERE question = 'Q22'
  AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
GROUP BY subject;

---7
SELECT institution,
       ROUND(SUM(score * response) / SUM(response)) AS avg_score
  FROM nss
 WHERE question = 'Q22'
   AND institution LIKE '%Manchester%'
GROUP BY institution;


---8
SELECT institution,
       SUM(sample) AS total_sample,
       SUM(CASE WHEN subject = '(8) Computer Science' THEN sample ELSE 0 END) AS computing_students
  FROM nss
 WHERE question = 'Q01'
   AND institution LIKE '%Manchester%'
GROUP BY institution;
