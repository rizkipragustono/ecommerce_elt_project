select s.order_date 
from {{ ref('sales_summary') }} s 
left join {{ ref('core_orders') }} o 
on s.order_date = date_trunc('day', o.order_purchase_timestamp)
where o.order_id is null