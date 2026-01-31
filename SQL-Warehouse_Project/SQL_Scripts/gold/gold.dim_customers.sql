/*
===============================================================================
View Hierarchy: Gold Layer (Dimensions)
View Name:      gold.dim_customers
Purpose:        Consolidates customer data from CRM and ERP systems 
                into a single, unified "360-degree" customer dimension.
                Includes data cleaning, gender normalization, and surrogate keys.
===============================================================================
*/
CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER( ORDER BY cst_id) AS Customer_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_number,
	ci.cst_firstname as first_name,
	ci.cst_lastname as last_name,
	ci.cst_marital_status as customer_material_status,
	CASE 
		WHEN ci.cst_gndr != 'Uknown' THEN ci.cst_gndr
		ELSE COALESCE (ca.gen,'Uknown')
	END as gender,
	ci.cst_create_date as create_date,
	ca.bdate as birthdate,
	la.cntry as country
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la 
ON ci.cst_key = la.cid
