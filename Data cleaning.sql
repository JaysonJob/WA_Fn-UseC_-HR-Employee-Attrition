create schema netflix_analysis;
set search_path to netflix_analysis;

CREATE TABLE netflix_titles (
    show_id VARCHAR(20) PRIMARY KEY,
    type VARCHAR(20),
    title TEXT,
    director TEXT,
    "cast" TEXT,
    country TEXT,
    date_added DATE,
    release_year INTEGER,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in TEXT,
    description TEXT
);
-- confirming our data if was imported sucesfully
select * from netflix_titles;


-- cheching the number of rows that we have
select count(*)
from netflix_titles;

--PART A--DATA CLEANING.
---1.Type column
select type,count(*)
from netflix_titles
group by type;

-- the column is great since we only have 2 types;the tvshow and movie

---2.TITLE column
--triming,standardizing letters
select title,count(*)
from netflix_titles
group by title;

update netflix_titles
set title = trim(initcap(title))
where title != trim(initcap(title));

---3.DIRECTOR column
select director,count(*)
from netflix_titles
group by director;
-- checking for nulls and blanks
select count(*) as missing
from netflix_titles
where director is null or director = '';
--replacing them with unknown--
update netflix_titles
set director = 'unknown'
where director = null or director = '';
--- Trimming and standardizing letters
update netflix_titles
set director = trim(initcap(director))
where director != trim(initcap(director));

-- 4.CAST column
select "cast"from netflix_titles;
--checking for nulls and replacing them with unknown
select count(*) as missing
from netflix_titles
where "cast" is null or "cast" = '';

update netflix_titles
set "cast" = 'unknown'
where "cast" = null or "cast" = '';

-- 5.COUNTRY column
--1.replacing blanks with unknown
--2.standardizing letters and trimming
select country from netflix_titles;

select count(*) as missing
from netflix_titles
where country is null or country = '';
--replacing them with unknown--
update netflix_titles
set country = 'unknown'
where country = null or country = '';
--- Trimming and standardizing letters
update netflix_titles
set country = trim(initcap(country))
where country != trim(initcap(country));

-- 6.DATE_ADDED column
select date_added from netflix_titles;
--1.cheking for blanks
select count(*) as invalid_dates
from netflix_titles
where date_added is null;

--7.RELEASE_YEAR column
--1.checking for nuls and also converting from currency to normal year
select release_year from netflix_titles;
-- checking for nulls
select count(*) as null_release_years
from netflix_titles
where release_year is null;
-- converting from curency to year
select release_year::text from netflix_titles;
-- Remove commas and convert to integer
UPDATE netflix_titles 
SET release_year = REPLACE(release_year::text, ',', '')::integer
WHERE release_year::text LIKE '%,%'; 

--8.RATINGS column
--checking for nulls and empty to be replaced with unknown
select rating from netflix_titles;
--checking for nulls and replacing them with unknown
select count(*) as missing
from netflix_titles
where rating is null or rating = '';

update netflix_titles
set rating = 'unknown'
where rating = null or rating = '';

--9.DUREATION column
select duration from netflix_titles;
--cheking for nulls
select count(*) as missing
from netflix_titles
where duration is null or duration = '';

--fixing it with unknown
update netflix_titles
set duration = 'unknown'
where duration = null or duration = '';

--10.LISTED IN column
select listed_in from netflix_titles;
--cheking for nulls
select count(*) as missing
from netflix_titles
where listed_in is null or listed_in = '';
--- Trimming and standardizing letters
update netflix_titles
set listed_in = trim(initcap(listed_in))
where listed_in != trim(initcap(listed_in));

-- 10.DESCRIPTION column
select description from netflix_titles;
--cheching for blanks
select count(*) as missing
from netflix_titles
where description is null or description = '';