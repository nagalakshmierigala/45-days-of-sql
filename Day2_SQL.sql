# Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where city not REGEXP '^[aeiou]' AND CITY NOT REGEXP '[aeiou]$';

# Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME FROM STUDENTS WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3), ID ASC;
 # or
 select Name from students where marks>75 order by substring(Name, length(Name)-2,3)asc,id asc;
 
 # Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
 select name from employee order by name;
 
 # Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.
 select name from employee where salary >2000 and months < 10
order by employee_id;

# Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
# Equilateral: It's a triangle with  sides of equal length.
# Isosceles: It's a triangle with  sides of equal length.
# Scalene: It's a triangle with  sides of differing lengths.
# Not A Triangle: The given values of A, B, and C don't form a triangle.

SELECT
    CASE 
        WHEN A + B <= C OR B + C <= A OR A + C <= B THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN A = B OR B = C OR A = C THEN 'Isosceles'
        ELSE 'Scalene'
    END as triangle_type
FROM triangles;

# Query a count of the number of cities in CITY having a Population larger than .
SELECT COUNT(ID) FROM CITY WHERE POPULATION > 100000;

# Query the total population of all cities in CITY where District is California.
SELECT SUM(population) FROM CITY WHERE DISTRICT = 'California';

# Query the average population of all cities in CITY where District is California.
select avg(population) from city where district = 'California';

# Query the average population for all cities in CITY, rounded down to the nearest integer.
select round(avg(population)) from city;

# Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.
select sum(population) from city where countrycode = 'JPN';

# Query the difference between the maximum and minimum populations in CITY.
select max(population)- min(population) from city;

# Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's  key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.
# Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer
select round(avg(salary))- round(avg(replace(salary,"0",""))) from employees;

# We define an employee's total earnings to be their monthly  worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. 
# Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings.
#  Then print these values as  space-separated integers.
select (months*salary) as earnings, count(employee_id) from employee
group by earnings 
order by earnings desc
limit 1;

# Query the following two values from the STATION table:
# The sum of all values in LAT_N rounded to a scale of  decimal places.
# The sum of all values in LONG_W rounded to a scale of  decimal places.
select round(sum(lat_n),2) as lat, round(sum(long_w),2) as lon from station;

# Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than  and less than . Truncate your answer to  decimal places.
select round(sum(lat_n),4) from station where lat_n > 38.7880 and lat_n<137.2345;



