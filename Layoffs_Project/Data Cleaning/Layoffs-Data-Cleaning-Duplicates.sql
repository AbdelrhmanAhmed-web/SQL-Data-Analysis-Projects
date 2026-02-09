-- 2- Removing Duplicates. 
-- Here, I create new column to detect the duplicate values.
ALTER TABLE layoffs_staging
ADD  row_num INT; 

-- Creating CTE table to detect the duplicate values: 
WITH cte_duplicate AS
(
SELECT * 
	, ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions ORDER BY date) AS row_num_calculated
	FROM layoffs_staging
)
UPDATE cte_duplicate 
SET row_num = row_num_calculated;
---------------------------------
SELECT * FROM layoffs_staging 
WHERE row_num > 1

-- There are 5 duplicate Values found. 

DELETE FROM layoffs_staging 
WHERE row_num > 1


-- Deleting the Duplicate Values. 
ALTER TABLE layoffs_staging
DROP COLUMN row_num;

/* In this Code, I :
	
	1- Added new column 'row_num', this column will help to detect the duplicate values. 
	2- Creating CTE Table and adding the ROW_NUMBER() FUNCTION and partition by everything, to detect the duplicate values. 
	3- setting the row_num coulmn (The new one) to = row_num_calculated from the CTE Table.
	4- finding the duplicate Values. 
	5- Deleting the Duplicates. 
	6- Droping the Coulmn After the Data IS cleaned and there are no Duplicates. 
*/
