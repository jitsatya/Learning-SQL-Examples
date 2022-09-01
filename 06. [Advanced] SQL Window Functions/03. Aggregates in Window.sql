--Aggregates in Window Functions with and without ORDER BY
SELECT id,
       account_id,
       standard_qty,
       strftime('%m', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY strftime('%m', occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY strftime('%m', occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY strftime('%m', occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY strftime('%m', occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY strftime('%m', occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY strftime('%m', occurred_at)) AS max_std_qty
FROM orders