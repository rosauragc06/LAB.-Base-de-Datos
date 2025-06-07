SELECT ticker, MIN(open) AS min_open
FROM stock_prices
WHERE ticker IN ('FB', 'AAPL', 'AMZN', 'NFLX', 'GOOG', 'META', 'MSFT')
GROUP BY ticker
HAVING MIN(open) > 100
ORDER BY min_open DESC;
