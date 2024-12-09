with order_payments as (
    select
        order_id,
        payment_sequential,
        payment_type,
        payment_installments,
        payment_value
    from {{ source('snowflake', 'olist_order_payments_dataset') }}
)
select * from order_payments