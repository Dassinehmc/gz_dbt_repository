#int_sales_margin.sql

WITH sales_data AS (
    SELECT 
        sales.orders_id,
        sales.date_date,
        sales.quantity,
        sales.revenue,
        products.purchase_price
    FROM 
        {{ ref("stg_raw__sales") }} AS sales
    LEFT JOIN 
        {{ ref("stg_raw__product") }} AS products
    ON 
        sales.product_id = products.products_id
)

SELECT
    orders_id,
    date_date,
    CAST(quantity AS INT64) * CAST(purchase_price AS FLOAT64) AS purchase_cost,   -- Calcul de purchase_cost
    ROUND(CAST(revenue AS FLOAT64) - (CAST(quantity AS INT64) * CAST(purchase_price AS FLOAT64)),2) AS margin -- Calcul de la marge
FROM 
    sales_data
