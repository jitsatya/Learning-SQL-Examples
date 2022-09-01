-- Questions: MIN, MAX, & AVERAGE

-- When was the earliest order ever placed? You only need to return the date.

SELECT MIN(occurred_at) as earliest_order
FROM orders;

-- Try performing the same query as in question 1 without using an aggregation function.

SELECT occurred_at as earliest_order1
FROM orders
ORDER BY occurred_at
LIMIT 1;
 
-- When did the most recent (latest) web_event occur?

SELECT MAX(occurred_at) as latestEvent
FROM web_events;

-- Try to perform the result of the previous query without using an aggregation function.

SELECT occurred_at as latestEvent1
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

-- Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. 
-- Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

SELECT AVG(standard_amt_usd) as standard_avg_usd,
		AVG(standard_qty) as standard_avg_qty,
		AVG(gloss_amt_usd) as gloss_avg_usd,
		AVG(gloss_qty) as gloss_avg_qty,
		AVG(poster_amt_usd) as poster_avg_usd,
		AVG(poster_qty) as poster_avg_qty
FROM orders;