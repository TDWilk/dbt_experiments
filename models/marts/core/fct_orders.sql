with order_payments as (
    select
        order_id,
        sum(case when status = 'success' then amount else 0 end) as amount
    FROM {{ ref('stg_payments') }}
    group by 1
)

SELECT
  so.order_id,
  so.customer_id,
  so.order_date,
  SUM(amount) AS amount

FROM {{ ref('stg_orders') }} so 
left join order_payments using (order_id)
GROUP BY
  so.order_id,
  so.customer_id,
  so.order_date