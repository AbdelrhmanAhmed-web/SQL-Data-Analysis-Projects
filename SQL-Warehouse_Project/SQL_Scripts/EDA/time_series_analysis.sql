/*
1- Find the total revenue, total customers , and toatal quantity sold per year
2- Calculate therunning total sales per yer.
*/
SELECT 
YEAR(order_date) year,
FORMAT(SUM(sales_amount),'#,##k') total_revenue,
COUNT(DISTINCT(customer_key)) total_customers,
SUM(quantity) total_quantity_sold
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- The reason why 2010 and 2014 are the lowest is because we obly have 1 month from them . 
--SELECT order_date FROM gold.fact_sales
--WHERE order_date < '2011-01-01' OR order_date > '2013-12-31';

--2
SELECT 
	order_date,
	total_sales,
	SUM(total_sales) OVER(PARTITION BY YEAR(order_date) ORDER BY order_date) cumulative_revenue
FROM(
SELECT 
	DATETRUNC(MONTH,order_date) order_date,
	SUM(sales_amount) total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL 
GROUP BY DATETRUNC(MONTH,order_date) 
)t;
