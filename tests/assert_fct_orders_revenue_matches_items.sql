select
    f.total as fct_total,
    s.total as staging_total
from (select sum(items_revenue) as total from {{ ref('fct_orders') }}) f
cross join (select sum(price) as total from {{ ref('stg_olist__order_items') }}) s
where abs(f.total - s.total) > 0.01