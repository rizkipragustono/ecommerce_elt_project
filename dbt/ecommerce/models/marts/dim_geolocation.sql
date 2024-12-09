SELECT
    zip_code_prefix,
    latitude,
    longitude,
    city,
    state
FROM {{ ref('stg_geolocation') }}