with order_items as (
    select
        oi.order_id,
        o.customer_id,
        oi.price,
        oi.freight_value,
        o.order_purchase_timestamp
    from {{ ref('stg_order_items') }} oi 
    join {{ ref('core_orders') }} o
        on oi.order_id = o.order_id
)
select 
    date_trunc('day', order_purchase_timestamp) as order_date,
    count(distinct order_id) as total_orders,
    sum(price) as total_sales,
    sum(freight_value) as total_freight
from order_items
group by 1
order by 1