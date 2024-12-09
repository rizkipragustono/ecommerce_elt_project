with order_reviews as (
    select
        review_id,
        order_id,
        review_score,
        review_comment_title,
        review_comment_message,
        review_creation_date,
        review_answer_timestamp
    from {{ source('snowflake', 'olist_order_reviews_dataset') }}
)
select * from order_reviews