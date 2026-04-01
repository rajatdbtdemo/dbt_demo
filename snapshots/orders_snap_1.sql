{% snapshot orders_snap_1 %}
{{
    config(
        target_schema='TRANSFORM', 
        target_database='TEST', 
        unique_key='order_id',  
        strategy='timestamp', 
        updated_at='load_date'
    )
}}
SELECT
    load_date,
    order_id,
    product_id,
    order_status
FROM {{ ref('order_raw') }}
        
{% endsnapshot %}