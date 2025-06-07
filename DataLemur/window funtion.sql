WITH first_issue AS (
  SELECT
    card_name,
    issue_year,
    issue_month,
    issued_amount,
    ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS rn
  FROM monthly_cards_issued
)
SELECT
  card_name,
  issued_amount
FROM first_issue
WHERE rn = 1
ORDER BY issued_amount DESC;
