/*
4.Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment, product_count_2020, product_count_2021, difference.
*/
WITH cte1 as 
(
SELECT
    count(distinct(s.product_code)) as p20,p.segment, s.fiscal_year
FROM 
    fact_sales_monthly as s
JOIN
    dim_product as p USING (product_code)
WHERE
   fiscal_year= 2020
GROUP BY
   p.segment
),
cte2 as 
(
SELECT
   count(distinct(s.product_code)) as p21, p.segment, s.fiscal_year
FROM
   fact_sales_monthly as s
JOIN
   dim_product as p USING (product_code)
WHERE
   fiscal_year = 2021
GROUP BY 
   p.segment
)
 SELECT
   cte1.segment, cte1.p20 as product_count_2020,
   cte2.p21 as product_count_2021,
   (cte2.p21 - cte1.p20) as difference
FROM
   cte1, cte2
WHERE
   cte1.segment = cte2.segment
ORDER BY
   product_count_2021 DESC;