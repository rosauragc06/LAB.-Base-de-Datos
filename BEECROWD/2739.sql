SELECT name, 
       EXTRACT(DAY FROM payday)::int AS day
FROM loan;