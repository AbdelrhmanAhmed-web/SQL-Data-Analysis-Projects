--2- Time Series Analysis:

--Total Layoffs by Year.
SELECT YEAR(date) AS YEAR ,
	SUM(total_laid_off) AS total_lay_offs
FROM layoffs_staging
WHERE date IS NOT NULL
GROUP BY YEAR(date)
ORDER BY 1

-- We have 2021 16,000 as the least layoffs year and 2022 by 160,000 as the highest one. and only 3 months in 2023 by almost 126,000 , by that we undersatnd that 2023 is like the worest year 

-- Layoffs Trend by Month.
WITH cte_rolling_total AS
(
SELECT 
	YEAR(date) Year
	,MONTH(date) AS Month,
	SUM(total_laid_off) AS total_lay_offs
FROM layoffs_staging
WHERE date IS NOT NULL
GROUP BY YEAR(date) ,MONTH(date)
)
SELECT 
	Year,
	Month,
	total_lay_offs,
	SUM(total_lay_offs) OVER(PARTITION BY Month) AS [Running total] -- This is for  comparison between months of every year.
FROM cte_rolling_total
ORDER BY 1,2

-- THE highest layoffs were in JAN by 92000 employee lost their jobs. and 84000 of them in 2023 only, and by the below code, we find that most of them are Big companies, 
-- Post-IPO

SELECT * FROM layoffs_staging WHERE date LIKE '2023-01%' and total_laid_off IS NOT  NULL  ORDER BY total_laid_off DESC

/*
In this code:
	total layoffs by year.
	the trend of layoffs and what are the heighest month of layoffs.
*/
