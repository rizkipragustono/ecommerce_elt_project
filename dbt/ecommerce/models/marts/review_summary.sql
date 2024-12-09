with reviews as (
    select 
        o.order_id,
        r.review_score,
        r.review_creation_date,
        r.review_answer_timestamp
    from {{ ref('stg_order_reviews') }} r 
    join {{ ref('core_orders') }} o 
        on r.order_id = o.order_id
)
select 
    date_trunc('day', review_creation_date) as review_date,
    count(review_score) as review_count,
    avg(review_score) as average_score
from reviews 
group by 1
order by 1