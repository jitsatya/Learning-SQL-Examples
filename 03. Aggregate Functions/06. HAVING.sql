-- How many of the sales reps have more than 5 accounts that they manage?
WITH table1 
AS (
SELECT s.name,
COUNT(*) num_accounts
FROM accounts as a
JOIN sales_reps as s
ON a.sales_rep_id = s.id
GROUP BY s.name
HAVING num_accounts>5)
	SELECT COUNT (*)
	FROM table1;

-- How many accounts have more than 20 orders?

WITH more_than20 AS
(
SELECT a.name, COUNT(*) as num_orders
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
HAVING num_orders>20
)
SELECT COUNT(*) as num_accounts
FROM more_than20;

-- Which account has the most orders?

SELECT a.name, COUNT(*) as num_orders
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY num_orders DESC
LIMIT 1;

-- Which accounts spent more than 30,000 usd total across all orders?

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
HAVING total_spent>30000
ORDER BY total_spent DESC;

-- Which accounts spent less than 1,000 usd total across all orders?

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
HAVING total_spent<1000
ORDER BY total_spent DESC;

-- Which account has spent the most with us?

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY total_spent DESC
LIMIT 1;

-- Which account has spent the least with us?

SELECT a.name, SUM(o.total_amt_usd) as total_spent
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
HAVING total_spent<1000
ORDER BY total_spent
LIMIT 1;

-- Which accounts used facebook as a channel to contact customers more than 6 times?

WITH facebook_channel AS
(
SELECT *
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
WHERE w.channel = 'facebook'
)
SELECT name,
COUNT(*) as num_times
FROM facebook_channel
GROUP BY name
HAVING num_times>6;
 
-- Which account used facebook most as a channel?

WITH facebook_channel AS
(
SELECT *
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
WHERE w.channel = 'facebook'
)
SELECT name,
COUNT(*) as num_times
FROM facebook_channel
GROUP BY name
HAVING num_times>6
ORDER BY num_times DESC
LIMIT 1;

-- Which channel was most frequently used by most accounts?

SELECT a.name, w.channel,
	COUNT(*) as num_times_used
FROM web_events as w
JOIN accounts as a
ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY num_times_used DESC
LIMIT 10;
