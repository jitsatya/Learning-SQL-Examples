-- Quizzes CONCAT
-- Each company in the accounts table wants to create an email address for each primary_poc. 
-- The email address should be the first name of the primary_poc . 
-- last name primary_poc @ company name .com.
WITH details as(
SELECT substr(primary_poc, 1, instr(primary_poc, ' ')-1) as poc_firstname,
substr(primary_poc, instr(primary_poc, ' ')+1, length(primary_poc)) as poc_last_name,
replace(name, ' ', '') as company
FROM accounts
)
SELECT lower(poc_firstname) || '.' || lower(poc_last_name) || '@' || lower(company) || '' || '.com' as email
FROM details;

-- You may have noticed that in the previous solution some of the company names include spaces, 
-- which will certainly not work in an email address. 
-- See if you can create an email address that will work by removing all of the spaces in the account name, 
-- but otherwise your solution should be just as in question 1. Some helpful documentation is here.

WITH details as(
SELECT substr(primary_poc, 1, instr(primary_poc, ' ')-1) as poc_firstname,
substr(primary_poc, instr(primary_poc, ' ')+1, length(primary_poc)) as poc_last_name,
replace(name, ' ', '') as company
FROM accounts
)
SELECT lower(poc_firstname) || lower(poc_last_name) || '@' || lower(company) || '' || '.com' as email
FROM details;

-- We would also like to create an initial password, 
-- which they will change after their first log in. 
-- The first password will be the first letter of the primary_poc's first name (lowercase), 
-- then the last letter of their first name (lowercase), 
-- the first letter of their last name (lowercase), 
-- the last letter of their last name (lowercase), 
-- the number of letters in their first name, 
-- the number of letters in their last name, 
-- and then the name of the company they are working with, 
-- all capitalized with no spaces.

WITH chars as (
SELECT
id,
lower(substr(primary_poc, 1,1)) as char_ffname,
lower(substr(primary_poc, instr(primary_poc, ' ')-1, 1)) as char_lfname,
lower(substr(primary_poc, instr(primary_poc, ' ')+1, 1)) as char_flname,
lower(substr(primary_poc, -1, 1)) as char_llname,
length(substr(primary_poc, 1, instr(primary_poc, ' ')-1)) as length_fname,
length(substr(primary_poc, instr(primary_poc, ' ')+1, length(primary_poc))) as length_lname,
replace(name, ' ', '') as company
FROM accounts
),
details as(
SELECT id, substr(primary_poc, 1, instr(primary_poc, ' ')-1) as poc_firstname,
substr(primary_poc, instr(primary_poc, ' ')+1, length(primary_poc)) as poc_last_name,
replace(name, ' ', '') as company
FROM accounts
),
email as (
SELECT id, lower(poc_firstname) || lower(poc_last_name) || '@' || lower(company) || '' || '.com' as email
FROM details
)
SELECT 
d.poc_firstname as first_name,
d.poc_last_name as last_name,
e.email as email,
c.char_ffname || c.char_lfname || c.char_flname || c.char_llname || c.length_fname || c.length_lname || upper(c.company) as password
FROM chars as c
JOIN details as d
ON c.id = d.id
JOIN email as e
ON d.id = e.id
