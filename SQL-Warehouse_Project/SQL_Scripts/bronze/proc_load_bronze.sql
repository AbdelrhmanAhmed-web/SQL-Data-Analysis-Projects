/*
--------------------
Store Procedure : Load Bronze Layer ( Source --> Bronze )
--------------------
Sript Purpose : 
	This Store Procedure Loads The Data Into The Bronze Schema, From External csv Files.
	It Performs The Following Actions :
	1- Truncate The Bronze Tables.
	2- USes The Bulk Insert To Insert The Data Into The Tables From The csv Files.
--------------------
How To USE ? 
USE COMMAND : ' EXEC bronze.load_bronze '  TO EXEC The Procedure.
*/
EXEC bronze.load_bronze 
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
	PRINT 'Loading The Bronze Layer : ';
	PRINT '---------------------------';

	PRINT 'LOADING crm TABLES : ';
	PRINT '-------------------- ';

	TRUNCATE TABLE bronze.crm_cust_info
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\ABWYD\Downloads\warehouse_project\crm_source\cust_info.csv'
	WiTH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)

	TRUNCATE TABLE bronze.crm_prd_info
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\ABWYD\Downloads\warehouse_project\crm_source\prd_info.csv'
	WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	)

	TRUNCATE TABLE bronze.crm_sales_details
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\ABWYD\Downloads\warehouse_project\crm_source\sales_details.csv'
	WITH(
	FIRSTROW =2 ,
	FIELDTERMINATOR = ',',
	TABLOCK
	)


	PRINT 'lOADING erp TABLES :';
	PRINT '--------------------';

	TRUNCATE TABLE bronze.erp_cust_az12
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\ABWYD\Downloads\warehouse_project\erp_source\CUST_AZ12.csv'
	WITH(
	FIRSTROW =2 , 
	FIELDTERMINATOR =',',
	TABLOCK
	)


	TRUNCATE TABLE bronze.erp_loc_a101
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\ABWYD\Downloads\warehouse_project\erp_source\LOC_A101.csv'
	WITH(
	FIRSTROW = 2, 
	FIELDTERMINATOR = ',', 
	TABLOCK
	)


	TRUNCATE TABLE bronze.erp_px_cat_g1v2
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\ABWYD\Downloads\warehouse_project\erp_source\PX_CAT_G1V2.csv'
	WITH(
	FIRSTROW = 2, 
	FIELDTERMINATOR = ',', 
	TABLOCK
	)
END
