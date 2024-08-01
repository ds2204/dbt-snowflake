{{config(
    database='newlayer',
    schema='analytics'
)}}

WITH
    customers AS (
        SELECT * FROM {{ ref("stg_customers") }}
    ),
    orders AS (
        SELECT * FROM {{ ref("stg_orders") }}
    ),
    payments AS (
        SELECT * FROM {{ ref("stg_payments") }}
    ),
    customer_level_details AS (
        SELECT
            c.CUSTOMER_ID AS customer_id,
            MIN(o.ORDER_DATE) AS first_order,
            MAX(o.ORDER_DATE) AS most_recent_order
        FROM customers c
        LEFT JOIN orders o ON c.CUSTOMER_ID = o.CUSTOMER_ID
        GROUP BY c.CUSTOMER_ID
    ),
    payment_detail AS (
        SELECT 
            o.CUSTOMER_ID AS customer_id,
            SUM(p.SALES_AMOUNT) AS amount
        FROM payments p
        LEFT JOIN orders o ON p.ORDER_ID = o.ORDER_ID
        GROUP BY o.CUSTOMER_ID
    ),
    final AS (
        SELECT 
            cl.customer_id,
            cl.first_order,
            cl.most_recent_order,
            COALESCE(pd.amount, 0) AS amount  -- Use COALESCE to handle cases where there are no matching records in payment_detail
        FROM customer_level_details cl
        LEFT JOIN payment_detail pd ON cl.customer_id = pd.customer_id
    )

SELECT * FROM final
