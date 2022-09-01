SELECT channel, AVG(num_events) as avg_events
FROM
(SELECT date( occurred_at) as day,
channel,
COUNT(*) as num_events
FROM web_events
GROUP BY 1, 2) as events_by_day_channel
GROUP BY channel
