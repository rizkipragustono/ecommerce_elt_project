with orders as (
    select 
        o.order_id,
        o.customer_id,
        o.order_status,
        o.order_purchase_timestamp,
        o.order_approved_at,
        o.order_delivered_carrier_date,
        o.order_delivered_customer_date,
        o.order_estimated_delivery_date,
        c.customer_unique_id
    from {{ ref('stg_orders') }} o 
    left join {{ ref('core_customers') }} c 
        on o.customer_id = c.customer_id
)
select * from orders