/*
Group customers into 3 segments based on their spending behavios :
VIP : cutomers with atleast 12 months of history and spending more than 5000
REGULAR : cutomers with atleast 12 months of history and spending less than or =  5000
NEW : neither of these.
*/
WITH spending AS
(
SELECT 
	customer_key,
	MIN(order_date) first_order,
	MAX(order_date) last_order,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) life_span,
	SUM(sales_amount) total_spendings
FROM gold.fact_sales
GROUP BY customer_key
)
SELECT 
	COUNT(customer_key) number_of_customers,
	segment_customers
FROM(
SELECT 
	customer_key,
	first_order,
	last_order,
	life_span,
	total_spendings,
	CASE
		WHEN total_spendings >= 5000 AND life_span >= 12 THEN 'VIP'
		WHEN total_spendings < 5000 AND life_span >= 12 THEN 'REGULAR'
		ELSE 'NEW'
	END segment_customers
FROM spending) t
GROUP BY segment_customers
