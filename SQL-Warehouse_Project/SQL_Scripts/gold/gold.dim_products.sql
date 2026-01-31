/*
===============================================================================
View Hierarchy: Gold Layer (Dimensions)
View Name:      gold.dim_products
Purpose:        Creates a master product dimension by joining CRM product info 
                with ERP category metadata. 
                - Filters for current active products only.
                - Includes category and sub-category hierarchy for reporting.
===============================================================================
*/
CREATE VIEW gold.dim_products AS
SELECT 
	ROW_NUMBER() OVER( ORDER BY cpi.prd_start_dt , cpi.prd_key ) AS product_key,
	cpi.prd_id AS product_id,
	cpi.cat_id AS category_id,
	cpi.prd_key AS product_number,
	cpi.prd_nm AS product_name,
	cpi.prd_cost AS product_cost,
	cpi.prd_line AS product_line,
	cpi.prd_start_dt AS  product_start_date,
	pcg.cat AS category ,
	pcg.subcat AS sub_category,
	pcg.maintenance 
FROM silver.crm_prd_info AS cpi
LEFT JOIN silver.erp_px_cat_g1v2 AS pcg
ON cpi.cat_id = pcg.id
WHERE cpi.prd_end_dt IS NULL
