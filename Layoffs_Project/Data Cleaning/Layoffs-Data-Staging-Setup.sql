/*
Layoffs Project :
	In This Project:
	`	contains 2 phases, The first one is cleaning the data, the Second one is EDA. 

	 cleaning the data:
		1- Creating new table to not affect the original data.
		2- Remove Duplicates.
		3- Standraize The Data.
		4- Cleaning the NULL OR Blank Values. 
	-------------------
	
*/

-- Phase ONE : 
-- Creating new table.
/*
Please be aware, Running this code will permenemtly delete the table and all the work you've done. 
You must chenage the databse name into the name you created to RUN this code.
*/



USE [world_layoffs]
GO
-- Droping the table if it already exists. 
DROP TABLE IF EXISTS [dbo].[layoffs_staging];
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- Just coping the columns names from the original table.
CREATE TABLE [dbo].[layoffs_staging](
	[company] [nvarchar](50) NULL,
	[location] [nvarchar](50) NULL,
	[industry] [nvarchar](50) NULL,
	[total_laid_off] [nvarchar](50) NULL,
	[percentage_laid_off] [float] NULL,
	[date] [date] NULL,
	[stage] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[funds_raised_millions] [nvarchar](50) NULL
) ON [PRIMARY]
GO

-- Insering the data from layoffs table into the new table.
INSERT INTO layoffs_staging
SELECT * FROM layoffs

-- In this Phase, I created a new table to copy the data from the row table into a new table to start cleaning and preparing the data for the EDA Phase.
