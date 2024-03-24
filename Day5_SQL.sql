# A median is defined as a number separating the higher half of a data set from the lower half. 
# Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
select round(lat_n,4)
from (
    select *, row_number() over(order by lat_n asc) as rn from station
    ) as temp
where rn = 250;

-- You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
-- Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
-- Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
-- The report must be in descending order by grade -- i.e. higher grades are entered first. 
-- If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order.
-- If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
-- Write a query to help Eve.

select case when g.grade>=8 then s.name else NULL end as Name, g.grade, s.marks from students s
join grades g on s.marks between g.min_mark and g.max_mark
order by g.grade desc, s.name asc;


-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
-- Order your output in descending order by the total number of challenges in which the hacker earned a full score.
--  If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

SELECT h.hacker_id, h.name
FROM Hackers AS h
JOIN Submissions AS s on s.hacker_id = h.hacker_id
JOIN Challenges AS c on c.challenge_id = s.challenge_id
JOIN Difficulty AS d on d.difficulty_level = c.difficulty_level
WHERE s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(c.challenge_id) > 1
ORDER BY COUNT(c.challenge_id) DESC, h.hacker_id;

-- Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age.
-- Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
-- If more than one wand has same power, sort the result in order of descending age.

select w.id, p.age, w.coins_needed, w.power as power1 from wands w
join Wands_Property p on p.code = w.code
where p.is_evil = '0'
and w.coins_needed in
(select min(w1.coins_needed) from wands w1
join Wands_Property p1 on w1.code = p1.code
where p.age = p1.age
and w.power = w1.power)
ORDER BY w.power DESC, p.age DESC;

-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
-- Order your output in descending order by the total number of challenges in which the hacker earned a full score.
--  If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

WITH ChallengeCounts AS (
    SELECT
        h.hacker_id,
        h.name,
        COUNT(c.challenge_id) AS NumChallenges
    FROM Hackers h
    JOIN Challenges c ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, h.name
),
MaxChallengeCount AS (
    SELECT MAX(NumChallenges) AS MaxNumChallenges
    FROM ChallengeCounts
),
NonUniqueCounts AS (
    SELECT NumChallenges
    FROM ChallengeCounts
    GROUP BY NumChallenges
    HAVING COUNT(*) > 1 AND NumChallenges < (SELECT MaxNumChallenges FROM MaxChallengeCount)
)
SELECT
    cc.hacker_id,
    cc.name,
    cc.NumChallenges
FROM ChallengeCounts cc
WHERE cc.NumChallenges NOT IN (SELECT NumChallenges FROM NonUniqueCounts)
ORDER BY cc.NumChallenges DESC, cc.hacker_id;
