{% macro convert_to_date(column_name) %}
     to_date({{column_name}}, 'dd-mm-yyyy')
{% endmacro %}