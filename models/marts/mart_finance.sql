with ticket_revenue as (

    select
        purchase_date as activity_date,
        sum(net_revenue) as ticket_revenue
    from {{ ref('fact_ticket_sales') }}
    group by purchase_date

),

merchandise_revenue as (

    select
        sale_date as activity_date,
        sum(net_revenue) as merchandise_revenue
    from {{ ref('fact_merchandise_sales') }}
    group by sale_date

),

operating_costs as (

    select
        cost_date as activity_date,
        sum(cost_amount) as operating_cost
    from {{ ref('fact_operating_costs') }}
    group by cost_date

),

all_dates as (

    select activity_date from ticket_revenue

    union

    select activity_date from merchandise_revenue

    union

    select activity_date from operating_costs

)

select
    all_dates.activity_date,
    coalesce(ticket_revenue.ticket_revenue, 0) as ticket_revenue,
    coalesce(merchandise_revenue.merchandise_revenue, 0) as merchandise_revenue,
    coalesce(operating_costs.operating_cost, 0) as operating_cost,

    coalesce(ticket_revenue.ticket_revenue, 0)
        + coalesce(merchandise_revenue.merchandise_revenue, 0)
        as total_revenue,

    coalesce(ticket_revenue.ticket_revenue, 0)
        + coalesce(merchandise_revenue.merchandise_revenue, 0)
        - coalesce(operating_costs.operating_cost, 0)
        as profit

from all_dates

left join ticket_revenue
    on all_dates.activity_date = ticket_revenue.activity_date

left join merchandise_revenue
    on all_dates.activity_date = merchandise_revenue.activity_date

left join operating_costs
    on all_dates.activity_date = operating_costs.activity_date