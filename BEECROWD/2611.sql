SELECT m.id AS movie_id, m.name AS movie_name
FROM movies m 
JOIN genres g ON m.id_genres = g.id
WHERE g.description = 'Action';
