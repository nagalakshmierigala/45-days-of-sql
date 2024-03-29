-- Recyclable and Low Fat Products
-- Write a solution to find the ids of products that are both low fat and recyclable.
-- Return the result table in any order.
-- The result format is in the following example.
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y';

-- Find Customer Referee
-- Find the names of the customer that are not referred by the customer with id = 2.
-- Return the result table in any order
select name from customer where referee_id != 2 is not false;

-- Big Countries
-- A country is big if:
-- it has an area of at least three million (i.e., 3000000 km2), or
-- it has a population of at least twenty-five million (i.e., 25000000).
-- Write a solution to find the name, population, and area of the big countries.
-- Return the result table in any order.
select name, population, area from world where area >= 3000000 or population >= 25000000;

-- Article Views I
-- Write a solution to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.
select distinct v.viewer_id as id
from views v
where v.viewer_id = v.author_id
order by id;

-- Invalid Tweets
-- Write a solution to find the IDs of the invalid tweets. 
-- The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
-- Return the result table in any order.
select tweet_id from tweets
where length(content)>15;

-- Replace Employee ID With The Unique Identifier
-- Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
-- Return the result table in any order.
select b.unique_id,a.name from employees a
left join employeeuni b on a.id = b.id;
