with online_sales as (

    select
        sale_id,
        customer_id,
        ticket_id,
        ticket_price,
        discount_percent,
        payment_method,
        purchase_date,
        visit_date,
        created_at,
        updated_at,
        'Online' as sale_channel
    from {{ ref('stg_ticketsalesonline') }}

),

physical_sales as (

    select
        sale_id,
        customer_id,
        ticket_id,
        ticket_price,
        discount_percent,
        payment_method,
        purchase_date,
        visit_date,
        created_at,
        updated_at,
        'Physical' as sale_channel
    from {{ ref('stg_ticketsalesphysical') }}

),

combined_sales as (

    select * from online_sales

    union all

    select * from physical_sales

)

select
    sale_id,
    customer_id,
    ticket_id,
    ticket_price,
    discount_percent,
    payment_method,
    purchase_date,
    visit_date,
    sale_channel,

    case
        when discount_percent is null or discount_percent = 0 then 'No Discount'
        when discount_percent <= 10 then 'Low Discount'
        when discount_percent <= 25 then 'Medium Discount'
        else 'High Discount'
    end as discount_category,

    case
        when purchase_date < visit_date then true
        else false
    end as advance_purchase_flag,

    case
        when purchase_date = visit_date then true
        else false
    end as same_day_purchase_flag,

    ticket_price * (1 - coalesce(discount_percent, 0) / 100) as net_revenue,

    created_at,
    updated_at

from combined_sales