-- The LIMIT statement is useful when you want to see just the first few rows of a table. 

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15