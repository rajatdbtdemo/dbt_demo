{{ 
    config(
        materialized='incremental',
        unique_key='order_id', 
        incremental_strategy='merge'
    )
}}

with order_status as (
SELECT *
FROM {{ ref('orders_snap_1') }}
where dbt_valid_to is null

{% if is_incremental() %}
    and  load_date > (SELECT max(load_date) FROM {{ this }})
{% endif %}

),
calender as (
    select {{ convert_to_date('dates') }} dates, days, is_holiday
    from {{ ref('dec_calendar') }}
)

select os.load_date, c.days, c.is_holiday, os.order_id, os.product_id, os.order_status, os.dbt_valid_from
from order_status os 
left join calender c 
on os.load_date = c.dates

