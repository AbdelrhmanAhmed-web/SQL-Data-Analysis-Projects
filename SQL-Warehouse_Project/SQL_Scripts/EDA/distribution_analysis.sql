/*
1- Find total number of customers per countrey.          2- Find total number of customer per gender.
3- Find total number of products per category            4- Find avg cost per category 
5-Find total revenue per category                        6-  Find total revenue per customer
*/
--1
SELECT 
	country,
	COUNT(customer_key) number_of_customers
FROM gold.dim_customers
WHERE country != 'Unkown'
GROUP BY country
ORDER BY 2 DESC;
--2
SELECT 
	gender,
	COUNT(customer_key) number_of_customers
FROM gold.dim_customers
WHERE gender != 'Unkown'
GROUP BY gender
ORDER BY 2 DESC;
--3
SELECT 
category,
COUNT(product_key) number_of_products
FROM gold.dim_products
GROUP BY category
ORDER BY 2 DESC ;
--4
SELECT 
category,
AVG(product_cost) avg_product_cost
FROM gold.dim_products
GROUP BY category
ORDER BY 2 DESC ;
--5
SELECT 
	dp.category,
	SUM(fc.sales_amount) revenue 
FROM gold.fact_sales fc 
LEFT JOIN gold.dim_products dp
ON fc.product_key = dp.product_key
GROUP BY dp.category
ORDER BY SUM(fc.sales_amount) ;
-- 6 
SELECT 
	dc.Customer_key,
	dc.first_name,
	dc.last_name,
	SUM(fc.sales_amount) revenue 
FROM gold.fact_sales fc 
LEFT JOIN gold.dim_customers dc
ON fc.product_key = dc.Customer_key
GROUP BY dc.Customer_key,
		 dc.first_name,
	     dc.last_name
ORDER BY SUM(fc.sales_amount) DESC ;
