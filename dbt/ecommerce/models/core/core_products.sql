with products as (
    select
        p.product_id,
        t.product_category_name_english,
        p.name_length,
        p.description_length,
        p.photos_qty,
        p.weight_g,
        p.length_cm,
        p.height_cm,
        p.width_cm
    from {{  ref('stg_products') }} p 
    left join {{ ref('stg_product_category_name_translation') }} t 
        on p.product_category_name = t.product_category_name
)
select * from products