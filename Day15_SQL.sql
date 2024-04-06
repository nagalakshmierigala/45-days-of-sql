-- Employees Whose Manager Left the Company
-- Table: Employees
-- +-------------+----------+
-- | Column Name | Type     |
-- +-------------+----------+
-- | employee_id | int      |
-- | name        | varchar  |
-- | manager_id  | int      |
-- | salary      | int      |
-- +-------------+----------+
-- In SQL, employee_id is the primary key for this table.
-- This table contains information about the employees, their salary, and the ID of their manager. Some employees do not have a manager (manager_id is null). 
-- Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.
-- Return the result table ordered by employee_id.
select employee_id from Employees where salary <30000
and manager_id not in (select employee_id from Employees)
order by employee_id;

--  Exchange Seats
--  Table: Seat
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key (unique value) column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- id is a continuous increment.
-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
-- Return the result table ordered by id in ascending order.
SELECT CASE WHEN id%2=0 THEN id-1 WHEN id%2=1 and id!=(select max(id) from Seat)THEN id+1 ELSE id END as id,student
FROM Seat
ORDER BY id;

-- Movie Rating
-- Table: Movies
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | title         | varchar |
-- +---------------+---------+
-- movie_id is the primary key (column with unique values) for this table.
-- title is the name of the movie.
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | name          | varchar |
-- +---------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- Table: MovieRating
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | movie_id      | int     |
-- | user_id       | int     |
-- | rating        | int     |
-- | created_at    | date    |
-- +---------------+---------+
-- (movie_id, user_id) is the primary key (column with unique values) for this table.
-- This table contains the rating of a movie by a user in their review.
-- created_at is the user's review date.
-- Write a solution to:
-- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
(SELECT u.name AS results
FROM Users u
JOIN MovieRating mr ON u.user_id = mr.user_id
GROUP BY u.name
ORDER BY COUNT(mr.movie_id) DESC, u.name ASC
LIMIT 1)

UNION ALL

(SELECT m.title AS results
FROM Movies m
JOIN MovieRating mr ON m.movie_id = mr.movie_id
WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY m.title
ORDER BY AVG(mr.rating) DESC, m.title ASC
LIMIT 1);


 -- Restaurant Growth
--  Table: Customer
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | customer_id   | int     |
-- | name          | varchar |
-- | visited_on    | date    |
-- | amount        | int     |
-- +---------------+---------+
-- In SQL,(customer_id, visited_on) is the primary key for this table.
-- This table contains data about customer transactions in a restaurant.
-- visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
-- amount is the total paid by a customer.
-- You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
-- Return the result table ordered by visited_on in ascending order.
SELECT visited_on,SUM(amount) as amount, ROUND((SUM(amount)/7), 2) as average_amount
FROM
(SELECT distinct visited_on,
sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount
FROM
(SELECT visited_on, SUM(amount) as amount FROM Customer GROUP BY 1) temp2
)TEMP
GROUP BY visited_on
LIMIT 100 OFFSET 6;

SELECT visited_on,SUM(amount) as amount, ROUND((SUM(amount)/7), 2) as average_amount
FROM
(SELECT distinct visited_on,
sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount
FROM
(SELECT visited_on, SUM(amount) as amount FROM Customer GROUP BY 1) temp2
)TEMP
GROUP BY visited_on
LIMIT 100 OFFSET 6;

SELECT visited_on,SUM(amount) as amount, ROUND((SUM(amount)/7), 2) as average_amount
FROM
(SELECT distinct visited_on,
sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount
FROM
(SELECT visited_on, SUM(amount) as amount FROM Customer GROUP BY 1) temp2
)TEMP
GROUP BY visited_on
LIMIT 100 OFFSET 6;

-- Friend Requests II: Who Has the Most Friends
-- Table: RequestAccepted
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
-- Write a solution to find the people who have the most friends and the most friends number.
-- The test cases are generated so that only one person has the most friends.
with a as
(select requester_id as id from requestaccepted
union all
select accepter_id as id from requestaccepted)

select id, count(id) as num
from a
group by id
order by num desc
limit 1;

-- Investments in 2016
-- Table: Insurance
-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | pid         | int   |
-- | tiv_2015    | float |
-- | tiv_2016    | float |
-- | lat         | float |
-- | lon         | float |
-- +-------------+-------+
-- pid is the primary key (column with unique values) for this table.
-- Each row of this table contains information about one policy where:
-- pid is the policyholder's policy ID.
-- tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
-- lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
-- lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.
-- Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
-- have the same tiv_2015 value as one or more other policyholders, and
-- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
-- Round tiv_2016 to two decimal places.
select round(sum(TIV_2016),2) as TIV_2016 from insurance
where TIV_2015 in
(select TIV_2015 from insurance group by TIV_2015 having count(TIV_2015) >1)
and concat(LAT, LON) not in
(select concat(LAT, LON) from insurance group by LAT, LON having count(concat(LAT, LON)) >1);


-- Department Top Three Salaries
-- Table: Employee
-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | id           | int     |
-- | name         | varchar |
-- | salary       | int     |
-- | departmentId | int     |
-- +--------------+---------+
-- id is the primary key (column with unique values) for this table.
-- departmentId is a foreign key (reference column) of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
-- Table: Department
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the ID of a department and its name.
-- A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
-- Write a solution to find the employees who are high earners in each of the departments.
-- Return the result table in any order.
with temp as (select d.name as 'Department', e.name as 'Employee', e.salary as 'Salary', dense_rank() over (partition by d.name order by e.salary desc) as 'ranking'
from employee e
left join department d
on e.departmentid = d.id)
select Department, Employee, Salary from temp where ranking between 1 and 3;



