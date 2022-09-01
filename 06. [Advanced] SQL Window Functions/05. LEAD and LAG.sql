SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
	   LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd as lead_difference
FROM (
SELECT occurred_at,
       total_amt_usd
  FROM orders 
 ) sub