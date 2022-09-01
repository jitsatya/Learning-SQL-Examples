-- Questions: Working With DATEs
-- Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
-- Do you notice any trends in the yearly sales totals?

SELECT strftime('%Y', occurred_at) as year,
SUM(total_amt_usd) as total_sales
FROM orders
GROUP BY 1
ORDER BY total_sales DESC;
 
-- Which month did Parch & Posey have the greatest sales in terms of total dollars? 
-- Are all months evenly represented by the dataset?

SELECT strftime('%m', occurred_at) as month,
SUM(total_amt_usd) as total_sales
FROM orders
GROUP BY 1
ORDER BY total_sales DESC;

-- Which year did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all years evenly represented by the dataset?

SELECT strftime('%Y', occurred_at) as year,
COUNT(*) as num_orders
FROM orders
GROUP BY 1
ORDER BY num_orders DESC;

-- Which month did Parch & Posey have the greatest sales in terms of total number of orders? 
-- Are all months evenly represented by the dataset?

SELECT strftime('%m', occurred_at) as month,
COUNT(*) as num_orders
FROM orders
GROUP BY 1
ORDER BY num_orders DESC;
 
-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

WITH walmart AS 
(SELECT *
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
WHERE a.name = 'Walmart'
)
SELECT strftime('%Y', occurred_at) as year,
strftime('%m', occurred_at) as month,
SUM(gloss_amt_usd) as spent_on_gloss,
COUNT(gloss_qty) as total_gloss_qty
FROM walmart
GROUP BY 1, 2
ORDER BY spent_on_gloss DESC
LIMIT 1;
