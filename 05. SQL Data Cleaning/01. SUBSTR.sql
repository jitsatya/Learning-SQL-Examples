-- SUBSTR
-- In the accounts table, there is a column holding the website for each company. 
-- The last three digits specify what type of web address they are using. 
-- A list of extensions (and pricing) is provided here https://iwantmyname.com/domains. 
-- Pull these extensions and provide how many of each website type exist in the accounts table.

SELECT substr(website, LENGTH(website)+1, -3) as extension,
COUNT(*) as frequency
FROM accounts
GROUP BY 1;

-- There is much debate about how much the name (or even the first letter of a company name) matters. 
-- Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).

SELECT substr(name, 1,1) as first_letter,
COUNT(*) as frequency
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;
 
-- Use the accounts table and a CASE statement to create two groups: 
-- one group of company names that start with a number and a second group of those company names that start with a letter. 
-- What proportion of company names start with a letter?
WITH cal as (
SELECT name,
CASE WHEN substr(name, 1,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END AS numbers,
CASE WHEN substr(name, 1,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 0 ELSE 1 END AS letters
FROM accounts
)
SELECT SUM(numbers) as total_nums,
SUM(letters) as total_letters
FROM cal;

-- Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?
WITH cal AS (
SELECT 
CASE WHEN substr(LOWER(name), 1,1) IN ('a', 'e', 'i', 'o', 'u') THEN 1 ELSE 0 END AS vowels,
CASE WHEN substr(LOWER(name), 1,1) NOT IN ('a', 'e', 'i', 'o', 'u') THEN 1 ELSE 0 END AS not_vowels
FROM accounts
)
SELECT SUM(vowels) as vowels,
SUM(not_vowels) as not_vowels
FROM cal