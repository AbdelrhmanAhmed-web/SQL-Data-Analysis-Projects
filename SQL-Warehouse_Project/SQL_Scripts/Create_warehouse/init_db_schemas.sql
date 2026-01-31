/*
-----------------------------------------------------
Create Database And Schemas :
-----------------------------------------------------
Script Purpose : 

	This Script Create a new DataBase named 'datawarehouseproject',
	Also the scripts set up 3 Schemas within the database:'bronze' , 'silver' , and 'gold'.

PLEASE BE AWARE IF YOU RAN THIS CODE IT WILL DROP THE DATABASE, 
ALL DATA IN THE DATABASE WILL BE PERMENANTLY REMOVED.
*/

USE master;
GO 

-- Drop and Replace Datawarehouse if it exists :

IF EXISTS ( SELECT 1 FROM sys.databases WHERE name = 'datawarehouseproject')
BEGIN 
	ALTER DATABASE datawarehouseproject SET SINGLE_USER WITH ROLLBACK IMMEDIATE ;
	DROP DATABASE datawarehouseproject
END

-- Creating the Datawarehouse 

CREATE DATABASE datawarehouseproject;
GO

USE datawarehouseproject;
GO

-- Creating Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
