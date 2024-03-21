# Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than . Truncate your answer to  decimal places.
SELECT MAX(TRUNCATE(LAT_N,4)) 
FROM STATION 
WHERE LAT_N < 137.2345;

# Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
# If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
(select city, length(city) as name_length from station
 order by name_length, city asc LIMIT 1)
UNION
(select city, length(city) as name_length from station
order by name_length desc, city asc LIMIT 1);
 
# Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than . Round your answer to  decimal places.
select round(long_w,4) from station where lat_n < 137.2345
order by lat_n desc
limit 1;

# Query the smallest Northern Latitude (LAT_N) from STATION that is greater than . Round your answer to  decimal places.
select round(lat_n, 4) from station where lat_n > 38.7780
order by lat_n
limit 1;

# Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than . Round your answer to  decimal places.
select round(long_w, 4) from station where lat_n > 38.7780
order by lat_n
limit 1;

# Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
# Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
select sum(a.population) from city a join country b on a.countrycode = b.code
where b.continent = 'Asia';

# Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
# Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
select a.name from city a join country b on a.countrycode = b.code
where b.continent = 'Africa';

# Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
# Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
select b.continent, truncate(avg(a.population),0) from city a
join country b on a.countrycode = b.code
group by b.continent;
# truncate, floor, round


# Generate the following two result sets:
# Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
# Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
select concat(name, '(', substr(occupation,1,1),')')
from occupations
order by name;

select concat('There are a total of ',count(occupation),' ',lower(occupation),'s.')
from occupations
group by occupation
order by count(occupation) asc, occupation;



