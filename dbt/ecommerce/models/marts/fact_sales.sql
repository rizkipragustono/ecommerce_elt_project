WITH base_orders AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_purchase_timestamp,
        oi.order_item_id,
        oi.product_id,
        oi.seller_id,
        oi.price AS payment_value,
        oi.freight_value
    FROM {{ ref('stg_orders') }} o
    JOIN {{ ref('stg_order_items') }} oi
    ON o.order_id = oi.order_id
),

final_sales AS (
    SELECT
        order_id,
        customer_id,
        order_purchase_timestamp,
        order_item_id,
        product_id,
        seller_id,
        payment_value,
        freight_value
    FROM base_orders
)

SELECT *
FROM final_sales