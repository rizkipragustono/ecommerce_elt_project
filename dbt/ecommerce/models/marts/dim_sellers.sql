SELECT
    seller_id,
    city,
    state,
    zip_code_prefix
FROM {{ ref('stg_sellers') }}