--- Analysis and answering business questions

set search_path to netflix_analysis;
select * from netflix_titles;

--1.how many tv shows were there:
select type,count(*) as total
from netflix_titles
group by type;

--2.most represented type(listed_in)
select listed_in,count(*) as totals
from netflix_titles
group by listed_in
order by totals desc;

--top 3 genre watched
select listed_in,count(*) as totals
from netflix_titles
group by listed_in
order by totals desc
limit 3;

-- most frequent casts
select "cast",count(*) as total_cast
from netflix_titles
group by "cast"
order by total_cast desc
limit 10;

-- most popular shows in all countries
select type,country,count(country)as totals
from netflix_titles
group by country,type
order by totals desc
limit 20;

-- total count of shows vs movies
select type,count(type) as totals
from netflix_titles
group by type;

--total no.of directors and no.of projects
select director,count(*) as totals_project
from netflix_titles
group by director
order by totals_project;



---========= Analysis=====----
--Top 5 Countries by Content Production with Ranking
select country,count(*) as totals,
      rank()over(order by count(*) desc)as rank
from netflix_titles
where country != 'unknown'
group by country
order by totals desc;

-- analyzing the content by ratings
select rating,
       count(case when type='Movie' then 1 end) movies,
       count(case when type='TV Show' then 1 end) tv_shows
from netflix_titles
where rating is not null
group by rating
order by movies desc;

-- Business questions
--1.how long does it take to get a netflix content ?
select release_year,
    round(avg(extract(year from date_added) - release_year), 1) as avg_years_to_add
from netflix_titles
group by release_year
order by release_year desc;

-- 2.which month does netflix have alot of shows and movies
select TO_CHAR(date_added, 'Month') as month,count(*) as titles_added
from netflix_titles
group by month,extract(month from date_added)
order by extract (month from date_added);

--3.what is the oldest and the newest netflic content
SELECT min(release_year) as oldest,
max(release_year) as newest
from netflix_titles;

-- 4.how many titles ere released each decade(10)yrs
select (release_year / 10) * 10 as decade, count(*) as titles
from netflix_titles
group by 1
order by 1;

--5.unique countries to produce netflix content
select count(distinct country) as unique_countries
from netflix_titles;

--CREATING VIEWS 
--i will be creating 4 views and among them 1 will be our fact table

--1.creating the netflix_title(fact table)
create or replace view vw_netflix_titles as
select
    show_id,type,title,director,country,date_added,
    ectract(year from date_added)::INT as year_added,
    release_year,rating,duration,
    listed_in,description
from netflix_titles;
--calling the view
select * from vw_netflix_titles;


--2.creating 2nd view called countries
-- i will only have 2 columns since the fact table hass it all
create or replace view vw_countries as
select show_id,country from netflix_titles;
--calling it
select * from vw_countries;


--3.creating the director view
--having column show_id,title,director,cast,listed_in,description
create or replace view vw_director as
select show_id,title,director,"cast",listed_in
from netflix_titles;
--calling it
select * from vw_director;


---4.creating the perioud view
-- having show_id,type,date added,release_year,duration,
create or replace view vw_periods as 
select show_id,type,date_added,release_year,duration,description
from netflix_titles;
--calling the periods view
select * from vw_periods;