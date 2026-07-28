with online_sales as (

    select
        sale_id,
        customer_id,
        product_id,
        product_name,
        category,
        quantity,
        unit_price,
        total_price,
        discount_applied,
        payment_method,
        sale_date,
        sale_timestamp,
        haunted_house_id,
        staff_member,
        created_at,
        updated_at,
        'Online' as sale_channel
    from {{ ref('stg_merchandisesalesonline') }}

),

physical_sales as (

    select
        sale_id,
        customer_id,
        product_id,
        product_name,
        category,
        quantity,
        unit_price,
        total_price,
        discount_applied,
        payment_method,
        sale_date,
        sale_timestamp,
        haunted_house_id,
        staff_member,
        created_at,
        updated_at,
        'Physical' as sale_channel
    from {{ ref('stg_merchandisesalesphysical') }}

),

combined_sales as (

    select * from online_sales

    union all

    select * from physical_sales

)

select
    sale_id,
    customer_id,
    product_id,
    product_name,
    category,
    quantity,
    unit_price,
    total_price,
    discount_applied,
    payment_method,
    sale_date,
    sale_timestamp,
    sale_channel,
    haunted_house_id,
    staff_member,

    quantity * unit_price as gross_revenue,

    total_price as net_revenue,

    created_at,
    updated_at

from combined_sales