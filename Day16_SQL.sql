-- Fix Names in a Table
-- Table: Users
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | user_id        | int     |
-- | name           | varchar |
-- +----------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
-- Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
-- Return the result table ordered by user_id.
select user_id,concat(upper(substr(name,1,1)),lower(substr(name,2,length(name)))) as name from Users order by user_id;

-- Patients With a Condition
-- Table: Patients
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | patient_id   | int     |
-- | patient_name | varchar |
-- | conditions   | varchar |
-- +--------------+---------+
-- patient_id is the primary key (column with unique values) for this table.
-- 'conditions' contains 0 or more code separated by spaces. 
-- This table contains information of the patients in the hospital.
-- Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.
-- Return the result table in any order.
select patient_id, patient_name, conditions from patients
where conditions like "% DIAB1%" or conditions like "DIAB1%";

-- Delete Duplicate Emails
-- Table: Person
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | email       | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains an email. The emails will not contain uppercase letters.
-- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
-- For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
-- For Pandas users, please note that you are supposed to modify Person in place.
-- After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. 
-- The final order of the Person table does not matter.
DELETE P1 FROM PERSON P1, PERSON P2
WHERE P1.Email = p2.Email AND P1.Id>P2.Id ;

-- Second Highest Salary
-- Table: Employee
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table contains information about the salary of an employee.
-- Write a solution to find the second highest salary from the Employee table. 
-- If there is no second highest salary, return null (return None in Pandas).
SELECT max(salary) AS SecondHighestSalary
FROM Employee 
WHERE Salary <> (SELECT max(salary) FROM Employee);


-- Group Sold Products By The Date
-- Table Activities:
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | sell_date   | date    |
-- | product     | varchar |
-- +-------------+---------+
-- There is no primary key (column with unique values) for this table. It may contain duplicates.
-- Each row of this table contains the product name and the date it was sold in a market.
-- Write a solution to find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.
-- Return the result table ordered by sell_date.
select 
sell_date, count(distinct product) as num_sold, 
group_concat(distinct product) as products 
from activities 
group by sell_date;

-- List the Products Ordered in a Period
-- Table: Products
-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | product_id       | int     |
-- | product_name     | varchar |
-- | product_category | varchar |
-- +------------------+---------+
-- product_id is the primary key (column with unique values) for this table.
-- This table contains data about the company's products.
-- Table: Orders
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | order_date    | date    |
-- | unit          | int     |
-- +---------------+---------+
-- This table may have duplicate rows.
-- product_id is a foreign key (reference column) to the Products table.
-- unit is the number of products ordered in order_date.
-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
-- Return the result table in any order.
SELECT product_name,unit FROM Products JOIN (SELECT product_id,sum(unit) AS 'unit' FROM
Orders
WHERE month(order_date) = 2 AND year(order_date) = 2020
GROUP BY product_id
HAVING sum(unit) >=100)T ON Products.product_id = T.product_id;


-- Find Users With Valid E-Mails
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- | mail          | varchar |
-- +---------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- This table contains information of the users signed up in a website. Some e-mails are invalid.
-- Write a solution to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- The domain is '@leetcode.com'.
-- Return the result table in any order.
SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[a-zA-Z]{1}[a-zA-Z0-9_.-]*@leetcode[.]com$';



