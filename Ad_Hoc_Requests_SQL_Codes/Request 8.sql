/*
8.In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity,
Quarter, total_sold_quantity.
*/
WITH cte AS 
(
SELECT
    date, month(date_add(date,interval 4 month)) as period, sold_quantity , fiscal_year
FROM fact_sales_monthly
)
SELECT
	CASE
    WHEN period >= 1 AND period <= 3 THEN  "Q1"
    WHEN period >3 AND period <=6 THEN "Q2"
    WHEN period >6 AND period <= 9 THEN "Q3"
    WHEN period >9 AND period <= 12 THEN "Q4"
    END quarter,
    concat(round(sum(sold_quantity)/1000000,2),"M") as total_sold_quantity_mln
    FROM cte
    WHERE 
		fiscal_year = 2020
    GROUP BY
		quarter
    ORDER BY 
		total_sold_quantity_mln desc;