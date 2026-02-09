/*
This is the final code, Creating a view to then connect the data with Power BI for Data Visualization.
In this code, I Renamed the columns into a friendly name, and removed the nulls that will ruin the data accurecy .
Please Be Aware that you don't need to create this View, you can just use the " layoffs_staging " table . But I uesed it to just change the cloumns names,
and to make sure that the data is accurat.
*/
CREATE VIEW PBI_layoffs AS
SELECT 
	company AS Company,
	location As Location,
	ISNULL(industry,'Unknown') AS Industry,
	total_laid_off AS Total_layoffs,
	percentage_laid_off AS Percentage_layoffs,
	date,
	ISNULL(stage,'Unknown') AS Stage,
	country AS Country,
	funds_raised_millions AS Funds_in_millions
FROM layoffs_staging
WHERE 
	 total_laid_off IS NOT NULL 
	 AND percentage_laid_off IS NOT NULL
	 AND date IS NOT NULL 
