-- Ranking Total Paper Ordered by Account
-- Select the id, account_id, and total variable from the orders table, 
-- then create a column called total_rank that ranks this total amount of 
-- paper ordered (from highest to lowest) for each account using a partition. 
-- Your final table should have these four columns.


-- ROW_NUMBER()
SELECT 
id,
account_id,
total,
row_number() OVER (ORDER BY occurred_at) as row_number
FROM orders;

--RANK()
SELECT 
id,
account_id,
total,
rank() OVER (PARTITION BY account_id ORDER BY total DESC) as rank
FROM orders;

--DENSE_RANK()
SELECT 
id,
account_id,
total,
dense_rank() OVER (PARTITION BY account_id ORDER BY total DESC) as dense_rank
FROM orders;
