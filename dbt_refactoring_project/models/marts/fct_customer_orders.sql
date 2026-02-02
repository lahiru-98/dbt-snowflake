with customers as 
(
    select * from {{ ref('stg_customers') }}
),
orders as 
(
    select * from {{ ref('stg_orders') }}
),
payments as 
(
    select * from {{ ref('stg_payments') }}
),

-- staging 
completed_payments as (

    select order_id, 
    max(payment_created_at) as payment_finalized_date, 
    sum(payment_amount) as total_amount_paid
    from payments
    where payment_status <> 'fail'
    group by 1   
),

paid_orders as 
(
    select  Orders.order_id,
            Orders.customer_id,
            Orders.order_placed_at,
            Orders.order_status,

            completed_payments.total_amount_paid,
            completed_payments.payment_finalized_date,

            customers.customer_first_name    as customer_first_name,
            customers.customer_last_name as customer_last_name

    FROM orders
    left join completed_payments ON orders.order_id = completed_payments.order_id
    left join customers on orders.customer_id = customers.customer_id
 ),

--  x as 
-- (
--     select
--     p.order_id,
--     sum(t2.total_amount_paid) as clv_bad
--     from paid_orders p
--     left join paid_orders t2 on p.customer_id = t2.customer_id and p.order_id >= t2.order_id
--     group by 1
--     order by p.order_id
-- ),

-- customer_orders as 
-- (
--     select C.ID as customer_id
--         , min(ORDER_DATE) as first_order_date
--         , max(ORDER_DATE) as most_recent_order_date
--         , count(ORDERS.ID) AS number_of_orders

--     from raw_customers C 
--     left join raw_orders as Orders
--     on orders.USER_ID = C.ID 
--     group by 1
-- ),
--- marts
final as (

    select
    order_id,
    customer_id,
    order_placed_at,
    order_status,
    total_amount_paid,
    payment_finalized_date,
    customer_first_name,
    customer_last_name,
    -- sales transaction sequence
    ROW_NUMBER() OVER (ORDER BY order_id) as transaction_seq,

    -- customer sales sequence
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_id) as customer_sales_seq,

    -- new vs returning customer
    case  
        when (
            rank() over (
            partition by customer_id
            order by order_placed_at, order_id
            ) = 1
        ) then 'new'
    else 'return' end as nvsr,

    -- customer lifetime value (clv_bad
    sum(total_amount_paid) over (
        partition by customer_id order by order_placed_at
        ) as customer_lifetime_value,

    -- first day of sale
    first_value(order_placed_at) over (
      partition by customer_id
      order by order_placed_at
      ) as fdos

    from paid_orders
)
select * from final
order by order_id

