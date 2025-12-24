/*
===========================================================================
Quality Checks
===========================================================================
Script Purpose:
  - Perform quality checks to validate the integrity, consistency, and
    accuracy of the gold layer
  - Ensure uniqueness of surrogate keys in dimension tables
  - Ensure referential integrity between fact and dimension tables
  - Ensure validity of relationships in the data model for analytical purposes

Usage Notes:
  - Run these queries after loading data into the gold layer
  - Invesstigate and resolve any discrepancies detected during checks
===========================================================================
*/


-- ========================================================================
-- Checking 'gold.fact_customers'
-- ========================================================================
-- Check for uniqueness of customer key in gold.dim_customers
-- Expectation: No results

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
  FROM gold.dim_customers
  GROUP BY product_key
  HAVING COUNT(*) > 1;

-- ========================================================================
-- Checking 'gold.fact_sales'
-- ========================================================================
-- Check for uniqueness of product key in gold.dim_products
-- Expectation: No results

SELECT 
    product_key,
    COUNT(*) AS duplicate_count
  FROM gold.dim_products
  GROUP BY product_key
  HAVING COUNT(*) > 1;

-- ========================================================================
-- Checking 'gold.fact_sales'
-- ========================================================================
-- Foreign Key integrity (Dimensions)

SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key

LEFT JOIN gold.dim_products p
ON  f.product_key = p.product_key

WHERE p.product_key IS NULL OR c.customer_key IN NULL

