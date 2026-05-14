
--Drop table if it EXISTS
DROP TABLE if exists netflix_tb;

--create table
CREATE TABLE netflix_tb
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

select * from netflix_tb;

----------------------------data cleaning-------------------------------------------

SELECT * from netflix_tb
WHERE show_id is null
		OR type is null
		OR title is null
		OR director is null
		OR casts is null
		OR country is null
		OR date_added is null
		OR release_year is null
		OR rating is null
		OR duration is null;


--delete if show id is null
DELETE  FROM netflix_tb
WHERE show_id is null;


-------------------------------------EDA-----------------------------------

--Total TV show and Movie
SELECT 
	type,
	count(*)
From netflix_tb
group by type;

--Country which released most content
Select 
	Trim(unnest(string_to_array(country,','))) as country,
	count(*) as total_content
From netflix_tb
where country is not null
group by country
order by total_content desc
limit 10;



--Country which released most movie
Select 
	Trim(unnest(string_to_array(country,','))) as country,
	count(*) as total_movie
From netflix_tb
where country is not null and type='Movie'
group by country
order by total_movie desc;

--Director which make most movie
Select 
	director,
	count(*) as total_movie_by_director
From netflix_tb
Where director is not null and type='Movie'
group by director
order by total_movie_by_director DESC;


---------------------------------Business releated query---------------------
--top 5 longest duration movie
Select 
	cast(split_part(duration,' ',1)as int) as duration,
	type
From netflix_tb
Where type='Movie' and duration is not null
order by duration DESC
limit 5;

-- Find the most common rating for Movies and TV Shows
SELECT
    type,
    rating,
    COUNT(*) AS total_content
FROM netflix_tb
WHERE rating IS NOT NULL
GROUP BY type, rating
ORDER BY total_content DESC;

-- Country with most directors
SELECT 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
    COUNT(director) AS total_director
FROM netflix_tb
WHERE country IS NOT NULL
AND director IS NOT NULL
GROUP BY 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ',')))
ORDER BY total_director DESC;

-- Find the most famous actor (hero) on Netflix

SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
    COUNT(*) AS total_content
FROM netflix_tb
WHERE casts IS NOT NULL
GROUP BY 1
ORDER BY total_content DESC
LIMIT 10;

--how many per YEAR RELEASE
SELECT
	release_year,
	count(*) as total_movie_per_year
from netflix_tb
group by 
	release_year
order by total_movie_per_year desc;


--most movie released by year and coutry
Select 
	  TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
	  release_year,
	  count(*) as total_movie_per_country_per_year
From netflix_tb
where country is not null and type='Movie'
group by  TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) ,release_year
order by total_movie_per_country_per_year  desc;

-- Find total movies released in India in 2017
SELECT 
    type,
    release_year, 
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
    COUNT(*) AS total_movie_made_in_india_in_2017
FROM netflix_tb
WHERE release_year = 2017
AND type = 'Movie'
AND country IS NOT NULL
GROUP BY type, release_year, country
HAVING country = 'India';

---- List all movies released in a specific year (e.g., 2020)
SELECT 
	type,
	release_year,
	count(*) as total_movie
from netflix_tb
where type='Movie' 
		AND release_year=2020
Group by  type ,release_year;


--List all TV shows with more than 5 seasons
select * From netflix_tb
where type='TV Show'
		AND cast(split_part(duration,' ',1)as int) >5;

-- most Tv show release by country
Select 
	type,
	TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) As country,
	count(*) as total_tvshow
from netflix_tb
where country is not null 
	And type='TV Show'
group by type,country
order by total_tvshow desc;

--  Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT *
FROM netflix_tb
WHERE director LIKE '%Rajiv Chilaka%';


-- Count comedy movies accurately
SELECT 
    COUNT(*) AS total_comedy_movies
FROM netflix_tb
WHERE type = 'Movie'
AND EXISTS (
    SELECT 1
    FROM UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
    WHERE TRIM(genre) = 'Comedies'
);

-- Find all content without a director
SELECT * FROM netflix_tb
WHERE director IS NULL

--Top countries by movie releases every year
WITH country_movies AS (
    SELECT 
        TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
        release_year
    FROM netflix_tb
    WHERE type = 'Movie'
)

SELECT *,
       RANK() OVER(
           PARTITION BY release_year
           ORDER BY total_movies DESC
       ) AS movie_rank
FROM (
    SELECT 
        country,
        release_year,
        COUNT(*) AS total_movies
    FROM country_movies
    GROUP BY country, release_year
) t;

-- Percentage of Movies and TV Shows released each year
SELECT 
    release_year,
    type,
    COUNT(*) AS total_content,
    
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(PARTITION BY release_year),
        2
    ) AS percentage_per_year

FROM netflix_tb
WHERE release_year IS NOT NULL
GROUP BY release_year, type
ORDER BY release_year;