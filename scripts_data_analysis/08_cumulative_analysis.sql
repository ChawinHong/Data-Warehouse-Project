-- Cumulative Analysis
SELECT *
	, SUM(total_sales) OVER(ORDER BY order_month ASC)
FROM (
SELECT
	YEAR(order_date) AS order_month 
	-- ,MONTH(order_date) AS order_month
	,SUM(sales_amount) AS total_sales


FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
) t


SELECT
	YEAR(order_date) AS order_year 
	-- ,MONTH(order_date) AS order_month
	,SUM(sales_amount) AS total_sales
	,SUM(SUM(sales_amount)) OVER(ORDER BY YEAR(order_date) ASC)

FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)



SELECT 
	order_date
	, total_sales
	, SUM(total_sales) OVER(PARTITION BY DATETRUNC(year, order_date) order by order_date ASC) AS running_total_sales
	, avg_price
	, AVG(avg_price) OVER(PARTITION BY DATETRUNC(year, order_date) order by order_date
		ROWS BETWEEN 2 PRECEDING and CURRENT ROW ) AS moving_avg_price
FROM (
SELECT
	DATETRUNC(month, order_date) AS order_date,
	SUM(sales_amount) AS total_sales,
	AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
) t
