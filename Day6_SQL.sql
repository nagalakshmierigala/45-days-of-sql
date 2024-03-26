-- You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
-- The total score of a hacker is the sum of their maximum scores for all of the challenges.
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
-- If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
-- Exclude all hackers with a total score of  from your result.

SELECT mx.hacker_id, h.name, SUM(mx.mx_score) AS total_score
FROM (
    SELECT hacker_id, challenge_id, MAX(score) AS mx_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) AS mx
INNER JOIN Hackers AS h ON mx.hacker_id = h.hacker_id
GROUP BY mx.hacker_id, h.name
HAVING SUM(mx.mx_score) > 0
ORDER BY total_score DESC, mx.hacker_id;

-- You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
-- It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
-- If the End_Date of the tasks are consecutive, then they are part of the same project.
--  Samantha is interested in finding the total number of different projects completed.
-- Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. 
-- If there is more than one project that have the same number of completion days, then order by the start date of the project.
SELECT START_DATE, MIN(END_DATE)
FROM
  (SELECT START_DATE
   FROM PROJECTS
   WHERE START_DATE NOT IN
       (SELECT END_DATE
        FROM PROJECTS)) A,
  (SELECT END_DATE
   FROM PROJECTS
   WHERE END_DATE NOT IN
       (SELECT START_DATE
        FROM PROJECTS)) B
WHERE START_DATE < END_DATE
GROUP BY START_DATE
ORDER BY (MIN(END_DATE) - START_DATE), START_DATE;


-- You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. 
-- Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
-- Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

with table1 as(select s.id,s.name,f.friend_id,p.salary from students s join friends f
on s.id=f.id join packages p on s.id=p.id)
select t1.name from table1 t1 join table1 t2
on t1.friend_id=t2.id where t1.salary < t2.salary order by t2.salary;


-- You are given a table, Functions, containing two columns: X and Y.
-- Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
-- Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
with newt as (
    select x, y, row_number() over() as rown
    from Functions
) 
SELECT distinct f1.x, f1.y
FROM newt f1
join newt f2 on f1.y = f2.x
where f1.x = f2.y and f1.x <= f1.y and f1.rown != f2.rown
order by f1.x;



