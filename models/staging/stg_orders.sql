{{config(
    database='staging',
    schema='stg'
)}}
with raw as(
    select * from {{source("Snowflake sources","raw_orders")}}
),
final as(
    select ID as ORDER_ID,
    USER_ID AS CUSTOMER_ID,
    ORDER_DATE,
    STATUS
    from raw
)

select * from final