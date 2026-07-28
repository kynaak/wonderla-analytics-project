{% macro calculate_net_revenue(price_column, discount_column) %}

(
    {{ price_column }}
    * (1 - coalesce({{ discount_column }}, 0) / 100)
)

{% endmacro %}