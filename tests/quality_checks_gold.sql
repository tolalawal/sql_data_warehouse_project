
==========================================================
Quality Checks
==========================================================
Script Purpose:
This script performs quality checks to validate the integrity,
consistency and accuracy of the gold layer. These checks ensure
-Uniqueness of surrogate keys in dimension tables
-Referential integrity between fact and dimendion tables
-Validation of relationships in the data model for analytical purpose
Usage Notes:
-Run these checks after loading the silver layer
-Investigate and resolve discrepancies found during the checks

==========================================================
Checking 'gold.dim_customers'
==========================================================
--Check for uniqueness of customer_key in gold.dim_products
--Expectation: No Results
SELECT
customer_key,
COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1

==========================================================
Checking 'gold.dim_products'
==========================================================
--Check for uniqueness of product_key in gold.dim_products
--Expectation: No Results
SELECT
product_key,
COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1

==========================================================
Checking 'gold.fact_sales'
==========================================================
Check the data connectivity between fact and dimensions
SELECT
*
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
LEFT JOIN gold.dim_products p
ON s.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL
