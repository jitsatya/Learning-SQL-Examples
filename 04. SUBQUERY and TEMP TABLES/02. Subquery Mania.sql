-- SUBQUERY MANIA
-- Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT region, sales_rep, MAX(total_sales) as max_sales
FROM (SELECT r.name as region, s.name as sales_rep,  SUM(total_amt_usd) as total_sales
	 FROM region as r
	 JOIN sales_reps as s
	 ON r.id = s.region_id
	 JOIN accounts as a
	 ON a.sales_rep_id = s.id
	 JOIN orders as o
	 ON o.account_id = a.id
	 GROUP BY 1,2) as sub
GROUP BY region;

-- For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?

SELECT r.name as region, COUNT(*) as num_orders
	 FROM region as r
	 JOIN sales_reps as s
	 ON r.id = s.region_id
	 JOIN accounts as a
	 ON a.sales_rep_id = s.id
	 JOIN orders as o
	 ON o.account_id = a.id
WHERE region = (SELECT region
				FROM (SELECT region, MAX(total_sales)
					FROM (SELECT r.name as region, SUM(o.total_amt_usd) as total_sales
						 FROM region as r
						 JOIN sales_reps as s
						 ON r.id = s.region_id
						 JOIN accounts as a
						 ON a.sales_rep_id = s.id
						 JOIN orders as o
						 ON o.account_id = a.id
						 GROUP BY 1) as sub) as sub2);


-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
SELECT COUNT(*) num_accounts
FROM (SELECT a.name
	FROM accounts as a 
	JOIN orders as o
	ON a.id = o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT total
					FROM (SELECT a.name as name,
						 SUM(standard_qty) as standard_bought,
						 SUM(o.total) as total
						 FROM accounts as a 
						 JOIN orders as o
						 ON a.id = o.account_id
						 GROUP BY 1
						 ORDER BY 2 DESC
						 LIMIT 1) as most_std_acc));

-- For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, 
-- how many web_events did they have for each channel?
SELECT a.name, w.channel, COUNT(*) as web_events
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
WHERE a.name = (SELECT name 
				FROM (SELECT a.name as name, SUM(o.total_amt_usd) as spent
					FROM accounts as a
					JOIN orders as o
					ON a.id = o.account_id
					GROUP BY 1
					ORDER BY 2 DESC
					LIMIT 1) as name_spent)
GROUP BY 2;
 

-- What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(total_spent)
FROM (SELECT a.name, SUM(o.total_amt_usd) as total_spent
	 FROM accounts as a
	 JOIN orders as o
	 ON a.id = o.account_id
	 GROUP BY 1
	 ORDER BY 2 DESC
	 LIMIT 10);

-- What is the lifetime average amount spent in terms of total_amt_usd, 
-- including only the companies that spent more per order, on average, than the average of all orders.
SELECT AVG(avg_usd)
FROM (SELECT a.name, AVG(o.total_amt_usd) as avg_usd
	FROM accounts as a
	JOIN orders as o
	ON a.id = o.account_id
	GROUP BY 1
	HAVING AVG(o.total_amt_usd)> (SELECT AVG(o.total_amt_usd)
									FROM orders as o));
