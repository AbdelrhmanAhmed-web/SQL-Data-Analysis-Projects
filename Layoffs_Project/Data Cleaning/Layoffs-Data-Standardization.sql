-- 3 Standraize The Data ( TEXT ) . 

SELECT * FROM layoffs_staging

-- 1- Checking that all are Standraize (No Spaces).

-- Updating the data to be trimmed 
UPDATE layoffs_staging 
SET company = TRIM(company)

UPDATE layoffs_staging 
SET location = TRIM(location)

UPDATE layoffs_staging 
SET industry = TRIM(industry)

UPDATE layoffs_staging 
SET stage = TRIM(stage)

UPDATE layoffs_staging 
SET country = TRIM(country)

-- Here I updated the column to make sure that there are no hidden spaces . 

-----------------------------------------

SELECT DISTINCT(industry)
FROM layoffs_staging

-- I found 2 issues, 
--1- We have 'Cryoto' Industry 3 times but with diffrenet names, so i will make them all in one CATEGORY.
-- 2- we have industry named as NULL (AS A TEXT ,not as a type), So i will Change it to be NULL type.

UPDATE layoffs_staging
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'

UPDATE layoffs_staging
SET industry = NULL
WHERE industry = 'NULL'
--------------
SELECT DISTINCT(country)
FROM layoffs_staging
ORDER BY 1

-- I found Issue, We have United States towies, AS United States, and AS United States.

UPDATE layoffs_staging
SET country = 'United States'
WHERE country LIKE 'United States%'

/*
In this code, I cleaned the Text Data, 
	1- trimming the data to make sure there are no hidden spaces. 
	2- Cleaning the industry column, I found Some repeted Categories, i grouped them into one category, also null AS A TEXT, Converted it into NULL Type.
	3- in The location column, United States was there towise, cleaned it into one . 

*/

