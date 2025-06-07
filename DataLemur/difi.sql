WITH revenue_per_member AS (
  SELECT
    artist_name,
    genre,
    concert_revenue,
    number_of_members,
    concert_revenue * 1.0 / number_of_members AS revenue_per_member,
    ROW_NUMBER() OVER (
      PARTITION BY genre
      ORDER BY concert_revenue * 1.0 / number_of_members DESC
    ) AS rn
  FROM concerts
  WHERE number_of_members > 0
)
SELECT
  artist_name,
  genre,
  concert_revenue,
  number_of_members,
  revenue_per_member
FROM revenue_per_member
WHERE rn = 1
ORDER BY genre, revenue_per_member DESC;
