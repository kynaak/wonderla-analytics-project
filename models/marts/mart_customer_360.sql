with customer_checkins as (

    select
        customer_id,
        count(*) as total_checkins
    from {{ ref('fact_checkins') }}
    group by customer_id

),

customer_ticket_sales as (

    select
        customer_id,
        count(*) as ticket_transactions,
        sum(net_revenue) as ticket_spend
    from {{ ref('fact_ticket_sales') }}
    group by customer_id

),

customer_merchandise_sales as (

    select
        customer_id,
        count(*) as merchandise_transactions,
        sum(net_revenue) as merchandise_spend
    from {{ ref('fact_merchandise_sales') }}
    group by customer_id

),

all_customers as (

    select customer_id from customer_checkins
    union
    select customer_id from customer_ticket_sales
    union
    select customer_id from customer_merchandise_sales

)

select
    all_customers.customer_id,

    coalesce(customer_checkins.total_checkins,0) as total_checkins,

    coalesce(customer_ticket_sales.ticket_transactions,0) as ticket_transactions,
    coalesce(customer_ticket_sales.ticket_spend,0) as ticket_spend,

    coalesce(customer_merchandise_sales.merchandise_transactions,0) as merchandise_transactions,
    coalesce(customer_merchandise_sales.merchandise_spend,0) as merchandise_spend,

    coalesce(customer_ticket_sales.ticket_spend,0)
    + coalesce(customer_merchandise_sales.merchandise_spend,0)
        as total_customer_spend

from all_customers

left join customer_checkins
    on all_customers.customer_id = customer_checkins.customer_id

left join customer_ticket_sales
    on all_customers.customer_id = customer_ticket_sales.customer_id

left join customer_merchandise_sales
    on all_customers.customer_id = customer_merchandise_sales.customer_id