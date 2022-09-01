-- Use DISTINCT to test if there are any accounts associated with more than one region.

SELECT DISTINCT a.name,
		COUNT(*) as num_times
FROM accounts as a
JOIN sales_reps as s
ON a.sales_rep_id = s.id
JOIN region as r
ON s.region_id = r.id
GROUP BY a.name
ORDER BY num_times DESC;
-- Have any sales reps worked on more than one account?

SELECT s.name as sales_rep,
		COUNT(*) as num_times
FROM accounts as a
JOIN sales_reps as s
ON a.sales_rep_id = s.id
GROUP BY sales_rep
ORDER BY num_times DESC;