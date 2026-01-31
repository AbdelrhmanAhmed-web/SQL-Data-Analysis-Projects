/*
===============================================================================
View Hierarchy: Gold Layer (Facts)
View Name:      gold.fact_sales
Purpose:        The core Fact Table for sales analysis. 
                - Connects sales transactions with Product and Customer dimensions.
                - Uses Surrogate Keys from the Gold layer for optimized analytical performance.
===============================================================================
*/
USE [datawarehouseproject]
GO

/****** Object:  View [gold].[fact_sales]    Script Date: 1/30/2026 6:40:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [gold].[fact_sales] AS 
SELECT 
	sd.sls_ord_num AS order_number,
	dp.product_key,
	du.Customer_key,
	sd.sls_order_dt  AS order_date,
	sd.sls_ship_dt ship_date,
	sd.sls_due_dt due_date,
	sd.sls_sales sales_amount,
	sd.sls_quantity quantity,
	sd.sls_price price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products dp
ON sd.sls_prd_key = dp.product_number
LEFT JOIN gold.dim_customers du
ON sd.sls_cust_id = du.customer_id
GO
