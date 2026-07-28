select
    ticket_id,
    ticket_type_name,
    description,
    price,
    includes_fast_pass,
    includes_vip_benefits,
    launch_date,
    created_at,
    updated_at
from {{ ref('stg_weather_tickettypes') }}