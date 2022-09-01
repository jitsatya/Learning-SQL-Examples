-- For each account, determine the average amount of each type of paper they purchased across their orders. 
-- Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name, AVG(o.standard_qty) as avg_standard, AVG(poster_qty) as avg_poster, AVG(gloss_qty) as avg_gloss
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name;

-- 
-- For each account, determine the average amount spent per order on each paper type. 
-- Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name as account_name, 
		AVG(o.standard_amt_usd) as avg_spent_std,
		AVG(o.poster_amt_usd) as avg_spent_pos,
		AVG(o.gloss_amt_usd) as avg_spent_gloss
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name;

-- 
-- Determine the number of times a particular channel was used in the web_events table for each sales rep. 
-- Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

SELECT s.name as sales_rep, 
		w.channel as channel,
		COUNT(*) as no_of_occurances
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
JOIN sales_reps as s 
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY no_of_occurances DESC;

-- Determine the number of times a particular channel was used in the web_events table for each region. 
-- Your final table should have three columns - the region name, the channel, and the number of occurrences. 
-- Order your table with the highest number of occurrences first.

SELECT r.name as region,
		w.channel as channel,
		COUNT(*) as times_used
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
JOIN sales_reps as s
ON a.sales_rep_id = s.id
JOIN region as r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY times_used DESC;
