--  Sales Person
--  Table: SalesPerson
-- +-----------------+---------+
-- | Column Name     | Type    |
-- +-----------------+---------+
-- | sales_id        | int     |
-- | name            | varchar |
-- | salary          | int     |
-- | commission_rate | int     |
-- | hire_date       | date    |
-- +-----------------+---------+
-- sales_id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the name and the ID of a salesperson alongside their salary, commission rate, and hire date.
-- Table: Company
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | com_id      | int     |
-- | name        | varchar |
-- | city        | varchar |
-- +-------------+---------+
-- com_id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the name and the ID of a company and the city in which the company is located.
-- Table: Orders
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | order_id    | int  |
-- | order_date  | date |
-- | com_id      | int  |
-- | sales_id    | int  |
-- | amount      | int  |
-- +-------------+------+
-- order_id is the primary key (column with unique values) for this table.
-- com_id is a foreign key (reference column) to com_id from the Company table.
-- sales_id is a foreign key (reference column) to sales_id from the SalesPerson table.
-- Each row of this table contains information about one order. This includes the ID of the company, the ID of the salesperson, the date of the order, and the amount paid.
-- Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".
-- Return the result table in any order.
select name from salesperson where name not in (
select s.name from
orders o join salesperson s on s.sales_id=o.sales_id
join company c on c.com_id=o.com_id
where c.name='RED'
);

-- Top Travellers
-- Table: Users
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- name is the name of the user.
-- Table: Rides
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | user_id       | int     |
-- | distance      | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- user_id is the id of the user who traveled the distance "distance".
-- Write a solution to report the distance traveled by each user.
-- Return the result table ordered by travelled_distance in descending order, if two or more users traveled the same distance, order them by their name in ascending order.
select u.name,coalesce( sum(r.distance),0) as travelled_distance from users u
left join rides r on r.user_id = u.id 
group by r.user_id
order by travelled_distance desc, name asc;


-- Actors and Directors Who Cooperated At Least Three Times
-- Table: ActorDirector
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | actor_id    | int     |
-- | director_id | int     |
-- | timestamp   | int     |
-- +-------------+---------+
-- timestamp is the primary key (column with unique values) for this table.
-- Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
-- Return the result table in any order.
Select actor_id,director_id
From ActorDirector
GROUP BY actor_id,director_id
Having count(timestamp)>=3 ;







 