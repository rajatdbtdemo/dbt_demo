{% test check_order_status_value(model, column_name) %}
    select *
    from {{ model }}
    where {{ column_name }} not in ('Shipped', 'Pending', 'Delivered', 'Cancelled', 'Placed')
{% endtest %}