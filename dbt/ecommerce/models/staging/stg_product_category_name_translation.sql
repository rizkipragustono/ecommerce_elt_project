with product_category_name_translation as (
    select
        product_category_name,
        product_category_name_english
    from {{ source('snowflake', 'product_category_name_translation') }}
)
select * from product_category_name_translation