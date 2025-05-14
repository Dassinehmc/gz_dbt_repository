# int_orders_operational.sql
with
    orders_margin_data as (
        select 
        orders_id, 
        date_date, 
        margin,
        revenue,
        quantity,
        purchase_price
        from {{ ref("int_sales_margin") }}
    ),

    shipping_data as (
        select
            orders_id,
            cast(shipping_fee as float64) as shipping_fee,
            cast(logcost as float64) as log_cost,
            cast(ship_cost as float64) as ship_cost
        from {{ ref("stg_raw_ship") }}
    )

select
    orders_margin_data.orders_id,
    orders_margin_data.date_date,
    round(margin + shipping_fee - log_cost - ship_cost, 2) as operational_margin,
    orders_margin_data.revenue,
    orders_margin_data.quantity,
    orders_margin_data.purchase_price,
    orders_margin_data.margin,
    shipping_data.shipping_fee,
    shipping_data.log_cost,          
    shipping_data.ship_cost  
from orders_margin_data
left join shipping_data 
on orders_margin_data.orders_id = shipping_data.orders_id