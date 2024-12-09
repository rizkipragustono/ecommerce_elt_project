with geolocation as (
    select
        geolocation_zip_code_prefix as zip_code_prefix,
        geolocation_lat as latitude,
        geolocation_lng as longitude,
        geolocation_city as city,
        geolocation_state as state
    from {{  source('snowflake', 'olist_geolocation_dataset') }}
)
select * from geolocation