WITH base_products AS (
    SELECT
        p.product_id,
        p.product_category_name,
        t.product_category_name_english,
        p.weight_g,
        p.length_cm,
        p.height_cm,
        p.width_cm
    FROM {{ ref('stg_products') }} p
    LEFT JOIN {{ ref('stg_product_category_name_translation') }} t
    ON p.product_category_name = t.product_category_name
)

SELECT *
FROM base_products