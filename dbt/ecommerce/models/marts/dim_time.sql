WITH base_time AS (
    SELECT
        DISTINCT order_purchase_timestamp,
        DATE(order_purchase_timestamp) AS order_purchase_date,
        YEAR(order_purchase_timestamp) AS order_year,
        MONTH(order_purchase_timestamp) AS order_month,
        DAY(order_purchase_timestamp) AS order_day
    FROM {{ ref('stg_orders') }}
)

SELECT *
FROM base_time