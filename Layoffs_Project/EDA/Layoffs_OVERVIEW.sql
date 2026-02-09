/*
Phase 2 : EDA Analysis.

	In this Phase, after cleaning the data, now it's ready for EDA Analysis:
		1-Overview :
			 The maximum laid offs .
			 companies with 100% lay offs (closed) .
			 Top Companies by Funding vs. Layoffs.
			 Total Layoffs by Country.
			 Total Layoffs by Industry.
		
		2- Time Series Analysis:
			Total Layoffs by Year.
			Layoffs Trend by Month.
			Rolling Total of Layoffs.

		3- Company Growth & Stages:
			Average Layoff Percentage per Industry.
			Layoffs by Company Stage.
*/

-- 1 OVERVIEW. 

-- The maximum laid offs 
SELECT 
     'Max_Laid_offs' AS Measure_name , MAX(total_laid_off)  AS Measry_Value
FROM layoffs_staging
UNION ALL
SELECT 
     'Max_Percentage' AS Measure_name , MAX(percentage_laid_off)  AS Measry_Value
FROM layoffs_staging;
-- We found that we have the maximum lay off is 12000 
SELECT * 
FROM layoffs_staging 
WHERE total_laid_off = 12000;

-- it's from Google company, and the percentag is 0.05 % !! SO waw !! it's a huge number of employees lost their jobs that day, but still a very small percentag.

-- companies with 100% lay offs (closed) .
SELECT *
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

--Top Companies by Funding vs. Layoffs.
SELECT TOP 10 * 
FROM layoffs_staging
WHERE funds_raised_millions IS NOT NULL
ORDER BY  total_laid_off DESC, funds_raised_millions DESC ;

-- All of these are big companies with stage Post-IPO , all of them are in the latest of 2022 and early of 2023 , but only Uber in 2020, i think because Covid 19 .


-- Total Layoffs by Country.

SELECT	
	country,
	SUM(total_laid_off) Total_layoffs_by_country
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY Total_layoffs_by_country DESC;


-- Total Layoffs by Industry.
SELECT	
	industry,
	SUM(total_laid_off) Total_layoffs_by_industry
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY Total_layoffs_by_industry DESC;

/* 
In this code I Found that:
	1- the maximum lay off was 12000 by Google.
	2- Companies who are out of business (100% lay off).
	3- Top Companies by Funding vs. Layoffs.
	4- Top countries with total layoffs.
	5- Top inustries with total layoffs.
*/ 

