-- The Number of Employees Which Report to Each Employee
-- Table: Employees
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | employee_id | int      |
-- | name        | varchar  |
-- | reports_to  | int      |
-- | age         | int      |
-- +-------------+----------+
-- employee_id is the column with unique values for this table.
-- This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
-- For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.
-- Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
-- Return the result table ordered by employee_id.
SELECT 
m.employee_id, 
m.name, 
COUNT(r.employee_id) AS reports_count, 
ROUND(AVG(r.age), 0) AS average_age
FROM 
    Employees AS m
JOIN 
    Employees AS r ON m.employee_id = r.reports_to
GROUP BY 
    m.employee_id, m.name
ORDER BY 
    m.employee_id;
    
    
-- Primary Department for Each Employee
-- Table: Employee
-- +---------------+---------+
-- | Column Name   |  Type   |
-- +---------------+---------+
-- | employee_id   | int     |
-- | department_id | int     |
-- | primary_flag  | varchar |
-- +---------------+---------+
-- (employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
-- employee_id is the id of the employee.
-- department_id is the id of the department to which the employee belongs.
-- primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
-- Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.
-- Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.
-- Return the result table in any order.   
select employee_id, department_id
from Employee
where primary_flag = 'Y' or employee_id in (
select employee_id from employee group by employee_id having count(department_id) = 1);


 -- Triangle Judgement
--  Table: Triangle
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | x           | int  |
-- | y           | int  |
-- | z           | int  |
-- +-------------+------+
-- In SQL, (x, y, z) is the primary key column for this table.
-- Each row of this table contains the lengths of three line segments.
-- Report for every three line segments whether they can form a triangle.
-- Return the result table in any order.
select x,y,z, case when x+y>z and y+z>x and z+x>y then 'Yes' else 'No' end as triangle from triangle;


-- Consecutive Numbers
-- Table: Logs
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- In SQL, id is the primary key for this table.
-- id is an autoincrement column.
-- Find all numbers that appear at least three times consecutively.
-- Return the result table in any order.
SELECT DISTINCT
    num AS ConsecutiveNums
FROM (
    SELECT 
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev_num,
        LAG(num, 2) OVER (ORDER BY id) AS prev_num2,
        LEAD(num, 1) OVER (ORDER BY id) AS next_num,
        LEAD(num, 2) OVER (ORDER BY id) AS next_num2
    FROM 
        Logs
) AS subquery
WHERE 
    (num = prev_num AND num = prev_num2) -- num matches the two previous rows
    OR 
    (num = next_num AND num = next_num2) -- num matches the two next rows
    OR 
    (num = prev_num AND num = next_num); -- num matches the previous and next row


-- Product Price at a Given Date
-- Table: Products
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key (combination of columns with unique values) of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
-- Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
-- Return the result table in any order.
SELECT
    product_id,
    COALESCE(
        (SELECT new_price FROM Products WHERE product_id = p.product_id AND change_date <= '2019-08-16'
         ORDER BY change_date DESC LIMIT 1),
         10) AS price
FROM
    (SELECT DISTINCT product_id FROM Products) p;


-- Last Person to Fit in the Bus
-- Table: Queue
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | person_id   | int     |
-- | person_name | varchar |
-- | weight      | int     |
-- | turn        | int     |
-- +-------------+---------+
-- person_id column contains unique values.
-- This table has the information about all people waiting for a bus.
-- The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
-- turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
-- weight is the weight of the person in kilograms.
-- There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.
-- Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.
with cte as (SELECT person_name,weight,turn,SUM(weight) over (order by turn) as total from Queue)
SELECT person_name
FROM cte
where total <= 1000
order by total DESC
LIMIT 1;

-- Count Salary Categories
-- Table: Accounts
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | account_id  | int  |
-- | income      | int  |
-- +-------------+------+
-- account_id is the primary key (column with unique values) for this table.
-- Each row contains information about the monthly income for one bank account.
-- Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:
-- "Low Salary": All the salaries strictly less than $20000.
-- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
-- "High Salary": All the salaries strictly greater than $50000.
-- The result table must contain all three categories. If there are no accounts in a category, return 0.
-- Return the result table in any order.
SELECT
    Category,
    COUNT(account_id) AS Accounts_Count
FROM
    (SELECT
         account_id,
         CASE
             WHEN income < 20000 THEN 'Low Salary'
             WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
             WHEN income > 50000 THEN 'High Salary'
             ELSE 'Unknown Category'
         END AS Category
     FROM Accounts) AS SalaryCategories
GROUP BY
    Category
UNION ALL
SELECT 'Low Salary' AS Category, 0 AS Accounts_Count
WHERE NOT EXISTS (SELECT 1 FROM Accounts WHERE income < 20000)
UNION ALL
SELECT 'Average Salary', 0
WHERE NOT EXISTS (SELECT 1 FROM Accounts WHERE income BETWEEN 20000 AND 50000)
UNION ALL
SELECT 'High Salary', 0
WHERE NOT EXISTS (SELECT 1 FROM Accounts WHERE income > 50000);


 
