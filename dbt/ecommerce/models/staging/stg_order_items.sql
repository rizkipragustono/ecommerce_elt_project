with order_items as (
    select
        order_id,
        order_item_id,
        product_id,
        seller_id,
        shipping_limit_date,
        price,
        freight_value
    from {{ source('snowflake', 'olist_order_items_dataset') }}
)
select * from order_items