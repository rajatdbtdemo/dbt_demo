{{ 
    config(
        materialized='view'
    )
}}

with order_latest as (
SELECT load_date, days,
count_if(order_status = 'Placed') as cnt_placed_orders,
count_if(order_status = 'Shipped') as cnt_shipped_orders,
count_if(order_status = 'Cancelled') as cnt_cancelled_orders,
count_if(order_status = 'Delivered') as cnt_delivered_orders
FROM {{ ref('order_latest') }}
group by 1,2
)
select * from order_latest
where load_date = (select max(load_date) from {{ ref('order_latest') }})