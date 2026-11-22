{{ config(materialized="table") }}

with
    orders as (select * from {{ ref("stg_olist__orders") }}),

    customers as (select * from {{ ref("stg_olist__customers") }}),

    order_items as (
        select
            order_id,
            count(*) as item_count,
            sum(price) as items_revenue,
            sum(freight_value) as freight_total,
        from {{ ref("stg_olist__order_items") }}
        group by order_id
    ),

    payments as (
        select order_id, sum(payment_value) as payment_total
        from {{ ref("stg_olist__order_payments") }}
        group by order_id
    )

select
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.customer_state,
    o.order_status,
    o.ordered_at,
    date(o.ordered_at) as order_date,
    o.delivered_at,
    date_diff(date(o.delivered_at), date(o.ordered_at), day) as days_to_deliver,
    coalesce(i.item_count, 0) as item_count,
    coalesce(i.items_revenue, 0) as items_revenue,
    coalesce(i.freight_total, 0) as freight_total,
    coalesce(p.payment_total, 0) as payment_total
from orders o
left join customers c on o.customer_id = c.customer_id
left join order_items i on o.order_id = i.order_id
left join payments p on o.order_id = p.order_id
