{{ config(materialized='table') }}

select
customer_unique_id,
min(order_date) as first_order,
max(order_date) as last_order,
count(distinct order_id) as order_count,
sum(items_revenue) as lifetime_revenue,
max(customer_state) as customer_state,
count(distinct order_id) > 1 as is_repeat_customer
from
{{ ref('fct_orders') }}
group by customer_unique_id