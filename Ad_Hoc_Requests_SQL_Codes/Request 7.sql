/*
7.Get the complete report of the Gross sales amount for the customer “Atliq exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.The final report contains these columns:
Month, Year, Gross sales Amount
*/
WITH cte AS 
(
SELECT 
	customer,
    CONCAT(MONTHNAME(S.date), ' (', YEAR(S.date), ')') AS Month,
    S.fiscal_year,
	(s.sold_quantity * g.gross_price)  AS gross_sales
FROM 
    fact_sales_monthly s 
JOIN
    fact_gross_price g ON s.product_code = g.product_code
JOIN 
	dim_customer c ON s.customer_code=c.customer_code
 WHERE 
	customer="Atliq exclusive"
)
SELECT 
	month ,fiscal_year, concat(round(sum(gross_sales)/1000000,2),"M") AS gross_sales 
FROM 
    cte
GROUP BY  
	Month, fiscal_year 
ORDER BY
    fiscal_year ;