# Netflix Content Analytics using PostgreSQL

Advanced PostgreSQL project analyzing Netflix Movies and TV Shows using data cleaning, exploratory data analysis (EDA), business intelligence queries, window functions, and trend analysis.

---

# Project Overview

This project focuses on analyzing Netflix Movies and TV Shows data using PostgreSQL.

The objective of this project is to perform:

- Data Cleaning
- Exploratory Data Analysis (EDA)
- Business Intelligence Analysis
- Trend Analysis
- Advanced SQL Querying

The dataset contains information related to:
- Movies
- TV Shows
- Directors
- Actors
- Countries
- Ratings
- Genres
- Release Years

This project demonstrates real-world SQL and PostgreSQL skills used in Data Analytics and Business Intelligence workflows.

---

# Tech Stack

- PostgreSQL
- SQL
- pgAdmin
- Git & GitHub
- Power BI (Optional)

---

# Project Structure

```bash
netflix-content-analytics-postgresql/
│
├── README.md
│
├── dataset/
│   └── netflix_titles.csv
│
├── sql_queries/
│   ├── 01_table_creation.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_eda_analysis.sql
│   ├── 04_business_problems.sql
│   └── 05_advanced_analysis.sql
│
├── screenshots/
│   ├── dataset_preview.png
│   ├── movie_vs_tvshow.png
│   ├── top_countries.png
│   ├── top_directors.png
│   ├── top_actors.png
│   └── yearly_releases.png
│
└── assets/
    └── er_diagram.png
```

---

# Dataset Information

The dataset contains Netflix Movies and TV Shows metadata including:

| Column Name | Description |
|---|---|
| show_id | Unique ID for each show |
| type | Movie or TV Show |
| title | Title of content |
| director | Director name |
| casts | Actors/Actresses |
| country | Country of release |
| date_added | Date added on Netflix |
| release_year | Release year |
| rating | Content rating |
| duration | Duration or seasons |
| listed_in | Genre/category |
| description | Content description |

Dataset Source: Netflix Dataset from Kaggle

---

# SQL Concepts Used

This project covers multiple SQL concepts:

- CREATE TABLE
- Data Cleaning
- NULL Handling
- DELETE Queries
- Aggregate Functions
- GROUP BY
- ORDER BY
- LIMIT
- Window Functions
- Common Table Expressions (CTEs)
- String Functions
- STRING_TO_ARRAY()
- UNNEST()
- CAST()
- SPLIT_PART()
- Business Intelligence Queries

---

# Data Cleaning

Performed multiple data cleaning operations such as:

- Checking NULL values
- Removing incomplete records
- Validating data consistency
- Filtering invalid rows

Example:

```sql
SELECT * 
FROM netflix_tb
WHERE show_id IS NULL;
```

---

# Exploratory Data Analysis (EDA)

The following analysis was performed:

- Total Movies vs TV Shows
- Country-wise content distribution
- Directors with most movies
- Most featured actors
- Year-wise release trends
- Rating analysis
- Longest duration movies
- TV Shows with more than 5 seasons

---

# Business Problems Solved

## 1. Total Movies and TV Shows

```sql
SELECT 
    type,
    COUNT(*) AS total_content
FROM netflix_tb
GROUP BY type;
```

---

## 2. Top Countries Producing Netflix Content

```sql
SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS country,
    COUNT(*) AS total_content
FROM netflix_tb
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 10;
```

---

## 3. Directors with Most Movies

```sql
SELECT
    director,
    COUNT(*) AS total_movie_by_director
FROM netflix_tb
WHERE director IS NOT NULL
AND type='Movie'
GROUP BY director
ORDER BY total_movie_by_director DESC;
```

---

## 4. Most Famous Actors on Netflix

```sql
SELECT
    TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actor,
    COUNT(*) AS total_content
FROM netflix_tb
WHERE casts IS NOT NULL
GROUP BY 1
ORDER BY total_content DESC
LIMIT 10;
```

---

## 5. TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix_tb
WHERE type='TV Show'
AND CAST(SPLIT_PART(duration,' ',1) AS INT) > 5;
```

---

# Advanced SQL Analysis

This project also includes advanced PostgreSQL queries using:

- Window Functions
- Ranking Functions
- Percentage Calculations
- CTEs
- Trend Analysis

Example:

```sql
RANK() OVER(
    PARTITION BY release_year
    ORDER BY total_movies DESC
)
```

---

# Key Insights

- Movies dominate Netflix content compared to TV Shows.
- The United States contributes the highest amount of Netflix content.
- Drama and Comedy are among the most popular genres.
- Netflix content production increased rapidly after 2015.
- Certain directors and actors appear frequently across Netflix titles.

---

# Screenshots

## Total Movies vs TV Shows

Add screenshot inside:

```bash
screenshots/movie_vs_tvshow.png
```

---

## Top Countries Producing Netflix Content

Add screenshot inside:

```bash
screenshots/top_countries.png
```

---

## Top Directors

Add screenshot inside:

```bash
screenshots/top_directors.png
```

---

## Most Featured Actors

Add screenshot inside:

```bash
screenshots/top_actors.png
```

---

# ER Diagram

Add ER diagram screenshot inside:

```bash
assets/er_diagram.png
```

Display it using:

```md
![ER Diagram](assets/er_diagram.png)
```

---

# How to Run This Project

## 1. Clone Repository

```bash
git clone https://github.com/Aakashkumar017/netflix-content-analytics-postgresql.git
```

---

## 2. Open PostgreSQL / pgAdmin

Open PostgreSQL and create a database.

---

## 3. Import Dataset

Import:

```bash
dataset/netflix_titles.csv
```

---

## 4. Run SQL Scripts

Execute files sequentially from:

```bash
sql_queries/
```

Order:

1. `01_table_creation.sql`
2. `02_data_cleaning.sql`
3. `03_eda_analysis.sql`
4. `04_business_problems.sql`
5. `05_advanced_analysis.sql`

---

# Future Improvements

Future enhancements for this project:

- Power BI Dashboard
- Tableau Visualization
- Python Integration
- Recommendation System
- ETL Pipeline
- Advanced Analytics Dashboard

---

# Author

## Aakash Kumar

- B.Tech CSE (Data Science)
- Data Analyst Enthusiast
- Passionate about SQL, Data Analytics, Machine Learning, and Business Intelligence

### Connect With Me

GitHub:
https://github.com/Aakashkumar017

LinkedIn:
https://www.linkedin.com/in/aakash-kumar-78ba57294

---

# License

This project is open-source and available under the MIT License.
