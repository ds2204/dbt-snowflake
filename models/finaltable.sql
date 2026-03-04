WITH FACT AS 
(
SELECT * FROM {{source('First Ecomm Pipeline','FACT_ORDER_2023')}}
UNION ALL
SELECT * FROM {{source('First Ecomm Pipeline','FACT_ORDER_2024')}}
)


SELECT a.* FROM FACT a
LEFT JOIN {{source('First Ecomm Pipeline','DIM_PRODUCT')}} b
ON a.PRODUCT_ID=b.product_id
LEFT JOIN {{source('First Ecomm Pipeline','DIM_CUSTOMER')}} c
ON b.customer_id=c.customer_id



