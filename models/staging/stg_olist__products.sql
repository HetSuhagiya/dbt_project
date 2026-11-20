select
    product_id,
    product_category_name,
    product_photos_qty,
    product_weight_g
from {{ source('olist', 'products') }}