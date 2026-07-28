with daily_checkins as (

    select
        checkin_date as activity_date,
        count(*) as total_checkins,
        count(distinct customer_id) as unique_customers
    from {{ ref('fact_checkins') }}
    group by checkin_date

),

daily_ticket_sales as (

    select
        purchase_date as activity_date,
        count(*) as ticket_transactions,
        sum(net_revenue) as ticket_revenue
    from {{ ref('fact_ticket_sales') }}
    group by purchase_date

),

daily_merchandise_sales as (

    select
        sale_date as activity_date,
        count(*) as merchandise_transactions,
        sum(net_revenue) as merchandise_revenue
    from {{ ref('fact_merchandise_sales') }}
    group by sale_date

),

daily_operating_costs as (

    select
        cost_date as activity_date,
        sum(cost_amount) as operating_cost
    from {{ ref('fact_operating_costs') }}
    group by cost_date

),

all_dates as (

    select activity_date from daily_checkins

    union

    select activity_date from daily_ticket_sales

    union

    select activity_date from daily_merchandise_sales

    union

    select activity_date from daily_operating_costs

)

select
    all_dates.activity_date,

    coalesce(daily_checkins.total_checkins, 0) as total_checkins,
    coalesce(daily_checkins.unique_customers, 0) as unique_customers,

    coalesce(daily_ticket_sales.ticket_transactions, 0)
        as ticket_transactions,

    coalesce(daily_ticket_sales.ticket_revenue, 0)
        as ticket_revenue,

    coalesce(daily_merchandise_sales.merchandise_transactions, 0)
        as merchandise_transactions,

    coalesce(daily_merchandise_sales.merchandise_revenue, 0)
        as merchandise_revenue,

    coalesce(daily_operating_costs.operating_cost, 0)
        as operating_cost,

    coalesce(daily_ticket_sales.ticket_revenue, 0)
        + coalesce(daily_merchandise_sales.merchandise_revenue, 0)
        as total_revenue,

    coalesce(daily_ticket_sales.ticket_revenue, 0)
        + coalesce(daily_merchandise_sales.merchandise_revenue, 0)
        - coalesce(daily_operating_costs.operating_cost, 0)
        as daily_profit

from all_dates

left join daily_checkins
    on all_dates.activity_date = daily_checkins.activity_date

left join daily_ticket_sales
    on all_dates.activity_date = daily_ticket_sales.activity_date

left join daily_merchandise_sales
    on all_dates.activity_date = daily_merchandise_sales.activity_date

left join daily_operating_costs
    on all_dates.activity_date = daily_operating_costs.activity_date