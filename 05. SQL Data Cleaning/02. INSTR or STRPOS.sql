-- Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.

SELECT 
substr(primary_poc, 1, instr(primary_poc, ' ')) as poc_first_name,
substr(primary_poc, instr(primary_poc, ' '), length(primary_poc)) as poc_last_name
FROM accounts;

-- Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.

SELECT 
substr(name, 1, instr(name, ' ')) as rep_first_name,
substr(name, instr(name, ' '), length(name)) as rep_last_name
FROM sales_reps;