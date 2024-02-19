with payment as (

    select
        id as payment_id,
        orderID as order_id,
        paymentmethod as payment_method,
        status,
        --amount is stored as cents, convert to dollars
        amount / 100 as amount,
        created as created_at

    from {{ source('stripe', 'payment') }}

)

select * from payment