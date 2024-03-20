# Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
# The CITY table is described as follows:
select * from city 
where countrycode = 'USA' and population > 100000;

# Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
# The CITY table is described as follows:
select name from city where countrycode = 'usa' and population > 120000;

# Query all columns (attributes) for every row in the CITY table.
 select * from city;
 
 # Query all columns for a city in CITY with the ID 1661.
 select * from city where id = 1661;
 
 # Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
 select * from city where countrycode = 'JPN';
 
#  Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select name from city where countrycode = 'jpn';

# Query a list of CITY and STATE from the STATION table.
select city, state from station;

# Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct city from station where id%2 = 0;

# Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
select count(city) - count(distinct city) from station;

# Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
 SELECT DISTINCT(CITY) FROM STATION WHERE city regexp'^[aeiou]';
 
 # Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT(CITY) FROM STATION WHERE city regexp'[aeiou]$';

# Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
select distinct city from station where city REGEXP '^[aeiou].*[aeiou]$';

# Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct city from station where city not regexp '^[aeiou]';

# Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where city not regexp '[aeiou]$';

# Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where city not REGEXP '^[aeiou].*[aeiou]$';
 



