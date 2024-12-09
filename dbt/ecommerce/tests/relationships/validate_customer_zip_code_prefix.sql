select c.zip_code_prefix
from {{ ref('core_customers') }} c 
left join {{ ref('stg_geolocation') }} g 
on c.zip_code_prefix = g.zip_code_prefix
where g.zip_code_prefix is null