/*
Customers Report : 
--------------------------------
purpose : 
	- This report consolidates key customer metrics and behaviors 

Highlights : 
	1. Generate essential fields such as names, ages, and transactios details. (DONE) 
	2. Segment Customers into Categories ('VIP','Regular','New'), amnd age groups . (DONE) 
	3. Aggregate customer-level metrics .(DONE) 
		- total orders.
		- total sales.
		- total quantity purchaced.
		- total products.
		- life span in months.
----------------------------------
*/
CREATE VIEW gold.cutomers_report AS 
WITH first_query AS 
(
SELECT 
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	f.price,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name, ' ' , c.last_name) AS customer_name,
	DATEDIFF(YEAR,c.birthdate,GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
ON f.Customer_key = c.Customer_key
WHERE f.order_date IS NOT NULL
),
seconed_query AS 
(
SELECT 
	 customer_key,
	 customer_number,
	 customer_name,
	 age,
	 COUNT(DISTINCT(order_number)) count_of_orders,
	 SUM(sales_amount) total_sales,
	 SUM(quantity) total_quantity,
	 COUNT(DISTINCT(product_key)) total_products,
	 DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) life_span_in_months
FROM first_query
GROUP BY 
	customer_key,
	customer_number,
	 customer_name,
	 age
)
SELECT 
	*,
	CASE
		WHEN age BETWEEN 40 AND 50 THEN '40-50'
		WHEN age BETWEEN 50 AND 60 THEN '50-60'
		ELSE 'Above 60'
	END age_segment,
	CASE
		WHEN total_sales >= 5000 AND life_span_in_months >= 12 THEN 'VIP'
		WHEN total_sales < 5000 AND life_span_in_months >= 12 THEN 'REGULAR'
		ELSE 'NEW'
	END segment_customers
FROM seconed_query
