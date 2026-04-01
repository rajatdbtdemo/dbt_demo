{% snapshot orders_snap_2 %}
    {{
        config(
            target_schema='TRANSFORM', 
            target_database='TEST', 
            unique_key='order_id',  
            strategy='check', 
            check_cols=['order_id', 'product_id', 'order_status']
        )
    }}
    SELECT
        load_date,
        order_id,
        product_id,
        order_status
    FROM {{ ref('order_raw') }}
{% endsnapshot %}