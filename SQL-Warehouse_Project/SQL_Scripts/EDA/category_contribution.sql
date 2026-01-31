-- Witch category conterbute the most to the overall sales? 
WITH over_all_sales AS
(
SELECT 
	P.category category,
	SUM(sales_amount) total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY P.category
)

SELECT 
	category,
	total_sales,
	SUM(total_sales) OVER() overall_sales,
	CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER())*100,2),'%') percentage_of_total_sales
FROM over_all_sales
