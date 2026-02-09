/* Standraize the data (Numeric). 
total_laid_off , and funds_raised_millions. 
These 2 columns are NVARCHAR TYPE, I will Convert Them into INT TYPE.
*/
SELECT  
	total_laid_off
FROM layoffs_staging
WHERE ISNUMERIC(total_laid_off)=0 AND total_laid_off IS NOT NULL;

-- We have NULL AS A TEXT TYPE, I'll convert it into a numeric NULL Type. 

UPDATE layoffs_staging
SET total_laid_off = NULL 
WHERE total_laid_off = 'NULL' OR total_laid_off = '';

-------------------------------

SELECT  
	funds_raised_millions
FROM layoffs_staging
WHERE ISNUMERIC(funds_raised_millions)=0 AND funds_raised_millions IS NOT NULL;

-- Same Issue as  total_laid_off . 

UPDATE layoffs_staging
SET funds_raised_millions = NULL 
WHERE funds_raised_millions = 'NULL' OR funds_raised_millions = '';

-- Now they both cleaned and there are no TEXT data in these Columns, the next step is to convert the type into numeric . 

ALTER TABLE layoffs_staging 
ALTER COLUMN total_laid_off INT;
--------------------------------
ALTER TABLE layoffs_staging 
ALTER COLUMN funds_raised_millions FLOAT ;

/*In This Code:
	1- convering the NULL TEXT date into numeric.
	2- Altring the columns : total_laid_off into INT Type, funds_raised_millions into FLOAT Type
*/
