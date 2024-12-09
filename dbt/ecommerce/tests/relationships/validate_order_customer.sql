select o.customer_id
from {{ ref('core_orders') }} o 
left join {{ ref('core_customers') }} c
on o.customer_id = c.customer_id
where c.customer_id is null 