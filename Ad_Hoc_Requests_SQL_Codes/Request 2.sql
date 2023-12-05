/*
2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields,
unique_products_2020, unique_products_2021, percentage_chg
*/
SELECT
   up_20.unique_products_2020,
   up_21.unique_products_2021,
   round((unique_products_2021 - unique_products_2020)/unique_products_2020*100,2) as percentage_chg
FROM
(
(select count(distinct(product_code)) as unique_products_2020 from fact_sales_monthly
where fiscal_year = 2020) up_20,
(select count(distinct(product_code)) as unique_products_2021 from fact_sales_monthly
where fiscal_year = 2021) up_21
);