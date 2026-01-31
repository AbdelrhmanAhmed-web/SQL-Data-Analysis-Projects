/*
1- Analyze the yearly performence of products by comparing each product sales to both its average sales performence,
and previous year's sales
*/

SELECT 
	order_date,
	product_name,
	total_sales,
	avg_sales,
	LAG(total_sales,1) OVER(ORDER BY order_date) previous_year,
	CASE 
		WHEN total_sales - LAG(total_sales,1) OVER(ORDER BY order_date) > avg_sales THEN 'Above_average'
		WHEN total_sales - LAG(total_sales,1) OVER(ORDER BY order_date) < avg_sales THEN 'Below_average'
		ELSE 'average'
	END flag_avg,
	CASE 
		WHEN total_sales > LAG(total_sales,1) OVER(ORDER BY order_date)  THEN 'Bigger than last year '
		WHEN total_sales < LAG(total_sales,1) OVER(ORDER BY order_date)  THEN 'Less than last year'
		ELSE 'same'
	END flag_year
FROM(
SELECT 
	p.product_name product_name,
	YEAR(f.order_date) order_date,
	SUM(f.sales_amount) total_sales,
	AVG(f.sales_amount) avg_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL 
GROUP BY 
p.product_name,
YEAR(order_date))t
ORDER BY product_name, order_date
