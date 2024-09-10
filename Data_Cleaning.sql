-- Data Cleaning and Transformation Project.

Create database world_layoffs;

Use world_layoffs;

show databases;

show tables;

Select * from layoffs_raw;

-- Following Tasks To Be Completed 
-- 1). Removing Duplicates.
-- 2). Standardizing The Data.
-- 3). Handling Null Values or Blank Values.
-- 4). Removing Unnecessary Columns.

-- First We will Create a Duplicate Table From The Raw Data where we will perform our project.

Create table layoffs_new
like layoffs_raw;

Insert Into layoffs_new
Select * From layoffs_raw;


-- Task 1). Finding & Removing Duplicates.


With cte as (
Select *,
row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off, `date`,stage,country,funds_raised_millions) RowNumber
From layoffs_new)
select * from cte where RowNumber > 1;

-- Here We got 5 entries which were duplicates on every attribute.

-- Now to delete these entries either we will create a new table with row number as a column.

Set sql_safe_updates = 0;

Create table layoffs_staging
like layoffs_new;

alter table layoffs_staging
add column RowNumber int;

insert into layoffs_staging
select*,
row_number() 
over(partition by company,location,industry,total_laid_off,percentage_laid_off, `date`,stage,country,funds_raised_millions)
from layoffs_new;

Delete 
from layoffs_staging
where rownumber > 1;


-- 2). Standardizing The Data. 

Select * from layoffs_staging;

-- Triming and removing the trailing dot in the columns.

Update layoffs_staging
Set company =  trim(trailing '.' from company),
	location =  trim(trailing '.' from location),
	industry =  trim(trailing '.' from industry),
	stage =  trim(trailing '.' from stage),
    country =  trim(trailing '.' from country);

-- Standardizing the industry column.

Select Distinct(industry) from layoffs_staging;

Update layoffs_staging
Set industry = 'Crypto'
Where industry Like '%Crypto%';

-- Standardizing Date Column.

Update layoffs_staging
Set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging
Modify `date` DATE;

-- 3). Handling Null Values.

Select * From layoffs_staging
where industry is null or industry = "";

-- We Got 4 Results here and now we will try to populate them.

Update layoffs_staging
set industry = null
where industry = "";

Update layoffs_staging t1
Join layoffs_staging t2
on t1.company = t2.company
Set t1.industry = t2.industry
where t1.industry is Null
and t2.industry is not Null;

Delete
From layoffs_staging
where total_laid_off is null and percentage_laid_off is null;


-- 4). Removing Unnecessary Columns.

Alter table layoffs_staging
Drop column RowNumber;


-- Voila we are done with the cleaning and transforming the Raw Data for Analysis. 
