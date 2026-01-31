-- TRUNCATING TABLES  silver LAYER , and INSERTING THE CLEANED DATA .
/*
In This Code , I create Store Procedure That Will Truncate And Insert The Cleaned Data In the Silver Layer.
Please Be Aware That If You Ran This Code , All The Data Will be Removed . 

How To Use? 
To Run This Code Please Use : EXEC silver.load_silver
*/
CREATE OR ALTER PROCEDURE silver.load_silver AS

BEGIN

	PRINT ' IN THIS PHASE , INSERTING THE CLEANED DATA FROM THE bronze layer and INSERT IT INTO THE silver layer' ;
	print '-------------------';

	PRINT ' TRUNCATE AND INSERT THE CLEANED DATA INTO THE silver.crm_cust_info ';
	TRUNCATE TABLE silver.crm_cust_info
	INSERT INTO silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
	)
	SELECT 
		cst_id,
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE
			WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Marrid'
			ELSE 'Unkown'
		END AS cst_marital_status,
		CASE
			WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			ELSE 'Unkown'
		END AS cst_gndr,
		cst_create_date
	FROM(
	SELECT 
	*,
	ROW_NUMBER() OVER( PARTITION BY cst_id ORDER BY cst_create_date) AS FLAG
	FROM bronze.crm_cust_info) AS cst_id_cleaned
	WHERE FLAG = 1

	PRINT '-----------------------------------------------';
	PRINT ' TRUNCATE AND INSERT THE CLEANED DATA INTO THE silver.crm_prd_info ';

	TRUNCATE TABLE silver.crm_prd_info

	IF OBJECT_ID ('silver.crm_prd_info','U') IS NOT NULL
		DROP TABLE silver.crm_prd_info

	CREATE TABLE silver.crm_prd_info(
	prd_id int,
	cat_id NVARCHAR(50),
	prd_key  NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	)

	INSERT INTO silver.crm_prd_info (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
	)
	SELECT 
		prd_id,-- Clean
		REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id, -- Substring the first 5 as the cat_is, to join it.
		SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key, -- the product key.
		prd_nm,-- Clean
		ISNULL (prd_cost,0) AS prd_cost, -- Replace the nulls with 0 
		CASE
		WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
		WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
		WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
		WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
		ELSE 'Unkown'
		END AS prd_line, 
		CAST(prd_start_dt AS DATE) AS prd_start_dt ,
		CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) prd_end_dt
	FROM bronze.crm_prd_info

	PRINT '-----------------------------------------------';

	PRINT ' TRUNCATE AND INSERT THE CLEANED DATA INTO THE silver.crm_sales_details ';

	TRUNCATE TABLE silver.crm_sales_details

	IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL 
		DROP TABLE silver.crm_sales_details;

	CREATE TABLE silver.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT, 
	sls_order_dt DATE,
	sls_ship_dt DATE, 
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT ,
	dwh_create_date datetime2 default getdate()
	);

	INSERT INTO silver.crm_sales_details(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt ,
	sls_ship_dt ,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
	)
	SELECT 
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		CASE
			WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_order_dt AS NVARCHAR(50)) AS DATE)  
		END sls_order_dt,
		CASE
			WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_ship_dt AS NVARCHAR(50)) AS DATE)  
		END sls_ship_dt,
		CASE
			WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_due_dt AS NVARCHAR(50)) AS DATE)  
		END sls_due_dt,
		CASE 
			WHEN sls_sales IS NULL OR sls_sales<=0 OR sls_sales != sls_quantity * ABS(sls_price)
				THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
			END sls_sales,
		sls_quantity,
		CASE 
			WHEN sls_price IS NULL OR sls_price<=0 THEN sls_sales / nullif(sls_quantity,0)
				ELSE sls_price
			END sls_price
	FROM bronze.crm_sales_details

	PRINT '-----------------------------------------------';
	PRINT 'THE ERP SOURCE : ';

	PRINT ' TRUNCATE AND INSERT THE CLEANED DATA INTO THE silver.erp_cust_az12 ';

	TRUNCATE TABLE silver.erp_cust_az12

	INSERT INTO silver.erp_cust_az12(
	cid,
	bdate,
	gen)
	SELECT 
		CASE 
			WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid,4,LEN(cid))
			ELSE cid
		END cid,
		CASE 
			WHEN bdate > getdate() THEN null
			ELSE bdate
		END bdate,
		CASE 
			WHEN gen IS NULL OR TRIM(gen) = '' THEN 'Unkown'
			WHEN UPPER(TRIM(gen)) = 'F' THEN 'Female'
			WHEN UPPER(TRIM(gen)) = 'M' THEN 'Male'
			ELSE gen
		END gen
	FROM bronze.erp_cust_az12;

	PRINT '-----------------------------------------------';
	PRINT ' TRUNCATE AND INSERT THE CLEANED DATA INTO THE silver.erp_loc_a101 ';

	TRUNCATE TABLE silver.erp_loc_a101

	INSERT INTO silver.erp_loc_a101(
		cid,
		cntry)

	SELECT 
		REPLACE(cid,'-','') AS cid,
		CASE
			WHEN cntry IS NULL OR TRIM(cntry) = '' THEN 'Unkown'
			WHEN UPPER(TRIM(cntry)) = 'DE' THEN 'Germany'
			WHEN UPPER(TRIM(cntry)) = 'USA' THEN 'United Stated'
			WHEN UPPER(TRIM(cntry)) = 'US' THEN 'United Stated'
			ELSE TRIM(cntry)
		END cntry
	FROM bronze.erp_loc_a101;


	PRINT '-----------------------------------------------';
	PRINT ' TRUNCATE AND INSERT THE CLEANED DATA INTO THE silver.erp_px_cat_g1v2 ';


	TRUNCATE TABLE silver.erp_px_cat_g1v2

	INSERT INTO silver.erp_px_cat_g1v2(
	id,
	cat,
	subcat,
	maintenance
	)

	SELECT 
		id,
		cat,
		subcat,
		maintenance
	FROM bronze.erp_px_cat_g1v2
END
