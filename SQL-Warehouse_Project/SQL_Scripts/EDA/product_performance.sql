/* 
1- Witch 5 products generate the highest revenue           Witch 5 products generate the lowest revenue
*/

SELECT TOP 5
	p.category,
	p.product_name,
	SUM(f.sales_amount) revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY 
	p.category,
	p.product_name
ORDER BY SUM(f.sales_amount) DESC; 

-- from this out put , i relaize that the business focus on the bikes and most of the revenue come from selling bikes, whitch means , 
-- if the bikes stop performing well, then the business might be in dangoures .

SELECT TOP 5
	p.category,
	p.product_name,
	SUM(f.sales_amount) revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount)) the_lowest_5_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY 
	p.category,
	p.product_name;
