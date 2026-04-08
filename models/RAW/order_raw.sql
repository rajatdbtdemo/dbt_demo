{{ config(materialized="incremental", incremental_strategy="append") }}

with
    orders as (
        select distinct
            load_date,
            order_id,
            product_id,
            order_status,
            current_timestamp() as dbt_load_ts
        from {{ source("dbt_demo_source", "orders") }}
    )
select *
from orders
