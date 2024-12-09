SELECT
    customer_id,
    customer_unique_id,
    city,
    state,
    zip_code_prefix
FROM {{ ref('stg_customers') }}