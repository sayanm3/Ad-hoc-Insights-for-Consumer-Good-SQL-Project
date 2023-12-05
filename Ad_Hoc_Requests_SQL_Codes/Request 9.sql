/*
9.Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields,
channel, gross_sales_mln, percentage.
*/
WITH cte1 AS 
(
SELECT 
	c.channel, 
	CONCAT(ROUND(SUM(s.sold_quantity * g.gross_price / 1000000), 2), "M") AS gross_sales_mln,
	s.fiscal_year
FROM 
	fact_sales_monthly s
JOIN fact_gross_price g USING (product_code)
JOIN dim_customer c USING (customer_code)
WHERE 
	s.fiscal_year = 2021
GROUP BY 
	channel
),
cte2 AS 
(
SELECT 
	SUM(gross_sales_mln) AS total 
FROM 
	cte1
)
SELECT 
    channel, 
    gross_sales_mln, 
    CONCAT(ROUND(SUM(gross_sales_mln / total * 100), 2), "%") AS percentage
FROM 
    cte1, 
    cte2
GROUP BY 
    channel, 
    gross_sales_mln
order by
	percentage desc ;
