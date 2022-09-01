WITH date_v1 AS(
SELECT substr(date, 1, instr(date, ' ')-1) as date
FROM sf_crime_data
),
date_v2 as (
SELECT substr(date, 1, 2) as month,
substr(date, 4, 2) as day,
substr(date, 7, 4) as year
FROM date_v1
)
SELECT datetime(year || '-' || month || '-' || day) as fixed_date
FROM date_v2
