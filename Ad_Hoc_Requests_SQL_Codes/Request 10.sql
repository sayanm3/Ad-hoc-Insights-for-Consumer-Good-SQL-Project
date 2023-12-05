/*
10. Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these fields,
division, product_code, product, total_sold_quantity, rank_order.
*/
WITH ref_tab AS 
(
SELECT
	p.division, p.product_code, p.product,
    sum(s.sold_quantity) as total_sold_quantity,
	rank() over(partition by division order by sum(s.sold_quantity) desc) as rank_order
FROM 
    fact_sales_monthly s
JOIN 
    dim_product p USING (product_code)
WHERE 
    fiscal_year = 2021
GROUP BY
    division, product_code,product
)
SELECT 
	* 
FROM 
    ref_tab
WHERE
	rank_order IN (1,2,3);