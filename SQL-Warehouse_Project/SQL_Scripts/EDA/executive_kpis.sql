/*
1- Find the total sales                              2- Find The Average Selling Price
3- Find the total number of orders                   4- Find the total number of products
5- Find the total number of customers                6- Find the total number of customers who placed anorder
*/
SELECT 'Total Sales' AS Measure_name, FORMAT(SUM(sales_amount),'#,## $K') AS Measry_Value
FROM gold.fact_sales
UNION ALL 
SELECT 'avg_selling_price' AS Measure_name, FORMAT(AVG(price),'#.## $') AS Measry_Value
FROM gold.fact_sales
UNION ALL
SELECT 'count_of_orders' AS Measure_name,  FORMAT(COUNT(DISTINCT(order_number)),'# k') AS Measry_Value
FROM gold.fact_sales
UNION ALL
SELECT 'number_of_products' AS Measure_name , FORMAT(COUNT(product_key),'# K') AS Measry_Value
FROM gold.dim_products
UNION ALL
SELECT 'number_of_cutomers' AS Measure_name,  FORMAT(COUNT(DISTINCT(Customer_key)),'# K') AS Measry_Value
FROM gold.dim_customers                   
UNION ALL
SELECT 'active_customers' AS Measure_name, FORMAT(COUNT(DISTINCT(customer_key)),'# K') AS  Measry_Value
FROM gold.fact_sales;
