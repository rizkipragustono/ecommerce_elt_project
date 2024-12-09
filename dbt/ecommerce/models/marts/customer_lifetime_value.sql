with customer_orders as (
    select 
        c.customer_id,
        c.customer_unique_id,
        sum(oi.price) as total_spent,
        count(distinct o.order_id) as order_count
    from {{ ref('core_customers') }} c
    join {{ ref('stg_orders') }} o 
        on c.customer_id = o.customer_id
    join {{ ref('stg_order_items') }} oi 
        on o.order_id = oi.order_id 
    group by c.customer_id, c.customer_unique_id
)
select * from customer_orders