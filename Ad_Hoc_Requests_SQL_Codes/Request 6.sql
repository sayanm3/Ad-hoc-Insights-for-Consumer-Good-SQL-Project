/*
6.Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields,
customer_code, customer, average_discount_percentage
*/
SELECT
    c.customer_code, c.customer , 
    round(avg(p.pre_invoice_discount_pct)*100,4) as average_discount_percentage
 FROM
    fact_pre_invoice_deductions p
JOIN 
    dim_customer c USING (customer_code)
 WHERE
    market = "India" AND 
	fiscal_year = 2021
 GROUP BY
    customer_code , customer
ORDER BY
    average_discount_percentage desc
 LIMIT 5 ;