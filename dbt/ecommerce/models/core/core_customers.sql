with customers as (
    select
        c.customer_id,
        c.customer_unique_id,
        c.zip_code_prefix,
        c.city,
        c.state,
        g.latitude,
        g.longitude
    from {{ ref('stg_customers') }} c 
    left join {{ ref('stg_geolocation') }} g 
        on c.zip_code_prefix = g.zip_code_prefix
)
select * from customers