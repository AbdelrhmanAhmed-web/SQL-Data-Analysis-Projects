--3- Company Growth & Stages:

--Average Layoff Percentage per Industry.
SELECT 
	industry,
	AVG(percentage_laid_off) AS [Average Layoff Percentage]
FROM layoffs_staging
GROUP BY industry
ORDER BY AVG(percentage_laid_off) DESC;


--Layoffs by Company Stage.
SELECT 
	stage,
	company,
	SUM(total_laid_off)  AS total_layoffs
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL 
GROUP BY stage,company
ORDER BY SUM(total_laid_off) DESC;

-- The Top 5 Companies per Year
WITH CTE_company_year AS 
(
SELECT YEAR(date) AS YEAR,
	company,
	industry,
	SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging
WHERE date IS NOT NULL
GROUP BY YEAR(date), company, industry
),
CTE_year_ranking AS
(
SELECT 
	*,
	DENSE_RANK() OVER (PARTITION BY YEAR ORDER BY total_layoffs DESC) AS Ranking
FROM CTE_company_year
)
SELECT * FROM CTE_year_ranking WHERE Ranking <=5 ORDER BY YEAR ASC, Ranking ASC;

/*
In this code : 
	1- Average Layoff Percentage per Industry.
		
		I found that the most layoffs were in Aerospace Industry with over than 50% ,
		even tho that the number of employees in this industry can't be big as the Retail industry, 
		but it't the number 1 in the layoffs, and that means this industry is so weak infront of the big crises. And the lowest was in Manufacturing and Sales. 
		[ By running the below code, we can see that total employees laid_off from Aerospace industry cant even reach 1000 employee.] */
		SELECT * FROM layoffs_staging WHERE industry = 'Aerospace';

/*	
	2-Layoffs by Company Stage.
		
		Most of the layoffs were in the big companies, and Google laid off 12000 employees in one day !
	
	3-The Top 5 Companies per Year
		
		In 2020, we can find that the top 5 companies were in (Transportation , Travil , Retail, Food) industries, whitch i believe it's because the Covid-19 .

*/
