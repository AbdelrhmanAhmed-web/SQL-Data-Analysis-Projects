-- Segment Products into cost ranges ad count how many products fall into each segment. 
WITH segment_product AS
(
SELECT 
	product_key,
	product_name,
	product_cost,
	CASE
		WHEN product_cost <100 THEN 'Below 100 '
		WHEN product_cost BETWEEN 100 AND 500  THEN '100 - 500'
		WHEN product_cost BETWEEN 500 AND 1000 THEN '500 - 1000 '
		ELSE 'Above 1000'
	END cost_segment
FROM gold.dim_products
),
count_of_segments AS
(
SELECT 
	product_key,
	product_name,
	product_cost,
	cost_segment,
	COUNT(cost_segment) OVER(PARTITION BY cost_segment ) AS number_of_products
FROM segment_product
)

SELECT *
FROM count_of_segments
ORDER BY number_of_products DESC
