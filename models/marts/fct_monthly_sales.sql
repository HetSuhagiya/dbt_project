{{
    config(
        materialized='table'
    )
}}

-- Monthly sales mart
-- Grain: Month (One row per month)

select 
date_trunc(order_date, month) as order_month, -- Only selects 1st day of the month from the date
count (*) as orders,
countif(order_status = 'delivered') as delivered_orders, -- only counts the delivered orders
count(distinct customer_unique_id) as unique_customers,
sum(items_revenue) as revenue,
round(safe_divide(sum(items_revenue), count(*)), 2) as avg_order_value,
round(avg(days_to_deliver), 2) as avg_days_to_deliver
from
{{ ref('fct_orders') }}
where order_status not in ('cancelled', 'unavailable') -- Excluded orders with this specific status
group by order_month