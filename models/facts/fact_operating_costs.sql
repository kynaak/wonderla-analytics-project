with electricity_costs as (

    select
        cost_id,
        ride_id,
        date as cost_date,
        electricity_cost as cost_amount,
        'Electricity' as expense_category,
        created_at,
        updated_at
    from {{ ref('stg_electricitycosts') }}

),

maintenance_costs as (

    select
        cost_id,
        ride_id,
        date as cost_date,
        maintenance_cost as cost_amount,
        'Maintenance' as expense_category,
        created_at,
        updated_at
    from {{ ref('stg_maintenancecosts') }}

),

staff_costs as (

    select
        cost_id,
        ride_id,
        date as cost_date,
        staff_cost as cost_amount,
        'Staff' as expense_category,
        created_at,
        updated_at
    from {{ ref('stg_staffcosts') }}

),

supplies_costs as (

    select
        cost_id,
        ride_id,
        date as cost_date,
        supplies_cost as cost_amount,
        'Supplies' as expense_category,
        created_at,
        updated_at
    from {{ ref('stg_suppliescosts') }}

),

combined_costs as (

    select * from electricity_costs

    union all

    select * from maintenance_costs

    union all

    select * from staff_costs

    union all

    select * from supplies_costs

)

select
    cost_id,
    ride_id,
    cost_date,
    cost_amount,
    expense_category,
    created_at,
    updated_at
from combined_costs