{% macro delivery_speed_bucket(days_column, fast_days=7, standard_days=14) %}
    case
    when {{ days_column }} is null then 'not delivered'
    when {{ days_column }} <= {{ fast_days }} then 'fast'
    when {{ days_column }} <= {{ standard_days }} then 'standard'
    else 'slow'
    end
{% endmacro %}