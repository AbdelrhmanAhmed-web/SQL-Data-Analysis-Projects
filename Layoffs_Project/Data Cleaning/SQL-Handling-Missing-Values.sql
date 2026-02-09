-- 4- Cleaning the NULLS AND Blank Values. 

SELECT * FROM layoffs_staging

-- First, with industry column . 

SELECT *
FROM layoffs_staging
WHERE industry IS NULL OR industry = ''

-- We have 4 Nulls in Industry column, i will try to clean them bu finding the True instry.
-- What we can do is join the table with itself, to find if the industry is avaialbe . 
SELECT t1.industry,
	t2.industry
FROM layoffs_staging t1 
join layoffs_staging t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL 

UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_staging t1
INNER JOIN layoffs_staging t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Still one industry isn't cahnged, company = 'Bally's Interactive', beacuse there are no other records for it , so i'll just leave it as it is .  


SELECT * FROM layoffs_staging
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL

-- We have 361 records where total_laid_off is null and percentage_laid_off is also null, so we don't know even if there were any lay offs in these companies,
-- So we don't need these records, because there are no need for them . 

DELETE FROM layoffs_staging 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL 
/*
In This code, Cleaning the NULLS AND Blank Values:
	1- industry column, replacing the null values with the correct values if found. 
	2- deleting the nulls when the total_laid_off and  percentage_laid_off both are nulls.

By this, I Finished cleaning up the data and preparing it for phase 2 (EDA).
*/
