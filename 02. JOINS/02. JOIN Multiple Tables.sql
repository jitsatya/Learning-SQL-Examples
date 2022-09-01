-- Questions
-- Provide a table for all web_events associated with account name of Walmart. 
-- There should be three columns. Be sure to include the primary_poc, time of the event, 
-- and the channel for each event. Additionally, you might choose to add a fourth column 
-- to assure only Walmart events were chosen.

SELECT a.name, a.primary_poc, w.occurred_at, w.channel
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.name = 'Walmart';

 
-- 
-- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to account name.

SELECT r.name AS region_name,
s.name AS sales_rep_name, 
a.name AS account_name
FROM accounts AS a
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
ORDER BY a.name;

-- 
-- Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
-- Your final table should have 3 columns: region name, account name, and unit price.
--  A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT r.name AS region_name, 
a.name AS account_name, 
round(o.total_amt_usd/o.total, 2) AS unit_price
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id;