
--3) Date Exploration

-- Find the date of the first and last order
-- How many years/months of sales are available
SELECT
	min(order_date) AS first_order_date,
	max(order_date) AS last_order_date ,
	DATEDIFF(month,min(order_date),max(order_date)) AS order_range_month
FROM [gold].[fact_sales]

-- Find the youngest and the oldest customer
SELECT
MIN(birthdate) AS oldest_birthdate,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS oldest_age,
DATEDIFF(YEAR,MAX(birthdate),GETDATE()) AS youngest_age
FROM gold.dim_customers
